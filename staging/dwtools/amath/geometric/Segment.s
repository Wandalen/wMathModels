(function _Segment_s_(){

'use strict';

let _ = _global_.wTools;
let avector = _.avector;
let vector = _.vector;
let Self = _.segment = _.segment || Object.create( null );

/*

  A segment is a finite line, starting at an origin and finishing at an end point.

  For the following functions, segments must have the shape [ startX, startY, startZ, endX, endY, endZ ],
where the dimension equals the object´s length divided by two.

  Moreover, startX, startY and startZ are the coordinates of the origin of the segment,
and endX, endY and endZ the coordinates of the end of the segment.

*/
// --
//
// --
//


function make( dim )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = _.segment.makeZero( dim );
  if( _.segment.is( dim ) )
  _.avector.assign( result,dim );
  return result;
}

//

function makeZero( dim )
{
  if( _.segment.is( dim ) )
  dim = _.segment.dimGet( dim );
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
  if( _.segment.is( dim ) )
  dim = _.segment.dimGet( dim );
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

function zero( segment )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( _.segment.is( segment ) )
  {
    let segmentView = _.segment._from( segment );
    segmentView.assign( 0 );
    return segment;
  }

  return _.segment.makeZero( segment );
}

//

function nil( segment )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( _.segment.is( segment ) )
  {
    let segmentView = _.segment._from( segment );
    let min = _.segment.originGet( segmentView );
    let max = _.segment.endPointGet( segmentView );

    _.vector.assign( min, +Infinity );
    _.vector.assign( max, -Infinity );

    return segment;
  }

  return _.segment.makeNil( segment );
}

//

function from( segment )
{
//  if( _.objectIs( segment ) )
//  {
//    _.assertMapHasFields( segment,{ min : 'min' , max : 'max' } );
//    segment = _.arrayAppendArray( [],[ segment.min,segment.max ] );
//  }

  _.assert( _.segment.is( segment ) || segment === null );
  _.assert( arguments.length === 1, 'expects single argument' );

//  if( _.vectorIs( segment ) )
//  {
//    debugger;
//    throw _.err( 'not implemented' );
//    return segment.slice();
//  }

  if( segment === null )
  return _.segment.make();

  return segment;
}

//

function _from( segment )
{
  _.assert( _.segment.is( segment ) );
  _.assert( arguments.length === 1, 'expects single argument' );
  return _.vector.from( segment );
}

//

/**
  * Check if input is a segment. Returns true if it is a segment and false if not.
  *
  * @param { Vector } segment - Source segment.
  *
  * @example
  * // returns true;
  * _.is( [ 0, 0, 1, 1 ] );
  *
  * @returns { Boolean } Returns true if the input is segment.
  * @function is
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @memberof wTools.segment
  */
function is( segment )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  return ( _.longIs( segment ) || _.vectorIs( segment ) ) && ( segment.length >= 0 ) && ( segment.length % 2 === 0 );
}

//

/**
  * Get segment dimension. Returns the dimension of the segment. segment stays untouched.
  *
  * @param { Vector } segment - The source segment.
  *
  * @example
  * // returns 2
  * _.dimGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns 1
  * _.dimGet( [ 0, 1 ] );
  *
  * @returns { Number } Returns the dimension of the segment.
  * @function dimGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @memberof wTools.segment
  */
function dimGet( segment )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( _.segment.is( segment ) );
  return segment.length / 2;
}

//

/**
  * Get the origin of a segment. Returns a vector with the coordinates of the origin of the segment.
  * segment stays untouched.
  *
  * @param { Vector } segment - The source segment.
  *
  * @example
  * // returns   0, 0
  * _.originGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns  1
  * _.originGet( [ 1, 2 ] );
  *
  * @returns { Vector } Returns the coordinates of the origin of the segment.
  * @function originGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @memberof wTools.segment
  */
