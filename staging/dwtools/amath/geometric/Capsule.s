(function _Capsule_s_(){

'use strict';

let _ = _global_.wTools;
let avector = _.avector;
let vector = _.vector;
let Self = _.capsule = _.capsule || Object.create( null );

/*

  A capsule is a basic geometric shape consisting of a cylinder with hemispherical ends.

  For the following functions, capsules must have the shape [ startX, startY, startZ, endX, endY, endZ, radius ],
where the dimension equals the object´s length minus one, divided by two.

  Moreover, startX, startY and startZ are the coordinates of the center of the bottom circle of the cylinder.
EndX, endY and endZ are the coordinates of the center of the top circle of the cylinder. Finally, radius is
the radius of the cylinder circles and therefore the radius of the capsule hemispherical ends.

*/
// --
//
// --
//


function make( dim )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = _.capsule.makeZero( dim );
  if( _.capsule.is( dim ) )
  _.avector.assign( result,dim );
  return result;
}

//

function makeZero( dim )
{
  if( _.capsule.is( dim ) )
  dim = _.capsule.dimGet( dim );
  if( dim === undefined || dim === null )
  dim = 3;
  _.assert( dim >= 0 );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = _.dup( 0, dim*2 + 1 );
  return result;
}

//

function makeNil( dim )
{
  if( _.capsule.is( dim ) )
  dim = _.capsule.dimGet( dim );
  if( dim === undefined || dim === null )
  dim = 3;

  _.assert( dim >= 0 );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = [];
  for( let i = 0 ; i < dim ; i++ )
  result[ i ] = + Infinity;
  for( let i = 0 ; i < dim + 1; i++ )
  result[ dim + i ] = -Infinity;

  return result;
}

//

function zero( capsule )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( _.capsule.is( capsule ) )
  {
    let capsuleView = _.capsule._from( capsule );
    capsuleView.assign( 0 );
    return capsule;
  }

  return _.capsule.makeZero( capsule );
}

//

function nil( capsule )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( _.capsule.is( capsule ) )
  {
    let capsuleView = _.capsule._from( capsule );
    let min = _.capsule.originGet( capsuleView );
    let max = _.capsule.endPointGet( capsuleView );
    let radius = _.capsule.radiusGet( capsuleView );

    _.vector.assign( min, +Infinity );
    _.vector.assign( max, -Infinity );
    capsuleView.eSet( capsuleView.length - 1, - Infinity );

    return capsule;
  }

  return _.capsule.makeNil( capsule );
}

//

function from( capsule )
{
  _.assert( _.capsule.is( capsule ) || capsule === null );
  _.assert( arguments.length === 1, 'expects single argument' );

  if( capsule === null )
  return _.capsule.make();

  return capsule;
}

//

function _from( capsule )
{
  _.assert( _.capsule.is( capsule ) );
  _.assert( arguments.length === 1, 'expects single argument' );
  return _.vector.from( capsule );
}

//

/**
  * Check if input is a capsule. Returns true if it is a capsule and false if not.
  *
  * @param { Vector } capsule - Source capsule.
  *
  * @example
  * // returns true;
  * _.is( [ 0, 0, 1, 1, 1 ] );
  *
  * @returns { Boolean } Returns true if the input is capsule.
  * @function is
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @memberof wTools.capsule
  */
function is( capsule )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  return ( _.longIs( capsule ) || _.vectorIs( capsule ) ) && ( capsule.length >= 0 ) && ( ( capsule.length - 1 ) % 2 === 0 );
}

//

/**
  * Get capsule dimension. Returns the dimension of the capsule. capsule stays untouched.
  *
  * @param { Vector } capsule - The source capsule.
  *
  * @example
  * // returns 2
  * _.dimGet( [ 0, 0, 2, 2, 1 ] );
  *
  * @example
  * // returns 1
  * _.dimGet( [ 0, 1, 1 ] );
  *
  * @returns { Number } Returns the dimension of the capsule.
  * @function dimGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( capsule ) is not capsule.
  * @memberof wTools.capsule
  */
function dimGet( capsule )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( _.capsule.is( capsule ) );
  return ( capsule.length - 1 ) / 2;
}

//

/**
  * Get the origin of a capsule. Returns a vector with the coordinates of the origin of the capsule.
  * capsule stays untouched.
  *
  * @param { Vector } capsule - The source capsule.
  *
  * @example
  * // returns   0, 0
  * _.originGet( [ 0, 0, 2, 2, 1 ] );
  *
  * @example
  * // returns  1
  * _.originGet( [ 1, 2, 1 ] );
  *
  * @returns { Vector } Returns the coordinates of the origin of the capsule.
  * @function originGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( capsule ) is not capsule.
  * @memberof wTools.capsule
  */
