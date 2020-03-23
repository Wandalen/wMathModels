(function _ConcavePolygon_s_(){

'use strict';

let _ = _global_.wTools;
// let this.tools.avector = this.tools.avector;
// let vector = this.tools.vectorAdapter;
let Self = _.concavePolygon = _.concavePolygon || Object.create( _.avector );

/*

  A concave polygon is a simple polygon where all interior angles are greater
  than 180 degrees. Therefore, it is a plane figure ( 2D ), closed and defined by a set of
  A concave polygon is the opposite of a convex polygon.
  In the following methods, concave polygons will be defined by a space where each column
represents one of the plygon´s vertices.

*/

// --
// routines
// --

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
  * _.make( 3, 8 );
  *
  * @example
  * // returns [ 0, 0, 1, 1 ];
  * _.make( [ 0, 0, 1, 1 ] );
  *
  * @returns { Array } Returns the array of the created box.
  * @function make
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @memberof wTools.concavePolygon
  */

function make( dim, vertices )
{
  _.assert( arguments.length === 2, 'concavePolygon.make expects exactly 2 arguments' );
  _.assert( _.numberIs( dim ) && dim > 1 && dim < 4, 'dim must be a number ( 2 or 3 )' );
  _.assert( _.numberIs( vertices ) && vertices > 2, 'vertices must be a number superior to two' );

  let dst = _.Matrix.makeZero([ dim, vertices ]);

  return dst;
}

//

/**
  * Check if the source polygon is a polygon. Returns true if it is a polygon.
  * Source polygon stays unchanged.
  *
  * @param { Matrix } polygon - The source polygon.
  *
  * @example
  * // returns true;
  * var polygon = _.Matrix.make([ 3, 5 ]).copy
  * ([
  *   1, 0, -1, 0, 2,
  *   0, 0, 1, 2, 2,
  *   0, 0, 0, 0, 0
  * ]);
  * _.isPolygon( polygon );
  *
  * @example
  * // returns false;
  * var polygon = _.Matrix.make([ 3, 5 ]).copy
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
  * @memberof wTools.concavePolygon
  */
function isPolygon( polygon )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.matrixIs( polygon ) );

  let dims = _.Matrix.DimsOf( polygon );

  if(  dims[ 0 ] < 2 || dims[ 0 ] > 3 || dims[ 1 ] < 3 )
  return false;
  else if( dims[ 0 ] === 3 && dims[ 1 ] > 3 )
  {
    let normal = this.tools.vectorAdapter.from( this.tools.longMakeZeroed/* _.array.makeArrayOfLengthZeroed */( dims[ 0 ] ) );
    let plane = this.tools.vectorAdapter.from( this.tools.longMakeZeroed/* _.array.makeArrayOfLengthZeroed */( dims[ 0 ] + 1 ) );
    let i = 0;

    while( this.tools.vectorAdapter.allEquivalent( normal, this.tools.vectorAdapter.fromNumber( 0, dims[ 0 ] ) ) && ( i <= dims[ 1 ] - 3 ) )
    {
      let pointOne = polygon.colVectorGet( i );
      let pointTwo = polygon.colVectorGet( i + 1 );
      let pointThree = polygon.colVectorGet( i + 2 );
      plane = this.tools.plane.fromPoints( null, pointOne, pointTwo, pointThree );
      normal = this.tools.plane.normalGet( plane );
      i = i + 1;
    }

    for( let i = 0 ; i < dims[ 1 ]; i += 1 )
    {
      let vertex = polygon.colVectorGet( i );

      if( !this.tools.plane.pointContains( plane, vertex ) )
      return false;
    }
  }

  return true;
}

//

function is( polygon )
{
  return _.matrixIs( polygon );
}

//

function pointContains( polygon, point )
{
  let self = this;
  //let c = [ point[ 0 ], point[ 1 ], 1 ];
  let line21 = [];
  let line20 = [];
  let p = 0;
  let pl = polygon.length / 2;
  let inside = 0;

  _.assert( pl === 2, 'not implemented' );

  //

  function pointsPointSide( points, point )
  {

    let point1 = [];
    point1[ 0 ] = points[ 0 ][ 0 ] - point[ 0 ];
    point1[ 1 ] = points[ 0 ][ 1 ] - point[ 1 ];

    let point2 = [];
    point2[ 0 ] = points[ 1 ][ 0 ] - point[ 0 ];
    point2[ 1 ] = points[ 1 ][ 1 ] - point[ 1 ];

    if( point1[ 0 ] < 0 && point2[ 0 ] < 0 )
    return false;

    if( point1[ 0 ] > 0 && point2[ 0 ] > 0 )
    return false;

    if( point1[ 0 ] === point2[ 0 ] )
    {
      if( point1[ 1 ] < 0 && point2[ 1 ] < 0 )
      return false;

      if( point1[ 1 ] > 0 && point2[ 1 ] > 0 )
      return false;

      return 2;
    }

    let upper = point2[ 1 ] - point2[ 0 ] * ( point1[ 1 ]-point2[ 1 ] ) / ( point1[ 0 ]-point2[ 0 ] );

    if( upper === 0 )
    return 2;

    return upper >= 0;
  }

  //

  let p1 = [ polygon[ (pl-1)*2+0 ], polygon[ (pl-1)*2+1 ] ];
  let p2 = [ polygon[ (p+0)*2+0 ], polygon[ (p+0)*2+1 ] ];
  let side = pointsPointSide( [ p1, p2 ], point );
  if( side === 2 ) return 1;
  inside = inside + side;

  //

  for( p = 1 ; p < pl ; p++ )
  {

    let p1 = [ polygon[ (p-1)*2+0 ], polygon[ (p-1)*2+1 ] ];
    let p2 = [ polygon[ (p+0)*2+0 ], polygon[ (p+0)*2+1 ] ];
    let side = pointsPointSide( [ p1, p2 ], point );
    if( side === 2 ) return p+1;
    inside = inside + side;

  }

  return inside % 2 ? pl+1 : 0;
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
  * let polygon = _.Matrix.make( [ 2, 3 ] ).copy
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
  * @memberof wTools.concavePolygon
  */

//

function pointDistanceSqr( polygon, point )
{
  _.assert( arguments.length === 2 );

  let p = 0;
  let pl = polygon.length / 2;

  _.assert( pl === 2, 'not implemented' );

  let p1 = [ polygon[ (pl-1)*2+0 ], polygon[ (pl-1)*2+1 ] ]
  let p2 = [ polygon[ (p+0)*2+0  ], polygon[ (p+0)*2+1 ]  ]
  let segment = this.tools.segment.fromPair( [ p1, p2 ] );

  let distance = this.tools.segment.pointDistanceSqr( segment, point );

  for( p = 1 ; p < pl ; p++ )
  {
    let p1 = [ polygon[ (p-1)*2+0 ], polygon[ (p-1)*2+1 ] ]
    let p2 = [ polygon[ (p+0)*2+0 ], polygon[ (p+0)*2+1 ] ]
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
  * let polygon = _.Matrix.make( [ 2, 3 ] ).copy
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
  * @memberof wTools.concavePolygon
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

  make,
  isPolygon,
  is,

  pointContains,
  pointDistanceSqr,
  pointDistance,

  // ref

  tools : _,
}

_.mapExtend( Self, Extension );

})();
