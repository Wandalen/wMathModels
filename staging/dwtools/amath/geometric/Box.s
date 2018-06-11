(function _Box_s_(){

'use strict';

var _ = _global_.wTools;
var avector = _.avector;
var vector = _.vector;
var Self = _.box = _.box || Object.create( null );

// --
//
// --

function make( dim )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  var result = _.box.makeZero( dim );
  if( _.box.is( dim ) )
  _.avector.assign( result,dim );
  return result;
}

//

function makeZero( dim )
{
  if( _.box.is( dim ) )
  dim = _.box.dimGet( dim );
  if( dim === undefined || dim === null )
  dim = 3;
  _.assert( dim >= 0 );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  var result = _.dup( 0,dim*2 );
  return result;
}

//

function makeNil( dim )
{
  if( _.box.is( dim ) )
  dim = _.box.dimGet( dim );
  if( dim === undefined || dim === null )
  dim = 3;

  var result = [];
  for( var i = 0 ; i < dim ; i++ )
  result[ i ] = +Infinity;
  for( var i = 0 ; i < dim ; i++ )
  result[ dim+i ] = -Infinity;

  return result;
}

//

function zero( box )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( _.box.is( box ) )
  {
    var boxv = _.box._from( box );
    boxv.assign( 0 );
    return box;
  }

  return _.box.makeZero( box );
}

//

function nil( box )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( _.box.is( box ) )
  {
    var boxv = _.box._from( box );
    var min = _.box.minGet( boxv );
    var max = _.box.maxGet( boxv );

    _.vector.assign( min, +Infinity );
    _.vector.assign( max, -Infinity );

    return box;
  }

  return _.box.makeNil( box );
}

//

function centeredOfSize( box,size )
{

  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( size === undefined )
  size = 1;

  if( !_.box.is( box ) )
  box = _.box.make( box );

  var boxv = _.box._from( box );
  var min = _.box.minGet( boxv );
  var max = _.box.maxGet( boxv );

  size = _.numbersSlice( size );
  size = _.avector.mulScalar( size,0.5 );
  _.vector.assign( max, size );
  size = _.avector.mulScalar( size,-1 );
  _.vector.assign( min, size );

  return box;
}

//

function from( box )
{

  if( _.objectIs( box ) )
  {
    _.assertMapHasOnly( box,{ min : 'min' , max : 'max' } );
    box = _.arrayAppendArrays( [],[ box.min,box.max ] );
  }

  _.assert( _.box.is( box ) );
  _.assert( arguments.length === 1 );

  if( _.vectorIs( box ) )
  {
    debugger;
    throw _.err( 'not implemented' );
    return box.slice();
  }

  return box;
}

//

function _from( box )
{
  _.assert( _.box.is( box ) );
  _.assert( arguments.length === 1 );
  return _.vector.from( box );
}

//

function fromPoints( box , points )
{

  _.assert( arguments.length === 2 );
  _.assert( _.arrayIs( points ) );

  if( box === null )
  box = _.box.makeNil();

  var boxv = _.box._from( box );
  var min = _.box.minGet( boxv );
  var max = _.box.maxGet( boxv );

  debugger;
  // throw _.err( 'not tested' );

  for( var i = 0 ; i < points.length ; i += 1 )
  {
    _.box.pointExpand( boxv, points[ i ] );
  }

  return box;

}

//

function fromCenterAndSize( box , center , size )
{

  if( box === null )
  box = _.box.make( center.length );

  var boxv = _.box._from( box );
  var min = _.box.minGet( boxv );
  var max = _.box.maxGet( boxv );
  var dim = _.box.dimGet( boxv );
  var center = _.vector.from( center );
  var size = _.vector.from( size );

  _.assert( dim === center.length );
  _.assert( dim === size.length );
  _.assert( arguments.length === 3 );

  debugger;
  throw _.err( 'not tested' );

  var size = _.vector.mulScalar( size.clone() , 0.5 );
  _.vector.subAssigning( min.copy( center ) , size );
  _.vector.addAssigning( max.copy( center ) , size );

  return box;
}

//