function originGet( capsule )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  let capsuleView = _.capsule._from( capsule );
  return capsuleView.subarray( 0, ( capsule.length - 1 ) / 2 );
}

//

/**
  * Get the end point of a capsule. Returns a vector with the coordinates of the final point of the capsule.
  * Capsule stays untouched.
  *
  * @param { Vector } capsule - The source capsule.
  *
  * @example
  * // returns   2, 2
  * _.endPointGet( [ 0, 0, 2, 2, 1 ] );
  *
  * @example
  * // returns  2
  * _.endPointGet( [ 1, 2, 1 ] );
  *
  * @returns { Vector } Returns the final point of the capsule.
  * @function endPointGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( capsule ) is not capsule.
  * @memberof wTools.capsule
  */
function endPointGet( capsule )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  let capsuleView = _.capsule._from( capsule );
  return capsuleView.subarray( ( capsule.length - 1 ) / 2, capsule.length - 1 );
}

//

/**
  * Get the radius of a capsule. Returns a number with the radius of the capsule.
  * Capsule stays untouched.
  *
  * @param { Array } capsule - The source capsule.
  *
  * @example
  * // returns 1
  * _.radiusGet( [ 0, 0, 2, 2, 1 ] );
  *
  * @example
  * // returns  1
  * _.radiusGet( [ 0, 2, 1 ] );
  *
  * @returns { Number } Returns the radius of the capsule.
  * @function radiusGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( capsule ) is not capsule.
  * @memberof wTools.capsule
  */

function radiusGet( capsule )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  let capsuleView = _.capsule._from( capsule );
  return capsuleView.eGet( capsule.length - 1 );
}

//


/**
  * Set the radius of a capsule. Returns a vector with the capsule including the new radius.
  * Radius stays untouched.
  *
  * @param { Array } capsule - The source and destination capsule.
  * @param { Number } radius - The source radius to set.
  *
  * @example
  * // returns [ 0, 0, 2, 2, 4 ]
  * _.radiusSet( [ 0, 0, 2, 2, 0 ], 4 );
  *
  * @example
  * // returns  [ 0, 1, - 2 ]
  * _.radiusSet( [ 0, 1, 1 ], -2 );
  *
  * @returns { Array } Returns the capsule with the modified radius.
  * @function radiusSet
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( capsule ) is not capsule.
  * @throws { Error } An Error if ( radius ) is not number.
  * @memberof wTools.capsule
  */

function radiusSet( capsule, radius )
{
  _.assert( _.capsule.is( capsule ) );
  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.numberIs( radius ) );

  let capsuleView = _.capsule._from( capsule );

  capsuleView.eSet( capsule.length-1, radius );
  return capsuleView;

  debugger;
}
//

/**
  * Check if a given point is contained inside a capsule. Returs true if it is contained, false if not.
  * Point and capsule stay untouched.
  *
  * @param { Array } srcCapsule - The source capsule.
  * @param { Array } srcPoint - The source point.
  *
  * @example
  * // returns true
  * _.pointContains( [ 0, 0, 2, 2, 1 ], [ 1, 1 ] );
  *
  * @example
  * // returns false
  * _.pointContains( [ 0, 0, 2, 2, 1 ], [ - 1, 3 ] );
  *
  * @returns { Boolen } Returns true if the point is inside the capsule, and false if the point is outside it.
  * @function pointContains
  * @throws { Error } An Error if ( dim ) is different than point.length (capsule and point have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcCapsule ) is not capsule.
  * @throws { Error } An Error if ( srcPoint ) is not point.
  * @memberof wTools.capsule
  */
function pointContains( srcCapsule, srcPoint )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.longIs( srcPoint ) || _.vectorIs( srcPoint ) );

  if( srcCapsule === null )
  srcCapsule = _.capsule.make( srcPoint.length );

  let srcCapsuleView = _.capsule._from( srcCapsule );
  let origin = _.capsule.originGet( srcCapsuleView );
  let end = _.capsule.endPointGet( srcCapsuleView );
  let radius = _.capsule.radiusGet( srcCapsuleView );
  let dimension  = _.capsule.dimGet( srcCapsuleView );
  let srcPointView = _.vector.from( srcPoint.slice() );

  _.assert( dimension === srcPoint.length, 'The capsule and the point must have the same dimension' );

  let srcSegment = _.segment.fromPair( [ origin, end ] );

  let distance = _.segment.pointDistance( srcSegment, srcPointView );
  if( distance <= radius )
  {
    return true;
  }
  else
  {
    return false;
  }
}

