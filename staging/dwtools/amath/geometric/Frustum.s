(function _Frustum_s_(){

'use strict';

let _ = _global_.wTools;
let avector = _.avector;
let Self = _.frustum = _.frustum || Object.create( null );

/*

Frustum planes convention : right, left, bottom, top, far, near;

Frustum planes must have director vectors pointing outside frustum;

*/

// --
// routines
// --

function make()
{
  _.assert( arguments.length === 0 );

  let dst = _.Space.make([ 4,6 ]);

  return dst;
}

//

function fromMatrixHomogenous( frustum , m )
{
  // let frustum , m;

  if( frustum === null )
  frustum = this.make();

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.frustum.is( frustum ) );
  _.assert( _.spaceIs( m ) );
  _.assert( m.hasShape([ 4,4 ]) );

  frustum.colVectorGet( 0 ).copy
  ([
    m.atomGet([ 3,0 ]) - m.atomGet([ 0,0 ]),
    m.atomGet([ 3,1 ]) - m.atomGet([ 0,1 ]),
    m.atomGet([ 3,2 ]) - m.atomGet([ 0,2 ]),
    m.atomGet([ 3,3 ]) - m.atomGet([ 0,3 ]),
  ]);

  frustum.colVectorGet( 1 ).copy
  ([
    m.atomGet([ 3,0 ]) + m.atomGet([ 0,0 ]),
    m.atomGet([ 3,1 ]) + m.atomGet([ 0,1 ]),
    m.atomGet([ 3,2 ]) + m.atomGet([ 0,2 ]),
    m.atomGet([ 3,3 ]) + m.atomGet([ 0,3 ]),
  ]);

  frustum.colVectorGet( 2 ).copy
  ([
    m.atomGet([ 3,0 ]) + m.atomGet([ 1,0 ]),
    m.atomGet([ 3,1 ]) + m.atomGet([ 1,1 ]),
    m.atomGet([ 3,2 ]) + m.atomGet([ 1,2 ]),
    m.atomGet([ 3,3 ]) + m.atomGet([ 1,3 ]),
  ]);

  frustum.colVectorGet( 3 ).copy
  ([
    m.atomGet([ 3,0 ]) - m.atomGet([ 1,0 ]),
    m.atomGet([ 3,1 ]) - m.atomGet([ 1,1 ]),
    m.atomGet([ 3,2 ]) - m.atomGet([ 1,2 ]),
    m.atomGet([ 3,3 ]) - m.atomGet([ 1,3 ]),
  ]);

  frustum.colVectorGet( 4 ).copy
  ([
    m.atomGet([ 3,0 ]) - m.atomGet([ 2,0 ]),
    m.atomGet([ 3,1 ]) - m.atomGet([ 2,1 ]),
    m.atomGet([ 3,2 ]) - m.atomGet([ 2,2 ]),
    m.atomGet([ 3,3 ]) - m.atomGet([ 2,3 ]),
  ]);

  frustum.colVectorGet( 5 ).copy
  ([
    m.atomGet([ 3,0 ]) + m.atomGet([ 2,0 ]),
    m.atomGet([ 3,1 ]) + m.atomGet([ 2,1 ]),
    m.atomGet([ 3,2 ]) + m.atomGet([ 2,2 ]),
    m.atomGet([ 3,3 ]) + m.atomGet([ 2,3 ]),
  ]);

  return frustum;
}

//

function is( frustum )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  return _.spaceIs( frustum ) && frustum.hasShape([ 4,6 ])
}

//

/**
  * Returns the coordinates of the corners of a frustum. Returns an space object where each column is a point.
  * Frustum remain unchanged. Frustum need to follow planes convention ( see top of the file )
  *
  * @param { Frustum } srcfrustum - Source frustum.
  *
  * @example
  * // returns furstumCorners =
  * [ 0, 0, 0, 0, 1, 1, 1, 1,
  *   1, 0, 1, 0, 1, 0, 1, 0,
  *   1, 1, 0, 0, 1, 1, 0, 0,
  * ];
  * let srcfrustum = _.Space.make( [ 4, 6 ] ).copy
  * ([ 0, 0, 0, 0, - 1, 1,
  *   1, - 1, 0, 0, 0, 0,
  *   0, 0, 1, - 1, 0, 0,
  *   - 1, 0, - 1, 0, 0, - 1
  * ]);
  *
  * _.cornersGet( srcfrustum );
  *
  * @returns { Space } Returns the coordintes of the points in the frustum corners.
  * @function cornersGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @memberof wTools.frustum
  */

