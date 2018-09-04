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
}

_.mapSupplement( Self, Proto );

//

if( typeof module !== 'undefined' )
{

  require( './Sphere.s' );

}

})();
