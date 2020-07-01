(function _ConcavePolygon_s_(){

'use strict';

let _ = _global_.wTools;
// let this.tools.avector = this.tools.avector;
// let vector = this.tools.vectorAdapter;
let Self = _.concavePolygon = _.concavePolygon || Object.create( _.avector );


/**
 * @description
 * A concave polygon is a simple polygon where all interior angles are greater
 * than 180 degrees. Therefore, it is a plane figure ( 2D ), closed and defined by a set of
 * A concave polygon is the opposite of a convex polygon.
 * In the following methods, concave polygons will be defined by a space where each column
 * represents one of the plygon´s vertices.
 * @namespace wTools.concavePolygon
 * @module Tools/math/Concepts
 */

// --
// routines
// --

function is( polygon )
{
  return this.tools.convexPolygon.is( polygon );
}

/**
 * Check if the source polygon is a polygon. Returns true if it is a polygon.
 * Source polygon stays unchanged.
 *
 * @param { Matrix } polygon - The source polygon.
 *
 * @example
 * // returns true;
 * var polygon = _.Matrix.Make([ 3, 5 ]).copy
 * ([
 *   1, 0, -1, 0, 2,
 *   0, 0, 1, 2, 2,
 *   0, 0, 0, 0, 0
 * ]);
 * _.isPolygon( polygon );
 *
 * @example
 * // returns false;
 * var polygon = _.Matrix.Make([ 3, 5 ]).copy
 * ([
 *   1, 0, -1, 0, 2,
 *   0, 0, 1, 2, 2,
 *   0, 0, 0, 2, 0
 * ]);
 * _.isPolygon( polygon );
 *
 * @returns { Boolean } Returns true if polygon is a polygon and false if not.
 * @function isPolygon
 * @throws { Error } An Error if ( arguments.length ) is different than one.
 * @namespace wTools.concavePolygon
 * @module Tools/math/Concepts
 */

function isPolygon( polygon )
{
  return this.tools.convexPolygon.isPolygon( polygon );
}

//

function isConvex( polygon )
{
  if( !this.isPolygon( polygon ) )
  return false;
  return !this.isConcave( polygon );
}

//

function isConcave( polygon )
{

  if( !this.isPolygon( polygon ) )
  return false;

  let dims = _.Matrix.DimsOf( polygon );

  if ( dims[ 1 ] < 4 )
  return false;

  let result = false;
  let vertexNumber = dims[ 1 ];

  for( let i = 0 ; i < vertexNumber ; i++ )
  {
    let dx1 = polygon.scalarGet([ 0, ( i + 2 ) % vertexNumber ]) - polygon.scalarGet([ 0, ( i + 1 ) % vertexNumber ]);
    let dy1 = polygon.scalarGet([ 1, ( i + 2 ) % vertexNumber ]) - polygon.scalarGet([ 1, ( i + 1 ) % vertexNumber ]);
    let dx2 = polygon.scalarGet([ 0, i ]) - polygon.scalarGet([ 0, ( i + 1 ) % vertexNumber ]);
    let dy2 = polygon.scalarGet([ 1, i ]) - polygon.scalarGet([ 1, ( i + 1 ) % vertexNumber ]);
    let cross = dx1 * dy2 - dy1 * dx2;

    if ( i == 0 )
    result = cross > 0;
    else if ( result != ( cross > 0 ) )
    return true;
  }

  return false;
}

//

function isClockwise( polygon )
{
  return this.tools.convexPolygon.isClockwise( polygon );
}

//

/**
 * Create a concave polygon of 'vertices' number of vertices and dimension dim ( 2 or 3 ), full of zeros.
 * Returns the created polygon. Vertices and dim remain unchanged.
 *
 * @param { Number } vertices - Number of vertices of the polygon.
 * @param { Number } dim - Dimension of the created polygon.
 *
 * @example
 * // returns cvexPolygon =
 * [
 *   0, 0, 0, 0, 0, 0, 0, 0,
 *   0, 0, 0, 0, 0, 0, 0, 0,
 *   0, 0, 0, 0, 0, 0, 0, 0,
 * ];
 * _.make( 8, 3 );
 *
 * @example
 * // returns [ 0, 0, 1, 1 ];
 * _.make( [ 0, 0, 1, 1 ] );
 *
 * @returns { Array } Returns the array of the created box.
 * @function make
 * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
 * @namespace wTools.concavePolygon
 * @module Tools/math/Concepts
 */

function make( vertices, dim )
{
  return this.tools.convexPolygon.make( vertices, dim );
}
//

function pointContains( polygon, point )
{
  let self = this;

  let p = 0;
  let pl = polygon.length / 2;

  _.assert( pl === 2, 'not implemented' );

  let p1 = [ polygon[ (pl-1)*2+0 ], polygon[ (pl-1)*2+1 ] ];

  for( p = 1 ; p < pl ; p++ )
  {

    let p2 = [ polygon[ (p-1)*2+0 ], polygon[ (p-1)*2+1 ] ];
    let p3 = [ polygon[ (p+0)*2+0 ], polygon[ (p+0)*2+1 ] ];

    let side = this.tools.linePointDir.pointsToPointSide( [ p1, p2 ], point );
    if( side === 0 )
    {
      let r = this.tools.segment.relativeSegment( [ p1, p2 ], point );
      return 0 <= r && r <= 1 ? p : 0;
    }

    let cside1 = this.tools.linePointDir.pointsToPointSide( [ p2, p3 ], point );
    if( side*cside1 < 0 )
    continue;
    else if( cside1 === 0 )
    {
      let r = this.tools.segment.relativeSegment( [ p2, p3 ], point );
      return 0 <= r && r <= 1 ? p : 0;
    }

    let cside2 = this.tools.linePointDir.pointsToPointSide( [ p3, p1 ], point );
    if( side*cside2 < 0 )
    continue;
    else if( cside2 === 0 )
    {
      let r = this.tools.segment.relativeSegment( [ p3, p1 ], point );
      return 0 <= r && r <= 1 ? p : 0;
    }

    return pl+1;
  }

  return 0;
}

//

/**
 * Calculates the distance between a concave polygon and a point. Returns the squared distance.
 * Polygon and point remain unchanged.
 *
 * @param { ConvexPolygon } polygon - Source polygon.
 * @param { Array } point - Source point.
 *
 * @example
 * // returns 1;
 * let polygon = _.Matrix.Make( [ 2, 3 ] ).copy
 * ([
 *     0, 1, 0,
 *     1, 0, 0
 * ]);
 * _.concavePolygon.pointDistanceSqr( polygon, [ 2, 0 ] );
 **
 * @returns { Distance } Returns the distance between the polygon and the point.
 * @function pointDistanceSqr
 * @throws { Error } An Error if ( arguments.length ) is different than two.
 * @throws { Error } An Error if ( polygon ) is not concave polygon.
 * @throws { Error } An Error if ( point ) is not point.
 * @namespace wTools.concavePolygon
 * @module Tools/math/Concepts
 */

//

function pointDistanceSqr( polygon, point )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( polygon ), 'polygon must be a concave polygon' );

  let p = 0;
  let pointView = this.tools.vectorAdapter.from( point );
  let dims = _.Matrix.DimsOf( polygon );
  let pl = polygon.dims[ 1 ];

  _.assert( dims[ 0 ] === pointView.length, 'Polygon and point must have same dimension' )

  let p1 = polygon.colGet( pl - 1 );
  let p2 = polygon.colGet( p );
  let segment = this.tools.segment.fromPair( [ p1, p2 ] );

  let distance = this.tools.segment.pointDistanceSqr( segment, point );

  for( p = 1 ; p < pl ; p++ )
  {
    let p1 = polygon.colGet( p - 1 );
    let p2 = polygon.colGet( p );
    let segment = this.tools.segment.fromPair( [ p1, p2 ] );
    let d = this.tools.segment.pointDistanceSqr( segment, point );
    if( d < distance ) distance = d;
  }

  return distance;
}