function cornersGet( srcfrustum )
{

  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( _.frustum.is( srcfrustum ) );
  debugger;

  let dims = _.Space.dimsOf( srcfrustum ) ;
  let rows = dims[ 0 ];
  let cols = dims[ 1 ];
  let pointsFru = _.Space.makeZero( [ rows - 1, cols + 2 ] );

  let right = _.vector.from(srcfrustum.colVectorGet( 0 ));
  let left = srcfrustum.colVectorGet( 1 );
  let top = srcfrustum.colVectorGet( 2 );
  let bottom = srcfrustum.colVectorGet( 3 );
  let far = srcfrustum.colVectorGet( 4 );
  let near = srcfrustum.colVectorGet( 5 );

  let point = _.plane.threeIntersectionPoint( far, top, right );
  if( ! _.vectorIs(point) )
  {
    return false;
  }
  else
  {
    point = _.vector.toArray( point );
    pointsFru.atomSet( [ 0, 0 ], point[ 0 ] ); pointsFru.atomSet( [ 1, 0 ], point[ 1 ] ); pointsFru.atomSet( [ 2, 0 ], point[ 2 ] );
  }

  point =  _.plane.threeIntersectionPoint( far, top, left );
  if( ! _.vectorIs( point) )
  {
    return false;
  }
  else
  {
    point = _.vector.toArray( point );
    pointsFru.atomSet( [ 0, 1 ], point[ 0 ] ); pointsFru.atomSet( [ 1, 1 ], point[ 1 ] ); pointsFru.atomSet( [ 2, 1 ], point[ 2 ] );
  }

  point =  _.plane.threeIntersectionPoint( far, bottom, right );
  if( ! _.vectorIs( point) )
  {
    return false;
  }
  else
  {
    point = _.vector.toArray( point );
    pointsFru.atomSet( [ 0, 2 ], point[ 0 ] ); pointsFru.atomSet( [ 1, 2 ], point[ 1 ] ); pointsFru.atomSet( [ 2, 2 ], point[ 2 ] );
  }

  point =  _.plane.threeIntersectionPoint( far, bottom, left );
  if( ! _.vectorIs( point) )
  {
    return false;
  }
  else
  {
    point = _.vector.toArray( point );
    pointsFru.atomSet( [ 0, 3 ], point[ 0 ] ); pointsFru.atomSet( [ 1, 3 ], point[ 1 ] ); pointsFru.atomSet( [ 2, 3 ], point[ 2 ] );
  }

  point = _.plane.threeIntersectionPoint( near, top, right );
  if( ! _.vectorIs( point) )
  {
    return false;
  }
  else
  {
    point = _.vector.toArray( point );
    pointsFru.atomSet( [ 0, 4 ], point[ 0 ] ); pointsFru.atomSet( [ 1, 4 ], point[ 1 ] ); pointsFru.atomSet( [ 2, 4 ], point[ 2 ] );
  }

  point =  _.plane.threeIntersectionPoint( near, top, left );
  if( ! _.vectorIs(point) )
  {
    return false;
  }
  else
  {
    point = _.vector.toArray( point );
    pointsFru.atomSet( [ 0, 5 ], point[ 0 ] ); pointsFru.atomSet( [ 1, 5 ], point[ 1 ] ); pointsFru.atomSet( [ 2, 5 ], point[ 2 ] );
  }

  point =  _.plane.threeIntersectionPoint( near, bottom, right );
  if( ! _.vectorIs(point) )
  {
    return false;
  }
  else
  {
    point = _.vector.toArray( point );
    pointsFru.atomSet( [ 0, 6 ], point[ 0 ] ); pointsFru.atomSet( [ 1, 6 ], point[ 1 ] ); pointsFru.atomSet( [ 2, 6 ], point[ 2 ] );
  }

  point = _.plane.threeIntersectionPoint( near, bottom, left );
  if( ! _.vectorIs(point) )
  {
    return false;
  }
  else
  {
    point = _.vector.toArray( point );
    pointsFru.atomSet( [ 0, 7 ], point[ 0 ] ); pointsFru.atomSet( [ 1, 7 ], point[ 1 ] ); pointsFru.atomSet( [ 2, 7 ], point[ 2 ] );
  }
  debugger;

  return pointsFru;
}

//

/**
  * Check if a frustum contains a point. Returns true if it contains it.
  * Frustum and point remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Array } point - Source point.
  *
  * @example
  * // returns false;
  * _.pointContains( _.frustum.make() , [ 1, 1, 1 ] );
  **
  * @returns { Boolean } Returns true if the frustum contains the point.
  * @function pointContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( point ) is not point.
  * @memberof wTools.frustum
  */

function pointContains( frustum , point )
{

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.frustum.is( frustum ) );

  debugger;

  for( let i = 0 ; i < 6 ; i += 1 )
  {

    let plane = frustum.colVectorGet( i );
    if( _.plane.pointDistance( plane, point ) > 1E-12 )
    return false;

  }

  return true;
}

//

/**
  * Calculates the distance between a frustum and a point. Returns the calculated distance.
  * Frustum and point remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Array } point - Source point.
  *
  * @example
  * // returns 1;
  * let frustum = _.Space.make( [ 4, 6 ] ).copy
  * ([
  *     0,   0,   0,   0, - 1,   1,
  *     1, - 1,   0,   0,   0,   0,
  *     0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ]
  * );
  * _.pointDistance( frustum, [ 1, 1, 2 ] );
  **
  * @returns { Distance } Returns the distance between the frustum and the point.
  * @function pointDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( point ) is not point.
  * @memberof wTools.frustum
  */

