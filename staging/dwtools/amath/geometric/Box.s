(function _Box_s_(){

'use strict';

let _ = _global_.wTools;
let avector = _.avector;
let vector = _.vector;
let Self = _.box = _.box || Object.create( null );

/*
qqq : make sure all routines in all files of such kind in order

  *Contains : *Contains,
  *Intersects : *Intersects,
  *Distance : *Distance,
  *ClosestPoint : *ClosestPoint,
  *Expand : *Expand,

- *Distance returns 0 if intersection
- _.*.*ClosestPoint does not accept undefines or null
- _.*.pointClosestPoint writes result into 2-nd argument
- other _.*.*ClosestPoint makes new Array for result
- no need in _.frustum.*Expand
- no need in _.*.pointIntersects

*/

// --
//
// --

//

/**
  *Create a box of dimension dim. Returns the created box. Box is stored in Array data structure.
  * Dim remains unchanged.
  *
  * @param { Number } dim - Dimension of the created box.
  *
  * @example
  * // returns [ 0, 0, 0, 0, 0, 0 ];
  * _.make( 3 );
  *
  * @example
  * // returns [ 0, 0, 1, 1 ];
  * _.make( [ 0, 0, 1, 1 ] );
  *
  * @returns { Array } Returns the array of the created box.
  * @function make
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @memberof wTools.box
  */
function make( dim )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = _.box.makeZero( dim );
  if( _.box.is( dim ) )
  _.avector.assign( result, dim );
  return result;
}

//

/**
  *Create a box of zeros of dimension dim. Returns the created box. Box is stored in Array data structure.
  * Dim remains unchanged.
  *
  * @param { Number } dim - Dimension of the created box.
  *
  * @example
  * // returns [ 0, 0, 0, 0, 0, 0 ];
  * _.makeZero( 3 );
  *
  * @example
  * // returns [ 0, 0, 0, 0 ];
  * _.makeZero( [ 1, 1, 2, 2] );
  *
  * @function makeZero
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @memberof wTools.box
  */
function makeZero( dim )
{
  if( _.box.is( dim ) )
  dim = _.box.dimGet( dim );
  if( dim === undefined || dim === null )
  dim = 3;
  _.assert( dim >= 0 );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = _.dup( 0, dim*2 );
  return result;
}

//

/**
  *Create a nil box of dimension dim. Returns the created box. Box is stored in Array data structure.
  * Dim remains unchanged.
  *
  * @param { Number } dim - Dimension of the created box.
  *
  * @example
  * // returns [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity ];
  * _.makeNil( 3 );
  *
  * @example
  * // returns [ Infinity, Infinity, - Infinity, - Infinity ];
  * _.makeNil( [ 1, 1, 2, 2] );
  *
  * @function makeNil
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @memberof wTools.box
  */
function makeNil( dim )
{
  if( _.box.is( dim ) )
  dim = _.box.dimGet( dim );
  if( dim === undefined || dim === null )
  dim = 3;

  let result = [];
  for( let i = 0 ; i < dim ; i++ )
  result[ i ] = +Infinity;
  for( let i = 0 ; i < dim ; i++ )
  result[ dim + i ] = -Infinity;

  return result;
}

//

/**
  *Transform a box in a box of zeros. Returns the created box. Box is stored in Array data structure.
  *
  * @param { Array } box - Destination box.
  *
  * @example
  * // returns [ 0, 0, 0, 0 ];
  * _.zero( [ 1, 1, 2, 2] );
  *
  * @example
  * // returns [ 0, 0, 0, 0, 0, 0 ];
  * _.zero( 3 );
  *
  * @function zero
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @memberof wTools.box
  */
function zero( box )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( _.box.is( box ) )
  {
    let boxVector = _.box._from( box );
    boxVector.assign( 0 );
    return box;
  }

  return _.box.makeZero( box );
}

//

/**
  *Transform a box in a nil box. Returns the created box. Box is stored in Array data structure.
  *
  * @param { Array } box - Destination box.
  *
  * @example
  * // returns [ Infinity, Infinity, - Infinity, - Infinity ];
  * _.nil( [ 1, 1, 2, 2] );
  *
  * @example
  * // returns [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity ];
  * _.nil( 3 );
  *
  * @function nil
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @memberof wTools.box
  */
function nil( box )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( _.box.is( box ) )
  {
    let boxVector = _.box._from( box );
    let min = _.box.cornerLeftGet( boxVector );
    let max = _.box.cornerRightGet( boxVector );

    _.vector.assign( min, +Infinity );
    _.vector.assign( max, -Infinity );

    return box;
  }

  return _.box.makeNil( box );
}

//

/**
  *Transform a box in a box centered in the origin of a given size. Returns the created box.
  * Box is stored in Array data structure.
  *
  * @param { Array } box - Destination box.
  * @param { Number } size - Source size.
  *
  * @example
  * // returns [ -0.5, -0.5, 0.5, 0.5 ];
  * _.centeredOfSize( [ 1, 1, 2, 2] );
  *
  * @example
  * // returns [ - 1.5, -1.5, -1.5, 1.5, 1.5, 1.5 ];
  * _.centeredOfSize( 3 );
  *
  * @example
  * // returns [ - 1.5, -1.5, 1.5, 1.5 ];
  * _.centeredOfSize( [ 1, 1, 2, 2], 3 );
  *
  * @returns { Array } Returns the created box.
  * @function centeredOfSize
  * @throws { Error } An Error if ( arguments.length ) is different than one or two.
  * @memberof wTools.box
  */
function centeredOfSize( box, size )
{

  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( size === undefined )
  size = 1;

  if( !_.box.is( box ) )
  box = _.box.make( box );

  let boxVector = _.box._from( box );
  let min = _.box.cornerLeftGet( boxVector );
  let max = _.box.cornerRightGet( boxVector );

  size = _.numbersSlice( size );
  size = _.avector.mulScalar( size, 0.5 );
  _.vector.assign( max, size );
  size = _.avector.mulScalar( size, -1 );
  _.vector.assign( min, size );

  return box;
}

//

/**
  *Create or return a box. Returns the created box.
  *
  * @param { Array } box - Destination box.
  *
  * @example
  * // returns [ 1, 1, 2, 2 ];
  * _.from( [ 1, 1, 2, 2 ] );
  *
  * @example
  * // returns _.vector.from( [ 1, 1, 2, 2 ] );
  * _.from( _.vector.from( [ 1, 1, 2, 2 ] ) );
  *
  * @function from
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @memberof wTools.box
  */
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

/**
  *Create or return a box vector. Returns the created box.
  *
  * @param { Array } box - Destination box.
  *
  * @example
  * // returns _.vector.from( [ 1, 1, 2, 2 ] );
  * _._from( [ 1, 1, 2, 2 ] );
  *
  * @returns { Vector } Returns the vector of the box.
  * @function _from
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @memberof wTools.box
  */
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

function fromPoints( box, points )
{

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.arrayIs( points ) );

  let dimp = points[0].length;

  if( box === null )
  box = _.box.makeNil( dimp );

  let boxVector = _.box._from( box );
  let min = _.box.cornerLeftGet( boxVector );
  let max = _.box.cornerRightGet( boxVector );

  debugger;
  // throw _.err( 'not tested' );

  for( let i = 0 ; i < points.length ; i += 1 )
  {
    _.box.pointExpand( boxVector, points[ i ] );
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

  let boxVector = _.box._from( box );
  let min = _.box.cornerLeftGet( boxVector );
  let max = _.box.cornerRightGet( boxVector );
  let dim = _.box.dimGet( boxVector );
  let center_ = _.vector.from( center );
  let size_ = _.vector.from( size );

  _.assert( dim === center_.length );
  _.assert( dim === size_.length );
  _.assert( arguments.length === 3, 'expects exactly three argument' );

  debugger;
  //throw _.err( 'not tested' );

  size_ = _.vector.mulScalar( size_.clone() , 0.5 );
  _.vector.subAssigning( min.copy( center_ ) , size_ );
  _.vector.addAssigning( max.copy( center_ ) , size_ );

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

  let _sphere = _.sphere._from( sphere );
  let dim1 = _.sphere.dimGet( _sphere );
  let center = _.sphere.centerGet( _sphere );
  let radius = _.sphere.radiusGet( _sphere );

  if( box === null )
  box = _.box.make( dim );

  let boxVector = _.box._from( box );
  let min = _.box.cornerLeftGet( boxVector );
  let max = _.box.cornerRightGet( boxVector );
  let dim2 = _.box.dimGet( boxVector );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( dim1 === dim2 );

  debugger;
  //throw _.err( 'not tested' );

  _.box.fromPoints( boxVector, [ center ] );
  _.box.expand( boxVector, radius );

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

  let boxVector = _.box._from( box );
  let min = _.box.cornerLeftGet( boxVector );
  let max = _.box.cornerRightGet( boxVector );
  let dim = _.box.dimGet( boxVector );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.numberIs( size ) );

  _.vector.assignScalar( min,-size/2 );
  _.vector.assignScalar( max,+size/2 );

  return box;
}