//

/**
 * Calculates the distance between a concave polygon and a point. Returns the square root of calculated distance.
 * Polygon and point remain unchanged.
 *
 * @param { ConvexPolygon } polygon - Source polygon.
 * @param { Array } point - Source point.
 *
 * @example
 * // returns 1;
 * let polygon = _.Matrix.Make( [ 2, 3 ] ).copy
 * ([
 *     0, 1, 0,
 *     1, 0, 0
 * ]);
 * _.concavePolygon.pointDistance( polygon, [ 2, 0 ] );
 **
 * @returns { Distance } Returns the distance between the polygon and the point.
 * @function pointDistance
 * @throws { Error } An Error if ( arguments.length ) is different than two.
 * @throws { Error } An Error if ( polygon ) is not concave polygon.
 * @throws { Error } An Error if ( point ) is not point.
 * @namespace wTools.concavePolygon
 * @module Tools/math/Concepts
 */

function pointDistance( polygon, point )
{
  _.assert( arguments.length === 2 );

  return Math.sqrt( this.pointDistanceSqr( polygon, point ) );
}

// --
// declare
// --


let Extension = /* qqq xxx : normalize order */
{

  is,
  isPolygon,
  isConvex,
  isConcave,
  isClockwise,

  make,

  pointContains,
  pointDistanceSqr,
  pointDistance,

  // ref

  tools : _,
}

_.mapExtend( Self, Extension );

})();