function originGet( segment )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  let segmentView = _.segment._from( segment );
  return segmentView.subarray( 0, segment.length/ 2 );
}

//

/**
  * Get the end point of a segment. Returns a vector with the coordinates of the final point of the segment.
  * Segment stays untouched.
  *
  * @param { Vector } segment - The source segment.
  *
  * @example
  * // returns   2, 2
  * _.endPointGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns  2
  * _.endPointGet( [ 1, 2 ] );
  *
  * @returns { Vector } Returns the final point of the segment.
  * @function endPointGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @memberof wTools.segment
  */
function endPointGet( segment )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  let segmentView = _.segment._from( segment );
  return segmentView.subarray( segment.length/ 2, segment.length );
}

//

/**
  * Get the direction of a segment. Returns a vector with the coordinates of the direction of the segment.
  * Segment stays untouched.
  *
  * @param { Vector } segment - The source segment.
  *
  * @example
  * // returns   2, 2
  * _.directionGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns  2
  * _.directionGet( [ 1, 2 ] );
  *
  * @returns { Vector } Returns the direction of the segment.
  * @function directionGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @memberof wTools.segment
  */
function directionGet( segment )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  let segmentView = _.segment._from( segment );
  let origin = _.segment.originGet( segment );
  let endPoint = _.segment.endPointGet( segment );
  let dim = _.segment.dimGet( segmentView );
  let direction = _.vector.from( _.array.makeArrayOfLength( dim ) );

  for( var i = 0; i < dim; i++ )
  {
    direction.eSet( i, endPoint.eGet( i ) - origin.eGet( i ) );
  }

  return direction;
}

//

/**
  * Get a point in a segment. Returns a vector with the coordinates of the point of the segment.
  * Segment and factor stay untouched.
  *
  * @param { Vector } srcSegment - The source segment.
  * @param { Vector } factor - The source factor.
  *
  * @example
  * // returns   1, 1
  * _.segmentAt( [ 0, 0, 2, 2 ], 0.5 );
  *
  * @example
  * // returns  1
  * _.segmentAt( [ 1, 2 ], 0 );
  *
  * @returns { Vector } Returns a point in the segment at a given factor.
  * @function segmentAt
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( factor ) is not number.
  * @memberof wTools.segment
  */
function segmentAt( srcSegment, factor )
{
  // let result = avector.mul( null, srcSegment[ 1 ], factor );
  // avector.add( result, srcSegment[ 0 ] );

  _.assert( arguments.length === 2, 'expects single argument' );
  _.assert( _.segment.is( srcSegment ) );
  _.assert( factor >= 0, 'Factor can not be negative ( point must be in the segment )');
  _.assert( factor <= 1, 'Factor can not be bigger than one ( point must be in the segment )');

  let segmentView = _.segment._from( srcSegment )
  let origin = _.segment.originGet( segmentView );
  let direction = _.segment.directionGet( segmentView );

  let result = avector.mul( null, direction, factor );
  result = avector.add( result, origin );

  return result;
}

segmentAt.shaderChunk =
`
  vec2 segmentAt( vec2 srcSegment[ 2 ], float factor )
  {

    vec2 result = srcSegment[ 1 ]*factor;
    result += srcSegment[ 0 ];

    return result;
  }
`

//

