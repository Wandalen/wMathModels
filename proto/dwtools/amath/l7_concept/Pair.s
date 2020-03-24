(function _Pair_s_(){

'use strict';

let _ = _global_.wTools;
// let this.tools.avector = this.tools.avector;
// let vector = this.tools.vectorAdapter;
let Self = _.pair = _.pair || Object.create( _.avector );

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
  let result = _.dup( 0, dim * 2 )
  return result;
}

//

function from( pair )
{

  _.assert( this.is( pair ) || pair === null );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( pair === null )
  return this.make();

  return pair;
}

//

/**
  * Check if input is a pair. Returns true if it is a pair and false if not.
  *
  * @param { Vector } pair - Source pair.
  *
  * @example
  * // returns true;
  * _.pair.is( [ [ 0, 0 ], [ 1, 1 ]  ] );
  * // returns false;
  * _.pair.is( [ 0,0 ] );
  *
  * @returns { Boolean } Returns true if the input is pair.
  * @function is
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @memberof module:Tools/math/Concepts.wTools.pair
  */

function is( pair )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  return ( _.longIs( pair ) || _.vectorAdapterIs( pair ) ) && ( pair.length % 2 === 0 ) && ( pair.length >= 4 );
}

//

/**
  * Get pair dimension. Returns the dimension of the pair. Pair stays untouched.
  *
  * @param { Vector } pair - The source pair.
  *
  * @example
  * // returns 2
  * _.dimGet( [ 0, 0, 0, 0 ] );
  *
  * @returns { Number } Returns the dimension of the pair.
  * @function dimGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( pair ) is not pair.
  * @memberof module:Tools/math/Concepts.wTools.pair
  */

function dimGet( pair )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( this.is( pair ) );
  return pair.length / 2;
}

//

function fromRay( dstPair, srcRay )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( arguments.length === 1 )
  {
    srcRay = arguments[ 0 ];
    dstPair = null;
  }

  if( dstPair === null )
  dstPair = this.make( srcRay.length / 2 )

  _.assert( this.is( dstPair ) );
  _.assert( srcRay.length === dstPair.length );

  let d = this.dimGet( dstPair );

  let srcRayP1View = this.tools.vectorAdapter.fromLongLrange( srcRay, 0, d );
  let srcRayP2View = this.tools.vectorAdapter.fromLongLrange( srcRay, d, d );

  let dstPair1View = this.tools.vectorAdapter.fromLongLrange( dstPair, 0, d );
  let dstPair2View = this.tools.vectorAdapter.fromLongLrange( dstPair, d, d );

  dstPair1View.assign( srcRayP1View );
  dstPair2View.assign( this.tools.vectorAdapter.add( null, srcRayP1View, srcRayP2View ) );

  return dstPair;
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

  fromRay,

  // ref

  tools : _,
}

_.mapExtend( Self, Extension );

})();