function fromSphere( box , sphere )
{

  var _sphere = _.sphere._from( sphere );
  var dim1 = _.sphere.dimGet( _sphere );
  var center = _.sphere.centerGet( _sphere );
  var radius = _.sphere.radiusGet( _sphere );

  if( box === null )
  box = _.box.make( dim );

  var boxv = _.box._from( box );
  var min = _.box.minGet( boxv );
  var max = _.box.maxGet( boxv );
  var dim2 = _.box.dimGet( boxv );

  _.assert( arguments.length === 2 );
  _.assert( dim1 === dim2 );

  debugger;
  throw _.err( 'not tested' );

  _.box.fromPoints( boxv, [ center ] );
  _.box.expand( boxv, radius );

  return box;
}

//

function fromCube( box , size )
{

  if( box === null )
  box = _.box.make();

  var boxv = _.box._from( box );
  var min = _.box.minGet( boxv );
  var max = _.box.maxGet( boxv );
  var dim = _.box.dimGet( boxv );

  _.assert( arguments.length === 2 );

  _.vector.assignScalar( min,-size/2 );
  _.vector.assignScalar( max,+size/2 );

  return box;
}

//

function is( box )
{
  _.assert( arguments.length === 1 );
  return ( _.arrayLike( box ) || _.vectorIs( box ) ) && ( box.length >= 0 ) && ( box.length % 2 === 0 );
}

//

function isEmpty( box )
{

  _.assert( arguments.length === 1 );

  var boxv = _.box._from( box );
  var dim = _.box.dimGet( boxv );
  var min = _.box.minGet( boxv );
  var max = _.box.maxGet( boxv );

  for( var d = 0 ; d < dim ; d++ )
  if( min.eGet( d ) >= max.eGet( d ) )
  return true;

  if( dim === 0 )
  return true;

  return false;
}

//

function isZero( box )
{

  _.assert( arguments.length === 1 );

  var boxv = _.box._from( box );
  var dim = _.box.dimGet( boxv );
  var min = _.box.minGet( boxv );
  var max = _.box.maxGet( boxv );

  for( var d = 0 ; d < dim ; d++ )
  if( min.eGet( d ) !== max.eGet( d ) )
  return false;

  return true;
}

//

function isNil( box )
{

  _.assert( arguments.length === 1 );

  var boxv = _.box._from( box );
  var dim = _.box.dimGet( boxv );
  var min = _.box.minGet( boxv );
  var max = _.box.maxGet( boxv );

  for( var d = 0 ; d < dim ; d++ )
  if( min.eGet( d ) > max.eGet( d ) )
  return true;

  return false;
}

//

function dimGet( box )
{
  _.assert( arguments.length === 1 );
  _.assert( _.box.is( box ) );
  return box.length / 2;
}

//

function minGet( box )
{
  var boxv = _.box._from( box );
  _.assert( arguments.length === 1 );
  return boxv.subarray( 0 , box.length / 2 );
}

//

function maxGet( box )
{
  var boxv = _.box._from( box );
  _.assert( arguments.length === 1 );
  return boxv.subarray( box.length / 2 , box.length );
}

//

function centerGet( box , dst )
{

  var boxv = _.box._from( box );
  var dim = _.box.dimGet( boxv );
  var min = _.box.minGet( boxv );
  var max = _.box.maxGet( boxv );

  if( !dst )
  dst = _.vector.from( _.dup( 0,dim ) );
  var dstv = _.vector.from( dst );

  _.assert( dim === dst.length );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  // debugger;
  // throw _.err( 'not tested' );

  _.vector.addAssigning( dstv.copy( min ), max ).mulScalar( 0.5 );

  return dst;
}

//

function sizeGet( box , dst )
{

  var boxv = _.box._from( box );
  var dim = _.box.dimGet( boxv );
  var min = _.box.minGet( boxv );
  var max = _.box.maxGet( boxv );

  if( !dst )
  dst = _.dup( 0,dim );
  var dstv = _.vector.from( dst );

  _.assert( dim === dst.length );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  _.vector.subVectors( dstv.copy( max ), min );

  return dst;
}

//