//

/**
  * Get the distance between a point and a capsule. Returs the calculated distance. Point and capsule stay untouched.
  *
  * @param { Array } srcCapsule - The source capsule.
  * @param { Array } srcPoint - The source point.
  *
  * @example
  * // returns 0
  * _.pointDistance( [ 0, 0, 0, 2, 1 ], [ 0, 1 ] );
  *
  * @example
  * // returns 1
  * _.pointDistance( [ 0, 0, 0, 2, 1 ], [ 2, 2 ] );
  *
  * @returns { Boolen } Returns the distance between the point and the capsule.
  * @function pointDistance
  * @throws { Error } An Error if ( dim ) is different than point.length (capsule and point have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcCapsule ) is not capsule.
  * @throws { Error } An Error if ( srcPoint ) is not point.
  * @memberof wTools.capsule
  */
function pointDistance( srcCapsule, srcPoint )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  if( srcCapsule === null )
  srcCapsule = _.capsule.make( srcPoint.length );

  let srcCapsuleView = _.capsule._from( srcCapsule );
  let origin = _.capsule.originGet( srcCapsuleView );
  let end = _.capsule.endPointGet( srcCapsuleView );
  let radius = _.capsule.radiusGet( srcCapsuleView );
  _.assert( radius >= 0 );
  let dimension  = _.capsule.dimGet( srcCapsuleView );
  let srcPointView = _.vector.from( srcPoint.slice() );

  _.assert( dimension === srcPoint.length, 'The capsule and the point must have the same dimension' );

  if( _.capsule.pointContains( srcCapsuleView, srcPointView ) )
  {
    return 0;
  }
  else
  {
    let srcSegment = _.segment.fromPair( [ origin, end ] );

    let distance = _.segment.pointDistance( srcSegment, srcPointView );

    return distance - radius;
  }
}

/**
  * Get the closest point between a point and a capsule. Returs the calculated point. srcPoint and capsule stay untouched.
  *
  * @param { Array } srcCapsule - The source capsule.
  * @param { Array } srcPoint - The source point.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  * _.pointClosestPoint( [ 0, 0, 0, 2, 1 ], [ 0, 1 ] );
  *
  * @example
  * // returns [ 1, 2 ]
  * _.pointClosestPoint( [ 0, 0, 0, 2, 1 ], [ 2, 2 ] );
  *
  * @returns { Boolen } Returns the closest point in a capsule to a point.
  * @function pointClosestPoint
  * @throws { Error } An Error if ( dim ) is different than point.length (capsule and point have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcCapsule ) is not capsule.
  * @throws { Error } An Error if ( srcPoint ) is not point.
  * @memberof wTools.capsule
  */
function pointClosestPoint( srcCapsule, srcPoint, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( srcPoint.length );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcCapsule === null )
  srcCapsule = _.capsule.make( srcPoint.length );

  let srcCapsuleView = _.capsule._from( srcCapsule );
  let origin = _.capsule.originGet( srcCapsuleView );
  let end = _.capsule.endPointGet( srcCapsuleView );
  let radius = _.capsule.radiusGet( srcCapsuleView );
  _.assert( radius >= 0 );
  let dimension  = _.capsule.dimGet( srcCapsuleView );
  let srcPointView = _.vector.from( srcPoint.slice() );
  let dstPointView = _.vector.from( dstPoint );

  _.assert( dimension === srcPoint.length, 'The capsule and the point must have the same dimension' );

  if( _.capsule.pointContains( srcCapsuleView, srcPointView ) )
  {
    for( let i = 0; i < srcPointView.length; i++ )
    {
      dstPointView.eSet( i, srcPointView.eGet( i ) );
    }
  }
  else
  {
    let pointVector = _.vector.from( _.array.makeArrayOfLengthZeroed( dimension ));

    let srcSegment = _.segment.fromPair( [ origin, end ] );

    let center = _.segment.pointClosestPoint( srcSegment, srcPointView );
    let sphere = _.sphere.make( dimension );
    _.sphere.fromCenterAndRadius( sphere, center, radius );
    pointVector = _.vector.from( _.sphere.pointClosestPoint( sphere, srcPointView ) );

    for( let i = 0; i < pointVector.length; i++ )
    {
      dstPointView.eSet( i, pointVector.eGet( i ) );
    }
  }

  return dstPoint;
}

