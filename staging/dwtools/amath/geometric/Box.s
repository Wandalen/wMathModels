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
    var min = _.box.cornerLeftGet( boxv );
    var max = _.box.cornerRightGet( boxv );

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
  var min = _.box.cornerLeftGet( boxv );
  var max = _.box.cornerRightGet( boxv );

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

  // if( _.objectIs( box ) )
  // {
  //    _.assertMapHasFields( box,{ min : 'min' , max : 'max' } );
  //   debugger;
  //   box = _.arrayAppendArrays( [],[ box.min,box.max ] );
  // }
  //
  // if( box === null || box === undefined )
  // box = this.make();

  _.assert( _.box.is( box ) || box === null );
  _.assert( arguments.length === 1, 'expects single argument' );

  if( box === null )
  return _.box.make();

  // if( _.vectorIs( box ) )
  // {
  //   debugger;
  //   throw _.err( 'not implemented' );
  //   return box.slice();
  // }

  return box;
}

//

function _from( box )
{
  _.assert( _.box.is( box ) );
  _.assert( arguments.length === 1, 'expects single argument' );
  return _.vector.from( box );
}

//


/**
  *Create or expand box from an array of points. Returns the expanded box. Box are stored in Array data structure.
  * Points stay untouched, box changes.
  *
  * @param { Array } box - box to be expanded.
  * @param { Array } points - Array of points of reference with expansion dimensions.
  *
  * @example
  * // returns [ 0, 0, 3, 3 ];
  * _.fromPoints( null , [ [ 1, 3 ], [ 0, 0 ], [ 3, 1 ] ] );
  *
  * @example
  * // returns [ 0, - 1, 2, 2 ];
  * _.fromPoints( [ 0, 0, 1, 1 ], [ [ 1, 2 ], [ 0, 0 ], [ 2, - 1 ] ] );
  *
  * @returns { Array } Returns the array of the box expanded.
  * @function fromPoints
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( point ) is not array.
  * @memberof wTools.box
  */

function fromPoints( box , points )
{

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.arrayIs( points ) );

  var dimp = points[0].length;

  if( box === null )
  box = _.box.makeNil( dimp );

  var boxv = _.box._from( box );
  var min = _.box.cornerLeftGet( boxv );
  var max = _.box.cornerRightGet( boxv );

  debugger;
  // throw _.err( 'not tested' );

  for( var i = 0 ; i < points.length ; i += 1 )
  {
    _.box.pointExpand( boxv, points[ i ] );
  }

  return box;

}

//

/**
  * Create or expand box from center point and size dimensions. Returns the expanded box.
  * Box are stored in Array data structure. Center point and size stay untouched, box changes.
  *
  * @param { Array } box - box to be expanded.
  * @param { Array } center - Point of reference with center coordinates.
  * @param { Array } size - Array of reference with size dimensions.
  *
  * @example
  * // returns [ - 1, - 1, 3, 3 ];
  * _.fromCenterAndSize( [ 0, 0, 1, 1 ], [ 1, 1 ], [ 4, 4 ] );
  *
  * @example
  * // returns [ 0, 0, 2, 2 ];
  * _.fromCenterAndSize( [ 0, 0, 1, 1 ], [ 1, 1 ], [ 2, 2 ] );
  *
  * @returns { Array } Returns the array of the box expanded.
  * @function fromCenterAndSize
  * @throws { Error } An Error if ( arguments.length ) is different than three.
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( center ) is not point.
  * @throws { Error } An Error if ( size ) is not array.
  * @memberof wTools.box
  */

function fromCenterAndSize( box , center , size )
{

  if( box === null )
  box = _.box.make( center.length );

  var boxv = _.box._from( box );
  var min = _.box.cornerLeftGet( boxv );
  var max = _.box.cornerRightGet( boxv );
  var dim = _.box.dimGet( boxv );
  var center = _.vector.from( center );
  var size = _.vector.from( size );

  _.assert( dim === center.length );
  _.assert( dim === size.length );
  _.assert( arguments.length === 3, 'expects exactly three argument' );

  debugger;
  //throw _.err( 'not tested' );

  var size = _.vector.mulScalar( size.clone() , 0.5 );
  _.vector.subAssigning( min.copy( center ) , size );
  _.vector.addAssigning( max.copy( center ) , size );

  return box;
}

//

/**
  * Create or expand box from sphere. Returns the expanded box.
  * Box are stored in Array data structure. Sphere stays untouched, box changes.
  * First, the box is expanded until it contains the center of the sphere.
  * Then, the box is expanded by the radius of the sphere.
  *
  * @param { Array } box - box to be expanded.
  * @param { Array } sphere - sphere of reference with expansion dimensions.
  *
  * @example
  * // returns [ - 1, - 1, 2, 2 ];
  * _.fromSphere( [ 0, 0, 1, 1 ], [ 1, 1, 1 ] );
  *
  * @example
  * // returns [ - 2, - 2, 3, 3 ];
  * _.fromSphere( [ 0, 0, 1, 1 ], [ 1, 1, 2 ] );
  *
  * @returns { Array } Returns the array of the expanded box.
  * @function fromSphere
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @memberof wTools.box
  */