function pointDistance( frustum, point )
{

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.frustum.is( frustum ) );

  let dims = _.Space.dimsOf( frustum ) ;
  let rows = dims[ 0 ];
  let cols = dims[ 1 ];
  _.assert( rows - 1 === point.length );

  debugger;

  if( _.frustum.pointContains( frustum, point ) )
  return 0;

  let corners = _.frustum.cornersGet( frustum );

  let distanceCorner = Infinity;
  let distancePlane = Infinity;
  for( let i = 0 ; i < 6 ; i ++ )
  {
    let plane = frustum.colVectorGet( i );

    let newDistPlane = Math.abs( _.plane.pointDistance( plane, point.slice() ) );
    if( newDistPlane < distancePlane )
    {
      let projection = _.plane.pointCoplanarGet( plane, point.slice() );
      if( _.frustum.pointContains( frustum, projection ))
      {
        distancePlane = newDistPlane;
      }
    }
  }

  for( let i = 0 ; i < 8 ; i++ )
  {
    let corner = corners.colVectorGet( i );

    let newDistCorner = _.avector.distance( point.slice(), corner.slice() );
    if( newDistCorner < distanceCorner )
    distanceCorner = newDistCorner;

  }

  let distance = distanceCorner;

  if( distancePlane < distance )
  distance = distancePlane;

  return distance;
}

//

/**
  * Returns the closest point in a frustum to a point. Returns the coordinates of the closest point.
  * Frustum and point remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Array } srcpoint - Source point.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * let frustum = _.Space.make( [ 4, 6 ] ).copy(
  *   [ 0,   0,   0,   0, - 1,   1,
  *     1, - 1,   0,   0,   0,   0,
  *     0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ] );
  * _.pointClosestPoint( frustum , [ - 1, - 1, - 1 ] );
  *
  * @returns { Array } Returns the array of coordinates of the closest point in the frustum.
  * @function pointClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( point ) is not point.
  * @memberof wTools.frustum
  */

/* qqq : dstPoint is destination */

function pointClosestPoint( frustum , srcPoint, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'expects two or three arguments' );
  _.assert( _.frustum.is( frustum ) );

  if( arguments.length === 2 )
  dstPoint = [ 0, 0, 0 ];

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let srcPointVector = _.vector.from( srcPoint );  /* qqq : problem */
  let dstPointVector = _.vector.from( dstPoint );
  let dims = _.Space.dimsOf( frustum ) ;
  let rows = dims[ 0 ];
  let cols = dims[ 1 ];
  let fpoints = _.frustum.cornersGet( frustum );
  _.assert( _.spaceIs( fpoints ) );
  _.assert( fpoints.hasShape([ 3, 8 ] ) );
  _.assert( rows -1 === srcPointVector.length );
  _.assert( dstPointVector.length === srcPointVector.length );

  let max = fpoints.colVectorGet( 0 );
  let min = fpoints.colVectorGet( 0 );
  max = _.vector.toArray( max );
  min = _.vector.toArray( min );
  let srcPointArray = _.vector.toArray( srcPointVector );
  let dstPointArray = _.vector.toArray( dstPointVector );

  for( let j = 1 ; j < cols ; j++ )
  {
    let newp = _.vector.toArray( fpoints.colVectorGet( j ) );
    if( newp[ 0 ] < min[ 0 ] )
    {
      min[ 0 ] = newp[ 0 ];
    }
    if( newp[ 1 ] < min[ 1 ] )
    {
      min[ 1 ] = newp[ 1 ];
    }
    if( newp[ 2 ] < min[ 2 ] )
    {
      min[ 2 ] = newp[ 2 ];
    }
    if( newp[ 0 ] > max[ 0 ] )
    {
      max[ 0 ] = newp[ 0 ];
    }
    if( newp[ 1 ] > max[ 1 ] )
    {
      max[ 1 ] = newp[ 1 ];
    }
    if( newp[ 2 ] > max[ 2 ] )
    {
      max[ 2 ] = newp[ 2 ];
    }
  }

  for( let i = 0 ; i < 3 ; i++ )
  {
    if( srcPointArray[ i ] >= max[ i ] )
    {
      dstPointArray[ i ] = max[ i ];
    }
    else if( srcPointArray[ i ] <= min[ i ] )
    {
      dstPointArray[ i ] = min[ i ];
    }
    else
    {
      dstPointArray[ i ] = srcPointArray[ i ];
    }
  }

  if( _.frustum.pointContains( frustum, dstPointVector ) === true )
  {
    return dstPoint;
  }

  else
  {
    let d0 = Infinity;
    let finalPointArray = dstPointVector.slice();

    for( let i = 0 ; i < cols ; i++ )
    {
      let plane = _.vector.from( frustum.colVectorGet( i ) );

      let p =  _.plane.pointCoplanarGet( plane, _.vector.toArray( dstPointVector ).slice() );

      let d = _.avector.distance( _.vector.toArray( dstPointVector ), p );

      let pVector = _.vector.from( p );
      if( d < d0  && _.frustum.pointContains( frustum, pVector ) )
      {
        finalPointArray[ 0 ] = pVector.eGet( 0 );
        finalPointArray[ 1 ] = pVector.eGet( 1 );
        finalPointArray[ 2 ] = pVector.eGet( 2 );
        d0 = d;
      }
    }

    dstPointVector.eSet( 0, finalPointArray[ 0 ] );
    dstPointVector.eSet( 1, finalPointArray[ 1 ] );
    dstPointVector.eSet( 2, finalPointArray[ 2 ] );

    _.assert( _.frustum.pointContains( frustum, dstPointVector ) === true );
    return dstPoint;
  }
}

//

/**
  * Check if a frustum contains a box. Returns true if the frustrum contains the box.
  * Frustum and box remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Array } box - Source box.
  *
  * @example
  * // returns false;
  * _.boxContains( _.frustum.make() , [ 2, 2, 2, 3, 3, 3 ] );
  **
  * @returns { Boolean } Returns true if the frustum contains the box.
  * @function boxContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( box ) is not box.
  * @memberof wTools.frustum
  */

