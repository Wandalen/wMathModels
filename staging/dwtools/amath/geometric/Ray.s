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

  for( let i = 0; i < pair[ 0 ].length ; i++ )
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
  * @param { Vector } srcRay - The source ray.
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
* Get the factor of a point inside a ray. Returs the calculated factor. Point and ray stay untouched.
*
* @param { Array } srcRay - The source ray.
* @param { Array } srcPoint - The source point.
*
* @example
* // returns 0.5
* _.getFactor( [ 0, 0, 2, 2 ], [ 1, 1 ] );
*
* @example
* // returns false
* _.getFactor( [ 0, 0, 2, 2 ], [ - 1, 3 ] );
*
* @returns { Number } Returns the factor if the point is inside the ray, and false if the point is outside it.
* @function getFactor
* @throws { Error } An Error if ( dim ) is different than point.length (ray and point have not the same dimension).
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( srcRay ) is not ray.
* @throws { Error } An Error if ( srcPoint ) is not point.
* @memberof wTools.ray
*/
function getFactor( srcRay, srcPoint )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  if( srcRay === null )
  srcRay = _.ray.make( srcPoint.length );

  let srcRayView = _.ray._from( srcRay.slice() );
  let origin = _.ray.originGet( srcRayView );
  let direction = _.ray.directionGet( srcRayView );
  let dimension  = _.ray.dimGet( srcRayView )
  let srcPointView = _.vector.from( srcPoint.slice() );

  _.assert( dimension === srcPoint.length, 'The ray and the point must have the same dimension' );
  let dOrigin = _.vector.from( avector.subVectors( srcPointView, origin ) );

  let factor;
  if( direction.eGet( 0 ) === 0 )
  {
    if( Math.abs( dOrigin.eGet( 0 ) ) > _.accuracySqr )
    {
      return false;
    }
    else
    {
      factor = 0;
    }
  }
  else
  {
    factor = dOrigin.eGet( 0 ) / direction.eGet( 0 );
  }

  // Factor can not be negative
  if(  factor <= 0 - _.accuracySqr )
  return false;

  for( var i = 1; i < dOrigin.length; i++ )
  {
    let newFactor;
    if( direction.eGet( i ) === 0 )
    {
      if( Math.abs( dOrigin.eGet( i ) ) > _.accuracySqr )
      {
        return false;
      }
      else
      {
        newFactor = 0;
      }
    }
    else
    {
      newFactor = dOrigin.eGet( i ) / direction.eGet( i );
      if( Math.abs( newFactor - factor ) > _.accuracySqr && newFactor !== 0 && factor !== 0 )
      {
        return false;
      }
      factor = newFactor;
    }
  }

  return factor;
}

//

/**
  * Check if two rays are parallel. Returns true if they are parallel and false if not.
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
function rayParallel3D( src1Ray, src2Ray, accuracySqr )
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
  _.assert( src1Ray.length === src2Ray.length );

  if( arguments.length === 2 || accuracySqr === undefined || accuracySqr === null )
  accuracySqr = _.accuracySqr;;

  let direction1 = _.ray.directionGet( src1Ray );
  let direction2 = _.ray.directionGet( src2Ray );
  let proportion = undefined;

  let zeros1 = 0;                               // Check if Ray1 is a point
  for( let i = 0; i < direction1.length ; i++  )
  {
    if( direction1.eGet( i ) === 0 )
    {
      zeros1 = zeros1 + 1;
    }
    if( zeros1 === direction1.length )
    return true;
  }

  let zeros2 = 0;                               // Check if Ray2 is a point
  for( let i = 0; i < direction2.length ; i++  )
  {
    if( direction2.eGet( i ) === 0 )
    {
      zeros2 = zeros2 + 1;
    }
    if( zeros2 === direction2.length )
    return true;
  }

  debugger;

  for( let i = 0; i < direction1.length ; i++  )
  {
    if( direction1.eGet( i ) === 0 || direction2.eGet( i ) === 0 )
    {
      if( direction1.eGet( i ) !== direction2.eGet( i ) )
      {
        return false;
      }
    }
    else
    {
      let newProportion = direction1.eGet( i ) / direction2.eGet( i );

      if( proportion !== undefined )
      {
        if( Math.abs( proportion - newProportion ) > accuracySqr)
        return false
      }

      proportion = newProportion;
    }
  }

  return true;
}

//

/**
  * Returns the factors for the intersection of two rays. Returns a vector with the intersection factors, 0 if there is no intersection.
  * Rays stay untouched.
  *
  * @param { Vector } src1Ray - The first source ray.
  * @param { Vector } src2Ray - The second source ray.
  *
  * @example
  * // returns   0
  * _.rayIntersectionFactors( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  _.vector.from( [ 2, 1 ] )
  * _.rayIntersectionFactors( [ - 2, 0, 1, 0 ], [ 0, - 2, 0, 2 ] );
  *
  * @returns { Array } Returns the factors for the two rays intersection.
  * @function rayIntersectionFactors
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Ray ) is not ray.
  * @throws { Error } An Error if ( src2Ray ) is not ray.
  * @memberof wTools.ray
  */