/**
* Get the factor of a point inside a segment. Returs the calculated factor. Point and segment stay untouched.
*
* @param { Array } srcSegment - The source segment.
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
* @returns { Number } Returns the factor if the point is inside the segment, and false if the point is outside it.
* @function getFactor
* @throws { Error } An Error if ( dim ) is different than point.length (segment and point have not the same dimension).
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( srcSegment ) is not segment.
* @throws { Error } An Error if ( srcPoint ) is not point.
* @memberof wTools.segment
*/
function getFactor( srcSegment, srcPoint )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  if( srcSegment === null )
  srcSegment = _.segment.make( srcPoint.length );

  let srcSegmentView = _.segment._from( srcSegment );
  let origin = _.segment.originGet( srcSegmentView );
  let direction = _.segment.directionGet( srcSegmentView );
  let dimension  = _.segment.dimGet( srcSegmentView )
  let srcPointView = _.vector.from( srcPoint.slice() );

  _.assert( dimension === srcPoint.length, 'The segment and the point must have the same dimension' );
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
  if(  factor <= 0 - _.accuracySqr || factor >= 1 + _.accuracySqr )
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
      // Factor can not be negative
      if(  factor <= 0 - _.accuracySqr || factor >= 1 + _.accuracySqr )
      return false;
    }
  }

  return factor;
}

//

/**
  * Check if two segments are parallel. Returns true if they are parallel and false if not.
  * Segments and accuracySqr stay untouched.
  *
  * @param { Vector } src1Segment - The first source segment.
  * @param { Vector } src2Segment - The second source segment.
  * @param { Vector } accuracySqr - The accuracy.
  *
  * @example
  * // returns   true
  * _.segmentParallel( [ 0, 0, 0, 2, 2, 2 ], [ 1, 2, 1, 3, 4, 3 ] );
  *
  * @example
  * // returns  false
  * _.segmentParallel( [ 1, 2, 1, 1, 1, 2 ], [ 1, 2, 1, 1, 3, 3 ] );
  *
  * @returns { Boolean } Returns true if the segments are parallel.
  * @function segmentParallel
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( src1Segment ) is not segment.
  * @throws { Error } An Error if ( src2Segment ) is not segment.
  * @throws { Error } An Error if ( accuracySqr ) is not number.
  * @memberof wTools.segment
  */
function segmentParallel( src1Segment, src2Segment, accuracySqr )
{
  _.assert( _.segment.is( src1Segment ) );
  _.assert( _.segment.is( src2Segment ) );
  _.assert( arguments.length === 2 || arguments.length === 3 );
  _.assert( src1Segment.length === src2Segment.length );

  if( arguments.length === 2 || accuracySqr === undefined || accuracySqr === null )
  accuracySqr = _.accuracySqr;;

  let direction1 = _.segment.directionGet( src1Segment );
  let direction2 = _.segment.directionGet( src2Segment );
  let proportion = undefined;

  let zeros1 = 0;                               // Check if Segment1 is a point
  for( let i = 0; i < direction1.length ; i++  )
  {
    if( direction1.eGet( i ) === 0 )
    {
      zeros1 = zeros1 + 1;
    }
    if( zeros1 === direction1.length )
    return true;
  }

  let zeros2 = 0;                               // Check if Segment2 is a point
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
  * Returns the factors for the intersection of two segments. Returns a vector with the intersection factors, 0 if there is no intersection.
  * Segments stay untouched.
  *
  * @param { Vector } src1Segment - The first source segment.
  * @param { Vector } src2Segment - The second source segment.
  *
  * @example
  * // returns   0
  * _.segmentIntersectionFactors( [ 0, 0, 2, 2 ], [ 3, 3, 4, 4 ] );
  *
  * @example
  * // returns  _.vector.from( [ 2/3, 0.5 ] )
  * _.segmentIntersectionFactors( [ - 2, 0, 1, 0 ], [ 0, - 2, 0, 2 ] );
  *
  * @returns { Array } Returns the factors for the two segments intersection.
  * @function segmentIntersectionFactors
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Segment ) is not segment.
  * @throws { Error } An Error if ( src2Segment ) is not segment.
  * @memberof wTools.segment
  */
