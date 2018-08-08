(function _Ray_s_(){

'use strict';

var _ = _global_.wTools;
var avector = _.avector;
var vector = _.vector;
var Self = _.ray = _.ray || Object.create( null );

// --
//
// --
//


function make( dim )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  var result = _.ray.makeZero( dim );
  if( _.ray.is( dim ) )
  _.avector.assign( result,dim );
  return result;
}

//

function makeZero( dim )
{
  if( _.ray.is( dim ) )
  dim = _.ray.dimGet( dim );
  if( dim === undefined || dim === null )
  dim = 3;
  _.assert( dim >= 0 );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  var result = _.dup( 0,dim*2 );
  return result;
}

//

function makeNil( dim )
{
  if( _.ray.is( dim ) )
  dim = _.ray.dimGet( dim );
  if( dim === undefined || dim === null )
  dim = 3;

  _.assert( dim >= 0 );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  var result = [];
  for( var i = 0 ; i < dim ; i++ )
  result[ i ] = +Infinity;
  for( var i = 0 ; i < dim ; i++ )
  result[ dim+i ] = -Infinity;

  return result;
}

//

function zero( ray )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( _.ray.is( ray ) )
  {
    var rayv = _.ray._from( ray );
    rayv.assign( 0 );
    return ray;
  }

  return _.ray.makeZero( ray );
}

//

function nil( ray )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( _.ray.is( ray ) )
  {
    var rayv = _.ray._from( ray );
    // var min = _.ray.cornerLeftGet( rayv );
    // var max = _.ray.cornerRightGet( rayv );
    var min = _.ray.originGet( rayv );
    var max = _.ray.directionGet( rayv );

    _.vector.assign( min, +Infinity );
    _.vector.assign( max, -Infinity );

    return ray;
  }

  return _.ray.makeNil( ray );
}

//

function from( ray )
{

  if( _.objectIs( ray ) )
  {
    _.assertMapHasFields( ray,{ min : 'min' , max : 'max' } );
    ray = _.arrayAppendArrays( [],[ ray.min,ray.max ] );
  }

  _.assert( _.ray.is( ray ) );
  _.assert( arguments.length === 1, 'expects single argument' );

  if( _.vectorIs( ray ) )
  {
    debugger;
    throw _.err( 'not implemented' );
    return ray.slice();
  }

  return ray;
}

//

function _from( ray )
{
  _.assert( _.ray.is( ray ) );
  _.assert( arguments.length === 1, 'expects single argument' );
  return _.vector.from( ray );
}

//

function fromPair( pair )
{
  var result = [];
  result[ 0 ] = pair[ 0 ];
  result[ 1 ] = avector.sub( null, pair[ 1 ], pair[ 0 ] );
  debugger;
  return result;
}

fromPair.shaderChunk =
`
  void ray_fromPair( out vec2 dstRay[ 2 ], vec2 pair[ 2 ] )
  {
    dstRay[ 0 ] = pair[ 0 ];
    dstRay[ 1 ] = pair[ 1 ] - pair[ 0 ];
  }

  void ray_fromPair( out vec3 dstRay[ 2 ], vec3 pair[ 2 ] )
  {
    dstRay[ 0 ] = pair[ 0 ];
    dstRay[ 1 ] = pair[ 1 ] - pair[ 0 ];
  }
`

//

/**
  * Check if input is a ray. Returns true if it is a ray and false if not.
  *
  * @param { Vector } ray - Source ray.
  *
  * @example
  * // returns true;
  * _.is( [ 0, 0, 1, 1 ] );
  *
  * @returns { Boolean } Returns true if the input is ray.
  * @function is
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @memberof wTools.ray
  */
function is( ray )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  return ( _.longIs( ray ) || _.vectorIs( ray ) ) && ( ray.length >= 0 ) && ( ray.length % 2 === 0 );
}

//

/**
  * Get ray dimension. Returns the dimension of the ray. Ray stays untouched.
  *
  * @param { Vector } ray - The source ray.
  *
  * @example
  * // returns 2
  * _.dimGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns 1
  * _.dimGet( [ 0, 1 ] );
  *
  * @returns { Number } Returns the dimension of the ray.
  * @function dimGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( ray ) is not ray.
  * @memberof wTools.ray
  */
function dimGet( ray )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( _.ray.is( ray ) );
  return ray.length / 2;
}

//

/**
  * Get the origin of a ray. Returns a vector with the coordinates of the origin of the ray.
  * Ray stays untouched.
  *
  * @param { Vector } ray - The source ray.
  *
  * @example
  * // returns   0, 0
  * _.originGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns  1
  * _.originGet( [ 1, 2 ] );
  *
  * @returns { Vector } Returns the coordinates of the origin of the ray.
  * @function originGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( ray ) is not ray.
  * @memberof wTools.ray
  */

function originGet( ray )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  let rayv = _.ray._from( ray );
  return rayv.subarray( 0, ray.length/ 2 );
}

//

/**
  * Get the direction of a ray. Returns a vector with the coordinates of the direction of the ray.
  * Ray stays untouched.
  *
  * @param { Vector } ray - The source ray.
  *
  * @example
  * // returns   2, 2
  * _.directionGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns  2
  * _.directionGet( [ 1, 2 ] );
  *
  * @returns { Vector } Returns the direction of the ray.
  * @function directionGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( ray ) is not ray.
  * @memberof wTools.ray
  */