//

/**
  * Check if input is a box. Returns true if it is a box and false if not.
  *
  * @param { Array } box - Source box.
  *
  * @example
  * // returns true;
  * _.is( [ 0, 0, 1, 1 ] );
  *
  * @returns { Boolean } Returns true if the input is box.
  * @function is
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @memberof wTools.box
  */

function is( box )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  // _.assert( !box.some( isNaN ) );
  return ( _.longIs( box ) || _.vectorIs( box ) ) && ( box.length >= 0 ) && ( box.length % 2 === 0 );
}

//

/**
  * Check if input box is empty. Returns true if it is empty and false if not.
  *
  * @param { Array } box - Source box.
  *
  * @example
  * // returns true;
  * _.isEmpty( [ 1, 1, 0, 0 ] );
  *
  * @returns { Boolean } Returns true if the input is an empty box.
  * @function isEmpty
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @memberof wTools.box
  */

function isEmpty( box )
{

  _.assert( arguments.length === 1, 'expects single argument' );

  let boxVector = _.box._from( box );
  let dim = _.box.dimGet( boxVector );
  let min = _.box.cornerLeftGet( boxVector );
  let max = _.box.cornerRightGet( boxVector );

  for( let d = 0 ; d < dim ; d++ )
  if( min.eGet( d ) >= max.eGet( d ) )
  return true;

  if( dim === 0 )
  return true;

  return false;
}

//

/**
  * Check if input is a zero box. Returns true if it is a zero box and false if not.
  *
  * @param { Array } box - Source box.
  *
  * @example
  * // returns true;
  * _.isZero( [ 1, 1, 1, 1 ] );
  *
  * @returns { Boolean } Returns true if the input is a zero box.
  * @function isZero
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @memberof wTools.box
  */

function isZero( box )
{

  _.assert( arguments.length === 1, 'expects single argument' );

  let boxVector = _.box._from( box );
  let dim = _.box.dimGet( boxVector );
  let min = _.box.cornerLeftGet( boxVector );
  let max = _.box.cornerRightGet( boxVector );

  for( let d = 0 ; d < dim ; d++ )
  if( min.eGet( d ) !== max.eGet( d ) )
  return false;

  return true;
}

//

/**
  * Check if input is a nil box. Returns true if it is a nil box and false if not.
  *
  * @param { Array } box - Source box.
  *
  * @example
  * // returns true;
  * _.isNil( [ 2, 2, 1, 1 ] );
  *
  * @returns { Boolean } Returns true if the input is a nil box.
  * @function isNil
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @memberof wTools.box
  */

function isNil( box )
{

  _.assert( arguments.length === 1, 'expects single argument' );

  let boxVector = _.box._from( box );
  let dim = _.box.dimGet( boxVector );
  let min = _.box.cornerLeftGet( boxVector );
  let max = _.box.cornerRightGet( boxVector );

  for( let d = 0 ; d < dim ; d++ )
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
  * // returns  [ 0, 1 ]
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
  let boxVector = _.box._from( box );
  _.assert( arguments.length === 1, 'expects single argument' );
  return boxVector.subarray( 0 , box.length / 2 );
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
  let boxVector = _.box._from( box );
  _.assert( arguments.length === 1, 'expects single argument' );
  return boxVector.subarray( box.length / 2 , box.length );
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

  let boxVector = _.box._from( box );
  let dim = _.box.dimGet( boxVector );
  let min = _.box.cornerLeftGet( boxVector );
  let max = _.box.cornerRightGet( boxVector );

  if( !dst )
  dst = _.dup( 0,dim ) ;
  debugger;
  let dstv = _.vector.from( dst );

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

  let boxVector = _.box._from( box );
  let dim = _.box.dimGet( boxVector );
  let min = _.box.cornerLeftGet( boxVector );
  let max = _.box.cornerRightGet( boxVector );

  if( !dst )
  dst = _.dup( 0,dim );
  let dstv = _.vector.from( dst );

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

  let boxVector = _.box._from( box );
  let dim = _.box.dimGet( boxVector );
  let min = _.box.cornerLeftGet( boxVector );
  let max = _.box.cornerRightGet( boxVector );
  expand = _.vector.fromMaybeNumber( expand,dim );

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

  let boxVector = _.box._from( box );
  let dim = _.box.dimGet( boxVector );
  let min = _.box.cornerLeftGet( boxVector );
  let max = _.box.cornerRightGet( boxVector );
  let pointv = _.vector.from( point );

  _.assert( dim === pointv.length );
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  if( _.vector.anyLess( pointv , min ) )
  return false;

  if( _.vector.anyGreater( pointv , max ) )
  return false;

  return true;
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

  let clamped = _.box.pointClosestPoint( box, point.slice() );

  return _.avector.distance( point, clamped );

  debugger;
}

//

/**
  * Clamp a point to a box. Returns the clamped point. Box and point stay unchanged.
  *
  * @param { Array } box - The source box.
  * @param { Array } point - The point to be clamped against the box.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns [ 0, 2 ]
  * _.pointClosestPoint( [ 0, 0, 2, 2 ], [ 0, 3 ] );
  *
  * @example
  * // returns [ 0, 1 ]
  * _.pointClosestPoint( [ 0, 0, 2, 2 ], [ 0, 1 ] );
  *
  * @returns { Array } Returns an array with the coordinates of the clamped point.
  * @function pointClosestPoint
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the box and the point don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( point ) is not point.
  * @throws { Error } An Error if ( dstPoint ) is not dstPoint.
  * @memberof wTools.box
  */

/* qqq : not 3 */