function segmentIntersectionFactors( srcSegment1, srcSegment2 )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( srcSegment1.length === srcSegment2.length,'The two segments must have the same dimension' );

  let srcSegment1View = _.segment._from( srcSegment1.slice() );
  let srcSegment2View = _.segment._from( srcSegment2.slice() );
  logger.log( 'Segments', srcSegment1View, srcSegment2View )
  let origin1 = _.segment.originGet( srcSegment1View );
  let origin2 = _.segment.originGet( srcSegment2View );
  let end1 = _.segment.endPointGet( srcSegment1View );
  let end2 = _.segment.endPointGet( srcSegment2View );
  logger.log( 'Origins', origin1, origin2 )
  let dOrigin = _.vector.from( avector.subVectors( origin2.clone(), origin1 ) );
  let direction1 = _.segment.directionGet( srcSegment1View );
  let direction2 = _.segment.directionGet( srcSegment2View );
  logger.log( 'Directions', direction1, direction2 )
  let directions = _.Space.make( [ srcSegment1.length / 2 , 2 ] );
  directions.colVectorGet( 0 ).copy( direction1 );
  directions.colVectorGet( 1 ).copy( direction2.clone().mulScalar( - 1 ) );

  // Same origin
  let identOrigin = 0;
  let identEnd = 0;
  let origin1End2 = 0;
  let end1Origin2 = 0;
  for( let i = 0; i < origin1.length; i++ )
  {
    if( origin1.eGet( i ) === origin2.eGet( i ) )
    identOrigin = identOrigin + 1;

    if( origin1.eGet( i ) === end2.eGet( i ) )
    origin1End2 = origin1End2 + 1;

    if( end1.eGet( i ) === origin2.eGet( i ) )
    end1Origin2 = end1Origin2 + 1;

    if( end1.eGet( i ) === end2.eGet( i ) )
    identEnd = identEnd + 1;
  }

  if( identOrigin === origin1.length )
  return _.vector.from( [ 0, 0 ] );

  else if( origin1End2 === origin1.length )
  return _.vector.from( [ 0, 1 ] );

  else if( end1Origin2 === origin1.length )
  return _.vector.from( [ 1, 0 ] );

  else if( identEnd === origin1.length )
  return _.vector.from( [ 1, 1 ] );

  // Parallel segments
  if( segmentParallel( srcSegment1, srcSegment2 ) === true )
  {
    if( _.segment.pointContains( srcSegment1, origin2 ) )
    {
      return _.vector.from( [ _.segment.getFactor( srcSegment1, origin2), 0 ] );
    }
    else if( _.segment.pointContains( srcSegment2, origin1 ) )
    {
      return _.vector.from( [  0, _.segment.getFactor( srcSegment2, origin1) ] );
    }
    else
    {
      return 0;
    }
  }

  let result = _.vector.from( [ 0, 0 ] );
  let oldResult = _.vector.from( [ 0, 0 ] );
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

    result = _.vector.from( x.base );

    let point1 = _.vector.from( _.array.makeArrayOfLength( dOrigin.length ) );
    let point2 = _.vector.from( _.array.makeArrayOfLength( dOrigin.length ) );
    let equal = 0;
    for( var j = 0; j < dOrigin.length; j++ )
    {
      point1.eSet( j, origin1.eGet( j ) + direction1.eGet( j )*result.eGet( 0 ) )
      point2.eSet( j, origin2.eGet( j ) + direction2.eGet( j )*result.eGet( 1 ) )
      logger.log( j, point1.eGet( j ), point2.eGet( j ) )
      logger.log( _.accuracy )
      if( point1.eGet( j ) + 1E-6 >= point2.eGet( j ) && point2.eGet( j ) >= point1.eGet( j ) - 1E-6 )
      {
        equal = equal + 1;
      }
    }

    let result0 = result.eGet( 0 ) >= 0 - _.accuracySqr && result.eGet( 0 ) <= 1 + _.accuracySqr;
    let result1 = result.eGet( 1 ) >= 0 - _.accuracySqr && result.eGet( 1 ) <= 1 + _.accuracySqr;
    if( equal === dOrigin.length && result0 && result1 )
    return result;
  }

  return 0;
}

//

