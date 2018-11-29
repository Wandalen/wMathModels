(function _ConvexPolygon_s_(){

'use strict';

let _ = _global_.wTools;
let avector = _.avector;
let vector = _.vector;
let Self = _.convexPolygon = _.convexPolygon || Object.create( null );

/*

  A convex polygon is a simple polygon where all interior angles are less than or equal
  edges ( segments ) and vertices ( corners ).
  to 180 degrees. Therefore, it is a plane figure ( 2D ), closed and defined by a set of

  In the following methods, convex polygons will be defined by a space where each column
represents one of the plygon´s vertices.

*/

// --
// routines
// --

/**
  * Create a convex polygon of 'vertices' number of vertices and dimension dim ( 2 or 3 ), full of zeros.
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
  _.assert( _.numberIs( dim ) && dim > 1 && dim < 4, 'dim must be a number ( 2 or 3 )' );
  _.assert( _.numberIs( vertices ) && vertices > 2, 'vertices must be a number superior to two' );

  let dst = _.Space.makeZero([ dim, vertices ]);

  return dst;
}

//

/**
  * Check if the source polygon is a polygon. Returns true if it is a polygon.
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
  * _.isPolygon( polygon );
  *
  * @example
  * // returns false;
  * var polygon = _.Space.make([ 3, 5 ]).copy
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
  * @memberof wTools.convexPolygon
  */
function isPolygon( polygon )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.spaceIs( polygon ) );

  let dims = _.Space.dimsOf( polygon );

  if(  dims[ 0 ] < 2 || dims[ 0 ] > 3 || dims[ 1 ] < 3 )
  return false;
  else if( dims[ 0 ] === 3 && dims[ 1 ] > 3 )
  {
    let normal = _.vector.from( _.array.makeArrayOfLengthZeroed( dims[ 0 ] ) );
    let plane = _.vector.from( _.array.makeArrayOfLengthZeroed( dims[ 0 ] + 1 ) );
    let i = 0;

    while( _.vector.allEquivalent( normal, _.array.makeArrayOfLengthZeroed( dims[ 0 ] ) ) && ( i <= dims[ 1 ] - 3 ) )
    {
      let pointOne = polygon.colVectorGet( i );
      let pointTwo = polygon.colVectorGet( i + 1 );
      let pointThree = polygon.colVectorGet( i + 2 );
      plane = _.plane.fromPoints( null, pointOne, pointTwo, pointThree );
      normal = _.plane.normalGet( plane );
      i = i + 1;
    }

    for( let i = 0 ; i < dims[ 1 ]; i += 1 )
    {
      let vertex = polygon.colVectorGet( i );
      if( !_.plane.pointContains( plane, vertex ) )
      return false;
    }
  }

  return true;
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
  *   1, 0, 1, 0, 2,
  *   0, 0, 1, 2, 2,
  *   0, 0, 0, 0, 0
  * ]);
  * _.is( polygon );
  *
  * @returns { Boolean } Returns true if polygon is a convex polygon and false if not.
  * @function is
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @memberof wTools.convexPolygon
  */