function expand( box , expand )
{

  if( box === null )
  box = _.box.make();

  var boxv = _.box._from( box );
  var dim = _.box.dimGet( boxv );
  var min = _.box.minGet( boxv );
  var max = _.box.maxGet( boxv );
  var expand = _.vector.fromMaybeNumber( expand,dim );

  _.assert( dim === expand.length );
  _.assert( arguments.length === 2 );

  debugger;
  throw _.err( 'not tested' );

  _.vector.subAssigning( min , expand );
  _.vector.addAssigning( max , expand );

  return box;
}

//
/**
*Returns the array of the first box expanded by the coordinates of the point.
*
* @param { Array } box to be expanded.
* @param { Array } Point of reference with expansion dimensions.
*
* @example
* // returns [ 0, 0, 3, 3 ];
* _.pointExpand( [ 0, 0, 2, 2 ], [ 1, 3 ] );
*
* @example
* // returns [ 0, 0, 2, 2 ];
* _.pointExpand( [ 0, 0, 2, 2 ], [ 1, 2 ] );
*
* @returns { Array } Returns the array of the box expanded.
* @function pointExpand
* @throws { Error } An Error if ( dim ) is different than point.length (the box and the point don´t have the same dimension).
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @memberof wTools.box
*/

function pointExpand( box , point )
{

  if( box === null )
  box = _.box.makeNil();

  var boxv = _.box._from( box );
  var dim = _.box.dimGet( boxv );
  var min = _.box.minGet( boxv );
  var max = _.box.maxGet( boxv );
  var point = _.vector.from( point );

  _.assert( dim === point.length );
  _.assert( arguments.length === 2 );

  _.vector.minVectors( min , point );
  _.vector.maxVectors( max , point );

  return box;
}

//

/**
* Routine checks if a given point is contained inside a box.
*
* @param { Array } box - The box to check if the point is inside.
* @param { Array } point - The point to check.
*
* @example
* // returns true
* _.pointContains( [ 0, 0, 2, 2 ], [ 1, 1 ] );
*
* @example
* // returns false
* _.pointContains( [ 0, 0, 2, 2 ], [ - 1, 3 ] );
*
* @returns { Boolen } Returns true if the point is inside the box, and false if the point is outside it.
* @function pointContains
* @throws { Error } An Error if ( dim ) is different than point.length (Box and point have not the same dimension).
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @memberof wTools.box
*/

function pointContains( box , point )
{

  if( box === null )
  box = _.box.make();

  var boxv = _.box._from( box );
  var dim = _.box.dimGet( boxv );
  var min = _.box.minGet( boxv );
  var max = _.box.maxGet( boxv );
  var point = _.vector.from( point );

  _.assert( dim === point.length );
  _.assert( arguments.length === 2 );

  debugger;
  //throw _.err( 'not tested' );

  if( _.vector.anyLessEqual( point , min ) )
  return false;

  if( _.vector.anyGreaterEqual( point , max ) )
  return false;

  return true;
}

//


/**
* Gives the relative coordinates of a point regarding a given box.
*
* @param { Array } box - The box reference coordinates.
* @param { Array } point - The point to calculate its relative reference.
*
* @example
* // returns [ 0.5, 1 ]
* _.pointRelative( [ 0, 0, 2, 2 ], [ 1, 2 ] );
*
* @example
* // returns [ - 1.5, 2 ]
* _.pointRelative( [ 0, 0, 2, 2 ], [ - 3, 4 ] );
*
* @returns { Array } Returns the relative coordinates of the point against the box coordinates.
* @function pointRelative
* @throws { Error } An Error if ( dim ) is different than point.length (Box and point have not the same dimension).
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @memberof wTools.box
*/

function pointRelative( box , point )
{

  if( box === null )
  box = _.box.make();

  var boxv = _.box._from( box );
  var dim = _.box.dimGet( boxv );
  var min = _.box.minGet( boxv );
  var max = _.box.maxGet( boxv );
  var _point = _.vector.from( point );

  _.assert( dim === point.length );
  _.assert( arguments.length === 2 );

  debugger;
  // throw _.err( 'not tested' );

  _.vector.divAssigning( _.vector.subAssigning( _point , min ) , _.vector.subAssigning( max.clone() , min ) );

  return point
}

//