/**
  * Returns the points of the intersection of two segments. Returns an array with the intersection points, 0 if there is no intersection.
  * Segments stay untouched.
  *
  * @param { Vector } src1Segment - The first source segment.
  * @param { Vector } src2Segment - The second source segment.
  *
  * @example
  * // returns   0
  * _.segmentIntersectionPoints( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  [ [ 0, 0 ], [ 0, 0 ] ]
  * _.segmentIntersectionPoints( [ -3, 0, 1, 0 ], [ 0, -2, 0, 1 ] );
  *
  * @returns { Array } Returns the points of intersection of the two segments.
  * @function segmentIntersectionPoints
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Segment ) is not segment.
  * @throws { Error } An Error if ( src2Segment ) is not segment.
  * @memberof wTools.segment
  */
function segmentIntersectionPoints( srcSegment1, srcSegment2 )
{
  let factors = segmentIntersectionFactors( srcSegment1, srcSegment2 );
  if( factors === 0 )
  return 0;

  let factorsView = _.vector.from( factors );
  let result = [ Self.segmentAt( srcSegment1, factorsView.eGet( 0 ) ), Self.segmentAt( srcSegment2, factorsView.eGet( 1 ) ) ];
  return result;
}

segmentIntersectionPoints.shaderChunk =
`
  void segmentIntersectionPoints( out vec2 result[ 2 ], vec2 srcSegment1[ 2 ], vec2 srcSegment2[ 2 ] )
  {

    vec2 factors = segmentIntersectionFactors( srcSegment1,srcSegment2 );
    result[ 0 ] = segmentAt( srcSegment1,factors[ 0 ] );
    result[ 1 ] = segmentAt( srcSegment2,factors[ 1 ] );

  }
`

//

/**
  * Returns the point of the intersection of two segments. Returns an array with the intersection point, 0 if there is no intersection.
  * Segments stay untouched.
  *
  * @param { Vector } src1Segment - The first source segment.
  * @param { Vector } src2Segment - The second source segment.
  *
  * @example
  * // returns   0
  * _.segmentIntersectionPoint( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  [ [ 0, 0 ] ]
  * _.segmentIntersectionPoint( [ -3, 0, 1, 0 ], [ 0, -2, 0, 1 ] );
  *
  * @returns { Array } Returns the point of intersection of the two segments.
  * @function segmentIntersectionPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Segment ) is not segment.
  * @throws { Error } An Error if ( src2Segment ) is not segment.
  * @memberof wTools.segment
  */
function segmentIntersectionPoint( srcSegment1,srcSegment2 )
{

  let factors = Self.segmentIntersectionFactors( srcSegment1,srcSegment2 );

  if( factors === 0 )
  return 0;

  return Self.segmentAt( srcSegment1, factors.eGet( 0 ) );

}

segmentIntersectionPoint.shaderChunk =
`
  vec2 segmentIntersectionPoint( vec2 srcSegment1[ 2 ], vec2 srcSegment2[ 2 ] )
  {

    vec2 factors = segmentIntersectionFactors( srcSegment1,srcSegment2 );
    return segmentAt( srcSegment1,factors[ 0 ] );

  }
`

//

/**
  * Returns the point of the intersection of two segments. Returns an array with the intersection point, 0 if there is no intersection.
  * Segments stay untouched.
  *
  * @param { Vector } src1Segment - The first source segment.
  * @param { Vector } src2Segment - The second source segment.
  *
  * @example
  * // returns   0
  * _.segmentIntersectionPointAccurate( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  [ [ 0, 0 ] ]
  * _.segmentIntersectionPointAccurate( [ -3, 0, 1, 0 ], [ 0, -2, 0, 1 ] );
  *
  * @returns { Array } Returns the point of intersection of the two segments.
  * @function segmentIntersectionPointAccurate
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Segment ) is not segment.
  * @throws { Error } An Error if ( src2Segment ) is not segment.
  * @memberof wTools.segment
  */