function is( polygon )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.spaceIs( polygon ) );


  if( !_.convexPolygon.isPolygon( polygon ) )
  return false;

  let dims = _.Space.dimsOf( polygon );

  let normal = _.vector.from( _.array.makeArrayOfLengthZeroed( dims[ 0 ] ) );
  if( dims[ 0 ] === 3 )
  {
    let i = 0;
    while( _.vector.allEquivalent( normal, _.array.makeArrayOfLengthZeroed( dims[ 0 ] ) ) && ( i <= dims[ 1 ] - 3 ) )
    {
      let pointOne = polygon.colVectorGet( i );
      let pointTwo = polygon.colVectorGet( i + 1 );
      let pointThree = polygon.colVectorGet( i + 2 );
      let plane = _.plane.fromPoints( null, pointOne, pointTwo, pointThree );
      normal = _.plane.normalGet( plane );
      i = i + 1;
    }
  }

  let angles = _.vector.from( _.array.makeArrayOfLengthZeroed( dims[ 1 ] ) );

  for( let i = 0 ; i < dims[ 1 ] ; i = i + 1 )
  {
    let h =  ( i - 1 >= 0 ) ? i - 1 : dims[ 1 ] - 1;
    let j =  ( i + 1 <= dims[ 1 ] - 1 ) ? i + 1 : 0;

    let pointOne = polygon.colVectorGet( h );
    let pointTwo = polygon.colVectorGet( i );
    let pointThree = polygon.colVectorGet( j );

    if( dims[ 0 ] === 2 )
    {
      angles.eSet( i, _.convexPolygon.angleThreePoints( pointOne, pointTwo, pointThree ) );
    }
    else if( dims[ 0 ] === 3 )
    {
      angles.eSet( i, _.convexPolygon.angleThreePoints( pointOne, pointTwo, pointThree, normal ) );
    }

  }
  debugger;

  if( _.vector.allLessEqual( angles, Math.PI ) || _.vector.allGreaterEqual( angles, Math.PI ) )
  return true;

  return false;
}

//

/**
  * Get an angle out of three points. Returns angle in radians.
  * Source points and normal stay unchanged.
  * Angle is calculated counter clockwise, according to the src normal direction.
  * If normal is not provided, it returns the small angle.
  * For 2D, normal is not used ( always counter clockwise )
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
function angleThreePoints( pointOne, pointTwo, pointThree, normal )
{
  _.assert( arguments.length === 3 || arguments.length === 4, 'Expects three or four arguments' );
  _.assert( pointOne.length === pointTwo.length, 'Points must have same length' );
  _.assert( pointOne.length === pointThree.length, 'Points must have same length' );
  _.assert( pointOne.length === 2 || pointOne.length === 3 , 'Implemented for 2D and 3D' );

  let angle;
  let pointOneView = _.vector.from( pointOne );
  let pointTwoView = _.vector.from( pointTwo );
  let pointThreeView = _.vector.from( pointThree );
  let vectorOne = _.vector.subVectors( pointOneView.clone(), pointTwoView );
  let vectorTwo = _.vector.subVectors( pointThreeView.clone(), pointTwoView );
  let accuracy = 1e-7; /*eps*/

  if( pointOne.length === 3 )
  {
    if( arguments.length === 3 )
    {
      let plane = _.plane.fromPoints( null, pointOne, pointTwo, pointThree );
      var normal = _.plane.normalGet( plane );
    }

    let normalView = _.vector.from( normal );
    normalView.normalize();
    _.assert( pointOne.length === normal.length, 'Normal and points must have same length' );

    if( _.vector.mag( normalView ) === 0 )
    {
      if( _.vector.allEquivalent( vectorOne.normalize(), vectorTwo.normalize() ) )
      return 0;

      return Math.PI;
    }

    _.assert( 1 - accuracy < _.vector.mag( normalView ) && _.vector.mag( normalView ) < 1 + accuracy );

    let dot = _.vector.dot( vectorOne, vectorTwo );
    let cross = _.vector.cross( vectorOne.clone(), vectorTwo );

    let det = _.vector.dot( normalView, cross );

    angle = Math.atan2( det, dot );
  }
  else
  {
    angle = Math.atan2( vectorTwo.eGet( 1 ), vectorTwo.eGet( 0 ) ) - Math.atan2( vectorOne.eGet( 1 ), vectorOne.eGet( 0 ) );
  }

  if( angle < 0 )
  angle = 2 * Math.PI + angle;

  return angle;
}

//

