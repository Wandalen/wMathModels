(function _ConvexPolygon_s_(){

'use strict';

let _ = _global_.wTools;
let avector = _.avector;
let vector = _.vector;
let Self = _.convexPolygon = _.convexPolygon || Object.create( null );

/*

  A convex polygon is a simple polygon where all interior angles are less than or equal
  to 180 degrees. Therefore, it is a plane figure ( 2D ), closed and defined by a set of
  edges ( segments ) and vertices ( corners ).

  In the following methods, convex polygons will be defined by a space where each column
represents one of the plygon´s vertices.

*/

// --
// routines
// --

/**
  * Create a convex polygon of 'vertices' number of vertices and dimension dim, full of zeros.
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
  * @memberof wTools.convexPolygon
  */
function make( dim, vertices )
{
  _.assert( arguments.length === 2, 'convexPolygon.make expects exactly 2 arguments' );
  _.assert( _.numberIs( dim ), 'dim must be a number' );
  _.assert( _.numberIs( vertices ), 'vertices must be a number' );

  let dst = _.Space.makeZero([ dim, vertices ]);

  return dst;
}

//

/**
  * Check if the source polygon is a convex polygon. Returns true if it is a convex polygon.
  * Source polygon stays unchanged.
  *
  * @param { Space } polygon - The source polygon.
  *
  * @example
  * // returns true;
  * var polygon = _.Space.make([ 3, 5 ]).copy
  * ([
  *   1, 0, -1, 0, 2,
  *   0, 0, 1, 2, 2,
  *   0, 0, 0, 0, 0
  * ]);
  * _.is( polygon );
  *
  * @example
  * // returns false;
  * var polygon = _.Space.make([ 3, 5 ]).copy
  * ([
  *   1, 0, -1, 0, 2,
  *   0, 0, 1, 2, 2,
  *   0, 0, 0, 2, 0
  * ]);
  * _.is( polygon );
  *
  * @returns { Boolean } Returns true of polygon is a convex polygon and false if not.
  * @function is
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @memberof wTools.convexPolygon
  */
function is( polygon )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  let dims = _.Space.dimsOf( polygon );

  if( dims[ 1 ] > 3 )
  {
    let vertexOne = polygon.colVectorGet( 0 );
    let vertexTwo = polygon.colVectorGet( 1 );
    let vertexThree = polygon.colVectorGet( 2 );
    let plane = _.plane.fromPoints( null, vertexOne, vertexTwo, vertexThree );

    for( let i = 3 ; i < dims[ 1 ]; i += 1 )
    {
      let vertex = polygon.colVectorGet( i );
      if( !_.plane.pointContains( plane, vertex ) )
      return false;
    }
  }

  return _.spaceIs( polygon );
}

//

/**
  * Get an angle out of three points. Returns angle in radians.
  * Source points and normal stay unchanged.
  * Angle is calculated counter clockwise, according to the plane of the src normal.
  * If normal is not provided, it returns the small angle.
  *
  * @param { Array } pointOne - The first source point.
  * @param { Array } pointTwo - The second source point ( the middle point ).
  * @param { Array } pointThree - The third source point.
  * @param { Array } normal - Direction of the reference plane.
  *
  * @example
  * // returns pi / 2;
  * _.angleThreePoints( [ 1, 0, 0 ], [ 0, 0, 0 ], [ 0, 1, 0 ] , [ 0, 0, 1 ] );
  *
  * @returns { Number } Returns the angle formed by the three points in radians.
  * @function angleThreePoints
  * @throws { Error } An Error if ( arguments.length ) is different than four.
  * @memberof wTools.convexPolygon
  */
function angleThreePoints( pointOne, pointTwo, pointThree, normal  )
{
  _.assert( arguments.length === 3 || arguments.length === 4, 'Expects three or four arguments' );
  _.assert( pointOne.length === pointTwo.length, 'Points must have same length' );
  _.assert( pointOne.length === pointThree.length, 'Points must have same length' );

  let angle;
  let pointOneView = _.vector.from( pointOne );
  let pointTwoView = _.vector.from( pointTwo );
  let pointThreeView = _.vector.from( pointThree );
  let vectorOne = _.vector.subVectors( pointOneView.clone(), pointTwoView );
  let vectorTwo = _.vector.subVectors( pointThreeView.clone(), pointTwoView );

  if( arguments.length === 3 )
  {
    let plane = _.plane.fromPoints( null, pointOne, pointTwo, pointThree );
    var normal = _.plane.normalGet( plane );
  }

  let normalView = _.vector.from( normal );
  normalView.normalize();
  _.assert( pointOne.length === normal.length, 'Normal and points must have same length' );
  _.assert( _.vector.mag( normalView ) === 1 );

  let dot = _.vector.dot( vectorOne, vectorTwo );
  let cross = _.vector.cross( vectorOne.clone(), vectorTwo );

  let det = _.vector.dot( normalView, cross );

  angle = Math.atan2( det, dot );

  if( angle < 0 )
  {
    angle = 2 * Math.PI + angle;
  }
  return angle;
}




// --
// declare
// --


let Proto =
{

  make : make,
  is : is,

  angleThreePoints : angleThreePoints,

}

_.mapSupplement( Self,Proto );

})();