function segmentIntersectionPointAccurate( srcSegment1, srcSegment2 )
{

  let closestPoints = Self.segmentIntersectionPoints( srcSegment1, srcSegment2 );
  debugger;

  if( closestPoints === 0 )
  return 0;

  return _.avector.mulScalar( _.avector.add( null, closestPoints[ 0 ], closestPoints[ 1 ] ), 0.5 );

}

segmentIntersectionPointAccurate.shaderChunk =
`
  vec2 segmentIntersectionPointAccurate( vec2 srcSegment1[ 2 ], vec2 srcSegment2[ 2 ] )
  {

    vec2 closestPoints[ 2 ];
    segmentIntersectionPoints( closestPoints,srcSegment1,srcSegment2 );
    return ( closestPoints[ 0 ] + closestPoints[ 1 ] ) * 0.5;

  }
`

//

/**
  * Check if two segments intersect. Returns true if they intersect, false if not.
  * Segments stay untouched.
  *
  * @param { Vector } src1Segment - The first source segment.
  * @param { Vector } src2Segment - The second source segment.
  *
  * @example
  * // returns   true
  * _.segmentIntersects( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  false
  * _.segmentIntersects( [ -3, 0, 1, 0 ], [ 0, -2, 1, 0 ] );
  *
  * @returns { Boolean } Returns true if the two segments intersect.
  * @function segmentIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Segment ) is not segment.
  * @throws { Error } An Error if ( src2Segment ) is not segment.
  * @memberof wTools.segment
  */
function segmentIntersects( srcSegment1, srcSegment2 )
{

  if( _.segment.segmentIntersectionFactors( srcSegment1, srcSegment2 ) === 0 )
  return false

  return true;
}

//

/**
  * Check if a given point is contained inside a segment. Returs true if it is contained, false if not.
  * Point and segment stay untouched.
  *
  * @param { Array } srcSegment - The source segment.
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
  * @returns { Boolen } Returns true if the point is inside the segment, and false if the point is outside it.
  * @function pointContains
  * @throws { Error } An Error if ( dim ) is different than point.length (segment and point have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcPoint ) is not point.
  * @memberof wTools.segment
  */
function pointContains( srcSegment, srcPoint )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  if( srcSegment === null )
  srcSegment = _.segment.make( srcPoint.length );

  let srcSegmentView = _.segment._from( srcSegment );
  let origin = _.segment.originGet( srcSegmentView );
  let direction = _.segment.directionGet( srcSegmentView );
  let dimension  = _.segment.dimGet( srcSegmentView )
  let srcPointView = _.vector.from( srcPoint.slice() );

  _.assert( dimension === srcPoint.length, 'The segment and the point must have the same dimension' );

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

  // Factor can not be negative or superior to one
  if(  factor <= 0 - _.accuracySqr && factor >= 1 + _.accuracySqr )
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

      if( Math.abs( newFactor - factor ) > _.accuracySqr && direction.eGet( i - 1 ) !== 0 )
      {
        return false;
      }
      factor = newFactor;

      // Factor can not be negative or superior to one
      if(  factor <= 0 - _.accuracySqr || factor >= 1 + _.accuracySqr )
      return false;
    }
  }

  return true;
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
  directionGet : directionGet,

  segmentAt : segmentAt,
  getFactor : getFactor,

  segmentParallel : segmentParallel,

  segmentIntersectionFactors : segmentIntersectionFactors,
  segmentIntersectionPoints : segmentIntersectionPoints,
  segmentIntersectionPoint : segmentIntersectionPoint,
  segmentIntersectionPointAccurate : segmentIntersectionPointAccurate,

  segmentIntersects : segmentIntersects,

  pointContains : pointContains,

}

_.mapSupplement( Self, Proto );

//

if( typeof module !== 'undefined' )
{

  require( './Sphere.s' );

}

})();
