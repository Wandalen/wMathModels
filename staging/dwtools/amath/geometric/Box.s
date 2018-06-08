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

function pointDistance( box , point )
{

  if( box === null )
  box = _.box.make();

  _.assert( arguments.length === 2 );

  debugger;
  //  throw _.err( 'not tested' );

  var clamped = _.box.pointClamp( box , point );

  return _.avector.distance( point,clamped );
}

//

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

function boxIntersects( box , box2 )
{

  var boxv = _.box._from( box2 );
  var dim = _.box.dimGet( boxv );
  var min = _.box.minGet( boxv );
  var max = _.box.maxGet( boxv );

  _.assert( arguments.length === 2 );
  _.assert( dim === _.box.dimGet( box ) );

  debugger;
  // throw _.err( 'not tested' );

  if( _.box.pointContains( box,min ) )
  return true;

  if( _.box.pointContains( box,max ) )
  return true;

  return false;
}

//

function boxExpand( box , box2 )
{

  var _box1 = _.box._from( box );
  var dim1 = _.box.dimGet( _box1 );
  var min1 = _.box.minGet( _box1 );
  var max1 = _.box.maxGet( _box1 );

  var _box2 = _.box._from( box2 );
  var dim2 = _.box.dimGet( _box2 );
  var min2 = _.box.minGet( _box2 );
  var max2 = _.box.maxGet( _box2 );

  _.assert( arguments.length === 2 );
  _.assert( dim1 === dim2 );

  _.vector.minVectors( min1 , min2 );
  _.vector.maxVectors( max1 , max2 );

  return box;
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