function pointClosestPoint( box , point, dstPoint )
{

  if( box === null )
  box = _.box.make();

  _.assert( arguments.length === 2 || arguments.length === 3 , 'expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = point.slice();

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let boxVector = _.box._from( box );
  let dim = _.box.dimGet( boxVector );
  let min = _.box.cornerLeftGet( boxVector );
  let max = _.box.cornerRightGet( boxVector );
  let pointVector = _.vector.from( point.slice() );
  let dstPointVector = _.vector.from( dstPoint );

  _.assert( dim === point.length );


  debugger;
  //  throw _.err( 'not tested' );
  let v = _.vector.clamp( pointVector, min, max );

  for( let i = 0; i < pointVector.length; i++ )
  {
    dstPointVector.eSet( i, v.eGet( i ) );
    debugger;
  }

  return dstPoint;
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

  let boxVector = _.box._from( dstBox );
  let dim = _.box.dimGet( boxVector );
  let min = _.box.cornerLeftGet( boxVector );
  let max = _.box.cornerRightGet( boxVector );
  let pointv = _.vector.from( point );

  _.assert( dim === pointv.length );
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  _.vector.minVectors( min , pointv );
  _.vector.maxVectors( max , pointv );

  return dstBox;
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

  let boxVector = _.box._from( box );
  let dim = _.box.dimGet( boxVector );
  let min = _.box.cornerLeftGet( boxVector );
  let max = _.box.cornerRightGet( boxVector );
  let pointVector = _.vector.from( point );

  _.assert( dim === point.length );
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  debugger;
  // throw _.err( 'not tested' );

  _.vector.divAssigning( _.vector.subAssigning( pointVector , min ) , _.vector.subAssigning( max.clone() , min ) );

  return point;
}

//

/**
  *Check if the source box contains tested box.
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
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the two boxes don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstBox ) or ( srcBox ) is not box
  * @memberof wTools.box
  */

function boxContains( box , box2 )
{

  let boxVector = _.box._from( box2 );
  let dim = _.box.dimGet( boxVector );
  let min = _.box.cornerLeftGet( boxVector );
  let max = _.box.cornerRightGet( boxVector );

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
  *Check if srcBox intersects with tstBox. Returns true if the boxes intersect, false if not.
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
  let srcBoxVector = _.box._from( srcBox );
  let srcDim = _.box.dimGet( srcBoxVector );
  let srcMin = _.box.cornerLeftGet( srcBoxVector );
  let srcMax = _.box.cornerRightGet( srcBoxVector );

  let tstBoxVector = _.box._from( tstBox );
  let tstDim = _.box.dimGet( tstBoxVector );
  let tstMin = _.box.cornerLeftGet( tstBoxVector );
  let tstMax = _.box.cornerRightGet( tstBoxVector );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( tstDim === srcDim );

  debugger;
  // throw _.err( 'not tested' );

  srcMin = _.vector.toArray( srcMin );
  srcMax = _.vector.toArray( srcMax );
  tstMin = _.vector.toArray( tstMin );
  tstMax = _.vector.toArray( tstMax );

  let interX = false;
  if( srcMin[ 0 ] <= tstMin[ 0 ] && tstMin[ 0 ] <= srcMax[ 0 ] )
  interX = true;
  else if( srcMin[ 0 ] <= tstMax[ 0 ] && tstMax[ 0 ] <= srcMax[ 0 ] )
  interX = true;
  else if( tstMin[ 0 ] <= srcMin[ 0 ] && srcMin[ 0 ] <= tstMax[ 0 ] )
  interX = true;
  else if( tstMin[ 0 ] <= srcMax[ 0 ] && srcMax[ 0 ] <= tstMax[ 0 ] )
  interX = true;

  let interY = false;
  if( srcMin[ 1 ] <= tstMin[ 1 ] && tstMin[ 1 ] <= srcMax[ 1 ] )
  interY = true;
  else if( srcMin[ 1 ] <= tstMax[ 1 ] && tstMax[ 1 ] <= srcMax[ 1 ] )
  interY = true;
  else if( tstMin[ 1 ] <= srcMin[ 1 ] && srcMin[ 1 ] <= tstMax[ 1 ] )
  interY = true;
  else if( tstMin[ 1 ] <= srcMax[ 1 ] && srcMax[ 1 ] <= tstMax[ 1 ] )
  interY = true;

  let interZ = false;
  if( srcMin[ 2 ] <= tstMin[ 2 ] && tstMin[ 2 ] <= srcMax[ 2 ] )
  interZ = true;
  else if( srcMin[ 2 ] <= tstMax[ 2 ] && tstMax[ 2 ] <= srcMax[ 2 ] )
  interZ = true;
  else if( tstMin[ 2 ] <= srcMin[ 2 ] && srcMin[ 2 ] <= tstMax[ 2 ] )
  interZ = true;
  else if( tstMin[ 2 ] <= srcMax[ 2 ] && srcMax[ 2 ] <= tstMax[ 2 ] )
  interZ = true;

  if( interX && interY && interZ )
  return true;

  return false;
}

//

/**
  * Calculates the distance between two boxes. Returns the distance value, 0 if intersection.
  * Box are stored in Array data structure. Source box and Test box stay untouched.
  *
  * @param { Array } srcBox - Source box
  * @param { Array } tstBox - Test box to calculate the distance
  *
  * @example
  * // returns 0
  * _.boxDistance( [ 0, 0, 2, 2 ], [ 1, 1, 3, 3 ] );
  *
  * @example
  * // returns 1
  * _.boxDistance( [ 0, 0, 2, 2 ], [ 0, 3, 2, 4 ] );
  *
  * @returns { Number } Returns the distance between the two boxes.
  * @function boxDistance
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the two boxes have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @memberof wTools.box
  */

function boxDistance( srcBox , tstBox )
{

  let srcBoxVector = _.box._from( srcBox );
  let srcDim = _.box.dimGet( srcBoxVector );
  let srcMin = _.box.cornerLeftGet( srcBoxVector );
  let srcMax = _.box.cornerRightGet( srcBoxVector );

  let tstBoxVector = _.box._from( tstBox );
  let tstDim = _.box.dimGet( tstBoxVector );
  let tstMin = _.box.cornerLeftGet( tstBoxVector );
  let tstMax = _.box.cornerRightGet( tstBoxVector );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( tstDim === srcDim );

  debugger;
  // throw _.err( 'not tested' );

  /* src corners */

  let c = _.Space.makeZero( [ 3, 8 ] );
  srcMin = _.vector.toArray( srcMin ); srcMax = _.vector.toArray( srcMax );
  c.colVectorGet( 0 ).copy( [ srcMin[ 0 ], srcMin[ 1 ], srcMin[ 2 ] ] );
  c.colVectorGet( 1 ).copy( [ srcMax[ 0 ], srcMin[ 1 ], srcMin[ 2 ] ] );
  c.colVectorGet( 2 ).copy( [ srcMin[ 0 ], srcMax[ 1 ], srcMin[ 2 ] ] );
  c.colVectorGet( 3 ).copy( [ srcMin[ 0 ], srcMin[ 1 ], srcMax[ 2 ] ] );
  c.colVectorGet( 4 ).copy( [ srcMax[ 0 ], srcMax[ 1 ], srcMax[ 2 ] ] );
  c.colVectorGet( 5 ).copy( [ srcMin[ 0 ], srcMax[ 1 ], srcMax[ 2 ] ] );
  c.colVectorGet( 6 ).copy( [ srcMax[ 0 ], srcMin[ 1 ], srcMax[ 2 ] ] );
  c.colVectorGet( 7 ).copy( [ srcMax[ 0 ], srcMax[ 1 ], srcMin[ 2 ] ] );

  /* tst box corners */

  let c1 = _.Space.makeZero( [ 3, 8 ] );
  tstMin = _.vector.toArray( tstMin ); tstMax = _.vector.toArray( tstMax );
  c1.colVectorGet( 0 ).copy( [ tstMin[ 0 ], tstMin[ 1 ], tstMin[ 2 ] ] );
  c1.colVectorGet( 1 ).copy( [ tstMax[ 0 ], tstMin[ 1 ], tstMin[ 2 ] ] );
  c1.colVectorGet( 2 ).copy( [ tstMin[ 0 ], tstMax[ 1 ], tstMin[ 2 ] ] );
  c1.colVectorGet( 3 ).copy( [ tstMin[ 0 ], tstMin[ 1 ], tstMax[ 2 ] ] );
  c1.colVectorGet( 4 ).copy( [ tstMax[ 0 ], tstMax[ 1 ], tstMax[ 2 ] ] );
  c1.colVectorGet( 5 ).copy( [ tstMin[ 0 ], tstMax[ 1 ], tstMax[ 2 ] ] );
  c1.colVectorGet( 6 ).copy( [ tstMax[ 0 ], tstMin[ 1 ], tstMax[ 2 ] ] );
  c1.colVectorGet( 7 ).copy( [ tstMax[ 0 ], tstMax[ 1 ], tstMin[ 2 ] ] );

  let distance = Infinity;
  for( let j = 0 ; j < 8 ; j++ )
  {
    let srcCorner = _.vector.toArray( c.colVectorGet( j ) );
    let tstCorner = _.vector.toArray( c1.colVectorGet( j ) );
    let dSrc = _.box.pointDistance( srcBox, tstCorner );
    let dTst = _.box.pointDistance( tstBox, srcCorner );

    let d;
    if( dSrc < dTst )
    d = dSrc;
    else
    d = dTst;
    if( d < distance )
    {
      distance = d;
    }

  }

  if( boxIntersects( srcBox , tstBox ) === true )
  return 0;
  else
  return distance;
}

//

/**
  * Calculates the closest point in a box. Returns the closest point coordinates.
  * Box are stored in Array data structure. Source box and Test box stay untouched.
  *
  * @param { Array } srcBox - Source box
  * @param { Array } tstBox - Test box to calculate the closest point in it.
  * @param { Array } dstPoint - Destination point
  *
  * @example
  * // returns 0
  * _.boxClosestPoint( [ 0, 0, 2, 2 ], [ 1, 1, 3, 3 ] );
  *
  * @example
  * // returns [ 3, 3 ]
  * _.boxClosestPoint( [ 0, 0, 2, 2 ], [ 3, 3, 4, 4 ] );
  *
  * @returns { Array } Returns the coordinates of the closest point.
  * @function boxClosestPoint
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the two boxes have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @memberof wTools.box
  */

function boxClosestPoint( srcBox , tstBox, dstPoint )
{

  let srcBoxVector = _.box._from( srcBox );
  let srcDim = _.box.dimGet( srcBoxVector );
  let srcMin = _.box.cornerLeftGet( srcBoxVector );
  let srcMax = _.box.cornerRightGet( srcBoxVector );

  let tstBoxVector = _.box._from( tstBox );
  let tstDim = _.box.dimGet( tstBoxVector );
  let tstMin = _.box.cornerLeftGet( tstBoxVector );
  let tstMax = _.box.cornerRightGet( tstBoxVector );

  _.assert( arguments.length === 2 || arguments.length === 3 , 'expects two or three arguments' );
  _.assert( tstDim === srcDim );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( tstDim );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  _.assert( tstDim === dstPoint.length );

  let dstPointVector = _.vector.from( dstPoint );

  debugger;
  // throw _.err( 'not tested' );

  if( boxIntersects( srcBox , tstBox ) === true )
  return 0;
  else
  {
    /* src corners */

    let c = _.Space.makeZero( [ 3, 8 ] );
    srcMin = _.vector.toArray( srcMin ); srcMax = _.vector.toArray( srcMax );
    c.colVectorGet( 0 ).copy( [ srcMin[ 0 ], srcMin[ 1 ], srcMin[ 2 ] ] );
    c.colVectorGet( 1 ).copy( [ srcMax[ 0 ], srcMin[ 1 ], srcMin[ 2 ] ] );
    c.colVectorGet( 2 ).copy( [ srcMin[ 0 ], srcMax[ 1 ], srcMin[ 2 ] ] );
    c.colVectorGet( 3 ).copy( [ srcMin[ 0 ], srcMin[ 1 ], srcMax[ 2 ] ] );
    c.colVectorGet( 4 ).copy( [ srcMax[ 0 ], srcMax[ 1 ], srcMax[ 2 ] ] );
    c.colVectorGet( 5 ).copy( [ srcMin[ 0 ], srcMax[ 1 ], srcMax[ 2 ] ] );
    c.colVectorGet( 6 ).copy( [ srcMax[ 0 ], srcMin[ 1 ], srcMax[ 2 ] ] );
    c.colVectorGet( 7 ).copy( [ srcMax[ 0 ], srcMax[ 1 ], srcMin[ 2 ] ] );

    /* tst box corners */

    let c1 = _.Space.makeZero( [ 3, 8 ] );
    tstMin = _.vector.toArray( tstMin ); tstMax = _.vector.toArray( tstMax );
    c1.colVectorGet( 0 ).copy( [ tstMin[ 0 ], tstMin[ 1 ], tstMin[ 2 ] ] );
    c1.colVectorGet( 1 ).copy( [ tstMax[ 0 ], tstMin[ 1 ], tstMin[ 2 ] ] );
    c1.colVectorGet( 2 ).copy( [ tstMin[ 0 ], tstMax[ 1 ], tstMin[ 2 ] ] );
    c1.colVectorGet( 3 ).copy( [ tstMin[ 0 ], tstMin[ 1 ], tstMax[ 2 ] ] );
    c1.colVectorGet( 4 ).copy( [ tstMax[ 0 ], tstMax[ 1 ], tstMax[ 2 ] ] );
    c1.colVectorGet( 5 ).copy( [ tstMin[ 0 ], tstMax[ 1 ], tstMax[ 2 ] ] );
    c1.colVectorGet( 6 ).copy( [ tstMax[ 0 ], tstMin[ 1 ], tstMax[ 2 ] ] );
    c1.colVectorGet( 7 ).copy( [ tstMax[ 0 ], tstMax[ 1 ], tstMin[ 2 ] ] );

    let distance = Infinity;
    let point = _.array.makeArrayOfLength( tstDim );
    for( let j = 0 ; j < 8 ; j++ )
    {
      let srcCorner = _.vector.toArray( c.colVectorGet( j ) );
      let tstCorner = _.vector.toArray( c1.colVectorGet( j ) );
      let dSrc = _.box.pointDistance( srcBox, tstCorner );
      let dTst = _.box.pointDistance( tstBox, srcCorner );

      if( dSrc < dTst && dSrc <= distance )
      {
        distance = dSrc;
        point = tstCorner;
      }
      else if( dTst <= dSrc && dTst <= distance )
      {
        distance = dTst;
        point = _.box.pointClosestPoint( tstBox, srcCorner );
      }
    }

    for( let i = 0; i < tstDim; i++ )
    {
      dstPointVector.eSet( i, point[ i ] );
      debugger;
    }

    return dstPoint;
  }

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

  let _dstBox = _.box._from( dstBox );
  let dim1 = _.box.dimGet( _dstBox );
  let min1 = _.box.cornerLeftGet( _dstBox );
  let max1 = _.box.cornerRightGet( _dstBox );

  let _srcBox = _.box._from( srcBox );
  let dim2 = _.box.dimGet( _srcBox );
  let min2 = _.box.cornerLeftGet( _srcBox );
  let max2 = _.box.cornerRightGet( _srcBox );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( dim1 === dim2 );

  _.vector.minVectors( min1 , min2 );
  _.vector.maxVectors( max1 , max2 );

  return dstBox;
}

//

/**
  *Check if the source box contains test sphere. Returns true if it is contained, false if not.
  * Box and sphere are stored in Array data structure and remain unchanged
  *
  * @param { Array } srcBox - The source box (container).
  * @param { Array } tstSphere - The tested sphere (the sphere to check if it is contained in srcBox).
  *
  * @example
  * // returns true
  * _.sphereContains( [ 0, 0, 0, 2, 2, 2 ], [ 1, 1, 1, 1 ] );
  *
  * @example
  * // returns false
  * _.sphereContains( [ 0, 0, 0, 2, 2, 2 ], [ 0, 0, 1, 2.5 ] );
  *
  * @returns { Boolean } Returns true if the sphere is contained and false if not.
  * @function sphereContains
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the box and sphere don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcBox ) is not box
  * @throws { Error } An Error if ( tstSphere ) is not sphere
  * @memberof wTools.box
  */

function sphereContains( srcBox , tstSphere )
{
  let _tstSphere = _.sphere._from( tstSphere );
  let center = _.sphere.centerGet( _tstSphere );
  let radius = _.sphere.radiusGet( _tstSphere );
  let dimS = _.sphere.dimGet( _tstSphere );

  let boxVector = _.box._from( srcBox );
  let dimB = _.box.dimGet( boxVector );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( dimS === dimB );

  let pointp = center.slice();
  let pointn = center.slice();
  for( let i = 0; i < dimS; i++ )
  {
    pointp[ i ] = pointp[ i ] + radius;
    pointn[ i ] = pointn[ i ] - radius;

    if( !_.box.pointContains( boxVector, pointp ) )
    return false;

    if( !_.box.pointContains( boxVector, pointn ) )
    return false;
  }

  return true;
}

//

/**
  *Check if the source box intersects with test sphere. Returns true if it they intersect, false if not.
  * Box and sphere are stored in Array data structure and remain unchanged
  *
  * @param { Array } srcBox - The source box.
  * @param { Array } tstSphere - The tested sphere.
  *
  * @example
  * // returns true
  * _.sphereIntersects( [ 0, 0, 0, 2, 2, 2 ], [ 0.5, 0.5, 1, 1 ] );
  *
  * @example
  * // returns false
  * _.sphereIntersects( [ 0, 0, 0, 2, 2, 2 ], [ 4, 4, 4, 1 ] );
  *
  * @returns { Boolean } Returns true if the sphere and the box intersect.
  * @function sphereIntersects
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the box and sphere don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcBox ) is not box
  * @throws { Error } An Error if ( tstSphere ) is not sphere
  * @memberof wTools.box
  */

function sphereIntersects( srcBox , tstSphere )
{
  let _tstSphere = _.sphere._from( tstSphere );
  let boxVector = _.box._from( srcBox );
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  let gotBool = _.sphere.boxIntersects( _tstSphere, boxVector );

  return gotBool;
}

//

/**
  * Calculates the distance between a box and a sphere. Returns the calculated distance.
  * Box and sphere are stored in Array data structure and remain unchanged
  *
  * @param { Array } srcBox - The source box.
  * @param { Array } tstSphere - The tested sphere (the sphere to calculate the distance).
  *
  * @example
  * // returns 0
  * _.sphereDistance( [ 0, 0, 0, 2, 2, 2 ], [ 0.5, 0.5, 1, 1 ] );
  *
  * @example
  * // returns 1
  * _.sphereDistance( [ 0, 0, 0, 2, 2, 2 ], [ 0, 0, 4, 1 ] );
  *
  * @returns { Number } Returns the distance between the box and the sphere.
  * @function sphereDistance
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the box and sphere don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcBox ) is not box
  * @throws { Error } An Error if ( tstSphere ) is not sphere
  * @memberof wTools.box
  */

function sphereDistance( srcBox , tstSphere )
{
  let _tstSphere = _.sphere._from( tstSphere );
  let center = _.sphere.centerGet( _tstSphere );
  let radius = _.sphere.radiusGet( _tstSphere );
  let dimS = _.sphere.dimGet( _tstSphere );

  let boxVector = _.box._from( srcBox );
  let dimB = _.box.dimGet( boxVector );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( dimS === dimB );

  let distance = 0;
  if( _.sphere.boxIntersects( _tstSphere, boxVector ) )
  return distance;
  else
  distance = _.box.pointDistance( boxVector, center ) - radius;

  return distance;
}

//

/**
  * Gets the closest point in a box to a sphere. Returns the closest point.
  * Box and sphere are stored in Array data structure and remain unchanged.
  *
  * @param { Array } srcBox - The source box.
  * @param { Array } tstSphere - The tested sphere.
  * @param { Array } dstPoint - The closest point in the sphere to the box.
  *
  * @example
  * // returns 0
  * _.sphereClosestPoint( [ 0, 0, 0, 2, 2, 2 ], [ 0.5, 0.5, 1, 1 ] );
  *
  * @example
  * // returns [ 0, 0, 2 ]
  * _.sphereClosestPoint( [ 0, 0, 0, 2, 2, 2 ], [ 0, 0, 4, 1 ] );
  *
  * @returns { Array } Returns the closest point in the box to the sphere.
  * @function sphereClosestPoint
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the box and sphere don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( tstSphere ) is not sphere.
  * @throws { Error } An Error if ( dstPoint ) is not point.
  * @memberof wTools.box
  */

function sphereClosestPoint( srcBox , tstSphere, dstPoint )
{

  let _tstSphere = _.sphere._from( tstSphere );
  let center = _.sphere.centerGet( _tstSphere );
  let radius = _.sphere.radiusGet( _tstSphere );
  let dimS = _.sphere.dimGet( _tstSphere );

  let boxVector = _.box._from( srcBox );
  let dimB = _.box.dimGet( boxVector );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( dimB );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let dstPointVector = _.vector.from( dstPoint );

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( dimS === dimB );
  _.assert( dimS === dstPoint.length );

  if( _.sphere.boxIntersects( _tstSphere, boxVector ) )
  return 0
  else
  {
    let p = _.box.pointClosestPoint( boxVector, center );

    for( let i = 0; i < dimB; i++ )
    {
      dstPointVector.eSet( i, p[ i ] );
    }

    return dstPoint;
  }

}
//

/**
  * Expand destination box by source sphere. Returns destination box.
  * Box and sphere are stored in Array data structure. Source sphere stays untouched.
  *
  * @param { Array } dstBox - box to be expanded.
  * @param { Array } srcSphere - source sphere with expansion dimensions.
  *
  * @example
  * // returns [ -2, -2, -2, 3, 3, 3 ];
  * _.sphereExpand( [ 1, 1, 1, 3, 3, 3 ], [ 0, 0, 0, 2 ] );
  *
  * @returns { Array } Returns the array of the expanded box, that contains new element ( src sphere ).
  * @function sphereExpand
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the box and the sphere don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstBox ) is not box
  * @throws { Error } An Error if ( srcSphere ) is not sphere
  * @memberof wTools.box
  */

function sphereExpand( dstBox , srcSphere )
{

  let _dstBox = _.box._from( dstBox );
  let dimB = _.box.dimGet( _dstBox );
  let min1 = _.box.cornerLeftGet( _dstBox );
  let max1 = _.box.cornerRightGet( _dstBox );

  let _srcSphere = _.sphere._from( srcSphere );
  let center = _.sphere.centerGet( _srcSphere );
  let radius = _.sphere.radiusGet( _srcSphere );
  let dimS = _.sphere.dimGet( _srcSphere );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( dimB === dimS );

  /* Sphere limits */

  let c1 = _.Space.makeZero( [ 3, 6 ] );
  center = _.vector.toArray( center );
  c1.colVectorGet( 0 ).copy( [ center[ 0 ] + radius, center[ 1 ], center[ 2 ] ] );
  c1.colVectorGet( 1 ).copy( [ center[ 0 ] - radius, center[ 1 ], center[ 2 ] ] );
  c1.colVectorGet( 2 ).copy( [ center[ 0 ], center[ 1 ] + radius, center[ 2 ] ] );
  c1.colVectorGet( 3 ).copy( [ center[ 0 ], center[ 1 ] - radius, center[ 2 ] ] );
  c1.colVectorGet( 4 ).copy( [ center[ 0 ], center[ 1 ], center[ 2 ] + radius ] );
  c1.colVectorGet( 5 ).copy( [ center[ 0 ], center[ 1 ], center[ 2 ] - radius ] );

  let box = _dstBox.slice();
  for( let j = 0 ; j < 6 ; j++ )
  {
    let srcCorner = _.vector.toArray( c1.colVectorGet( j ) );
    box = _.box.pointExpand( box, srcCorner );
  }
  _dstBox.eSet( 0, box[ 0 ] );
  _dstBox.eSet( 1, box[ 1 ] );
  _dstBox.eSet( 2, box[ 2 ] );
  _dstBox.eSet( 3, box[ 3 ] );
  _dstBox.eSet( 4, box[ 4 ] );
  _dstBox.eSet( 5, box[ 5 ] );


  return dstBox;

}

//

/**
  *Check if the source box intersects with test plane. Returns true if it they intersect, false if not.
  * Box and plane are stored in Array data structure and remain unchanged
  *
  * @param { Array } srcBox - The source box.
  * @param { Array } tstPlane - The tested plane.
  *
  * @example
  * // returns true
  * _.planeIntersects( [ 0, 0, 0, 2, 2, 2 ], [ 1, 0, 0, -1 ] );
  *
  * @example
  * // returns false
  * _.sphereIntersects( [ 0, 0, 0, 2, 2, 2 ], [ 1, 0, 0, 1 ] );
  *
  * @returns { Boolean } Returns true if the plane and the box intersect.
  * @function planeIntersects
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the box and plane don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcBox ) is not box
  * @throws { Error } An Error if ( tstPlane ) is not plane
  * @memberof wTools.box
  */

function planeIntersects( srcBox , tstPlane )
{
  let _tstPlane = _.plane._from( tstPlane );
  let boxVector = _.box._from( srcBox );
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  let gotBool = _.plane.boxIntersects( _tstPlane, boxVector );

  return gotBool;
}

//

/**
  * Calculates the distance between a plane and a box. Returns the distance between the two elements.
  * The box and the plane remain unchanged.
  *
  * @param { Array } srcBox - Source box.
  * @param { Array } plane - Source plane.
  *
  * @example
  * // returns 0;
  * _.planeDistance( [ 1, 0, 0, 1 ] , [ -1, 2, 2, -1, 2, 8 ]);
  *
  * @example
  * // returns 3;
  * _.planeDistance( [ 0, 1, 0, 1 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Number } Returns the distance between the plane and the box.
  * @function planeDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( dim ) is different than box.dimGet (the plane and box don´t have the same dimension).
  * @memberof wTools.box
  */

function planeDistance( srcBox, plane )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  let boxVector = _.box._from( srcBox );
  let dimB = _.box.dimGet( boxVector );
  let min = _.box.cornerLeftGet( boxVector );
  let max = _.box.cornerRightGet( boxVector );

  let _plane = _.plane._from( plane );
  let dimP = _.plane.dimGet( _plane );

  _.assert( dimP === dimB );

  if( _.plane.boxIntersects( _plane, boxVector ) )
  return 0;
  else
  {
    /* box corners */

    let c = _.Space.makeZero( [ 3, 8 ] );
    min = _.vector.toArray( min ); max = _.vector.toArray( max );
    c.colVectorGet( 0 ).copy( [ min[ 0 ], min[ 1 ], min[ 2 ] ] );
    c.colVectorGet( 1 ).copy( [ max[ 0 ], min[ 1 ], min[ 2 ] ] );
    c.colVectorGet( 2 ).copy( [ min[ 0 ], max[ 1 ], min[ 2 ] ] );
    c.colVectorGet( 3 ).copy( [ min[ 0 ], min[ 1 ], max[ 2 ] ] );
    c.colVectorGet( 4 ).copy( [ max[ 0 ], max[ 1 ], max[ 2 ] ] );
    c.colVectorGet( 5 ).copy( [ min[ 0 ], max[ 1 ], max[ 2 ] ] );
    c.colVectorGet( 6 ).copy( [ max[ 0 ], min[ 1 ], max[ 2 ] ] );
    c.colVectorGet( 7 ).copy( [ max[ 0 ], max[ 1 ], min[ 2 ] ] );

    let distance = Infinity;
    let d = 0;
    for( let j = 0 ; j < 8 ; j++ )
    {
      let corner = c.colVectorGet( j );
      d = Math.abs( _.plane.pointDistance( plane, corner ) );

      if( d < distance )
      {
        distance = d;
      }

    }

    return distance;
  }
}