function fromSphere( box , sphere )
{

  var _sphere = _.sphere._from( sphere );
  var dim1 = _.sphere.dimGet( _sphere );
  var center = _.sphere.centerGet( _sphere );
  var radius = _.sphere.radiusGet( _sphere );

  if( box === null )
  box = _.box.make( dim );

  var boxv = _.box._from( box );
  var min = _.box.cornerLeftGet( boxv );
  var max = _.box.cornerRightGet( boxv );
  var dim2 = _.box.dimGet( boxv );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( dim1 === dim2 );

  debugger;
  //throw _.err( 'not tested' );


  _.box.fromPoints( boxv, [ center ] );
  _.box.expand( boxv, radius );

  return box;
}

//

/**
  * Create a cube from cube size centered in origin. Returns the box converted in cube.
  * Box are stored in Array data structure. Cube size stay untouched, box changes.
  *
  * @param { Array } box - box to be converted to cube.
  * @param { Number } size - Cube size.
  *
  * @example
  * // returns [ - 2, - 2, 2, 2 ];
  * _.fromCube( [ 0, 0, 1, 1 ], [ 4, 4 ] );
  *
  * @example
  * // returns [ - 1, - 1, 1, 1 ];
  * _.fromCube( [ 3, 3, 5, 5 ], [ 2, 2 ] );
  *
  * @returns { Array } Returns the array of the new cube.
  * @function fromCube
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( size ) is not a number.
  * @memberof wTools.box
  */

function fromCube( box , size )
{

  if( box === null )
  box = _.box.make();

  var boxv = _.box._from( box );
  var min = _.box.cornerLeftGet( boxv );
  var max = _.box.cornerRightGet( boxv );
  var dim = _.box.dimGet( boxv );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.numberIs( size ) );

  _.vector.assignScalar( min,-size/2 );
  _.vector.assignScalar( max,+size/2 );

  return box;
}

//

function is( box )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  // _.assert( !box.some( isNaN ) );
  return ( _.arrayLike( box ) || _.vectorIs( box ) ) && ( box.length >= 0 ) && ( box.length % 2 === 0 );
}

//

function isEmpty( box )
{

  _.assert( arguments.length === 1, 'expects single argument' );

  var boxv = _.box._from( box );
  var dim = _.box.dimGet( boxv );
  var min = _.box.cornerLeftGet( boxv );
  var max = _.box.cornerRightGet( boxv );

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

  _.assert( arguments.length === 1, 'expects single argument' );

  var boxv = _.box._from( box );
  var dim = _.box.dimGet( boxv );
  var min = _.box.cornerLeftGet( boxv );
  var max = _.box.cornerRightGet( boxv );

  for( var d = 0 ; d < dim ; d++ )
  if( min.eGet( d ) !== max.eGet( d ) )
  return false;

  return true;
}

//

function isNil( box )
{

  _.assert( arguments.length === 1, 'expects single argument' );

  var boxv = _.box._from( box );
  var dim = _.box.dimGet( boxv );
  var min = _.box.cornerLeftGet( boxv );
  var max = _.box.cornerRightGet( boxv );

  for( var d = 0 ; d < dim ; d++ )
  if( min.eGet( d ) > max.eGet( d ) )
  return true;

  return false;
}

//

/**
  * Get box dimension. Returns the dimension of the box. Box stays untouched.
  *
  * @param { Array } box - The source box.
  *
  * @example
  * // returns 2
  * _.dimGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns 1
  * _.dimGet( [ 0, 1 ] );
  *
  * @returns { Number } Returns the dimension of the box.
  * @function dimGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( box ) is not box.
  * @memberof wTools.box
  */

function dimGet( box )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( _.box.is( box ) );
  return box.length / 2;
}

//

/**
  * Get the coordinates of the left corner of a box.
  * Returns a vector with the coordinates of the left corner of the box definition. Box stays untouched.
  *
  * @param { Array } box - The source box.
  *
  * @example
  * // returns  0
  * _.cornerLeftGet( [ 0, 2 ] );
  *
  * @example
  * // returns  0, 1
  * _.cornerLeftGet( [ 0, 1, 2, 3 ] );
  *
  * @returns { Vector } Returns a vector with the left corner of the box.
  * @function cornerLeftGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( box ) is not box.
  * @memberof wTools.box
  */

function cornerLeftGet( box )
{
  var boxv = _.box._from( box );
  _.assert( arguments.length === 1, 'expects single argument' );
  return boxv.subarray( 0 , box.length / 2 );
}

