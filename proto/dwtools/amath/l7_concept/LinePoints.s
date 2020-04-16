(function _LinePoints_s_(){

'use strict';

let _ = _global_.wTools;
// let this.tools.avector = this.tools.avector;
// let vector = this.tools.vectorAdapter;
let Self = _.linePoints = _.linePoints || Object.create( _.avector );

/**
 * @description
 * A line defined by two points.
 *
 * For the following functions, lines must have the shape [ X1, Y1, Z1, X2, Y2, Z2 ],
 * where the dimension equals the long's length divided by two.
 *
 * @namespace wTools.linePoints
  * @module Tools/math/Concepts
 */

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

function adapterFrom( points )
{
  _.assert( this.is( points ) );
  _.assert( arguments.length === 1, 'Expects single argument' );
  return this.tools.vectorAdapter.from( points );
}

//

/**
  * Check if input is a line by two points. Returns true if it is a line and false if not.
  *
  * @param { Vector } line - Source line points.
  *
  * @example
  * // returns true;
  * _.linePoints.is( [ 0, 0, 1, 1 ] );
  * // returns false;
  * _.linePoints.is( [ 0,0 ] );
  *
  * @returns { Boolean } Returns true if the input is line by two points.
  * @function is
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  @namespace wTools.linePoints
  * @module Tools/math/Concepts
*/

function is( linePoints )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  return ( _.longIs( linePoints ) || _.vectorAdapterIs( linePoints ) ) && ( linePoints.length % 2 === 0 ) && ( linePoints.length >= 4 );
}

//

/**
  * Get line dimension. Returns the dimension of the line. Line stays untouched.
  *
  * @param { Vector } linePoints - The source points.
  *
  * @example
  * // returns 2
  * _.linePoints.dimGet( [ 0, 0, 0, 0 ] );
  *
  * @returns { Number } Returns the dimension of the line.
  * @function dimGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( linePoints ) is not a line.
  @namespace wTools.linePoints
  * @module Tools/math/Concepts
  */

function dimGet( linePoints )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( this.is( linePoints ) );
  return linePoints.length / 2;
}

//

function firstPointGet( points )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  let pointsView = this.adapterFrom( points );
  return pointsView.review([ 0, points.length / 2 - 1 ]);
}

//

function secondPointGet( points )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  let pointsView = this.adapterFrom( points );
  return pointsView.review([ points.length / 2, points.length - 1 ]);
}

//

function fromRay( ray )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( this.tools.ray.is( ray ) );

  return this.tools.ray.toLinePoints( ray );
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
  let ray1 = this.tools.ray.fromPair2( pair1 );
  let ray2 = this.tools.ray.fromPair2( pair2 );
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
  let ray1 = this.tools.ray.fromPair2( pair1 );
  let ray2 = this.tools.ray.fromPair2( pair2 );
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

pairIntersectionFactors.shaderChunkName = 'pairPairIntersectionFactors'

//


function pairIntersectionPoint( pair1, pair2 )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let ray1 = this.tools.ray.fromPair2( pair1 );
  let ray2 = this.tools.ray.fromPair2( pair2 );
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
pairIntersectionPoint.shaderChunkName = 'pairPairIntersectionPoint'

//


function pairIntersectionPointAccurate( pair1, pair2 )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let ray1 = this.tools.ray.fromPair2( pair1 );
  let ray2 = this.tools.ray.fromPair2( pair2 );
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

pairIntersectionPointAccurate.shaderChunkName = 'pairPairIntersectionPointAccurate'


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
  adapterFrom,

  is,
  dimGet,

  firstPointGet,
  secondPointGet,

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