//

/**
  * Get the closest point in a box to a plane. Returns the closest point. Box and plane stay untouched.
  *
  * @param { Array } box - The source box.
  * @param { Array } plane - The source plane.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns [ 0, 2 ]
  * _.planeClosestPoint( [ 0, 0, 2, 2 ], [ 0, 3 ] );
  *
  * @example
  * // returns [ 0, 1 ]
  * _.planeClosestPoint( [ 0, 0, 2, 2 ], [ 0, 1 ] );
  *
  * @returns { Array } Returns an array with the coordinates of the closest point.
  * @function planeClosestPoint
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the box and the plane don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( dstPoint ) is not dstPoint.
  * @memberof wTools.box
  */
function planeClosestPoint( srcBox, plane, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );

  let boxVector = _.box._from( srcBox );
  let dimB = _.box.dimGet( boxVector );
  let min = _.box.cornerLeftGet( boxVector );
  let max = _.box.cornerRightGet( boxVector );

  let _plane = _.plane._from( plane );
  let dimP = _.plane.dimGet( _plane );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( dimB );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let dstPointVector = _.vector.from( dstPoint );

  _.assert( dimP === dimB );
  _.assert( dimP === dstPoint.length );

  if( _.plane.boxIntersects( _plane, boxVector ) )
  return 0;
  else
  {

    /* box corners */

    let c = _.Space.makeZero( [ 3, 8 ] );
    min = _.vector.toArray( min ); max = _.vector.toArray( max );
    c.colVectorGet( 0 ).copy( [ min[ 0 ], min[ 1 ], min[ 2 ] ] );
    c.colVectorGet( 1 ).copy( [ max[ 0 ], min[ 1 ], min[ 2 ] ] );
    c.colVectorGet( 2 ).copy( [ min[ 0 ], max[ 1 ], min[ 2 ] ] );
    c.colVectorGet( 3 ).copy( [ min[ 0 ], min[ 1 ], max[ 2 ] ] );
    c.colVectorGet( 4 ).copy( [ max[ 0 ], max[ 1 ], max[ 2 ] ] );
    c.colVectorGet( 5 ).copy( [ min[ 0 ], max[ 1 ], max[ 2 ] ] );
    c.colVectorGet( 6 ).copy( [ max[ 0 ], min[ 1 ], max[ 2 ] ] );
    c.colVectorGet( 7 ).copy( [ max[ 0 ], max[ 1 ], min[ 2 ] ] );

    let distance = Infinity;
    let d = 0;
    let point = _.array.makeArrayOfLength( dimB );
    for( let j = 0 ; j < 8 ; j++ )
    {
      let corner = c.colVectorGet( j );
      d = Math.abs( _.plane.pointDistance( plane, corner ) );

      if( d < distance )
      {
        distance = d;
        point = corner;
      }

    }

    for( let i = 0; i < point.length; i++ )
    {
      dstPointVector.eSet( i, point.eGet( i ) );
    }

    return dstPoint;
  }
}