//

/**
  * Check if a capsule contains a box. Returns true if it contains the box and false if not.
  * The box and the capsule remain unchanged.
  *
  * @param { Array } srcCapsule - Source capsule.
  * @param { Array } srcBox - Source box.
  *
  * @example
  * // returns true;
  * _.boxContains( [ 0, 0, 0, 2, 2, 2, 2 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns false;
  * _.boxContains( [ 0, -1, 0, 0, -2, 0, 1 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Boolean } Returns true if the capsule and the box contains.
  * @function boxContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcCapsule ) is not capsule.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( dim ) is different than box.dimGet (the capsule and box don´t have the same dimension).
  * @memberof wTools.capsule
  */
function boxContains( srcCapsule, srcBox )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  if( srcCapsule === null )
  srcCapsule = _.capsule.make( srcBox.length / 2 );

  let srcCapsuleView = _.capsule._from( srcCapsule );
  let origin = _.capsule.originGet( srcCapsuleView );
  let end = _.capsule.endPointGet( srcCapsuleView );
  let dimCapsule  = _.capsule.dimGet( srcCapsuleView );

  let boxView = _.box._from( srcBox );
  let dimBox = _.box.dimGet( boxView );

  _.assert( dimCapsule === dimBox );

  /* box corners */
  let c = _.box.cornersGet( boxView );

  for( let j = 0 ; j < _.Space.dimsOf( c )[ 1 ] ; j++ )
  {
    let corner = c.colVectorGet( j );

    if( !_.capsule.pointContains( srcCapsuleView, corner ) )
    return false;
  }

  return true;

}

//

/**
  * Check if a capsule and a box intersect. Returns true if they intersect and false if not.
  * The box and the capsule remain unchanged.
  *
  * @param { Array } srcCapsule - Source capsule.
  * @param { Array } srcBox - Source box.
  *
  * @example
  * // returns true;
  * _.boxIntersects( [ 0, 0, 0, 2, 2, 2, 1 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns false;
  * _.boxIntersects( [ 0, -1, 0, 0, -2, 0, 1 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Boolean } Returns true if the capsule and the box intersect.
  * @function boxIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcCapsule ) is not capsule.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( dim ) is different than box.dimGet (the capsule and box don´t have the same dimension).
  * @memberof wTools.capsule
  */
function boxIntersects( srcCapsule, srcBox )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  if( srcCapsule === null )
  srcCapsule = _.capsule.make( srcBox.length / 2 );

  let srcCapsuleView = _.capsule._from( srcCapsule );
  let origin = _.capsule.originGet( srcCapsuleView );
  let end = _.capsule.endPointGet( srcCapsuleView );
  let radius = _.capsule.radiusGet( srcCapsuleView );
  _.assert( radius >= 0 );
  let dimCapsule  = _.capsule.dimGet( srcCapsuleView );

  let boxView = _.box._from( srcBox );
  let dimBox = _.box.dimGet( boxView );

  _.assert( dimCapsule === dimBox );

  let srcSegment = _.segment.fromPair( [ origin, end ] );

  let distance = _.segment.boxDistance( srcSegment, boxView );

  if( distance <= radius )
  { return true; }

  return false;

}

//

/**
  * Get the distance between a capsule and a box. Returns the calculated distance.
  * The box and the capsule remain unchanged.
  *
  * @param { Array } srcCapsule - Source capsule.
  * @param { Array } srcBox - Source box.
  *
  * @example
  * // returns 0;
  * _.boxDistance( [ 0, 0, 0, 2, 2, 2, 1 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns Math.sqrt( 12 ) - 1;
  * _.boxDistance( [ 0, 0, 0, 0, -2, 0, 1 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Number } Returns the distance between the capsule and the box.
  * @function boxDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcCapsule ) is not capsule.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( dim ) is different than box.dimGet (the capsule and box don´t have the same dimension).
  * @memberof wTools.capsule
  */
function boxDistance( srcCapsule, srcBox )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  if( srcCapsule === null )
  srcCapsule = _.capsule.make( srcBox.length / 2 );

  let srcCapsuleView = _.capsule._from( srcCapsule );
  let origin = _.capsule.originGet( srcCapsuleView );
  let end = _.capsule.endPointGet( srcCapsuleView );
  let radius = _.capsule.radiusGet( srcCapsuleView );
  _.assert( radius >= 0 );
  let dimCapsule  = _.capsule.dimGet( srcCapsuleView );

  let boxView = _.box._from( srcBox );
  let dimBox = _.box.dimGet( boxView );

  _.assert( dimCapsule === dimBox );

  if( _.capsule.boxIntersects( srcCapsuleView, boxView ) )
  return 0;

  let srcSegment = _.segment.fromPair( [ origin, end ] );

  let distance = _.segment.boxDistance( srcSegment, boxView );

  return distance - radius;
}