/**
*Returns an array with the clamped coordinates of a point against a box.
*
* @param { Array } box - The reference box.
* @param { Array } point - The point to be clamped against the box.
*
* @example
* // returns [ 0, 2 ]
* _.pointClamp( [ 0, 0, 2, 2 ], [ 0, 3 ] );
*
* @example
* // returns [ 0, 1 ]
* _.pointClamp( [ 0, 0, 2, 2 ], [ 0, 1 ] );
*
* @returns { Array } Returns an array with the coordinates of the clamped point.
* @function pointClamp
* @throws { Error } An Error if ( dim ) is different than dimGet(box) (the two boxes have not the same dimension).
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @memberof wTools.box
*/

function pointClamp( box , point )
{

  if( box === null )
  box = _.box.make();

  var boxv = _.box._from( box );
  var dim = _.box.dimGet( boxv );
  var min = _.box.minGet( boxv );
  var max = _.box.maxGet( boxv );
  var _point = _.vector.from( point );

  _.assert( dim === point.length );
  _.assert( arguments.length === 2 );

  debugger;
  //  throw _.err( 'not tested' );

  _.vector.clamp( _point, min, max );

  debugger;

  return point;
}

//

/**
*Calulate distance between point and box. Returns distance value. Point and box stay untouched.
*
* @param { Array } box - source box.
* @param { Array } point - source point.
*
* @example
* // returns 1;
* _.pointDistance( [ 0, 0, 2, 2 ], [ 0, 3 ] );
*
* @example
* // returns 0;
* _.pointDistance( [ 0, 0, 2, 2 ], [ 1, 1 ] );
*
* @returns { Number } Returns the distance between the point and the nearest point in the box.
* @function pointDistance
* @throws { Error } An Error if ( dim ) is different than dimGet(box) (the point and the box don´t have the same dimension).
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( box ) is not box
* @throws { Error } An Error if ( point ) is not point
* @memberof wTools.box
*/

function pointDistance( box , point )
{

  if( box === null )
  box = _.box.make();

  _.assert( arguments.length === 2 );

  debugger;
  //  throw _.err( 'not tested' );

  var clamped = _.box.pointClamp( box, point.slice() );

  return _.avector.distance( point,clamped );

  debugger;
}

//

/**
*Check if the source box contains tested box (if a side is touching then it doesn´t contain it).
*Returns true if it is contained, false if not. Box are stored in Array data structure. Source and tested boxes remain unchanged
*
* @param { Array } srcBox - The source box (container).
* @param { Array } tstBox - The tested box (the box to check if it is contained in srcBox).
*
* @example
* // returns true
* _.boxContains( [ 0, 0, 2, 2 ], [ 0.5, 0.5, 1, 1 ] );
*
* @example
* // returns false
* _.boxContains( [ 0, 0, 2, 2 ], [ 0, 0, 1, 2.5 ] );
*
* @returns { Boolean } Returns true if the box is contained and false if not.
* @function boxContains
* @throws { Error } An Error if ( dim ) is different than dimGet(box) (the two boxes have not the same dimension).
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( dstBox ) or ( srcBox ) is not box
* @memberof wTools.box
*/

function boxContains( box , box2 )
{

  var boxv = _.box._from( box2 );
  var dim = _.box.dimGet( boxv );
  var min = _.box.minGet( boxv );
  var max = _.box.maxGet( boxv );

  _.assert( arguments.length === 2 );
  _.assert( dim === _.box.dimGet( box ) );

  debugger;
  // throw _.err( 'not tested' );

  if( !_.box.pointContains( box,min ) )
  return false;

  if( !_.box.pointContains( box,max ) )
  return false;

  return true;
}

//


/**
*Expand destination box by source box. Returns destination box. Box are stored in Array data structure. Source box stays untouched.
*
* @param { Array } dstBox - box to be expanded.
* @param { Array } srcBox - source box with expansion dimensions.
* @throws { Error } An Error if ( dstBox ) or ( srcBox ) is not box
* @memberof wTools.box
*/

