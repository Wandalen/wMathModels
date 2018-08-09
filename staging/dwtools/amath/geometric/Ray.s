(function _Ray_s_(){

'use strict';

let _ = _global_.wTools;
let avector = _.avector;
let vector = _.vector;
let Self = _.ray = _.ray || Object.create( null );

// --
//
// --
//


function make( dim )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = _.ray.makeZero( dim );
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
  let result = _.dup( 0,dim*2 );
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
  let result = [];
  for( let i = 0 ; i < dim ; i++ )
  result[ i ] = +Infinity;
  for( let i = 0 ; i < dim ; i++ )
  result[ dim+i ] = -Infinity;

  return result;
}

//

function zero( ray )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( _.ray.is( ray ) )
  {
    let rayView = _.ray._from( ray );
    rayView.assign( 0 );
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
    let rayView = _.ray._from( ray );
    // let min = _.ray.cornerLeftGet( rayView );
    // let max = _.ray.cornerRightGet( rayView );
    let min = _.ray.originGet( rayView );
    let max = _.ray.directionGet( rayView );

    _.vector.assign( min, +Infinity );
    _.vector.assign( max, -Infinity );

    return ray;
  }

  return _.ray.makeNil( ray );
}

//

function from( ray )
{


//  if( _.objectIs( ray ) )
//  {
//    _.assertMapHasFields( ray,{ min : 'min' , max : 'max' } );
//    ray = _.arrayAppendArrays( [],[ ray.min,ray.max ] );
//  }

  _.assert( _.ray.is( ray ) || ray === null );
  _.assert( arguments.length === 1, 'expects single argument' );

//  if( _.vectorIs( ray ) )
//  {
//    debugger;
//    throw _.err( 'not implemented' );
//    return ray.slice();
//  }

  if( ray === null )
  return _.ray.make();

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

/**
  * Get a ray out of two points. Returns a vector with the coordinates of the ray.
  * The pair of points stays untouched.
  *
  * @param { Array } pair - The source points.
  *
  * @example
  * // returns  [ 1, 2, 1, 2 ]
  * _.fromPair( [ 1, 2 ], [ 3, 4 ] );
  *
  * @returns { Vector } Returns the ray containing the two points.
  * @function fromPair
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( pair ) is not array.
  * @memberof wTools.ray
  */
function fromPair( pair )
{
//  let result = [];
//  result[ 0 ] = pair[ 0 ];
//  result[ 1 ] = avector.sub( null, pair[ 1 ], pair[ 0 ] );

  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( pair.length === 2, 'expects two points' );
  _.assert( pair[ 0 ].length === pair[ 1 ].length, 'expects two points' );

  let result = _.array.makeArrayOfLength( pair[ 0 ].length * 2 );

  for( var i = 0; i < pair[ 0 ].length ; i++ )
  {
    result[ i ] = pair[ 0 ][ i ];
    result[ pair[ 0 ].length + i ] = avector.sub( null, pair[ 1 ], pair[ 0 ] )[ i ];
  }

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
  let rayView = _.ray._from( ray );
  return rayView.subarray( 0, ray.length/ 2 );
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
  let rayView = _.ray._from( ray );
  return rayView.subarray( ray.length/ 2, ray.length );
}

//

/**
  * Get a point in a ray. Returns a vector with the coordinates of the point of the ray.
  * Ray and factor stay untouched.
  *
  * @param { Vector } ray - The source ray.
  * @param { Vector } factor - The source factor.
  *
  * @example
  * // returns   4, 4
  * _.rayAt( [ 0, 0, 2, 2 ], 2 );
  *
  * @example
  * // returns  1
  * _.rayAt( [ 1, 2 ], 0 );
  *
  * @returns { Vector } Returns a point in the ray at a given factor.
  * @function rayAt
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( factor ) is not number.
  * @memberof wTools.ray
  */
function rayAt( srcRay, factor )
{
  // let result = avector.mul( null, srcRay[ 1 ], factor );
  // avector.add( result, srcRay[ 0 ] );

  _.assert( arguments.length === 2, 'expects single argument' );
  _.assert( _.ray.is( srcRay ) );
  _.assert( factor >= 0, 'Factor can not be negative ( point must be in the ray )');

  let rayView = _.ray._from( srcRay )
  let origin = _.ray.originGet( rayView );
  let direction = _.ray.directionGet( rayView );

  let result = avector.mul( null, direction, factor );
  result = avector.add( result, origin );

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

/**
  * Ckeck if two rays are parallel. Returns true if they are parallel and false if not.
  * Rays and accuracySqr stay untouched. Only for 3D.
  *
  * @param { Vector } src1Ray - The first source ray.
  * @param { Vector } src2Ray - The second source ray.
  * @param { Vector } accuracySqr - The accuracy.
  *
  * @example
  * // returns   true
  * _.rayParallel( [ 0, 0, 0, 2, 2, 2 ], [ 1, 2, 1, 4, 4, 4 ] );
  *
  * @example
  * // returns  false
  * _.rayParallel( [ 1, 2, 1, 1, 1, 2 ], [ 1, 2, 1, 1, 3, 3 ] );
  *
  * @returns { Boolean } Returns true if the rays are parallel.
  * @function rayParallel
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( src1Ray ) is not ray.
  * @throws { Error } An Error if ( src2Ray ) is not ray.
  * @throws { Error } An Error if ( accuracySqr ) is not number.
  * @memberof wTools.ray
  */
function rayParallel( src1Ray, src2Ray, accuracySqr )
{
  // _.assert( src1Ray.length === 3 );
  // _.assert( src2Ray.length === 3 );
  // _.assert( arguments.length === 2 || arguments.length === 3 );

  // if( accuracySqr === undefined )
  // accuracySqr = Self.accuracySqr;

  // return _magSqr( avector.cross( src1Ray[ 1 ], src2Ray[ 1 ] ) ) <= Self.accuracySqr;

  _.assert( _.ray.is( src1Ray ) );
  _.assert( _.ray.is( src2Ray ) );
  _.assert( arguments.length === 2 || arguments.length === 3 );

  if( arguments.length === 2 || accuracySqr === undefined || accuracySqr === null )
  accuracySqr = _.accuracySqr;;

  let direction1 = _.ray.directionGet( src1Ray );
  let direction2 = _.ray.directionGet( src2Ray );

  debugger;
  return avector.magSqr( avector.cross( null, direction1, direction2 )) <= accuracySqr;

}

//

/**
  * Returns the factors for the intersection of two rays. Returns an array with the intersection factors, 0 if there is no intersection.
  * Rays stay untouched. Only for 2D.
  *
  * @param { Vector } src1Ray - The first source ray.
  * @param { Vector } src2Ray - The second source ray.
  *
  * @example
  * // returns   0
  * _.rayIntersectionFactors( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  [ 2, 1 ]
  * _.rayIntersectionFactors( [ - 2, 0, 1, 0 ], [ 0, - 2, 0, 2 ] );
  *
  * @returns { Array } Returns the factors for the two rays intersection.
  * @function rayIntersectionFactors
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Ray ) is not ray.
  * @throws { Error } An Error if ( src2Ray ) is not ray.
  * @memberof wTools.ray
  */
function rayIntersectionFactors( r1,r2 )
{

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  //_.assert( r1[ 0 ].length === 2,'implemented only for d2' );
  //_.assert( r2[ 0 ].length === 2,'implemented only for d2' );
  _.assert( r1.length === 4,'implemented only for d2' );
  _.assert( r2.length === 4,'implemented only for d2' );

  // var dorigin = avector.subVectors( r2[ 0 ].slice() , r1[ 0 ] );

  // var y = [];
  // y[ 0 ] = + dorigin[ 0 ];
  // y[ 1 ] = - dorigin[ 1 ];

  // var m = [];
  // m[ 0 ] = + r1[ 1 ][ 0 ];
  // m[ 1 ] = - r1[ 1 ][ 1 ];
  // m[ 2 ] = - r2[ 1 ][ 0 ];
  // m[ 3 ] = + r2[ 1 ][ 1 ];

  // var x = d2linearEquationSolve( m,y );
  // debbuger;
  // return x;
  var r1View = _.ray._from( r1 );
  var r2View = _.ray._from( r2 );
  var origin1 = _.ray.originGet( r1View );
  var origin2 = _.ray.originGet( r2View );

  if( origin1.slice()[ 0 ] === origin2.slice()[ 0 ] && origin1.slice()[ 1 ] === origin2.slice()[ 1 ] )
  return [ 0, 0 ];

  var x = [];

  // x[ 0 ] = ( r2View.eGet( 2 )*( r1View.eGet( 1 ) - r2View.eGet( 1 ) ) + r2View.eGet( 3 )*( r2View.eGet( 0 ) - r1View.eGet( 0 ) ) ) / ( r2View.eGet( 3 )*r1View.eGet( 2 ) - r2View.eGet( 2 )*r1View.eGet( 3 ) );
  x[ 1 ] = ( r1View.eGet( 2 )*( r2View.eGet( 1 ) - r1View.eGet( 1 ) ) + r1View.eGet( 3 )*( r1View.eGet( 0 ) - r2View.eGet( 0 ) ) ) / ( r2View.eGet( 2 )*r1View.eGet( 3 ) - r2View.eGet( 3 )*r1View.eGet( 2 ) );
  x[ 0 ] = ( r2View.eGet( 0 ) + r2View.eGet( 2 )*x[ 1 ] - r1View.eGet( 0 ) )/ r1View.eGet( 2 );

  if(  x[ 0 ] <= 0 - _.accuracySqr || x[ 1 ] <= 0 - _.accuracySqr )
  return 0;

  if(  x[ 0 ] === Infinity || x[ 1 ] === Infinity )
  return 0;

  if(  !_.numberIs( x[ 0 ] ) || !_.numberIs( x[ 1 ] ) )
  return 0;

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

/**
  * Returns the points of the intersection of two rays. Returns an array with the intersection points, 0 if there is no intersection.
  * Rays stay untouched. Only for 2D.
  *
  * @param { Vector } src1Ray - The first source ray.
  * @param { Vector } src2Ray - The second source ray.
  *
  * @example
  * // returns   0
  * _.rayIntersectionPoints( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  [ [ 0, 0 ], [ 0, 0 ] ]
  * _.rayIntersectionPoints( [ -3, 0, 1, 0 ], [ 0, -2, 0, 1 ] );
  *
  * @returns { Array } Returns the points of intersection of the two rays.
  * @function rayIntersectionPoints
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Ray ) is not ray.
  * @throws { Error } An Error if ( src2Ray ) is not ray.
  * @memberof wTools.ray
  */
function rayIntersectionPoints( r1,r2 )
{
  var factors = rayIntersectionFactors( r1,r2 );

  if( factors === 0 )
  return 0;

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

/**
  * Returns the point of the intersection of two rays. Returns an array with the intersection point, 0 if there is no intersection.
  * Rays stay untouched. Only for 2D.
  *
  * @param { Vector } src1Ray - The first source ray.
  * @param { Vector } src2Ray - The second source ray.
  *
  * @example
  * // returns   0
  * _.rayIntersectionPoint( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  [ [ 0, 0 ], [ 0, 0 ] ]
  * _.rayIntersectionPoint( [ -3, 0, 1, 0 ], [ 0, -2, 0, 1 ] );
  *
  * @returns { Array } Returns the point of intersection of the two rays.
  * @function rayIntersectionPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Ray ) is not ray.
  * @throws { Error } An Error if ( src2Ray ) is not ray.
  * @memberof wTools.ray
  */
function rayIntersectionPoint( r1,r2 )
{

  var factors = Self.rayIntersectionFactors( r1,r2 );

  if( factors === 0 )
  return 0;

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
