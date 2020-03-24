(function _Triangle_s_(){

'use strict';

let _ = _global_.wTools;
// let this.tools.avector = this.tools.avector;
// let vector = this.tools.vectorAdapter;
let Self = _.triangle = _.triangle || Object.create( _.avector );

// --
// routines
// --

function make( dim )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = this.makeZero( dim );
  if( this.is( dim ) )
  this.tools.avector.assign( result, dim );
  return result;
}

//

function makeZero( dim )
{
  if( this.is( dim ) )
  dim = this.dimGet( dim );
  if( dim === undefined || dim === null )
  dim = 2;
  _.assert( dim >= 0 );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = _.dup( 0, dim*3 );
  return result;
}

//

function from( triangle )
{

  _.assert( this.is( triangle ) || triangle === null );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( triangle === null )
  return this.make();

  return triangle;
}

//

/**
  * Check if input is a triangle. Returns true if it is a triangle and false if not.
  *
  * @param { Vector } triangle - Source triangle.
  *
  * @example
  * // returns true;
  * _.is( [ 0, 0, 1, 1, 0, 0 ] );
  *
  * @returns { Boolean } Returns true if the input is triangle.
  * @function is
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @memberof module:Tools/math/Concepts.wTools.triangle
  */

function is( triangle )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  return ( _.longIs( triangle ) || _.vectorAdapterIs( triangle ) ) && ( triangle.length === 6 );
}

//

function pointContains( tri, point )
{
  _.assert( this.is( tri ) );
  _.assert( arguments.length === 2 );
  _.assert( point.length === 2, 'not implemented' );
  _.assert( this.dimGet( tri ) === 2, 'not implemented' );

  let triView = this.vectorAdapter.from( tri );

  let s1 = this.tools.line.pointsToPointSide( [ triView.eGet( 0 ), triView.eGet( 1 ) , triView.eGet( 2 ), triView.eGet( 3 ) ], point );

  let s2 = this.tools.line.pointsToPointSide( [ triView.eGet( 2 ), triView.eGet( 3 ), triView.eGet( 4 ), triView.eGet( 5 ) ], point );
  if( s1*s2 < 0 )
  return false;

  let s3 = this.tools.line.pointsToPointSide( [ triView.eGet( 4 ), triView.eGet( 5 ), triView.eGet( 0 ), triView.eGet( 1 ) ], point );
  if( s1*s3 < 0 )
  return false;

  return true;
}

//

/**
  * Get triangle dimension. Returns the dimension of the triangle. Triangle stays untouched.
  *
  * @param { Vector } triangle - The source triangle.
  *
  * @example
  * // returns 2
  * _.dimGet( [ 0, 0, 2, 2, 0, 0 ] );
  *
  * @returns { Number } Returns the dimension of the triangle.
  * @function dimGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( triangle ) is not triangle.
  * @memberof module:Tools/math/Concepts.wTools.triangle
  */
 function dimGet( triangle )
 {
   _.assert( arguments.length === 1, 'Expects single argument' );
   _.assert( this.is( triangle ) );
   return triangle.length / 3;
 }



// --
// declare
// --


let Extension = /* qqq xxx : normalize order */
{
  make,
  makeZero,

  from,

  is,
  dimGet,

  pointContains,

  // ref

  tools : _,
}

_.mapExtend( Self, Extension );

})();