//

/**
  * Get the closest point in a capsule to a box. Returns the calculated point.
  * The box and the capsule remain unchanged.
  *
  * @param { Array } srcCapsule - Source capsule.
  * @param { Array } srcBox - Source box.
  * @param { Array } dstPoint - Destination Point (optional).
  *
  * @example
  * // returns 0;
  * _.boxClosestPoint( [ 0, 0, 0, 2, 2, 2, 1 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.boxClosestPoint( [ 0, - 1, 0, 0, -2, 0, 1 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Number } Returns the closest point in the capsule to the box.
  * @function boxClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcCapsule ) is not capsule.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( dim ) is different than box.dimGet (the capsule and box don´t have the same dimension).
  * @memberof wTools.capsule
  */
function boxClosestPoint( srcCapsule, srcBox, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( srcBox.length / 2 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcCapsule === null )
  srcCapsule = _.capsule.make( srcBox.length / 2 );

  let srcCapsuleView = _.capsule._from( srcCapsule );
  let origin = _.capsule.originGet( srcCapsuleView );
  let end = _.capsule.endPointGet( srcCapsuleView );
  let radius = _.capsule.radiusGet( srcCapsuleView );
  _.assert( radius >= 0 );
  let dimCapsule  = _.capsule.dimGet( srcCapsuleView );

  let boxView = _.box._from( srcBox );
  let dimBox = _.box.dimGet( boxView );
  let min = _.vector.from( _.box.cornerLeftGet( boxView ) );
  let max = _.vector.from( _.box.cornerRightGet( boxView ) );

  let dstPointView = _.vector.from( dstPoint );
  _.assert( dimCapsule === dimBox );

  if( _.capsule.boxIntersects( srcCapsuleView, boxView ) )
  return 0;

  let srcSegment = _.segment.fromPair( [ origin, end ] );

  let center = _.segment.boxClosestPoint( srcSegment, boxView );
  let sphere = _.sphere.make( dimBox );
  _.sphere.fromCenterAndRadius( sphere, center, radius );
  let point =_.sphere.boxClosestPoint( sphere, boxView );

  let pointView = _.vector.from( point );
  for( let i = 0; i < pointView.length; i++ )
  {
    dstPointView.eSet( i, pointView.eGet( i ) );
  }

  return dstPoint;
}

//

/**
  * Check if two capsules intersect. Returns true if they intersect and false if not.
  * The capsules remain unchanged.
  *
  * @param { Array } srcCapsule - Source capsule.
  * @param { Array } tstCapsule - Test capsule.
  *
  * @example
  * // returns true;
  * _.capsuleIntersects( [ 0, 0, 0, 2, 2, 2, 1 ] , [ 0, 0, 0, 1, 1, 1, 0 ]);
  *
  * @example
  * // returns false;
  * _.capsuleIntersects( [ 0, -1, 0, 0, -2, 0, 1 ] , [ 2, 2, 2, 2, 2, 2, 1 ]);
  *
  * @returns { Boolean } Returns true if the capsules intersect.
  * @function capsuleIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcCapsule ) is not capsule.
  * @throws { Error } An Error if ( tstCapsule ) is not capsule.
  * @throws { Error } An Error if ( dim ) is different than capsule.dimGet (the capsules don´t have the same dimension).
  * @memberof wTools.capsule
  */
function capsuleIntersects( srcCapsule, tstCapsule )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  if( srcCapsule === null )
  srcCapsule = _.capsule.make( _.capsule.dimGet( tstCapsule ) );

  let srcCapsuleView = _.capsule._from( srcCapsule );
  let origin = _.capsule.originGet( srcCapsuleView );
  let end = _.capsule.endPointGet( srcCapsuleView );
  let radius = _.capsule.radiusGet( srcCapsuleView );
  _.assert( radius >= 0 );
  let srcDim  = _.capsule.dimGet( srcCapsuleView );

  let tstCapsuleView = _.capsule._from( tstCapsule );
  let tstOrigin = _.capsule.originGet( tstCapsuleView );
  let tstEnd = _.capsule.endPointGet( tstCapsuleView );
  let tstRadius = _.capsule.radiusGet( tstCapsuleView );
  _.assert( tstRadius >= 0 );
  let tstDim  = _.capsule.dimGet( tstCapsuleView );

  _.assert( srcDim === tstDim );

  let srcSegment = _.segment.fromPair( [ origin, end ] );
  let tstSegment = _.segment.fromPair( [ tstOrigin, tstEnd ] );

  let distance = _.segment.segmentDistance( srcSegment, tstSegment );

  if( distance <= radius + tstRadius )
  { return true; }

  return false;

}

