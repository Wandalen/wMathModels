(function _LinePoints_s_(){

'use strict';

let _ = _global_.wTools;
// let this.tools.avector = this.tools.avector;
// let vector = this.tools.vectorAdapter;
let Self = _.linePoints = _.linePoints || Object.create( _.avector );

// --
// routines
// --

function make( dim )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = this.makeZero( dim );
  if( this.is( dim ) )
  this.tools.avector.assign( result, dim );
  return result;
}

//

function makeZero( dim )
{
  if( this.is( dim ) )
  dim = this.dimGet( dim );
  if( dim === undefined || dim === null )
  dim = 2;
  _.assert( dim >= 0 );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = _.dup( 0, dim * 2 )
  return result;
}

//

function from( pair )
{

  _.assert( this.is( pair ) || pair === null );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( pair === null )
  return this.make();

  return pair;
}

//

/**
  * Check if input is a pair. Returns true if it is a pair and false if not.
  *
  * @param { Vector } pair - Source pair.
  *
  * @example
  * // returns true;
  * _.pair.is( [ [ 0, 0 ], [ 1, 1 ]  ] );
  * // returns false;
  * _.pair.is( [ 0,0 ] );
  *
  * @returns { Boolean } Returns true if the input is pair.
  * @function is
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @memberof module:Tools/math/Concepts.wTools.pair
  */

function is( pair )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  return ( _.longIs( pair ) || _.vectorAdapterIs( pair ) ) && ( pair.length % 2 === 0 ) && ( pair.length >= 4 );
}

//

/**
  * Get pair dimension. Returns the dimension of the pair. Pair stays untouched.
  *
  * @param { Vector } pair - The source pair.
  *
  * @example
  * // returns 2
  * _.dimGet( [ 0, 0, 0, 0 ] );
  *
  * @returns { Number } Returns the dimension of the pair.
  * @function dimGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( pair ) is not pair.
  * @memberof module:Tools/math/Concepts.wTools.pair
  */

function dimGet( pair )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( this.is( pair ) );
  return pair.length / 2;
}

//

function fromRay( dstPair, srcRay )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( arguments.length === 1 )
  {
    srcRay = arguments[ 0 ];
    dstPair = null;
  }

  if( dstPair === null )
  dstPair = this.make( srcRay.length / 2 )

  _.assert( this.is( dstPair ) );
  _.assert( srcRay.length === dstPair.length );

  let d = this.dimGet( dstPair );

  let srcRayP1View = this.tools.vectorAdapter.fromLongLrange( srcRay, 0, d );
  let srcRayP2View = this.tools.vectorAdapter.fromLongLrange( srcRay, d, d );

  let dstPair1View = this.tools.vectorAdapter.fromLongLrange( dstPair, 0, d );
  let dstPair2View = this.tools.vectorAdapter.fromLongLrange( dstPair, d, d );

  dstPair1View.assign( srcRayP1View );
  dstPair2View.assign( this.tools.vectorAdapter.add( null, srcRayP1View, srcRayP2View ) );

  return dstPair;
}

//

function pairAt( pair, factor )
{
  _.assert( arguments.length === 2 );
  _.assert( this.is( pair ) );

  let d = this.dimGet( pair );

  let pair1View = this.tools.vectorAdapter.fromLongLrange( pair, 0, d );
  let pair2View = this.tools.vectorAdapter.fromLongLrange( pair, d, d );

  let a = this.tools.vectorAdapter.mul( null, pair1View, 1-factor );
  let b = this.tools.vectorAdapter.mul( null, pair2View, factor );

  let result = this.tools.vectorAdapter.add( a, b );

  return result;
}

pairAt.shaderChunk =
`
  vec2 pairAt( vec2 pair[ 2 ], float factor )
  {

    vec2 a = pair[ 0 ] * ( 1.0-factor );
    vec2 b = pair[ 1 ] * factor;
    vec2 result = a + b;

    return result;
  }
`

//

function pairPairParallel( pair1, pair2 )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let ray1 = this.tools.ray.fromPair( pair1 );
  let ray2 = this.tools.ray.fromPair( pair2 );
  return this.tools.ray.rayParallel( ray1, ray2 );
}

pairPairParallel.shaderChunk =
`
  vec2 pairPairParallel( vec2 p1[ 2 ], vec2 p2[ 2 ] )
  {

    vec2 r1[ 2 ], r2[ 2 ];
    ray_fromPair( r1, p1 );
    ray_fromPair( r2, p2 );

    return rayRayParallel( r1, r2 );
  }
`

//

function pairIntersectionFactors( pair1, pair2 )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let ray1 = this.tools.ray.fromPair( pair1 );
  let ray2 = this.tools.ray.fromPair( pair2 );
  return this.tools.ray.rayIntersectionFactors( ray1, ray2 );
}

pairIntersectionFactors.shaderChunk =
`
  vec2 pairPairIntersectionFactors( vec2 p1[ 2 ], vec2 p2[ 2 ] )
  {

    vec2 r1[ 2 ], r2[ 2 ];
    ray_fromPair( r1, p1 );
    ray_fromPair( r2, p2 );

    return ray_rayIntersectionFactors( r1, r2 );
  }
`

//


function pairIntersectionPoint( pair1, pair2 )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let ray1 = this.tools.ray.fromPair( pair1 );
  let ray2 = this.tools.ray.fromPair( pair2 );
  return this.tools.ray.rayIntersectionPoint( ray1, ray2 );
}

pairIntersectionPoint.shaderChunk =
`
  vec2 pairPairIntersectionPoint( vec2 p1[ 2 ], vec2 p2[ 2 ] )
  {

    vec2 r1[ 2 ], r2[ 2 ];
    ray_fromPair( r1, p1 );
    ray_fromPair( r2, p2 );

    return ray_rayIntersectionPoint( r1, r2 );
  }
`

//


function pairIntersectionPointAccurate( pair1, pair2 )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let ray1 = this.tools.ray.fromPair( pair1 );
  let ray2 = this.tools.ray.fromPair( pair2 );
  return this.tools.ray.rayIntersectionPointAccurate( ray1, ray2 );
}

pairIntersectionPointAccurate.shaderChunk =
`
  vec2 pairPairIntersectionPointAccurate( vec2 p1[ 2 ], vec2 p2[ 2 ] )
  {

    vec2 r1[ 2 ], r2[ 2 ];
    ray_fromPair( r1, p1 );
    ray_fromPair( r2, p2 );

    return ray_rayIntersectionPointAccurate( r1, r2 );
  }
`

//

function injectChunks( routines )
{

  _global_.w4d = _global_.w4d || Object.create( null );
  let Chunks = w4d.Chunks = w4d.Chunks || Object.create( null );

  for( let r in routines )
  {
    let routine = routines[ r ];

    if( !_.routineIs( routine ) )
    continue;

    if( !routine.shaderChunk )
    continue;

    _.assert( _.strIs( routine.shaderChunk ) );

    let shaderChunk = '';
    shaderChunk += '\n' + routine.shaderChunk + '\n';

    let chunkName = routine.shaderChunkName || r;

    Chunks[ chunkName ] = shaderChunk;

  }

}

// --
// declare
// --


let Extension = /* qqq xxx : normalize order */
{
  make,
  makeZero,

  from,

  is,
  dimGet,

  fromRay,

  pairAt,

  pairPairParallel,
  pairIntersectionFactors,
  pairIntersectionPoint,
  pairIntersectionPointAccurate,

  // ref

  tools : _,
}

_.mapExtend( Self, Extension );
injectChunks( Extension );

})();