/**
  * Check if the source polygon contains the source point. Returns true if it contains it.
  * Source polygon and point stay unchanged.
  *
  * @param { ConvexPolygon } polygon - The source polygon.
  * @param { Array } point - The source point.
  *
  * @example
  * // returns true;
  * var polygon = _.Space.make([ 3, 5 ]).copy
  * ([
  *   1, 0, -1, 0, 2,
  *   0, 0, 1, 2, 2,
  *   0, 0, 0, 0, 0
  * ]);
  * _.pointContains( polygon, [ 1, 1, 0 ] );
  *
  * @example
  * // returns false;
  * var polygon = _.Space.make([ 3, 5 ]).copy
  * ([
  *   1, 0, -1, 0, 2,
  *   0, 0, 1, 2, 2,
  *   0, 0, 0, 0, 0
  * ]);
  * _.pointContains( polygon, [ 3, 3, 3 ] );
  *
  * @returns { Boolean } Returns true if the src polygon contains the src point, and false if not.
  * @function pointContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( point ) is not a point.
  * @memberof wTools.convexPolygon
  */
function pointContains( polygon, point )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.convexPolygon.is( polygon ) );

  let pointView = _.vector.from( point );
  let dims = _.Space.dimsOf( polygon );

  _.assert( dims[ 0 ] === point.length, 'Polygon and point must have same dimension' )
  debugger;

  let normal = _.vector.from( _.array.makeArrayOfLengthZeroed( dims[ 0 ] ) );
  if( dims[ 0 ] === 3 )
  {
    let plane = _.vector.from( _.array.makeArrayOfLengthZeroed( dims[ 0 ] + 1 ) );
    let i = 0;
    while( _.vector.allIdentical( normal, _.array.makeArrayOfLengthZeroed( dims[ 0 ] ) ) && ( i <= dims[ 1 ] - 3 ) )
    {
      let pointOne = polygon.colVectorGet( i );
      let pointTwo = polygon.colVectorGet( i + 1 );
      let pointThree = polygon.colVectorGet( i + 2 );
      plane = _.plane.fromPoints( null, pointOne, pointTwo, pointThree );
      normal = _.plane.normalGet( plane );
      i = i + 1;
    }

    if( !_.plane.pointContains( plane, pointView ) )
    return false;
  }

  let angles = _.vector.from( _.array.makeArrayOfLengthZeroed( dims[ 1 ] ) );

  for( let i = 0 ; i < dims[ 1 ] ; i = i + 1 )
  {
    let j =  ( i + 1 <= dims[ 1 ] - 1 ) ? i + 1 : 0;

    let vertex = polygon.colVectorGet( i );
    let nextVertex = polygon.colVectorGet( j );

    if( _.vector.allEquivalent( pointView, vertex ) )
    return true;

    if( dims[ 0 ] === 2 )
    {
      angles.eSet( i, _.convexPolygon.angleThreePoints( vertex, pointView, nextVertex ) );
    }
    else if( dims[ 0 ] === 3 )
    {
      angles.eSet( i, _.convexPolygon.angleThreePoints(  vertex, pointView, nextVertex, normal ) );
    }
  }

  if(  _.avector.allEquivalent( angles, _.array.makeArrayOfLengthZeroed( dims[ 1 ] ) ) )
  return false;

  debugger;

  if( _.vector.allLessEqual( angles, Math.PI ) || _.vector.allGreaterEqual( angles, Math.PI ) )
  return true;

  return false;

}

//

/**
  * Calculates the distance between a convex polygon and a point. Returns the calculated distance.
  * Polygon and point remain unchanged.
  *
  * @param { ConvexPolygon } polygon - Source polygon.
  * @param { Array } point - Source point.
  *
  * @example
  * // returns 1;
  * let polygon = _.Space.make( [ 2, 3 ] ).copy
  * ([
  *     0, 1, 0,
  *     1, 0, 0
  * ]);
  * _.pointDistance( polygon, [ 2, 0 ] );
  **
  * @returns { Distance } Returns the distance between the polygon and the point.
  * @function pointDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not convex polygon.
  * @throws { Error } An Error if ( point ) is not point.
  * @memberof wTools.convexPolygon
  */