//

/**
  * Get the distance between twp capsules. Returns the calculated distance.
  * The capsules remain unchanged.
  *
  * @param { Array } srcCapsule - Source capsule.
  * @param { Array } tstCapsule - Test capsule.
  *
  * @example
  * // returns 0;
  * _.capsuleDistance( [ 0, 0, 0, 2, 2, 2, 1 ] , [ 0, 0, 0, 1, 1, 1, 0 ]);
  *
  * @example
  * // returns Math.sqrt( 12 ) - 1;
  * _.capsuleDistance( [ 0, 0, 0, 0, -2, 0, 1 ] , [ 2, 2, 2, 2, 2, 2, 0 ]);
  *
  * @returns { Number } Returns the distance between two capsules.
  * @function capsuleDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcCapsule ) is not capsule.
  * @throws { Error } An Error if ( tstCapsule ) is not capsule.
  * @throws { Error } An Error if ( dim ) is different than capsule.dimGet (the capsules don´t have the same dimension).
  * @memberof wTools.capsule
  */
function capsuleDistance( srcCapsule, tstCapsule )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );


  if( srcCapsule === null )
  srcCapsule = _.capsule.make( _.capsule.dimGet( tstCapsule ) );

  let srcCapsuleView = _.capsule._from( srcCapsule );
  let origin = _.capsule.originGet( srcCapsuleView );
  let end = _.capsule.endPointGet( srcCapsuleView );
  let radius = _.capsule.radiusGet( srcCapsuleView );
  _.assert( radius >= 0 );
  let srcDim  = _.capsule.dimGet( srcCapsuleView );

  let tstCapsuleView = _.capsule._from( tstCapsule );
  let tstOrigin = _.capsule.originGet( tstCapsuleView );
  let tstEnd = _.capsule.endPointGet( tstCapsuleView );
  let tstRadius = _.capsule.radiusGet( tstCapsuleView );
  _.assert( tstRadius >= 0 );
  let tstDim  = _.capsule.dimGet( tstCapsuleView );

  _.assert( srcDim === tstDim );

  if( _.capsule.capsuleIntersects( srcCapsuleView, tstCapsuleView ) )
  return 0;

  let srcSegment = _.segment.fromPair( [ origin, end ] );
  let tstSegment = _.segment.fromPair( [ tstOrigin, tstEnd ] );

  let distance = _.segment.segmentDistance( srcSegment, tstSegment );

  return distance - ( radius + tstRadius );
}

//

/**
  * Get the closest point in a capsule to a capsule. Returns the calculated point.
  * The capsules remain unchanged.
  *
  * @param { Array } srcCapsule - Source capsule.
  * @param { Array } tstCapsule - Test capsule.
  * @param { Array } dstPoint - Destination Point (optional).
  *
  * @example
  * // returns 0;
  * _.capsuleClosestPoint( [ 0, 0, 0, 2, 2, 2, 1 ] , [ 0, 0, 0, 1, 1, 1, 0 ]);
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.capsuleClosestPoint( [ 0, - 1, 0, 0, -2, 0, 1 ] , [ 2, 2, 2, 2, 2, 2, 0 ]);
  *
  * @returns { Number } Returns the closest point in the capsule to the capsule.
  * @function capsuleClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcCapsule ) is not capsule.
  * @throws { Error } An Error if ( tstCapsule ) is not capsule.
  * @throws { Error } An Error if ( dim ) is different than capsule.dimGet (the capsules don´t have the same dimension).
  * @memberof wTools.capsule
  */