function rayIntersectionFactors( r1, r2 )
{
  //_.assert( r1[ 0 ].length === 2,'implemented only for d2' );
  //_.assert( r2[ 0 ].length === 2,'implemented only for d2' );

  // let dorigin = avector.subVectors( r2[ 0 ].slice() , r1[ 0 ] );

  // let y = [];
  // y[ 0 ] = + dorigin[ 0 ];
  // y[ 1 ] = - dorigin[ 1 ];

  // let m = [];
  // m[ 0 ] = + r1[ 1 ][ 0 ];
  // m[ 1 ] = - r1[ 1 ][ 1 ];
  // m[ 2 ] = - r2[ 1 ][ 0 ];
  // m[ 3 ] = + r2[ 1 ][ 1 ];

  // let x = d2linearEquationSolve( m,y );
  // debbuger;
  // return x;

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( r1.length === r2.length,'The two rays must have the same dimension' );

  let r1View = _.ray._from( r1.slice() );
  let r2View = _.ray._from( r2.slice() );

  let origin1 = _.ray.originGet( r1View );
  let origin2 = _.ray.originGet( r2View );
  let dOrigin = _.vector.from( avector.subVectors( origin2.slice(), origin1.slice() ) );

  let direction1 = _.ray.directionGet( r1View );
  let direction2 = _.ray.directionGet( r2View );
  let directions = _.Space.make( [ r1.length / 2 , 2 ] );
  directions.colVectorGet( 0 ).copy( direction1 );
  directions.colVectorGet( 1 ).copy( direction2.mulScalar( - 1 ) );

  // Same origin
  let identOrigin = 0;
  for( let i = 0; i < origin1.length; i++ )
  {
    if( origin1.eGet( i ) === origin2.eGet( i ) )
    identOrigin = identOrigin + 1;
  }
  if( identOrigin === origin1.length )
  return _.vector.from( [ 0, 0 ] );

  // Parallel rays
  if( rayParallel( r1, r2 ) === true )
  return 0;

  let result = _.vector.from( [ 0, 0 ] );

  debugger;

  for( let i = 0; i < dOrigin.length - 1 ; i++ )
  {
    let m = _.Space.make( [ 2, 2 ] );
    m.rowSet( 0, directions.rowVectorGet( i ) );
    m.rowSet( 1, directions.rowVectorGet( i + 1 ) );

    let or = _.Space.makeCol( [ dOrigin.eGet( i ), dOrigin.eGet( i + 1 ) ] );

    let o =
    {
      x : null,
      m : m,
      y : or,
      kernel : null,
      pivoting : 1,
    }

    let x = _.Space.solveGeneral( o );

    if( i > 0)
    {
      let x1 = x.base.colVectorGet( 0 ).eGet( 0 );
      let x2 = x.base.colVectorGet( 0 ).eGet( 1 );
      let diff1 = Math.abs( x1 - result.eGet( 0 ) );
      let diff2 = Math.abs( x1 - result.eGet( 1 ) );
      let diff3 = Math.abs( x2 - result.eGet( 0 ) );
      let diff4 = Math.abs( x2 - result.eGet( 1 ) );
      if( ( diff1 < 1E-6 || diff2 < 1E-6 ) && ( diff3 < 1E-6 || diff4 < 1E-6 ) )
      {
      }
      else
      {
        return 0;
      }
    }

    result = _.vector.from( x.base )
  }

  // Factors can not be negative
  if(  result.eGet( 0 ) <= 0 - _.accuracySqr || result.eGet( 1 ) <= 0 - _.accuracySqr )
  return 0;

  return result;
}

//