function pointDistance( polygon, point )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.convexPolygon.is( polygon ) );

  let pointView = _.vector.from( point );
  let dims = _.Space.dimsOf( polygon );

  _.assert( dims[ 0 ] === pointView.length, 'Polygon and point must have same dimension' )
  debugger;

  if( _.convexPolygon.pointContains( polygon, pointView ) )
  return 0;


  let plane = _.vector.from( _.array.makeArrayOfLengthZeroed( dims[ 0 ] + 1 ) );
  if( dims[ 0 ] === 3 )
  {
    let normal = _.vector.from( _.array.makeArrayOfLengthZeroed( dims[ 0 ] ) );
    let i = 0;
    while( _.vector.allIdentical( normal, _.array.makeArrayOfLengthZeroed( dims[ 0 ] ) ) && ( i <= dims[ 1 ] - 3 ) )
    {
      let pointOne = polygon.colVectorGet( i );
      let pointTwo = polygon.colVectorGet( i + 1 );
      let pointThree = polygon.colVectorGet( i + 2 );
      plane = _.plane.fromPoints( null, pointOne, pointTwo, pointThree );
      normal = _.plane.normalGet( plane );
      i = i + 1;
    }

    let proy = _.vector.from( _.plane.pointCoplanarGet( plane, pointView ) );

    if( _.convexPolygon.pointContains( polygon, proy ) )
    return _.vector.distance( pointView, proy );
  }


  let distance = Infinity;
  for( let i = 0 ; i < dims[ 1 ] ; i = i + 1 )
  {
    let j =  ( i + 1 <= dims[ 1 ] - 1 ) ? i + 1 : 0;

    let vertex = polygon.colVectorGet( i );
    let nextVertex = polygon.colVectorGet( j );

    let segment = _.segment.fromPair( [ vertex, nextVertex ] );
    let d = _.segment.pointDistance( segment, pointView );
    _.assert( d > 0 );
    if( d < distance )
    distance = d;
  }

  return distance;
}

//

/**
  * Returns the closest point in a polygon to a point. Returns the coordinates of the closest point.
  * Polygon and point remain unchanged.
  *
  * @param { Polygon } polygon - Source polygon.
  * @param { Array } srcPoint - Source point.
  * @param { Array } dstPoint - Destination point.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * let polygon = _.Space.make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.pointClosestPoint( polygon, [ - 1, - 1, - 1 ] );
  *
  * @returns { Array } Returns the array of coordinates of the closest point in the polygon.
  * @function pointClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( point ) is not point.
  * @memberof wTools.convexPolygon
  */

function pointClosestPoint( polygon , srcPoint, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );
  _.assert( _.convexPolygon.is( polygon ) );

  let pointView = _.vector.from( srcPoint );
  let dims = _.Space.dimsOf( polygon );

  _.assert( dims[ 0 ] === pointView.length, 'Polygon and point must have same dimension' )
  debugger;

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLengthZeroed( dims[ 0 ] );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointView = _.vector.from( dstPoint );

  if( _.convexPolygon.pointContains( polygon, pointView ) )
  {
    dstPointView.copy( pointView );
    return dstPoint;
  }

  let plane = _.vector.from( _.array.makeArrayOfLengthZeroed( dims[ 0 ] + 1 ) );
  if( dims[ 0 ] === 3 )
  {
    let normal = _.vector.from( _.array.makeArrayOfLengthZeroed( dims[ 0 ] ) );
    let i = 0;
    while( _.vector.allIdentical( normal, _.array.makeArrayOfLengthZeroed( dims[ 0 ] ) ) && ( i <= dims[ 1 ] - 3 ) )
    {
      let pointOne = polygon.colVectorGet( i );
      let pointTwo = polygon.colVectorGet( i + 1 );
      let pointThree = polygon.colVectorGet( i + 2 );
      plane = _.plane.fromPoints( null, pointOne, pointTwo, pointThree );
      normal = _.plane.normalGet( plane );
      i = i + 1;
    }

    var proy = _.vector.from( _.plane.pointCoplanarGet( plane, pointView ) );

    if( _.convexPolygon.pointContains( polygon, proy ) )
    {
      dstPointView.copy( proy );
      return dstPoint;
    }
  }


  let distance = Infinity;
  let point;
  for( let i = 0 ; i < dims[ 1 ] ; i = i + 1 )
  {
    let j =  ( i + 1 <= dims[ 1 ] - 1 ) ? i + 1 : 0;

    let vertex = polygon.colVectorGet( i );
    let nextVertex = polygon.colVectorGet( j );

    let segment = _.segment.fromPair( [ vertex, nextVertex ] );
    let d = _.segment.pointDistance( segment, pointView );
    _.assert( d > 0 );
    if( d < distance )
    {
      distance = d;
      point = _.segment.pointClosestPoint( segment, pointView );
    }
  }

  dstPointView.copy( point );

  _.assert( _.convexPolygon.pointContains( polygon, dstPointView ) === true );

  return dstPoint;
}