/**
*Check if srcBox intersects with tstBox. Returns true if the boxes intersect, false if not (if only side is touching then they don´t intersect).
* Box are stored in Array data structure. Source box and Test box stay untouched.
*
* @param { Array } srcBox - Source box
* @param { Array } tstBox - Test box to check if it intersects
*
* @example
* // returns true
* _.boxIntersects( [ 0, 0, 2, 2 ], [ 1, 1, 3, 3 ] );
*
* @example
* // returns false
* _.boxIntersects( [ 0, 0, 2, 2 ], [ 3, 3, 4, 4 ] );
*
* @returns { Boolean } Returns true if the boxes intersect and false if not.
* @function boxIntersects
* @throws { Error } An Error if ( dim ) is different than dimGet(box) (the two boxes have not the same dimension).
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @memberof wTools.box
*/

function boxIntersects( srcBox , tstBox )
{

  var boxv = _.box._from( tstBox );
  var dim = _.box.dimGet( boxv );
  var min = _.box.minGet( boxv );
  var max = _.box.maxGet( boxv );

  _.assert( arguments.length === 2 );
  _.assert( dim === _.box.dimGet( srcBox ) );

  debugger;
  // throw _.err( 'not tested' );

  if( _.box.pointContains( srcBox,min ) )
  return true;

  if( _.box.pointContains( srcBox,max ) )
  return true;

  return false;
}

//

/**
*Expand destination box by source box. Returns destination box. Box are stored in Array data structure. Source box stays untouched.
*
* @param { Array } dstBox - box to be expanded.
* @param { Array } srcBox - source box with expansion dimensions.
*
* @example
* // returns [ 0, 0, 3, 3 ];
* _.boxExpand( [ 0, 0, 2, 2 ], [ 1, 1, 3, 3 ] );
*
* @example
* // returns [ 0, 0, 2, 2 ];
* _.boxExpand( [ 0, 0, 2, 2 ], [ 1, 1, 2, 2 ] );
*
* @returns { Array } Returns the array of the box expanded.
* @function boxExpand
* @throws { Error } An Error if ( dim ) is different than dimGet(box) (the two boxes have not the same dimension).
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( dstBox ) or ( srcBox ) is not box
* @memberof wTools.box
*/

function boxExpand( dstBox , srcBox )
{

  var _dstBox = _.box._from( dstBox );
  var dim1 = _.box.dimGet( _dstBox );
  var min1 = _.box.minGet( _dstBox );
  var max1 = _.box.maxGet( _dstBox );

  var _srcBox = _.box._from( srcBox );
  var dim2 = _.box.dimGet( _srcBox );
  var min2 = _.box.minGet( _srcBox );
  var max2 = _.box.maxGet( _srcBox );

  _.assert( arguments.length === 2 );
  _.assert( dim1 === dim2 );

  _.vector.minVectors( min1 , min2 );
  _.vector.maxVectors( max1 , max2 );

  return dstBox;
}

//

function matrixHomogenousApply( box , matrix )
{

  var boxv = _.box._from( box );
  var dim = _.box.dimGet( boxv );
  var min = _.box.minGet( boxv );
  var max = _.box.maxGet( boxv );

  _.assert( arguments.length === 2 );
  _.assert( _.spaceIs( matrix ) );
  _.assert( matrix.hasShape([ dim+1,dim+1 ]) );

  var box2 = _.box.nil( dim );

  var point = [];
  var samples = _.dup( [ 0,1 ] , dim );
  _.eachSample( samples,function( sample,i )
  {

    for( var i = 0 ; i < dim ; i++ )
    point[ i ] = sample[ i ] ? max.eGet( i ) : min.eGet( i );
    matrix.matrixHomogenousApply( point );
    _.box.pointExpand( box2,point );

  });

  boxv.copy( box2 );

  return box;
}

//

function translate( box , offset )
{

  this.min.add( offset );
  this.max.add( offset );

  return box;

}