/**
  * Returns the factors for the intersection of two rays. Returns an array with the intersection factors, 0 if there is no intersection.
  * Rays stay untouched.
  *
  * @param { Vector } src1Ray - The first source ray.
  * @param { Vector } src2Ray - The second source ray.
  *
  * @example
  * // returns   0
  * _.rayIntersectionFactors( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  _.vector.from( [ 2, 1 ] )
  * _.rayIntersectionFactors( [ - 2, 0, 1, 0 ], [ 0, - 2, 0, 2 ] );
  *
  * @returns { Array } Returns the factors for the two rays intersection.
  * @function rayIntersectionFactors
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Ray ) is not ray.
  * @throws { Error } An Error if ( src2Ray ) is not ray.
  * @memberof wTools.ray
  */

function rayIntersectionFactors2( r1, r2 )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( r1.length === r2.length,'The two rays must have the same dimension' );

  let r1View = _.ray._from( r1 );
  let origin1 = _.ray.originGet( r1View );
  let direction1 = _.ray.directionGet( r1View );
  let r2View = _.ray._from( r2 );
  let origin2 = _.ray.originGet( r2View );
  let direction2 = _.ray.directionGet( r2View );

  // Same origin
  let identOrigin = 0;
  for( let i = 0; i < origin1.length; i++ )
  {
    if( origin1.eGet( i ) === origin2.eGet( i ) )
    identOrigin = identOrigin + 1;
  }
  if( identOrigin === origin1.length )
  return [ 0, 0 ];

  // Parallel rays
  if( rayParallel( r1, r2 ) === true )
  return 0;

  let x = [];
  let origin1x = origin1.eGet( 0 ); let origin1y = origin1.eGet( 1 );
  let dir1x = direction1.eGet( 0 ); let dir1y = direction1.eGet( 1 );
  let origin2x = origin2.eGet( 0 ); let origin2y = origin2.eGet( 1 );
  let dir2x = direction2.eGet( 0 ); let dir2y = direction2.eGet( 1 );
  x[ 1 ] = ( dir1x*( origin2y - origin1y ) + dir1y*( origin1x -origin2x ) ) / ( dir2x*dir1y - dir2y*dir1x );

  let w = 1;
  while( isNaN( x[ 1 ] ) && w < origin1.length - 1 )
  {
    let origin1y = origin1.eGet( w + 1 ); let dir1y = direction1.eGet( w + 1 );
    let origin2y = origin1.eGet( w + 1 ); let dir2y = direction1.eGet( w + 1 );
    x[ 1 ] = ( dir1x*( origin2y - origin1y ) + dir1y*( origin1x -origin2x ) ) / ( dir2x*dir1y - dir2y*dir1x );
    w = w + 1;
  }
  x[ 0 ] = ( origin2x + dir2x*x[ 1 ] - origin1x )/ dir1x;

  // Factors can not be negative
  if(  x[ 0 ] <= 0 - _.accuracySqr || x[ 1 ] <= 0 - _.accuracySqr )
  return 0;

  if(  x[ 0 ] === Infinity || x[ 1 ] === Infinity )
  return 0;

  if(  !_.numberIs( x[ 0 ] ) || isNaN( x[ 0 ] ) || !_.numberIs( x[ 1 ] ) || isNaN( x[ 1 ] ) )
  return 0;

  // Check other dimensions in ray coincide with the calculated factor
  for( let i = 0; i < origin1.length; i++ )
  {
    let point1 = origin1.eGet( i ) + direction1.eGet( i )*x[ 0 ];
    let point2 = origin2.eGet( i ) + direction2.eGet( i )*x[ 1 ];
    if( Math.abs( point1 - point2 ) > 1E-7 )
    return 0;
  }

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
  let factors = rayIntersectionFactors( r1,r2 );
  if( factors === 0 )
  return 0;

  let result = [ Self.rayAt( r1,factors.eGet( 0 ) ),Self.rayAt( r2,factors.eGet( 1 ) ) ];
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

  let factors = Self.rayIntersectionFactors( r1,r2 );

  if( factors === 0 )
  return 0;

  return Self.rayAt( r1,factors.eGet( 0 ) );

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

/**
  * Returns the point of the intersection of two rays. Returns an array with the intersection point, 0 if there is no intersection.
  * Rays stay untouched. Only for 2D.
  *
  * @param { Vector } src1Ray - The first source ray.
  * @param { Vector } src2Ray - The second source ray.
  *
  * @example
  * // returns   0
  * _.rayIntersectionPointAccurate( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  [ [ 0, 0 ], [ 0, 0 ] ]
  * _.rayIntersectionPointAccurate( [ -3, 0, 1, 0 ], [ 0, -2, 0, 1 ] );
  *
  * @returns { Array } Returns the point of intersection of the two rays.
  * @function rayIntersectionPointAccurate
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Ray ) is not ray.
  * @throws { Error } An Error if ( src2Ray ) is not ray.
  * @memberof wTools.ray
  */