//

/**
  * Expand a box with a plane equation. Returns the expanded box.
  * Plane stay untouched, box changes.
  *
  * @param { Array } dstBox - The destination box.
  * @param { Array } srcPlane - The source plane.
  *
  * @example
  * // returns [ -1, -1, -1, 2, 2, 2 ]
  * _.planeExpand( [ 0, 0, 0, 2, 2, 2 ], [ 1, 0, 0, 1 ] );
  *
  * @example
  * // returns [ 0, 0, 0, 2, 2, 2 ]
  * _.planeExpand( [ 0, 0, 0, 2, 2, 2 ], [ 1, 0, 0, 0 ] );
  *
  * @returns { Array } Returns an array with the coordinates of the expanded box.
  * @function planeExpand
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the box and the plane don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstBox ) is not box.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @memberof wTools.box
  */
function planeExpand( dstBox, srcPlane )
{
  _.assert( arguments.length === 2, 'expects two arguments' );

  let boxVector = _.box._from( dstBox );
  let dimB = _.box.dimGet( boxVector );
  let min = _.box.cornerLeftGet( boxVector );
  let max = _.box.cornerRightGet( boxVector );

  let _plane = _.plane._from( srcPlane );
  let dimP = _.plane.dimGet( _plane );

  _.assert( dimP === dimB );

  if( _.plane.boxIntersects( _plane, boxVector ) )
  return dstBox;
  else
  {
    let boxPoint = _.box.planeClosestPoint( boxVector.slice(), _plane );
    let planePoint = _.plane.pointCoplanarGet( _plane, boxPoint );
    let box = _.box.pointExpand( boxVector.slice(), planePoint);
    for( let i = 0; i < box.length; i++ )
    {
      boxVector.eSet( i, box[ i ] );
    }
    return dstBox;
  }
}