function boxContains( frustum, box )
{

  let _box = _.box._from( box );
  let dim1 = _.box.dimGet( _box );
  let min1 = _.box.cornerLeftGet( _box );
  let max1 = _.box.cornerRightGet( _box );
  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.frustum.is( frustum ) );
  debugger;

  let dims = _.Space.dimsOf( frustum ) ;
  let rows = dims[ 0 ];
  let cols = dims[ 1 ];
  _.assert( rows -1 === dim1 );

  /* src corners */

  let c = _.Space.makeZero( [ 3, 8 ] );
  let srcMin = _.vector.toArray( min1 ); let srcMax = _.vector.toArray( max1 );
  c.colVectorGet( 0 ).copy( [ srcMin[ 0 ], srcMin[ 1 ], srcMin[ 2 ] ] );
  c.colVectorGet( 1 ).copy( [ srcMax[ 0 ], srcMin[ 1 ], srcMin[ 2 ] ] );
  c.colVectorGet( 2 ).copy( [ srcMin[ 0 ], srcMax[ 1 ], srcMin[ 2 ] ] );
  c.colVectorGet( 3 ).copy( [ srcMin[ 0 ], srcMin[ 1 ], srcMax[ 2 ] ] );
  c.colVectorGet( 4 ).copy( [ srcMax[ 0 ], srcMax[ 1 ], srcMax[ 2 ] ] );
  c.colVectorGet( 5 ).copy( [ srcMin[ 0 ], srcMax[ 1 ], srcMax[ 2 ] ] );
  c.colVectorGet( 6 ).copy( [ srcMax[ 0 ], srcMin[ 1 ], srcMax[ 2 ] ] );
  c.colVectorGet( 7 ).copy( [ srcMax[ 0 ], srcMax[ 1 ], srcMin[ 2 ] ] );

  let distance = Infinity;
  for( let j = 0 ; j < 8 ; j++ )
  {
    let srcCorner = _.vector.toArray( c.colVectorGet( j ) );
    if( _.frustum.pointContains( frustum, srcCorner ) === false )
    {
      return false;
    }
  }

  return true;

}

//

/**
  * Check if a frustum and a box intersect. Returns true if they intersect.
  * Frustum and box remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Array } box - Source box.
  *
  * @example
  * // returns false;
  * _.boxIntersects( _.frustum.make() , [ 2, 2, 2, 3, 3, 3 ] );
  **
  * @returns { Boolean } Returns true if the frustum and the box intersect.
  * @function boxIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( box ) is not box.
  * @memberof wTools.frustum
  */

function boxIntersects( frustum , box )
{

  let _box = _.box._from( box );
  let dim1 = _.box.dimGet( _box );
  let min1 = _.box.cornerLeftGet( _box );
  let max1 = _.box.cornerRightGet( _box );
  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.frustum.is( frustum ) );
  debugger;

  let c0 = _.vector.from( min1 );
  let c4 = _.vector.from( max1 );
  c0 = _.vector.toArray( c0 );
  c4 = _.vector.toArray( c4 );

  let c1 = c0.slice(); c1[0] = c4[ 0 ];
  let c2 = c0.slice(); c2[1] = c4[ 1 ];
  let c3 = c0.slice(); c3[2] = c4[ 2 ];
  let c5 = c0.slice(); c5[0] = c4[ 0 ]; c5[ 2 ] = c4[ 2 ];
  let c6 = c0.slice(); c6[1] = c4[ 1 ]; c6[ 0 ] = c4[ 0 ];
  let c7 = c0.slice(); c7[2] = c4[ 2 ]; c7[ 1 ] = c4[ 1 ];

  if( _.frustum.pointContains( frustum, _.vector.from( c0.slice( ) ) ) === true )
  {
    return true;
  }
  if( _.frustum.pointContains( frustum, _.vector.from( c1.slice( ) ) ) === true )
  {
    return true;
  }
  if( _.frustum.pointContains( frustum, _.vector.from( c2.slice( ) ) ) === true )
  {
    return true;
  }
  if( _.frustum.pointContains( frustum, _.vector.from( c3.slice( ) ) ) === true )
  {
    return true;
  }
  if( _.frustum.pointContains( frustum, _.vector.from( c4.slice( ) ) ) === true )
  {
    return true;
  }
  if( _.frustum.pointContains( frustum, _.vector.from( c5.slice( ) ) ) === true )
  {
    return true;
  }
  if( _.frustum.pointContains( frustum, _.vector.from( c6.slice( ) ) ) === true )
  {
    return true;
  }
  if( _.frustum.pointContains( frustum, _.vector.from( c7.slice( ) ) ) === true )
  {
    return true;
  }

  let fpoints = _.frustum.cornersGet( frustum );
  _.assert( _.spaceIs( fpoints ) );

  for( let i = 0 ; i < 6 ; i ++ )
  {
    let point = fpoints.colVectorGet( i );

    if( _.box.pointContains( box, point ) === true )
    {
      return true;
    }
  }
  return false;
}