function rayIntersectionPointAccurate( r1,r2 )
{

  let closestPoints = Self.rayIntersectionPoints( r1,r2 );
  // return closestPoints[ 0 ].add( closestPoints[ 1 ] ).mul( 0.5 );
  debugger;

  if( closestPoints === 0)
  return 0;

  return _.avector.mulScalar( _.avector.add( null, closestPoints[ 0 ], closestPoints[ 1 ] ), 0.5 );

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

//

/**
  * Check if a given point is contained inside a ray. Returs true if it is contained, false if not. Point and ray stay untouched.
  *
  * @param { Array } srcRay - The source ray.
  * @param { Array } srcPoint - The source point.
  *
  * @example
  * // returns true
  * _.pointContains( [ 0, 0, 2, 2 ], [ 1, 1 ] );
  *
  * @example
  * // returns false
  * _.pointContains( [ 0, 0, 2, 2 ], [ - 1, 3 ] );
  *
  * @returns { Boolen } Returns true if the point is inside the ray, and false if the point is outside it.
  * @function pointContains
  * @throws { Error } An Error if ( dim ) is different than point.length (ray and point have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( srcPoint ) is not point.
  * @memberof wTools.ray
  */
function pointContains( srcRay, srcPoint )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  if( srcRay === null )
  srcRay = _.ray.make( srcPoint.length );

  let srcRayView = _.ray._from( srcRay.slice() );
  let origin = _.ray.originGet( srcRayView );
  let direction = _.ray.directionGet( srcRayView );
  let dimension  = _.ray.dimGet( srcRayView )
  let srcPointView = _.vector.from( srcPoint.slice() );

  _.assert( dimension === srcPoint.length, 'The ray and the point must have the same dimension' );
  let dOrigin = _.vector.from( avector.subVectors( srcPointView, origin ) );

  let factor;
  if( direction.eGet( 0 ) === 0 )
  {
    if( Math.abs( dOrigin.eGet( 0 ) ) > _.accuracySqr )
    {
      return false;
    }
    else
    {
      factor = 0;
    }
  }
  else
  {
    factor = dOrigin.eGet( 0 ) / direction.eGet( 0 );
  }

  // Factor can not be negative
  if(  factor <= 0 - _.accuracySqr )
  return false;

  for( var i = 1; i < dOrigin.length; i++ )
  {
    let newFactor;
    if( direction.eGet( i ) === 0 )
    {
      if( Math.abs( dOrigin.eGet( i ) ) > _.accuracySqr )
      {
        return false;
      }
      else
      {
        newFactor = 0;
      }
    }
    else
    {
      newFactor = dOrigin.eGet( i ) / direction.eGet( i );
      if( Math.abs( newFactor - factor ) > _.accuracySqr && newFactor !== 0 && factor !== 0 )
      {
        return false;
      }
      factor = newFactor;
    }
  }

  return true;
}

//

/**
  * Get the distance between a point and a ray. Returs the calculated distance. Point and ray stay untouched.
  *
  * @param { Array } srcRay - The source ray.
  * @param { Array } srcPoint - The source point.
  *
  * @example
  * // returns 0
  * _.pointDistance( [ 0, 0, 0, 2 ], [ 0, 1 ] );
  *
  * @example
  * // returns 2
  * _.pointDistance( [ 0, 0, 0, 2 ], [ 2, 2 ] );
  *
  * @returns { Boolen } Returns the distance between the point and the ray.
  * @function pointDistance
  * @throws { Error } An Error if ( dim ) is different than point.length (ray and point have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( srcPoint ) is not point.
  * @memberof wTools.ray
  */
function pointDistance( srcRay, srcPoint )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  if( srcRay === null )
  srcRay = _.ray.make( srcPoint.length );

  let srcRayView = _.ray._from( srcRay.slice() );
  let origin = _.ray.originGet( srcRayView );
  let direction = _.ray.directionGet( srcRayView );
  let dimension  = _.ray.dimGet( srcRayView )
  let srcPointView = _.vector.from( srcPoint.slice() );

  _.assert( dimension === srcPoint.length, 'The ray and the point must have the same dimension' );

  if( _.ray.pointContains( srcRayView, srcPointView ) )
  {
    return 0;
  }
  else
  {
    if( _.ray.getFactor === false )
    {
      let dOrigin = _.vector.from( avector.subVectors( srcPointView, origin ) );
      return Math.norm( dOrigin );
    }
    else
    {
      let projection = _.ray.pointClosestPoint( srcRayView, srcPointView );
      let dPoints = _.vector.from( avector.subVectors( srcPointView, projection ) );
      debugger;
      let mod = _.vector.dot( dPoints, dPoints );
      console.log( mod )
      mod = Math.sqrt( mod );
      return mod;
    }

  }

  return true;
}