function directionGet( ray )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  let rayv = _.ray._from( ray );
  return rayv.subarray( ray.length/ 2, ray.length );
}

//

function rayAt( srcRay,factor )
{
  var result = avector.mul( null, srcRay[ 1 ], factor );
  avector.add( result, srcRay[ 0 ] );
  return result;
}

rayAt.shaderChunk =
`
  vec2 rayAt( vec2 srcRay[ 2 ], float factor )
  {

    vec2 result = srcRay[ 1 ]*factor;
    result += srcRay[ 0 ];

    return result;
  }
`

//

function rayParallel( src1Ray, src2Ray, accuracySqr )
{
  _.assert( src1Ray.length === 3 );
  _.assert( src2Ray.length === 3 );
  _.assert( arguments.length === 2 || arguments.length === 3 );

  if( accuracySqr === undefined )
  accuracySqr = Self.accuracySqr;

  return _magSqr( avector.cross( src1Ray[ 1 ], src2Ray[ 1 ] ) ) <= Self.accuracySqr;
}

//

function rayIntersectionFactors( r1,r2 )
{

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( r1[ 0 ].length === 2,'implemented only for d2' );
  _.assert( r2[ 0 ].length === 2,'implemented only for d2' );

  var dorigin = avector.subVectors( r2[ 0 ].slice() , r1[ 0 ] );

  var y = [];
  y[ 0 ] = + dorigin[ 0 ];
  y[ 1 ] = - dorigin[ 1 ];

  var m = [];
  m[ 0 ] = + r1[ 1 ][ 0 ];
  m[ 1 ] = - r1[ 1 ][ 1 ];
  m[ 2 ] = - r2[ 1 ][ 0 ];
  m[ 3 ] = + r2[ 1 ][ 1 ];

  var x = d2linearEquationSolve( m,y );
  return x;
}

rayIntersectionFactors.shaderChunk =
`
  vec2 rayIntersectionFactors( vec2 r1[ 2 ], vec2 r2[ 2 ] )
  {

    vec2 dorigin = r2[ 0 ] - r1[ 0 ];

    vec2 y;
    y[ 0 ] = + dorigin[ 0 ];
    y[ 1 ] = - dorigin[ 1 ];

    mat2 m;
    m[ 0 ][ 0 ] = + r1[ 1 ][ 0 ];
    m[ 1 ][ 0 ] = - r1[ 1 ][ 1 ];
    m[ 0 ][ 1 ] = - r2[ 1 ][ 0 ];
    m[ 1 ][ 1 ] = + r2[ 1 ][ 1 ];

    vec2 x = d2linearEquationSolve( m,y );
    return x;

  }
`

//

function rayIntersectionPoints( r1,r2 )
{
  var factors = rayIntersectionFactors( r1,r2 );
  var result = [ Self.rayAt( r1,factors[ 0 ] ),Self.rayAt( r2,factors[ 1 ] ) ];
  return result;

}

rayIntersectionPoints.shaderChunk =
`
  void rayIntersectionPoints( out vec2 result[ 2 ], vec2 r1[ 2 ], vec2 r2[ 2 ] )
  {

    vec2 factors = rayIntersectionFactors( r1,r2 );
    result[ 0 ] = rayAt( r1,factors[ 0 ] );
    result[ 1 ] = rayAt( r2,factors[ 1 ] );

  }
`

//

function rayIntersectionPoint( r1,r2 )
{

  var factors = Self.rayIntersectionFactors( r1,r2 );
  return Self.rayAt( r1,factors[ 0 ] );

}

rayIntersectionPoint.shaderChunk =
`
  vec2 rayIntersectionPoint( vec2 r1[ 2 ], vec2 r2[ 2 ] )
  {

    vec2 factors = rayIntersectionFactors( r1,r2 );
    return rayAt( r1,factors[ 0 ] );

  }
`

//

function rayIntersectionPointAccurate( r1,r2 )
{

  var closestPoints = Self.rayIntersectionPoints( r1,r2 );
  return closestPoints[ 0 ].slice().add( closestPoints[ 1 ] ).mul( 0.5 );

}

rayIntersectionPointAccurate.shaderChunk =
`
  vec2 rayIntersectionPointAccurate( vec2 r1[ 2 ], vec2 r2[ 2 ] )
  {

    vec2 closestPoints[ 2 ];
    rayIntersectionPoints( closestPoints,r1,r2 );
    return ( closestPoints[ 0 ] + closestPoints[ 1 ] ) * 0.5;

  }
`

// --
// define class
// --

var Proto =
{

  make : make,
  makeZero : makeZero,
  makeNil : makeNil,

  zero : zero,
  nil : nil,

  from : from,
  _from : _from,

  fromPair : fromPair,

  is : is,
  dimGet : dimGet,
  originGet : originGet,
  directionGet : directionGet,

  rayAt : rayAt,         /* Factor can not be negative */

  rayParallel : rayParallel,
  rayIntersectionFactors : rayIntersectionFactors,
  rayIntersectionPoints : rayIntersectionPoints,
  rayIntersectionPoint : rayIntersectionPoint,
  rayIntersectionPointAccurate : rayIntersectionPointAccurate,

  // fromPoints : fromPoints,

}

_.mapSupplement( Self, Proto );

//

if( typeof module !== 'undefined' )
{

  require( './Sphere.s' );

}

})();