//function boxIntersects( frustum , box )
//{
//
//  _.assert( arguments.length === 2, 'expects exactly two arguments' );
//  _.assert( _.frustum.is( frustum ) );
//  debugger;
//
//  let p1 = [];
//  let p2 = [];
//
//  for( let i = 0 ; i < 6 ; i += 1 )
//  {
//    let plane = frustum.colVectorGet( i );
//
//    p1 = _.box.cornerLeftGet( box );
//    p2 = _.box.cornerRightGet( box );
//
//    let d1 = _.plane.pointDistance( plane,p1 );
//    let d2 = _.plane.pointDistance( plane,p2 );
//
//    if( d1 < 0 && d2 < 0 )
//    return false;
//
//  }
//
//  return true;
//}

//

/**
  * Returns the closest point in a frustum to a box. Returns the coordinates of the closest point.
  * Frustum and box remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Array } box - Source box.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * let frustum = _.Space.make( [ 4, 6 ] ).copy(
  *   [ 0,   0,   0,   0, - 1,   1,
  *     1, - 1,   0,   0,   0,   0,
  *     0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ] );
  * _.boxClosestPoint( frustum , [ - 1, - 1, - 1, -0.1, -0.1, -0.1 ] );
  *
  * @returns { Array } Returns the array of coordinates of the closest point in the frustum.
  * @function boxClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( box ) is not box.
  * @memberof wTools.frustum
  */

function boxClosestPoint( frustum, box, dstPoint )
{
  let _box = _.box._from( box );
  let dim1 = _.box.dimGet( _box );
  let min1 = _.box.cornerLeftGet( _box );
  let max1 = _.box.cornerRightGet( _box );
  let dims = _.Space.dimsOf( frustum ) ;
  let rows = dims[ 0 ];
  let cols = dims[ 1 ];

  _.assert( _.frustum.is( frustum ) );
  _.assert( dim1 === 3 );
  _.assert( arguments.length === 2 || arguments.length === 3 , 'expects two or three arguments' );
  if( arguments.length === 2 )
  dstPoint = [ 0, 0, 0 ];

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointVector = _.vector.from( dstPoint );

  if( _.frustum.boxIntersects( frustum, _box ) )
  return 0;

  let point = _.vector.from( [ 0, 0, 0 ] );
  /* frustum corners */

  let fpoints = _.frustum.cornersGet( frustum );
  let dist = Infinity;
  for ( let j = 0 ; j < cols ; j++ )
  {
    let newp = fpoints.colVectorGet( j );
    let d = _.box.pointDistance( _box, newp );

    if( d < dist )
    {
      point = _.vector.from( newp.slice() );
      dist = d;
    }
  }

  /* box corners */

  let c = _.Space.makeZero( [ 3, 8 ] );
  min1 = _.vector.toArray( min1 ); max1 = _.vector.toArray( max1 );
  c.colVectorGet( 0 ).copy( [ min1[ 0 ], min1[ 1 ], min1[ 2 ] ] );
  c.colVectorGet( 1 ).copy( [ max1[ 0 ], min1[ 1 ], min1[ 2 ] ] );
  c.colVectorGet( 2 ).copy( [ min1[ 0 ], max1[ 1 ], min1[ 2 ] ] );
  c.colVectorGet( 3 ).copy( [ min1[ 0 ], min1[ 1 ], max1[ 2 ] ] );
  c.colVectorGet( 4 ).copy( [ max1[ 0 ], max1[ 1 ], max1[ 2 ] ] );
  c.colVectorGet( 5 ).copy( [ min1[ 0 ], max1[ 1 ], max1[ 2 ] ] );
  c.colVectorGet( 6 ).copy( [ max1[ 0 ], min1[ 1 ], max1[ 2 ] ] );
  c.colVectorGet( 7 ).copy( [ max1[ 0 ], max1[ 1 ], min1[ 2 ] ] );

  for( let j = 0 ; j < 8 ; j++ )
  {
    let corner = c.colVectorGet( j );
    let proj = _.frustum.pointClosestPoint( frustum, corner );
    let d = _.avector.distance( corner, _.vector.toArray( proj ) );
    if( d < dist )
    {
      point = _.vector.from( proj.slice() );
      dist = d;
    }
  }
  dstPointVector.eSet( 0, point.eGet( 0 ) );
  dstPointVector.eSet( 1, point.eGet( 1 ) );
  dstPointVector.eSet( 2, point.eGet( 2 ) );

  return dstPoint;
}

//

/**
  * Check if a frustum contains a sphere. Returns true it contains the sphere.
  * Frustum and sphere remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Sphere } sphere - Source sphere.
  *
  * @example
  * // returns false;
  * _.sphereContains( _.frustum.make() , [ 2, 2, 2, 1 ] );
  *
  * @returns { Boolean } Returns true if the frustum contains the sphere.
  * @function sphereContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @memberof wTools.frustum
  */

function sphereContains( frustum , sphere )
{

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.frustum.is( frustum ) );

  let center = _.sphere.centerGet( sphere );
  let radius = _.sphere.radiusGet( sphere );

  for( let i = 0 ; i < 6 ; i += 1 )
  {
    let plane = frustum.colVectorGet( i );
    if( _.plane.pointDistance( plane, center ) > - radius + 1E-12 )
    return false;
  }

  return true;
}

//

/**
  * Check if a frustum and a sphere intersect. Returns true if they intersect.
  * Frustum and sphere remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Sphere } sphere - Source sphere.
  *
  * @example
  * // returns false;
  * _.sphereIntersects( _.frustum.make() , [ 2, 2, 2, 1 ] );
  **
  * @returns { Boolean } Returns true if the frustum and the sphere intersect.
  * @function sphereIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @memberof wTools.frustum
  */