//

/**
  * Get the coordinates of the right corner of a box.
  * Returns a vector with the coordinates of the right corner of the box definition. Box stays untouched.
  *
  * @param { Array } box - The source box.
  *
  * @example
  * // returns [ 2 ]
  * _.cornerRightGet( [ 0, 2 ] );
  *
  * @example
  * // returns [ 2, 3 ]
  * _.cornerRightGet( [ 0, 1, 2, 3 ] );
  *
  * @returns { Array } Returns a sub-array with the maximun coordinates of the box.
  * @function cornerRightGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( box ) is not box.
  * @memberof wTools.box
  */

function cornerRightGet( box )
{
  var boxv = _.box._from( box );
  _.assert( arguments.length === 1, 'expects single argument' );
  return boxv.subarray( box.length / 2 , box.length );
}

//

/**
  * Get the center of a box. Returns the center of the box. Box stays untouched.
  *
  * @param { Array } box - The source box.
  * @param { Array } dst - The destination array (optional - sets the type of the returned object).
  *
  * @example
  * // returns [ 0, 1 ]
  * _.centerGet( [ 0, 0, 2, 2 ] , [ 5, 0 ]);
  *
  * @example
  * // returns [ 0.5 ]
  * _.centerGet( [ 0, 1 ] );
  *
  * @returns { Array } Returns the coordinates of the center of the box.
  * @function centerGet
  * @throws { Error } An Error if ( arguments.length ) is different than one or two.
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( dst ) is not point.
  * @memberof wTools.box
  */

function centerGet( box , dst )
{

  var boxv = _.box._from( box );
  var dim = _.box.dimGet( boxv );
  var min = _.box.cornerLeftGet( boxv );
  var max = _.box.cornerRightGet( boxv );

  if( !dst )
  dst = _.dup( 0,dim ) ;
  debugger;
  var dstv = _.vector.from( dst );

  _.assert( dim === dst.length );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  debugger;
  // throw _.err( 'not tested' );

  _.vector.addAssigning( dstv.copy( min ), max ).mulScalar( 0.5 );

  debugger;
  return dst;
}

//

/**
  * Get the size of a box. Returns an array with the length of each side the box.
  * Box stays untouched.
  *
  * @param { Array } box - The source box.
  * @param { Array } dst - The destination array (optional - sets the type of the returned object).
  *
  * @example
  * // returns [ 2, 2 ]
  * _.sizeGet( [ 0, 0, 2, 2 ] , [ 5, 0 ]);
  *
  * @example
  * // returns [ 1 ]
  * _.sizeGet( [ 0, 1 ] );
  *
  * @returns { Array } Returns the lenght of each side of the box.
  * @function sizeGet
  * @throws { Error } An Error if ( arguments.length ) is different than one or two.
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( point ) is not point.
  * @memberof wTools.box
  */

function sizeGet( box , dst )
{

  var boxv = _.box._from( box );
  var dim = _.box.dimGet( boxv );
  var min = _.box.cornerLeftGet( boxv );
  var max = _.box.cornerRightGet( boxv );

  if( !dst )
  dst = _.dup( 0,dim );
  var dstv = _.vector.from( dst );

  _.assert( dim === dst.length );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  _.vector.subVectors( dstv.copy( max ), min );

  return dst;
}

//

/**
  * Expand all sides of a box by the dimensions in the expansion array.
  * Returns the expanded box. Box are stored in Array data structure.
  * The expansion array stays untouched, the box changes.
  *
  * @param { Array } box - box to be expanded.
  * @param { Array } expand - Array of reference with expansion dimensions.
  *
  * @example
  * // returns [ - 1, - 3, 4, 6 ];
  * _.expand( [ 0, 0, 2, 2 ], [ 1, 3 ] );
  *
  * @example
  * // returns [ - 1, - 2, 2, 4 ];
  * _.expand( [ 0, 0, 2, 2 ], [ 1, 2 ] );
  *
  * @returns { Array } Returns the array of the box expanded.
  * @function expand
  * @throws { Error } An Error if ( dim ) is different than expand.length (the box and the expansion array don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( expand ) is not an array.
  * @memberof wTools.box
  */

function expand( box , expand )
{

  if( box === null )
  box = _.box.make();

  var boxv = _.box._from( box );
  var dim = _.box.dimGet( boxv );
  var min = _.box.cornerLeftGet( boxv );
  var max = _.box.cornerRightGet( boxv );
  var expand = _.vector.fromMaybeNumber( expand,dim );

  _.assert( dim === expand.length );
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  debugger;
  //throw _.err( 'not tested' );

  _.vector.subAssigning( min , expand );
  _.vector.addAssigning( max , expand );

  return box;
}

//