//

/**
  * Check if a box contains a frustum. Returns true if it is contained, false if not.
  * Box and frustum remain unchanged
  *
  * @param { Array } box - The source box (container).
  * @param { Space } frustum - The tested frustum (the frustum to check if it is contained in box).
  *
  * @example
  * // returns true
  * let frustum =  _.Space.make( [ 4, 6 ] ).copy
  * ([
  *   0,   0,   0,   0, - 1,   1,
  *   1, - 1,   0,   0,   0,   0,
  *   0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ]
  * );
  * _.frustumContains( [ 0, 0, 0, 2, 2, 2 ], frustum );
  *
  * @example
  * // returns false
  * _.frustumContains( [ 2, 2, 2, 3, 3, 3 ], frustum );
  *
  * @returns { Boolean } Returns true if the frustum is contained and false if not.
  * @function frustumContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( box ) is not box
  * @throws { Error } An Error if ( frustum ) is not frustum
  * @memberof wTools.box
  */
function frustumContains( box, frustum )
{

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.frustum.is( frustum ) );
  let _box = _.box._from( box );
  let dim = _.box.dimGet( _box );
  let min = _.box.cornerLeftGet( _box );
  let max = _.box.cornerRightGet( _box );

  let fpoints = _.frustum.cornersGet( frustum );
  _.assert( _.spaceIs( fpoints ) );

  for( let i = 0 ; i < 6 ; i += 1 )
  {
    let point = fpoints.colVectorGet( i );

    if( _.box.pointContains( box, point ) !== true )
    {
      return false;
    }
  }
  return true;
}