//

/**
  * Check if a convex polygon and a box intersect. Returns true if they intersect.
  * Convex polygon and box remain unchanged.
  *
  * @param { Polygon } polygon - Source polygon.
  * @param { Array } box - Source box.
  *
  * @example
  * // returns false;
  * let polygon = _.Space.make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.boxIntersects( polygon , [ 4, 4, 4, 5, 5, 5 ] );
  **
  * @returns { Boolean } Returns true if the polygon and the box intersect.
  * @function boxIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( box ) is not box.
  * @memberof wTools.convexPolygon
  */

function boxIntersects( polygon, box )
{

  let boxView = _.box._from( box );
  let dimB = _.box.dimGet( boxView );
  let minB = _.box.cornerLeftGet( boxView );
  let maxB = _.box.cornerRightGet( boxView );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.convexPolygon.is( polygon ) );
  debugger;

  let dims = _.Space.dimsOf( polygon );

  let boxCorners = _.box.cornersGet( boxView );
  let dimCorners = _.Space.dimsOf( boxCorners );

  for( let b = 0; b < dimCorners[ 1 ]; b++ )
  {
    let corner = boxCorners.colVectorGet( b );
    if( _.convexPolygon.pointContains( polygon, corner ) === true )
    {
      return true;
    }
  }


  for( let i = 0 ; i < dims[ 1 ] ; i ++ )
  {
    let point = polygon.colVectorGet( i );

    if( _.box.pointContains( box, point ) === true )
    {
      return true;
    }
  }

  for( let i = 0 ; i < dims[ 1 ] ; i = i + 1 )
  {
    let j = ( i + 1 <= dims[ 1 ] - 1 ) ? i + 1 : 0;

    let vertex = polygon.colVectorGet( i );
    let nextVertex = polygon.colVectorGet( j );

    let segment = _.segment.fromPair( [ vertex, nextVertex ] );

    if( _.segment.boxIntersects( segment, boxView ) )
    {
      return true;
    }
  }

  //3D case include segment - polygon intersection
  if( dims[ 0 ] > 2 )
  {
    let corner0 = boxCorners.colVectorGet( 0 );
    for( let b = 1; b < dimCorners[ 1 ]; b++ )
    {
      let corner = boxCorners.colVectorGet( b );
      let segment = _.segment.fromPair( [ corner0, corner ] );
      if( _.convexPolygon.segmentIntersects( polygon, segment ) === true )
      return true;
    }
  }
  return false;
}

//

/**
  * Get the distance between a convex polygon and a box. Returns the calculated distance.
  * The polygon and box remain unchanged.
  *
  * @param { Polygon } polygon - Source convex polygon.
  * @param { Array } box - Source box.
  *
  * @example
  * // returns 1;
  * let polygon = _.Space.make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.boxDistance( polygon , [ 0, 0, 4, 5, 5, 5 ] );
  *
  * @returns { Number } Returns the distance between the polygon and the box.
  * @function boxDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not polygon.
  * @throws { Error } An Error if ( box ) is not box.
  * @memberof wTools.convexPolygon
  */

