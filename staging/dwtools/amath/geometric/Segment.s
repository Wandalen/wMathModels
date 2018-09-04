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
  
}

_.mapSupplement( Self, Proto );

//

if( typeof module !== 'undefined' )
{

  require( './Sphere.s' );

}

})();