function sphereIntersects( frustum , sphere )
{

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.frustum.is( frustum ) );

  let center = _.sphere.centerGet( sphere );
  let radius = _.sphere.radiusGet( sphere );

  if( _.frustum.pointContains( frustum, _.vector.from( center )) === true )
  {
    return true;
  }
  else
  {
    let newc = _.vector.from( center.slice() );
    let proj = _.frustum.pointClosestPoint( frustum, center );
    let d = _.avector.distance( _.vector.toArray( proj ), _.vector.toArray( center ) );
    if( d <= radius )
    {
      return true;
    }
  }
  return false;
}

//

/**
  * Returns the closest point in a frustum to a sphere. Returns the coordinates of the closest point.
  * Frustum and sphere remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Array } sphere - Source sphere.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * let frustum = _.Space.make( [ 4, 6 ] ).copy(
  *   [ 0,   0,   0,   0, - 1,   1,
  *     1, - 1,   0,   0,   0,   0,
  *     0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ] );
  * _.sphereClosestPoint( frustum , [ - 1, - 1, - 1, 0.1 ] );
  *
  * @returns { Array } Returns the array of coordinates of the closest point in the frustum.
  * @function sphereClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @memberof wTools.frustum
  */

function sphereClosestPoint( frustum , sphere, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'expects two or three arguments' );

  let spherev = _.sphere._from( sphere );
  let center = _.sphere.centerGet( spherev );
  let radius = _.sphere.radiusGet( spherev );
  let dim = _.sphere.dimGet( spherev );
  _.assert( dim === 3 );

  if( arguments.length === 2 )
  dstPoint = [ 0, 0, 0 ];

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointVector = _.vector.from( dstPoint );

  _.assert( _.frustum.is( frustum ) );

  if( _.frustum.sphereIntersects( frustum, spherev ) == true )
  return 0;

  let point = _.frustum.pointClosestPoint( frustum, center );

  dstPointVector.eSet( 0, point[ 0 ] );
  dstPointVector.eSet( 1, point[ 1 ] );
  dstPointVector.eSet( 2, point[ 2 ] );

  return dstPoint;

}

//

/**
  * Check if a frustum and a plane intersect. Returns true if they intersect.
  * Frustum and plane remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Plane } plane - Source plane.
  *
  * @example
  * // returns false;
  * _.planeIntersects( _.frustum.make() , [ 2, 2, 2, 1 ] );
  **
  * @returns { Boolean } Returns true if the frustum and the plane intersect.
  * @function planeIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( sphere ) is not plane.
  * @memberof wTools.frustum
  */

function planeIntersects( frustum, plane )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.frustum.is( frustum ) );

  let _plane = _.plane._from( plane );
  let corners = _.frustum.cornersGet( frustum );
  let side;
  for( let j = 0 ; j < 8 ; j = j + 1 )
  {
    let corner = corners.colVectorGet( j );
    let distance = _.plane.pointDistance( _plane, corner );
    if( distance === 0 )
    return true;

    if( j > 0 )
    {
      let newSide = distance/ Math.abs( distance );
      if( side === - newSide )
      {
        return true;
      }
      side = newSide;
    }
    side = distance/ Math.abs( distance );
  }

  return false;
}

//

/**
  * Calculates the distance between a frustum and a plane. Returns the calculated distance.
  * Frustum and plane remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Plane } plane - Source plane.
  *
  * @example
  * // returns 2;
  * let frustum =  _.Space.make( [ 4, 6 ] ).copy
  * ([
  *   0,   0,   0,   0, - 1,   1,
  *   1, - 1,   0,   0,   0,   0,
  *   0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ]
  * );
  * _.planeDistance( frustum , [ 1, 0, 0, 2 ] );
  **
  * @returns { Number } Returns the distance between the frustum and the plane.
  * @function planeDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( sphere ) is not plane.
  * @memberof wTools.frustum
  */

function planeDistance( frustum, plane )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.frustum.is( frustum ) );

  let _plane = _.plane._from( plane );
  if( _.frustum.planeIntersects( frustum, _plane ) )
  return 0;

  let corners = _.frustum.cornersGet( frustum );
  let distance = Infinity;
  for( let j = 0 ; j < 8 ; j = j + 1 )
  {
    let corner = corners.colVectorGet( j );
    let dist = Math.abs( _.plane.pointDistance( _plane, corner ) );
    if( dist < distance )
    distance = dist;
  }

  return distance;
}

//

/**
  * Calculates the closest point in a frustum to a plane. Returns the calculated point.
  * Frustum and plane remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Plane } plane - Source plane.
  * @param { Point } dstPoint - Destination point.
  *
  * @example
  * // returns [ 1, 1, 1 ];
  * let frustum =  _.Space.make( [ 4, 6 ] ).copy
  * ([
  *   0,   0,   0,   0, - 1,   1,
  *   1, - 1,   0,   0,   0,   0,
  *   0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ]
  * );
  * _.planeClosestPoint( frustum , [ 1, 1, 1, 6 ] );
  *
  * @returns { Array } Returns the coordinates of the closest point.
  * @function planeClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( sphere ) is not plane.
  * @throws { Error } An Error if ( dstPoint ) is not point.
  * @memberof wTools.frustum
  */