function boxDistance( polygon, box )
{
  let boxView = _.box._from( box );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.convexPolygon.is( polygon ) );
  debugger;

  if( _.convexPolygon.boxIntersects( polygon, boxView ) )
  return 0;

  let closestPoint = _.convexPolygon.boxClosestPoint( polygon, boxView );

  let distance = _.box.pointDistance( boxView, closestPoint );

  return distance;
}

//

/**
  * Returns the closest point in a convex polygon to a box. Returns the coordinates of the closest point.
  * The polygon and box remain unchanged.
  *
  * @param { Polygon } polygon - Source convex polygon.
  * @param { Array } box - Source box.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * let polygon = _.Space.make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.boxClosestPoint( polygon , [ - 1, - 1, - 1, -0.1, -0.1, -0.1 ] );
  *
  * @returns { Array } Returns the array of coordinates of the closest point in the convex polygon.
  * @function boxClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( box ) is not box.
  * @memberof wTools.convexPolygon
  */

function boxClosestPoint( polygon, box, dstPoint )
{
  let boxView = _.box._from( box );
  let dimB = _.box.dimGet( boxView );
  let minB = _.box.cornerLeftGet( boxView );
  let maxB = _.box.cornerRightGet( boxView );
  let dims = _.Space.dimsOf( polygon );
  let rows = dims[ 0 ];
  let cols = dims[ 1 ];

  _.assert( _.convexPolygon.is( polygon ) );
  _.assert( dimB === rows );
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( rows );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointView = _.vector.from( dstPoint );
  _.assert( dstPointView.length === rows );

  if( _.convexPolygon.boxIntersects( polygon, boxView ) )
  return 0;

  let point = _.vector.from( _.array.makeArrayOfLength( rows ) );

  /* polygon vertices */

  let dist = Infinity;
  for ( let j = 0 ; j < cols ; j++ )
  {
    let newVertex = polygon.colVectorGet( j );
    let d = _.box.pointDistance( boxView, newVertex );

    if( d < dist )
    {
      point = _.vector.from( newVertex.slice() );
      dist = d;
    }
  }

  /* box corners */
  let c = _.box.cornersGet( boxView );

  for( let j = 0 ; j < _.Space.dimsOf( c )[ 1 ] ; j++ )
  {
    let corner = c.colVectorGet( j );
    let proj = _.convexPolygon.pointClosestPoint( polygon, corner );
    let d = _.avector.distance( corner, proj );
    if( d < dist )
    {
      point = _.vector.from( proj.slice() );
      dist = d;
    }
  }

  for( var i = 0; i < dstPointView.length; i++ )
  {
    dstPointView.eSet( i, point.eGet( i ) );
  }

  return dstPoint;
}

//

/**
  * Check if a convex polygon and a capsule intersect. Returns true if they intersect.
  * Convex polygon and capsule remain unchanged.
  *
  * @param { Polygon } polygon - Source polygon.
  * @param { Array } capsule - Source capsule.
  *
  * @example
  * // returns false;
  * let polygon = _.Space.make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.capsuleIntersects( polygon , [ 4, 4, 4, 5, 5, 5, 0.2 ] );
  **
  * @returns { Boolean } Returns true if the polygon and the capsule intersect.
  * @function capsuleIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( capsule ) is not capsule.
  * @memberof wTools.convexPolygon
  */

function capsuleIntersects( polygon, capsule )
{

  let capsuleView = _.vector.from( capsule );
  let dimC = _.capsule.dimGet( capsuleView );
  let originC = _.capsule.originGet( capsuleView );
  let endC = _.capsule.endPointGet( capsuleView );
  let radiusC = _.capsule.radiusGet( capsuleView );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.convexPolygon.is( polygon ) );
  debugger;

  let dims = _.Space.dimsOf( polygon );

}