/**
  *Expand box by point. Returns the expanded box. Box are stored in Array data structure. Point stays untouched, dstBox changes.
  *
  * @param { Array } dstBox - box to be expanded.
  * @param { Array } point - Point of reference with expansion dimensions.
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
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( point ) is not point.
  * @memberof wTools.box
  */

function pointExpand( dstBox , point )
{

  if( dstBox === null )
  dstBox = _.box.makeNil();

  var boxv = _.box._from( dstBox );
  var dim = _.box.dimGet( boxv );
  var min = _.box.cornerLeftGet( boxv );
  var max = _.box.cornerRightGet( boxv );
  var point = _.vector.from( point );

  _.assert( dim === point.length );
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  _.vector.minVectors( min , point );
  _.vector.maxVectors( max , point );

  return dstBox;
}

//

/**
  * Check if a given point is contained inside a box. Returs true if it is contained, false if not. Point and box stay untouched.
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
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( point ) is not point.
  * @memberof wTools.box
  */

function pointContains( box , point )
{

  if( box === null )
  box = _.box.make();

  var boxv = _.box._from( box );
  var dim = _.box.dimGet( boxv );
  var min = _.box.cornerLeftGet( boxv );
  var max = _.box.cornerRightGet( boxv );
  var point = _.vector.from( point );

  _.assert( dim === point.length );
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  if( _.vector.anyLess( point , min ) )
  return false;

  if( _.vector.anyGreater( point , max ) )
  return false;

  return true;
}

//

/**
  * Get the relative coordinates of a point regarding a given box. Returns the point in relative coordinates.
  * Source box remains untouched.
  *
  * @param { Array } box - Source box.
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
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( point ) is not point.
  * @memberof wTools.box
  */

function pointRelative( box , point )
{

  if( box === null )
  box = _.box.make();

  var boxv = _.box._from( box );
  var dim = _.box.dimGet( boxv );
  var min = _.box.cornerLeftGet( boxv );
  var max = _.box.cornerRightGet( boxv );
  var _point = _.vector.from( point );

  _.assert( dim === point.length );
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  debugger;
  // throw _.err( 'not tested' );

  _.vector.divAssigning( _.vector.subAssigning( _point , min ) , _.vector.subAssigning( max.clone() , min ) );

  return point
}

/**
  * Clamp a point to a box. Returns the clamped point. Box stays untouched, point gets clamped.
  *
  * @param { Array } box - The source box.
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
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( point ) is not point.
  * @memberof wTools.box
  */

function pointClamp( box , point )
{

  if( box === null )
  box = _.box.make();

  var boxv = _.box._from( box );
  var dim = _.box.dimGet( boxv );
  var min = _.box.cornerLeftGet( boxv );
  var max = _.box.cornerRightGet( boxv );
  var _point = _.vector.from( point );

  _.assert( dim === point.length );
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  debugger;
  //  throw _.err( 'not tested' );

  _.vector.clamp( _point, min, max );

  debugger;

  return point;
}

//

/**
  *Calulate distance between point and box ( distance between point and nearest point in box ). Returns distance value.
  * Point and box stay untouched.
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

  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  debugger;
  //  throw _.err( 'not tested' );

  var clamped = _.box.pointClamp( box, point.slice() );

  return _.avector.distance( point, clamped );

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
  var min = _.box.cornerLeftGet( boxv );
  var max = _.box.cornerRightGet( boxv );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( dim === _.box.dimGet( box ) );

  if( !_.box.pointContains( box,min ) )
  return false;

  if( !_.box.pointContains( box,max ) )
  return false;

  return true;
}

//

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
  var min = _.box.cornerLeftGet( boxv );
  var max = _.box.cornerRightGet( boxv );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
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
  * @returns { Array } Returns the array of the expanded box, that contains new element ( src box ).
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
  var min1 = _.box.cornerLeftGet( _dstBox );
  var max1 = _.box.cornerRightGet( _dstBox );

  var _srcBox = _.box._from( srcBox );
  var dim2 = _.box.dimGet( _srcBox );
  var min2 = _.box.cornerLeftGet( _srcBox );
  var max2 = _.box.cornerRightGet( _srcBox );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
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
  var min = _.box.cornerLeftGet( boxv );
  var max = _.box.cornerRightGet( boxv );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
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
//   _.assert( arguments.length === 2, 'expects exactly two arguments' );
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
//   _.assert( arguments.length === 2, 'expects exactly two arguments' );
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
//   _.assert( arguments.length === 2, 'expects exactly two arguments' );
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
//   _.assert( arguments.length === 2, 'expects exactly two arguments' );
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
//   _.assert( arguments.length === 2, 'expects exactly two arguments' );
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
//   _.assert( arguments.length === 2, 'expects exactly two arguments' );
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
// define class
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
  cornerLeftGet : cornerLeftGet,
  cornerRightGet : cornerRightGet,
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