function planeClosestPoint( frustum, plane, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'expects two or three arguments' );
  _.assert( _.frustum.is( frustum ) );

  if( arguments.length === 2 )
  dstPoint = [ 0, 0, 0 ];

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointVector = _.vector.from( dstPoint );

  let _plane = _.plane._from( plane );
  if( _.frustum.planeIntersects( frustum, _plane ) )
  return 0;

  let corners = _.frustum.cornersGet( frustum );
  let distance = Infinity;
  let point = [ 0, 0, 0 ];
  for( let j = 0 ; j < 8 ; j = j + 1 )
  {
    let corner = corners.colVectorGet( j );
    let dist = Math.abs( _.plane.pointDistance( _plane, corner ) );
    if( dist < distance )
    {
      distance = dist;
      point = _.vector.from( corner.slice() );
    }
  }

  dstPointVector.eSet( 0, point.eGet( 0 ) );
  dstPointVector.eSet( 1, point.eGet( 1 ) );
  dstPointVector.eSet( 2, point.eGet( 2 ) );

  return dstPoint;
}

//

/**
* Check if a frustum contains another frustum. Returns true if it contains the frustum.
* Both frustums remain unchanged.
*
* @param { Frustum } srcFrustum - Source frustum ( container ).
* @param { Frustum } tstFrustum - Frustum to test if it is contained.
*
* @example
* // returns true;
* let srcFrustum = _.Space.make( [ 4, 6 ] ).copy
*  ([
*     0,   0,   0,   0, - 1,   1,
*     1, - 1,   0,   0,   0,   0,
*     0,   0,   1, - 1,   0,   0,
*   - 1,   0, - 1,   0,   0, - 1 ]
*   );
* let tstFrustum = _.Space.make( [ 4, 6 ] ).copy
*   ([
*    0,   0,   0,   0, - 1,   1,
*    1, - 1,   0,   0,   0,   0,
*    0,   0,   1, - 1,   0,   0,
*   -0.5, -0.5, -0.5, -0.5, -0.5, -0.5 ]
*   );
* _.frustumContains( srcFrustum , tstFrustum );
*
* @returns { Boolean } Returns true if the srcFrustum contains the tstFrustum.
* @function frustumContains
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( srcFrustum ) is not frustum.
* @throws { Error } An Error if ( tstFrustum ) is not frustum.
* @memberof wTools.frustum
*/

function frustumContains( srcFrustum , tstFrustum )
{

_.assert( arguments.length === 2, 'expects exactly two arguments' );
_.assert( _.frustum.is( srcFrustum ) );
_.assert( _.frustum.is( tstFrustum ) );
debugger;

let points = _.frustum.cornersGet( tstFrustum );

for( let i = 0 ; i < points.length ; i += 1 )
{
let point = points.colVectorGet( i );
let c = _.frustum.pointContains( srcFrustum, point );
if( c !== true )
return false;

}

return true;
}

//

/**
  * Check if a frustum intersects with another frustum. Returns true if they intersect.
  * Both frustums remain unchanged.
  *
  * @param { Frustum } srcFrustum - Source frustum.
  * @param { Frustum } tstFrustum - Frustum to test if it intersects.
  *
  * @example
  * // returns true;
  * let srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  *  ([
  *     0,   0,   0,   0, - 1,   1,
  *     1, - 1,   0,   0,   0,   0,
  *     0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ]
  *   );
  * let tstFrustum = _.Space.make( [ 4, 6 ] ).copy
  *   ([
  *    0,   0,   0,   0, - 1,   1,
  *    1, - 1,   0,   0,   0,   0,
  *    0,   0,   1, - 1,   0,   0,
  *   -0.5, -0.5, -0.5, -0.5, -0.5, -0.5 ]
  *   );
  * _.frustumIntersects( srcFrustum , tstFrustum );
  *
  * @returns { Boolean } Returns true if the frustums intersect.
  * @function frustumIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( tstFrustum ) is not frustum.
  * @memberof wTools.frustum
  */

function frustumIntersects( srcFrustum , tstFrustum )
{

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.frustum.is( srcFrustum ) );
  _.assert( _.frustum.is( tstFrustum ) );
  debugger;

  let points = _.frustum.cornersGet( srcFrustum );

  for( let i = 0 ; i < points.length ; i += 1 )
  {
    let point = points.colVectorGet( i );
    let c = _.frustum.pointContains( tstFrustum, point );
    if( c === true )
    return true;

  }

  let points2 = _.frustum.cornersGet( tstFrustum );

  for( let i = 0 ; i < points2.length ; i += 1 )
  {
    let point = points2.colVectorGet( i );
    let c = _.frustum.pointContains( srcFrustum, point );
    if( c === true )
    return true;

  }

  return false;
}

//

/**
  * Calculates the distance between two frustums. Returns the calculated distance.
  * Both frustums remain unchanged.
  *
  * @param { Frustum } srcFrustum - Source frustum.
  * @param { Frustum } tstFrustum - Frustum to calculate the distance.
  *
  * @example
  * // returns 0;
  * let srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  *  ([
  *     0,   0,   0,   0, - 1,   1,
  *     1, - 1,   0,   0,   0,   0,
  *     0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ]
  *   );
  * let tstFrustum = _.Space.make( [ 4, 6 ] ).copy
  *   ([
  *    0,   0,   0,   0, - 1,   1,
  *    1, - 1,   0,   0,   0,   0,
  *    0,   0,   1, - 1,   0,   0,
  *   -0.5, -0.5, -0.5, -0.5, -0.5, -0.5 ]
  *   );
  * _.frustumDistance( srcFrustum , tstFrustum );
  *
  * @returns { Number } Returns the distance between the two frustums.
  * @function frustumDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( tstFrustum ) is not frustum.
  * @memberof wTools.frustum
  */