//

/**
  * Check if a convex polygon and a segment intersect. Returns true if they intersect.
  * Convex polygon and segment remain unchanged.
  *
  * @param { Polygon } polygon - Source polygon.
  * @param { Array } segment - Source segment.
  *
  * @example
  * // returns false;
  * let polygon = _.Space.make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.segmentIntersects( polygon , [ 4, 4, 4, 5, 5, 5 ] );
  **
  * @returns { Boolean } Returns true if the polygon and the segment intersect.
  * @function segmentIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @memberof wTools.convexPolygon
  */

function segmentIntersects( polygon, segment )
{

  let segmentView = _.vector.from( segment );
  let sOrigin = _.segment.originGet( segmentView );
  let sEnd = _.segment.endPointGet( segmentView );
  let sDim  = _.segment.dimGet( segmentView )
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.convexPolygon.is( polygon ) );
  debugger;

  let dims = _.Space.dimsOf( polygon );
  _.assert( sDim === dims[ 0 ] );

  let containOrigin = _.convexPolygon.pointContains( polygon, sOrigin );
  let containEnd = _.convexPolygon.pointContains( polygon, sEnd );
  if( containOrigin === true || containEnd === true )
  {
    return true;
  }

  for( let i = 0 ; i < dims[ 1 ] ; i = i + 1 )
  {
    let j = ( i + 1 <= dims[ 1 ] - 1 ) ? i + 1 : 0;

    let vertex = polygon.colVectorGet( i );
    let nextVertex = polygon.colVectorGet( j );
    let segmentP = _.segment.fromPair( [ vertex, nextVertex ] );

    if( _.segment.segmentIntersects( segmentP, segmentView ) )
    {
      return true;
    }
  }

  if( dims[ 0 ] > 2 )
  {
    let normal = _.vector.from( _.array.makeArrayOfLengthZeroed( dims[ 0 ] ) );
    let plane = _.vector.from( _.array.makeArrayOfLengthZeroed( dims[ 0 ] + 1 ) );
    let i = 0;

    while( _.vector.allEquivalent( normal, _.array.makeArrayOfLengthZeroed( dims[ 0 ] ) ) && ( i <= dims[ 1 ] - 3 ) )
    {
      let pointOne = polygon.colVectorGet( i );
      let pointTwo = polygon.colVectorGet( i + 1 );
      let pointThree = polygon.colVectorGet( i + 2 );
      plane = _.plane.fromPoints( null, pointOne, pointTwo, pointThree );
      normal = _.plane.normalGet( plane );
      i = i + 1;
    }

    if( _.segment.planeIntersects( segmentView, plane ) )
    {
      let copOrigin = _.plane.pointCoplanarGet( plane, sOrigin );
      let copEnd = _.plane.pointCoplanarGet( plane, sEnd );
      let copSegment = _.segment.fromPair( [ copOrigin, copEnd ] );
      debugger;
      if( _.segment.segmentIntersects( segmentView, copSegment ) )
      {
        let intPoint = _.segment.segmentIntersectionPoint( segmentView, copSegment );

        if( _.convexPolygon.pointContains( polygon, intPoint ) )
        return true;
      }
    }
  }

  return false;
}

//

/**
  * Get the distance between a convex polygon and a segment. Returns the calculated distance.
  * Convex polygon and segment remain unchanged.
  *
  * @param { Polygon } polygon - Source polygon.
  * @param { Array } segment - Source segment.
  *
  * @example
  * // returns false;
  * let polygon = _.Space.make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.segmentIntersects( polygon , [ 4, 4, 4, 5, 5, 5 ] );
  **
  * @returns { Number } Returns the distance between the polygon and the capsule, 0 if they intersect.
  * @function segmentDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @memberof wTools.convexPolygon
  */