function capsuleClosestPoint( srcCapsule, tstCapsule, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'expects two or three arguments' );

  if( srcCapsule === null )
  srcCapsule = _.capsule.make( _.capsule.dimGet( tstCapsule ) );

  let srcCapsuleView = _.capsule._from( srcCapsule );
  let origin = _.capsule.originGet( srcCapsuleView );
  let end = _.capsule.endPointGet( srcCapsuleView );
  let radius = _.capsule.radiusGet( srcCapsuleView );
  _.assert( radius >= 0 );
  let srcDim  = _.capsule.dimGet( srcCapsuleView );

  let tstCapsuleView = _.capsule._from( tstCapsule );
  let tstOrigin = _.capsule.originGet( tstCapsuleView );
  let tstEnd = _.capsule.endPointGet( tstCapsuleView );
  let tstRadius = _.capsule.radiusGet( tstCapsuleView );
  _.assert( tstRadius >= 0 );
  let tstDim  = _.capsule.dimGet( tstCapsuleView );

  _.assert( srcDim === tstDim );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( srcDim );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointView = _.vector.from( dstPoint );
  _.assert( tstDim === srcDim );

  if( _.capsule.capsuleIntersects( srcCapsuleView, tstCapsuleView ) )
  return 0;

  let srcSegment = _.segment.fromPair( [ origin, end ] );
  let tstSegment = _.segment.fromPair( [ tstOrigin, tstEnd ] );

  let center = _.segment.segmentClosestPoint( srcSegment, tstSegment );
  let sphere = _.sphere.make( srcDim );
  _.sphere.fromCenterAndRadius( sphere, center, radius );
  let point =_.sphere.segmentClosestPoint( sphere, tstSegment );

  let pointView = _.vector.from( point );
  for( let i = 0; i < pointView.length; i++ )
  {
    dstPointView.eSet( i, pointView.eGet( i ) );
  }

  return dstPoint;
}

//

/**
  * Check if a capsule and a frustum intersect. Returns true if they intersect and false if not.
  * The frustum and the capsule remain unchanged.
  *
  * @param { Array } srcCapsule - Source capsule.
  * @param { Array } srcFrustum - Source frustum.
  *
  * @example
  * // returns true;
  * var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  * ([
  *   0,   0,   0,   0, - 1,   1,
  *   1, - 1,   0,   0,   0,   0,
  *   0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1
  * ]);
  * _.frustumIntersects( [ 0, 0, 0, 2, 2, 2, 1 ] , srcFrustum );
  *
  * @example
  * // returns false;
  * _.frustumIntersects( [ 0, -2, 0, 0, -3, 1, 0.5 ] , srcFrustum );
  *
  * @returns { Boolean } Returns true if the capsule and the frustum intersect.
  * @function frustumIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcCapsule ) is not capsule.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( dim ) is different than frustum.dimGet (the capsule and frustum don´t have the same dimension).
  * @memberof wTools.capsule
  */
function frustumIntersects( srcCapsule, srcFrustum )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.frustum.is( srcFrustum ) );

  let dimFrustum = _.Space.dimsOf( srcFrustum ) ;
  let rows = dimFrustum[ 0 ];
  let cols = dimFrustum[ 1 ];

  if( srcCapsule === null )
  srcCapsule = _.capsule.make( rows - 1 );

  let srcCapsuleView = _.capsule._from( srcCapsule );
  let origin = _.capsule.originGet( srcCapsuleView );
  let end = _.capsule.endPointGet( srcCapsuleView );
  let radius = _.capsule.radiusGet( srcCapsuleView );
  _.assert( radius >= 0 );
  let dimCapsule  = _.capsule.dimGet( srcCapsuleView );

  _.assert( dimCapsule === rows - 1 );

  let srcSegment = _.segment.fromPair( [ origin, end ] );

  let distance = _.segment.frustumDistance( srcSegment, srcFrustum )

  if( distance <= radius )
  return true;

  return false;
}

//

/**
  * Get the distance between a capsule and a frustum. Returns the calculated distance.
  * The frustum and the capsule remain unchanged.
  *
  * @param { Array } srcCapsule - Source capsule.
  * @param { Array } srcFrustum - Source frustum.
  *
  * @example
  * // returns 0;
  * var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  * ([
  *   0,   0,   0,   0, - 1,   1,
  *   1, - 1,   0,   0,   0,   0,
  *   0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1
  * ]);
  * _.frustumDistance( [ 0, 0, 0, 2, 2, 2, 1 ], srcFrustum );
  *
  * @example
  * // 1;
  * _.frustumDistance( [ 0, - 2, 0, 0, -3, 0, 1 ], srcFrustum );
  *
  * @returns { Number } Returns the distance between a capsule and a frustum.
  * @function frustumDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcCapsule ) is not capsule.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( dim ) is different than frustum.dimGet (the capsule and frustum don´t have the same dimension).
  * @memberof wTools.capsule
  */