function frustumDistance( srcFrustum , tstFrustum )
{

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.frustum.is( srcFrustum ) );
  _.assert( _.frustum.is( tstFrustum ) );
  debugger;

  if( _.frustum.frustumIntersects( srcFrustum, tstFrustum ) )
  return 0;

  let distance = Infinity;

  let points = _.frustum.cornersGet( srcFrustum );
  for( let i = 0 ; i < points.length ; i += 1 )
  {
    let point = points.colVectorGet( i );
    let d = _.frustum.pointDistance( tstFrustum, point );
    if( d < distance )
    distance = d;
  }

  let points2 = _.frustum.cornersGet( tstFrustum );
  for( let i = 0 ; i < points2.length ; i += 1 )
  {
    let point = points2.colVectorGet( i );
    let d2 = _.frustum.pointDistance( srcFrustum, point );
    if( d2 < distance )
    distance = d2;
  }

  return distance;
}

//

/**
  * Calculates the closest point in a frustum to another frustum. Returns the calculated point.
  * Both frustums remain unchanged.
  *
  * @param { Frustum } srcFrustum - Source frustum ( closest point in it ).
  * @param { Frustum } tstFrustum - Test frustum.
  * @param { Point } dstPoint - Destination point.
  *
  * @example
  * // returns 0;
  * let srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  *  ([
  *     0,   0,   0,   0, - 1,   1,
  *     1, - 1,   0,   0,   0,   0,
  *     0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ]
  *   );
  * let tstFrustum = _.Space.make( [ 4, 6 ] ).copy
  *   ([
  *    0,   0,   0,   0, - 1,   1,
  *    1, - 1,   0,   0,   0,   0,
  *    0,   0,   1, - 1,   0,   0,
  *   -0.5, -0.5, -0.5, -0.5, -0.5, -0.5 ]
  *   );
  * _.frustumClosestPoint( srcFrustum , testFrustum );
  *
  * @returns { Number } Returns the closest point to a frustum.
  * @function frustumClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( tstFrustum ) is not frustum.
  * @throws { Error } An Error if ( dstPoint ) is not point.
  * @memberof wTools.frustum
  */

function frustumClosestPoint( srcFrustum , tstFrustum, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'expects two or three arguments' );
  _.assert( _.frustum.is( srcFrustum ) );
  _.assert( _.frustum.is( tstFrustum ) );

  if( arguments.length === 2 )
  dstPoint = [ 0, 0, 0 ];

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointVector = _.vector.from( dstPoint );

  debugger;

  if( _.frustum.frustumIntersects( srcFrustum, tstFrustum ) )
  return 0;

  let distance = Infinity;
  let finalPoint = [ 0, 0, 0 ];

  let points = _.frustum.cornersGet( srcFrustum );
  for( let i = 0 ; i < points.length ; i += 1 )
  {
    let point = points.colVectorGet( i );
    let d = _.frustum.pointDistance( tstFrustum, point );
    if( d < distance )
    {
      distance = d;
      finalPoint = point.slice();
    }
  }

  let points2 = _.frustum.cornersGet( tstFrustum );
  for( let i = 0 ; i < points2.length ; i += 1 )
  {
    let point = points2.colVectorGet( i );
    let d2 = _.frustum.pointDistance( srcFrustum, point );
    if( d2 < distance )
    {
      distance = d2;
      let finalPoint = point.slice();
    }
  }

  dstPointVector.eSet( 0, finalPoint[ 0 ] );
  dstPointVector.eSet( 1, finalPoint[ 1 ] );
  dstPointVector.eSet( 2, finalPoint[ 2 ] );

  return dstPoint;
}

// --
// define class
// --

/* qqq : please sort */

let Proto =
{

  make : make,
  fromMatrixHomogenous : fromMatrixHomogenous,
  is : is,

  cornersGet : cornersGet,

  pointContains : pointContains,
  pointDistance : pointDistance, /* qqq : implement me */
  pointClosestPoint : pointClosestPoint, /* qqq : review please */

  boxContains : boxContains, /* qqq : implement me */
  boxIntersects : boxIntersects,
  // boxDistance : boxDistance, /* qqq : implement me - Same as _.box.frustumDistance */
  boxClosestPoint : boxClosestPoint,

  sphereContains : sphereContains, /* qqq : implement me */
  sphereIntersects : sphereIntersects,
  // sphereDistance : sphereDistance, /* qqq : implement me - Same as _.sphere.frustumDistance  */
  sphereClosestPoint : sphereClosestPoint,

  planeIntersects : planeIntersects, /* qqq : implement me */
  planeDistance : planeDistance, /* qqq : implement me */
  planeClosestPoint : planeClosestPoint, /* qqq : implement me */

  frustumContains : frustumContains, /* qqq : implement me */
  frustumIntersects : frustumIntersects,
  frustumDistance : frustumDistance, /* qqq : implement me */
  frustumClosestPoint : frustumClosestPoint, /* qqq : implement me */

}

_.mapSupplement( Self,Proto );

})();