function segmentDistance( polygon, segment )
{

  let segmentView = _.vector.from( segment );
  let sOrigin = _.segment.originGet( segmentView );
  let sEnd = _.segment.endPointGet( segmentView );
  let sDim  = _.segment.dimGet( segmentView )
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.convexPolygon.is( polygon ) );
  debugger;

  let dims = _.Space.dimsOf( polygon );
  _.assert( sDim === dims[ 0 ] );

  if( _.convexPolygon.segmentIntersects( polygon, segmentView ) )
  return 0;

  let closestPoint = _.convexPolygon.segmentClosestPoint( polygon, segmentView );
  logger.log( closestPoint)
  let distance = _.segment.pointDistance( segmentView, closestPoint );

  return distance;
}

//

/**
  * Returns the closest point in a convex polygon to a segment. Returns the coordinates of the closest point.
  * The polygon and segment remain unchanged.
  *
  * @param { Polygon } polygon - Source convex polygon.
  * @param { Array } segment - Source segment.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * let polygon = _.Space.make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.segmentClosestPoint( polygon , [ - 1, - 1, - 1, -0.1, -0.1, -0.1 ] );
  *
  * @returns { Array } Returns the array of coordinates of the closest point in the convex polygon.
  * @function segmentClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @memberof wTools.convexPolygon
  */

function segmentClosestPoint( polygon, segment, dstPoint )
{
  let segmentView = _.vector.from( segment );
  let sOrigin = _.segment.originGet( segmentView );
  let sEnd = _.segment.endPointGet( segmentView );
  let sDim  = _.segment.dimGet( segmentView )
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );
  _.assert( _.convexPolygon.is( polygon ) );
  debugger;

  let dims = _.Space.dimsOf( polygon );
  _.assert( sDim === dims[ 0 ] );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( sDim );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointView = _.vector.from( dstPoint );
  _.assert( dstPointView.length === dims[ 0 ] );

  if( _.convexPolygon.segmentIntersects( polygon, segmentView ) )
  return 0;

  let point = _.vector.from( _.array.makeArrayOfLength( sDim ) );

  let dist = Infinity;

  /* segment corners */
  let dOrigin = _.convexPolygon.pointDistance( polygon, sOrigin );
  let dEnd = _.convexPolygon.pointDistance( polygon, sEnd );

  if( dOrigin < dist )
  {
    dist = dOrigin;
    point = _.vector.from( _.convexPolygon.pointClosestPoint( polygon, sOrigin ) );
  }

  if( dEnd < dist )
  {
    dist = dEnd;
    point = _.vector.from( _.convexPolygon.pointClosestPoint( polygon, sEnd ) );
  }

  /* polygon vertices */
  for ( let j = 0 ; j < dims[ 1 ] ; j++ )
  {
    let newVertex = polygon.colVectorGet( j );
    let d = _.segment.pointDistance( segmentView, newVertex );

    if( d < dist )
    {
      point = _.vector.from( newVertex.slice() );
      dist = d;
    }
  }

  for( var i = 0; i < dstPointView.length; i++ )
  {
    dstPointView.eSet( i, point.eGet( i ) );
  }

  return dstPoint;
}


// --
// declare
// --


let Proto =
{

  make : make,
  isPolygon : isPolygon,
  is : is,
  angleThreePoints : angleThreePoints,

  pointContains : pointContains,
  pointDistance : pointDistance,
  pointClosestPoint : pointClosestPoint,

  boxIntersects : boxIntersects,
  boxDistance : boxDistance,
  boxClosestPoint : boxClosestPoint,

  capsuleIntersects : capsuleIntersects,
  //capsuleDistance : capsuleDistance,
  //capsuleClosestPoint : capsuleClosestPoint,

  segmentIntersects : segmentIntersects,
  segmentDistance : segmentDistance,
  segmentClosestPoint : segmentClosestPoint,

}

_.mapSupplement( Self,Proto );

})();