function frustumDistance( srcCapsule, srcFrustum )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.frustum.is( srcFrustum ) );

  let dimFrustum = _.Space.dimsOf( srcFrustum ) ;
  let rows = dimFrustum[ 0 ];
  let cols = dimFrustum[ 1 ];

  if( srcCapsule === null )
  srcCapsule = _.capsule.make( rows - 1 );

  let srcCapsuleView = _.capsule._from( srcCapsule );
  let origin = _.capsule.originGet( srcCapsuleView );
  let end = _.capsule.endPointGet( srcCapsuleView );
  let radius = _.capsule.radiusGet( srcCapsuleView );
  _.assert( radius >= 0 );
  let dimCapsule  = _.capsule.dimGet( srcCapsuleView );

  _.assert( dimCapsule === rows - 1 );

  if( _.capsule.frustumIntersects( srcCapsuleView, srcFrustum ) )
  return 0;

  let srcSegment = _.segment.fromPair( [ origin, end ] );

  let distance = _.segment.frustumDistance( srcSegment, srcFrustum )

  return distance - radius;
}

//

/**
  * Get the closest point in a capsule to a frustum. Returns the calculated point.
  * The frustum and the capsule remain unchanged.
  *
  * @param { Array } srcCapsule - Source capsule.
  * @param { Array } srcFrustum - Source frustum.
  *
  * @example
  * // returns 0;
  * var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  * ([
  *   0,   0,   0,   0, - 1,   1,
  *   1, - 1,   0,   0,   0,   0,
  *   0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1
  * ]);
  * _.frustumClosestPoint( [ 0, 0, 0, 2, 2, 2, 1 ] , srcFrustum );
  *
  * @example
  * // returns [ 0, - 0.5, 0 ];
  * _.frustumClosestPoint( [ 0, - 1, 0, 0, -2, 0, 0.5 ] , srcFrustum );
  *
  * @returns { Array } Returns the closest point in the capsule to the frustum.
  * @function frustumClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcCapsule ) is not capsule.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( dim ) is different than frustum.dimGet (the capsule and frustum don´t have the same dimension).
  * @memberof wTools.capsule
  */
function frustumClosestPoint( srcCapsule, srcFrustum, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'expects two or three arguments' );
  _.assert( _.frustum.is( srcFrustum ) );

  let dimFrustum = _.Space.dimsOf( srcFrustum ) ;
  let rows = dimFrustum[ 0 ];
  let cols = dimFrustum[ 1 ];

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( rows - 1 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcCapsule === null )
  srcCapsule = _.capsule.make( rows - 1 );

  let srcCapsuleView = _.capsule._from( srcCapsule );
  let origin = _.capsule.originGet( srcCapsuleView );
  let end = _.capsule.endPointGet( srcCapsuleView );
  let radius = _.capsule.radiusGet( srcCapsuleView );
  _.assert( radius >= 0 );
  let dimCapsule  = _.capsule.dimGet( srcCapsuleView );

  let dstPointView = _.vector.from( dstPoint );
  _.assert( dimCapsule === rows - 1 );

  if( _.capsule.frustumIntersects( srcCapsuleView, srcFrustum ) )
  return 0;

  let srcSegment = _.segment.fromPair( [ origin, end ] );

  let center = _.segment.frustumClosestPoint( srcSegment, srcFrustum );
  let sphere = _.sphere.make( dimCapsule );
  _.sphere.fromCenterAndRadius( sphere, center, radius );
  let pointView =_.sphere.frustumClosestPoint( sphere, srcFrustum );

  pointView = _.vector.from( pointView );
  for( let i = 0; i < pointView.length; i++ )
  {
    dstPointView.eSet( i, pointView.eGet( i ) );
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

  is : is,
  dimGet : dimGet,
  originGet : originGet,
  endPointGet : endPointGet,
  radiusGet : radiusGet,
  radiusSet : radiusSet,

  pointContains : pointContains,
  pointDistance : pointDistance,
  pointClosestPoint : pointClosestPoint,

  boxContains : boxContains,
  boxIntersects : boxIntersects,
  boxDistance : boxDistance,
  boxClosestPoint : boxClosestPoint,

  capsuleIntersects : capsuleIntersects,
  capsuleDistance : capsuleDistance,
  capsuleClosestPoint : capsuleClosestPoint,

  frustumIntersects : frustumIntersects,
  frustumDistance : frustumDistance,
  frustumClosestPoint : frustumClosestPoint,

}

_.mapSupplement( Self, Proto );

//

if( typeof module !== 'undefined' )
{

  // require( './Sphere.s' );

}

})();