/**
  * Get the closest point between a point and a ray. Returs the calculated point. srcPoint and ray stay untouched.
  *
  * @param { Array } srcRay - The source ray.
  * @param { Array } srcPoint - The source point.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  * _.pointClosestPoint( [ 0, 0, 0, 2 ], [ 0, 1 ] );
  *
  * @example
  * // returns [ 0, 2 ]
  * _.pointClosestPoint( [ 0, 0, 0, 2 ], [ 2, 2 ] );
  *
  * @returns { Boolen } Returns the closest point in a ray to a point.
  * @function pointClosestPoint
  * @throws { Error } An Error if ( dim ) is different than point.length (ray and point have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( srcPoint ) is not point.
  * @memberof wTools.ray
  */
function pointClosestPoint( srcRay, srcPoint, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( srcPoint.length );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcRay === null )
  srcRay = _.ray.make( srcPoint.length );

  let srcRayView = _.ray._from( srcRay.slice() );
  let origin = _.ray.originGet( srcRayView );
  let direction = _.ray.directionGet( srcRayView );
  let dimension  = _.ray.dimGet( srcRayView )
  let srcPointView = _.vector.from( srcPoint.slice() );
  let dstPointView = _.vector.from( dstPoint );

  _.assert( dimension === srcPoint.length, 'The ray and the point must have the same dimension' );

  let pointVector;

  var dir = 0;
  for( var i = 0; i < direction.length; i++ )
  {
    if( direction.eGet( i ) === 0 )
    dir = dir + 1;
  }

  if( dir === direction.length )
  {
    pointVector = origin;
  }
  else if( _.ray.pointContains( srcRayView, srcPointView ) )
  {
    pointVector = _.vector.from( srcPointView );
  }
  else
  {
    let dOrigin = _.vector.from( avector.subVectors( srcPointView, origin ) );
    let dot = _.vector.dot( direction, direction );
    let factor = _.vector.dot( direction , dOrigin ) / dot ;
    if( factor < 0 || dot === 0 )
    {
      pointVector = _.vector.from( origin );
    }
    else
    {
      pointVector = _.vector.from( _.ray.rayAt( srcRayView, factor ) );
    }
  }

  for( let i = 0; i < pointVector.length; i++ )
  {
    dstPointView.eSet( i, pointVector.eGet( i ) );
  }

  return dstPoint;
}


// --
// define class
// --

let Proto =
{

  make : make,
  makeZero : makeZero,
  makeNil : makeNil,

  zero : zero,
  nil : nil,

  from : from,
  _from : _from,
  fromPair : fromPair, // fromPoints : fromPoints,

  is : is,
  dimGet : dimGet,
  originGet : originGet,
  directionGet : directionGet,

  rayAt : rayAt,
  getFactor : getFactor,

  rayParallel : rayParallel,
  rayIntersectionFactors : rayIntersectionFactors,
  rayIntersectionFactors2 : rayIntersectionFactors2,
  rayIntersectionPoints : rayIntersectionPoints,
  rayIntersectionPoint : rayIntersectionPoint,
  rayIntersectionPointAccurate : rayIntersectionPointAccurate,

  pointContains : pointContains,
  pointDistance : pointDistance,
  pointClosestPoint : pointClosestPoint,

  // boxIntersects : boxIntersects,
  // boxDistance : boxDistance,
  // boxClosestPoint : boxClosestPoint,

  // sphereIntersects : sphereIntersects,
  // sphereDistance : sphereDistance,
  // sphereClosestPoint : sphereClosestPoint,

  // planeIntersects : planeIntersects,
  // planeDistance : planeDistance,
  // planeClosestPoint : planeClosestPoint,

  // frustumIntersects : frustumIntersects,
  // frustumDistance : frustumDistance,
  // frustumClosestPoint : frustumClosestPoint,

}

_.mapSupplement( Self, Proto );

//

if( typeof module !== 'undefined' )
{

  require( './Sphere.s' );

}

})();