//

/**
  * Check if a box and a frustum intersect. Returns true if they intersect, false if not.
  * Box and frustum remain unchanged
  *
  * @param { Array } box - The source box.
  * @param { Space } frustum - The tested frustum.
  *
  * @example
  * // returns true
  * let frustum =  _.Space.make( [ 4, 6 ] ).copy
  * ([
  *   0,   0,   0,   0, - 1,   1,
  *   1, - 1,   0,   0,   0,   0,
  *   0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ]
  * );
  * _.frustumIntersects( [ 0, 0, 0, 2, 2, 2 ], frustum );
  *
  * @example
  * // returns false
  * _.frustumIntersects( [ 2, 2, 2, 3, 3, 3 ], frustum );
  *
  * @returns { Boolean } Returns true if the frustum and the box intersect.
  * @function frustumIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( box ) is not box
  * @throws { Error } An Error if ( frustum ) is not frustum
  * @memberof wTools.box
  */
function frustumIntersects( box, frustum )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.frustum.is( frustum ) );
  let _box = _.box._from( box );

  let gotBool = _.frustum.boxIntersects( frustum, _box );
  return gotBool;
}

//

/**
  * Calculates the distance between a box and a frustum. Returns the calculated distance.
  * Box and frustum remain unchanged
  *
  * @param { Array } box - The source box.
  * @param { Space } frustum - The source frustum.
  *
  * @example
  * // returns 0
  * let frustum =  _.Space.make( [ 4, 6 ] ).copy
  * ([
  *   0,   0,   0,   0, - 1,   1,
  *   1, - 1,   0,   0,   0,   0,
  *   0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ]
  * );
  * _.frustumDistance( [ 0, 0, 0, 2, 2, 2 ], frustum );
  *
  * @example
  * // returns 1
  * _.frustumDistance( [ 2, 2, 2, 3, 3, 3 ], frustum );
  *
  * @returns { Number } Returns the distance between the box and the point.
  * @function frustumDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( box ) is not box
  * @throws { Error } An Error if ( frustum ) is not frustum
  * @memberof wTools.box
  */
function frustumDistance( box, frustum )
{

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.frustum.is( frustum ) );

  let _box = _.box._from( box );

  let dim = _.box.dimGet( _box );
  _.assert( dim === 3 );
  let min = _.box.cornerLeftGet( _box );
  let max = _.box.cornerRightGet( _box );

  if( _.frustum.boxIntersects( frustum, _box ) )
  return 0;

  let frustumPoint = _.frustum.boxClosestPoint( frustum, _box );

  /* box corners */

  let c = _.Space.makeZero( [ 3, 8 ] );
  let min1 = _.vector.toArray( min ); let max1 = _.vector.toArray( max );
  c.colVectorGet( 0 ).copy( [ min1[ 0 ], min1[ 1 ], min1[ 2 ] ] );
  c.colVectorGet( 1 ).copy( [ max1[ 0 ], min1[ 1 ], min1[ 2 ] ] );
  c.colVectorGet( 2 ).copy( [ min1[ 0 ], max1[ 1 ], min1[ 2 ] ] );
  c.colVectorGet( 3 ).copy( [ min1[ 0 ], min1[ 1 ], max1[ 2 ] ] );
  c.colVectorGet( 4 ).copy( [ max1[ 0 ], max1[ 1 ], max1[ 2 ] ] );
  c.colVectorGet( 5 ).copy( [ min1[ 0 ], max1[ 1 ], max1[ 2 ] ] );
  c.colVectorGet( 6 ).copy( [ max1[ 0 ], min1[ 1 ], max1[ 2 ] ] );
  c.colVectorGet( 7 ).copy( [ max1[ 0 ], max1[ 1 ], min1[ 2 ] ] );

  let distance = Infinity;
  for( let j = 0 ; j < 8 ; j++ )
  {
    let corner = c.colVectorGet( j );
    let proj = _.frustum.pointClosestPoint( frustum, corner );
    let d = _.avector.distance( corner, frustumPoint.slice() );
    if( d < distance )
    {
      distance = d;
    }
  }

  return distance;

}

//

/**
  * Calculates the closest point in a box to a frustum. Returns the calculated point.
  * Box and frustum remain unchanged
  *
  * @param { Array } box - The source box.
  * @param { Space } frustum - The source frustum.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  * let frustum =  _.Space.make( [ 4, 6 ] ).copy
  * ([
  *   0,   0,   0,   0, - 1,   1,
  *   1, - 1,   0,   0,   0,   0,
  *   0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ]
  * );
  * _.frustumClosestPoint( [ 0, 0, 0, 2, 2, 2 ], frustum );
  *
  * @example
  * // returns [ 2, 2, 2 ]
  * _.frustumClosestPoint [ 2, 2, 2, 3, 3, 3 ], frustum );
  *
  * @returns { Array } Returns the closest point to the frustum.
  * @function frustumClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( box ) is not box
  * @throws { Error } An Error if ( frustum ) is not frustum
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @memberof wTools.box
  */
function frustumClosestPoint( box, frustum, dstPoint )
{

  _.assert( _.frustum.is( frustum ) );

  let _box = _.box._from( box );
  let dimB = _.box.dimGet( _box );
  _.assert( dimB === 3 );
  let min = _.box.cornerLeftGet( _box );
  let max = _.box.cornerRightGet( _box );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( dimB );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let dstPointVector = _.vector.from( dstPoint );

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( dimB === 3 );
  _.assert( dimB === dstPoint.length );

  if( _.frustum.boxIntersects( frustum, _box ) )
  return 0
  else
  {
    let frustumPoint = _.frustum.boxClosestPoint( frustum, _box );

    /* box corners */

    let c = _.Space.makeZero( [ 3, 8 ] );
    let min1 = _.vector.toArray( min ); let max1 = _.vector.toArray( max );
    c.colVectorGet( 0 ).copy( [ min1[ 0 ], min1[ 1 ], min1[ 2 ] ] );
    c.colVectorGet( 1 ).copy( [ max1[ 0 ], min1[ 1 ], min1[ 2 ] ] );
    c.colVectorGet( 2 ).copy( [ min1[ 0 ], max1[ 1 ], min1[ 2 ] ] );
    c.colVectorGet( 3 ).copy( [ min1[ 0 ], min1[ 1 ], max1[ 2 ] ] );
    c.colVectorGet( 4 ).copy( [ max1[ 0 ], max1[ 1 ], max1[ 2 ] ] );
    c.colVectorGet( 5 ).copy( [ min1[ 0 ], max1[ 1 ], max1[ 2 ] ] );
    c.colVectorGet( 6 ).copy( [ max1[ 0 ], min1[ 1 ], max1[ 2 ] ] );
    c.colVectorGet( 7 ).copy( [ max1[ 0 ], max1[ 1 ], min1[ 2 ] ] );

    let distance = Infinity;
    let point = [ 0, 0, 0 ];
    for( let j = 0 ; j < 8 ; j++ )
    {
      let corner = c.colVectorGet( j );
      let d = _.avector.distance( corner, frustumPoint.slice() );
      if( d < distance )
      {
        distance = d;
        point = corner.slice();
      }
    }

    for( let i = 0; i < dimB; i++ )
    {
      dstPointVector.eSet( i, point[ i ] );
    }

    return dstPoint;
  }

}