// //
//
// function pointContains( box,point )
// {
//
//   _.assert( arguments.length === 2 );
//   _.assert( _.box.is( box ) );
//   debugger;
//   throw _.err( 'not implemented' );
//
//   var boxv = _.box._from( box );
//   var center = _.box.centerGet( boxv );
//   var radius = _.box.radiusGet( boxv );
//
//   return( vector.distanceSqr( vector.from( point ) , center ) <= ( radius * radius ) );
// }
//
// //
//
// function pointDistance( box,point )
// {
//
//   _.assert( arguments.length === 2 );
//   _.assert( _.box.is( box ) );
//   debugger;
//   throw _.err( 'not implemented' );
//
//   var boxv = _.box._from( box );
//   var center = _.box.centerGet( boxv );
//   var radius = _.box.radiusGet( boxv );
//
//   return( vector.distance( vector.from( point ) , center ) - radius );
// }
//
// //
//
// function pointClamp( box, point )
// {
//
//   _.assert( arguments.length === 2 );
//   _.assert( _.box.is( box ) );
//   debugger;
//   throw _.err( 'not implemented' );
//
//   var pointVector = vector.from( point );
//   var boxv = _.box._from( box );
//   var center = _.box.centerGet( boxv );
//   var radius = _.box.radiusGet( boxv );
//
//   var distanseSqr = vector.distanceSqr( pointVector , center );
//
//   if( distanseSqr > radius * radius )
//   {
//
//     _.vector.subVectors( pointVector,center );
//     _.vector.normalize( pointVector );
//     _.vector.mulScalar( pointVector,radius );
//     _.vector.addVectors( pointVector,center );
//
//   }
//
//   return point;
// }
//
// //
//
// function boxIntersects( box1, box2 )
// {
//
//   _.assert( arguments.length === 2 );
//   _.assert( _.box.is( box1 ) );
//   _.assert( _.box.is( box2 ) );
//   debugger;
//   throw _.err( 'not implemented' );
//
//   var _box1 = _.box._from( box1 );
//   var center1 = _.box.centerGet( _box1 );
//   var radius1 = _.box.radiusGet( _box1 );
//
//   var _box2 = _.box._from( box2 );
//   var center2 = _.box.centerGet( _box2 );
//   var radius2 = _.box.radiusGet( _box2 );
//
//   var r = radius1 + radius2;
//   return _.vector.distanceSqr( center1,center2 ) <= r*r;
// }
//
// //
//
// function matrixHomogenousApply( box,matrix )
// {
//
//   _.assert( arguments.length === 2 );
//   _.assert( _.box.is( box ) );
//   _.assert( _.spaceIs( matrix ) );
//   debugger;
//   throw _.err( 'not implemented' );
//
//   var boxv = _.box._from( box );
//   var center = _.box.centerGet( boxv );
//   var radius = _.box.radiusGet( boxv );
//
//   matrix.matrixHomogenousApply( center );
//   _.box.radiusSet( radius,matrix.scaleMaxGet() )
//
//   return box;
// }
//
// //
//
// function translate( box,offset )
// {
//
//   _.assert( arguments.length === 2 );
//   _.assert( _.box.is( box ) );
//   _.assert( _.spaceIs( matrix ) );
//   debugger;
//   throw _.err( 'not implemented' );
//
//   var boxv = _.box._from( box );
//   var center = _.box.centerGet( boxv );
//   var radius = _.box.radiusGet( boxv );
//
//   center.add( offset );
//
//   return box;
// }

// --
// prototype
// --

var Proto =
{

  make : make,
  makeZero : makeZero,
  makeNil : makeNil,

  zero : zero,
  nil : nil,
  centeredOfSize : centeredOfSize,

  from : from,
  _from : _from,
  fromPoints : fromPoints,
  fromCenterAndSize : fromCenterAndSize,
  fromSphere : fromSphere,
  fromCube : fromCube,

  is : is,
  isEmpty : isEmpty,
  isZero : isZero,
  isNil : isNil,

  dimGet : dimGet,
  minGet : minGet,
  maxGet : maxGet,
  centerGet : centerGet,
  sizeGet : sizeGet,

  expand : expand,

  pointExpand : pointExpand,
  pointContains : pointContains,
  pointRelative : pointRelative,
  pointClamp : pointClamp,
  pointDistance : pointDistance,

  boxContains : boxContains,
  boxIntersects : boxIntersects,
  boxExpand : boxExpand,

  matrixHomogenousApply : matrixHomogenousApply,
  translate : translate,

}

_.mapSupplement( Self,Proto );

//

if( typeof module !== 'undefined' )
{

  require( './Sphere.s' );

}
})();