//

/**
  * Expand a box with a frustum. Returns the expanded box.
  * Frustum remains unchanged
  *
  * @param { Array } dstBox - The destination box.
  * @param { Space } srcFrustum - The source frustum.
  *
  * @example
  * // returns [ 0, 0, 0, 2, 2, 2 ]
  * let frustum =  _.Space.make( [ 4, 6 ] ).copy
  * ([
  *   0,   0,   0,   0, - 1,   1,
  *   1, - 1,   0,   0,   0,   0,
  *   0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ]
  * );
  * _.frustumExpand( [ 0, 0, 0, 2, 2, 2 ], frustum );
  *
  * @example
  * // returns [ 0, 0, 0, 3, 3, 3 ]
  * _.frustumExpand( [ 2, 2, 2, 3, 3, 3 ], frustum );
  *
  * @returns { Array } Returns the expanded box.
  * @function frustumExpand
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstBox ) is not box
  * @throws { Error } An Error if ( srcFrustum ) is not frustum
  * @memberof wTools.box
  */
function frustumExpand( dstBox, srcFrustum )
{

_.assert( arguments.length === 2, 'expects exactly two arguments' );
_.assert( _.frustum.is( srcFrustum ) );

let _box = _.box._from( dstBox );

let dim = _.box.dimGet( _box );
_.assert( dim === 3 );
let min = _.box.cornerLeftGet( _box );
let max = _.box.cornerRightGet( _box );

let fpoints = _.frustum.cornersGet( srcFrustum );
_.assert( _.spaceIs( fpoints ) );
_.assert( fpoints.hasShape([ 3, 8 ] ) );

let box2 = _box.slice();
for( let j = 0 ; j < 8 ; j++ )
{
  let newp = _.vector.toArray( fpoints.colVectorGet( j ) );
  box2 = _.box.pointExpand( box2, newp );
}

for( let j = 0 ; j < 6 ; j++ )
{
  _box.eSet( j,  box2[ j ] );
}

  return dstBox;
}

//

/**
  * Apply a space transformation to a box. Returns the transformed box.
  *
  * @param { Array } box - The destination box.
  * @param { Space } matrix - The transformation matrix.
  *
  * @example
  * // returns [ 0, 0, 0, 1, 1, 1 ]
  * var matrix = _.Space.make( [ 4, 4 ] ).copy
  *  ([
  *    0.5, 0, 0, 0,
  *    0, 0.5, 0, 0,
  *    0, 0, 0.5, 0,
  *    0, 0, 0, 1
  *  ]);
  * _.matrixHomogenousApply( [ 0, 0, 0, 2, 2, 2 ], matrix );
  *
  * @returns { Array } Returns the transformed box.
  * @function matrixHomogenousApply
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( box ) is not box
  * @throws { Error } An Error if ( matrix ) is not space
  * @memberof wTools.box
  */

function matrixHomogenousApply( box , matrix )
{

  let boxVector = _.box._from( box );
  let dim = _.box.dimGet( boxVector );
  let min = _.box.cornerLeftGet( boxVector );
  let max = _.box.cornerRightGet( boxVector );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.spaceIs( matrix ) );
  _.assert( matrix.hasShape([ dim+1,dim+1 ]) );

  let box2 = _.box.nil( dim );

  let point = [];
  let samples = _.dup( [ 0,1 ] , dim );
  _.eachSample( samples,function( sample,i )
  {

    for( let i = 0 ; i < dim ; i++ )
    point[ i ] = sample[ i ] ? max.eGet( i ) : min.eGet( i );
    matrix.matrixHomogenousApply( point );
    debugger;
    _.box.pointExpand( box2,point );

  });

  boxVector.copy( box2 );

  return box;
}

//

/**
  * Translate a box by a given offset. Returns the translated box.
  *
  * @param { Array } box - The destination box.
  * @param { Number } offset - The translation offset.
  *
  * @example
  * // returns [ 3, 3, 3, 5, 5, 5 ]
  * _.translate( [ 0, 0, 0, 2, 2, 2 ], 3 );
  *
  * @returns { Array } Returns the translated box.
  * @function translate
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstBox ) is not box
  * @memberof wTools.box
  */

function translate( box, offset )
{

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  let boxVector = _.box._from( box );

  boxVector.addScalar( offset );

  return box;

}

//

/*
*
*  function translate( box , offset )
*  {
*
*    this.min.add( offset );
*    this.max.add( offset );
*
*    return box;
*
*  }
*/


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
//   let boxVector = _.box._from( box );
//   let center = _.box.centerGet( boxVector );
//   let radius = _.box.radiusGet( boxVector );
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
//   let boxVector = _.box._from( box );
//   let center = _.box.centerGet( boxVector );
//   let radius = _.box.radiusGet( boxVector );
//
//   return( vector.distance( vector.from( point ) , center ) - radius );
// }
//
// //
//
// function pointClosestPoint( box, point )
// {
//
//   _.assert( arguments.length === 2, 'expects exactly two arguments' );
//   _.assert( _.box.is( box ) );
//   debugger;
//   throw _.err( 'not implemented' );
//
//   let pointVector = vector.from( point );
//   let boxVector = _.box._from( box );
//   let center = _.box.centerGet( boxVector );
//   let radius = _.box.radiusGet( boxVector );
//
//   let distanseSqr = vector.distanceSqr( pointVector , center );
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
//   let _box1 = _.box._from( box1 );
//   let center1 = _.box.centerGet( _box1 );
//   let radius1 = _.box.radiusGet( _box1 );
//
//   let _box2 = _.box._from( box2 );
//   let center2 = _.box.centerGet( _box2 );
//   let radius2 = _.box.radiusGet( _box2 );
//
//   let r = radius1 + radius2;
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
//   let boxVector = _.box._from( box );
//   let center = _.box.centerGet( boxVector );
//   let radius = _.box.radiusGet( boxVector );
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
//   let boxVector = _.box._from( box );
//   let center = _.box.centerGet( boxVector );
//   let radius = _.box.radiusGet( boxVector );
//
//   center.add( offset );
//
//   return box;
// }

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

  pointContains : pointContains,
  pointDistance : pointDistance,
  pointClosestPoint : pointClosestPoint,
  pointExpand : pointExpand,
  pointRelative : pointRelative,

  boxContains : boxContains,
  boxIntersects : boxIntersects,
  boxDistance : boxDistance, /* qqq : implement me */
  boxClosestPoint : boxClosestPoint, /* qqq : implement me */
  boxExpand : boxExpand,

  sphereContains : sphereContains, /* qqq : implement me */
  sphereIntersects : sphereIntersects, /* qqq : implement me - Same as _.sphere.boxIntersects */
  sphereDistance : sphereDistance, /* qqq : implement me */
  sphereClosestPoint : sphereClosestPoint, /* qqq : implement me */
  sphereExpand : sphereExpand, /* qqq : implement me */

  planeIntersects : planeIntersects, /* qqq : implement me - Same as _.plane.boxIntersects */
  planeDistance : planeDistance, /* qqq : implement me */
  planeClosestPoint : planeClosestPoint, /* qqq : implement me */
  planeExpand : planeExpand, /* qqq : implement me */

  frustumContains : frustumContains, /* qqq : implement me */
  frustumIntersects : frustumIntersects, /* qqq : implement me - Same as _.frustum.boxIntersects */
  frustumDistance : frustumDistance, /* qqq : implement me */
  frustumClosestPoint : frustumClosestPoint, /* qqq : implement me */
  frustumExpand : frustumExpand, /* qqq : implement me */

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
