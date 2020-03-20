(function _LineImplicit_s_(){

'use strict';

let _ = _global_.wTools;
// let this.tools.avector = this.tools.avector;
// let vector = this.tools.vectorAdapter;
let Self = _.lineImplicit = _.lineImplicit || Object.create( _.avector );

/**
 * @description
 * For the following functions, implicit lines must have the shape [ A,B,C ],
 *
 * @namespace "wTools.lineImplicit"
 * @memberof module:Tools/math/Concepts
*/

// --
//
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
  let result = _.dup( 0, dim + 1 );
  return result;
}

//

function makeNil( dim )
{
  if( this.is( dim ) )
  dim = this.dimGet( dim );
  if( dim === undefined || dim === null )
  dim = 2;

  _.assert( dim >= 0 );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = [];
  for( let i = 0 ; i < dim ; i++ )
  result[ i ] = +Infinity;
  for( let i = 0 ; i < dim - 1 ; i++ )
  result[ dim+i ] = -Infinity;

  return result;
}

//

function zero( line )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( this.is( line ) )
  {
    let lineView = this.adapterFrom( line );
    lineView.assign( 0 );
    return line;
  }

  return this.makeZero( line );
}

//

function nil( line )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( this.is( line ) )
  {
    let lineView = this.adapterFrom( line );
    let min = this.originGet( lineView );
    let max = this.directionGet( lineView );

    this.tools.vectorAdapter.assign( min, +Infinity );
    this.tools.vectorAdapter.assign( max, -Infinity );

    return line;
  }

  return this.makeNil( line );
}

//

function from( line )
{

  _.assert( this.is( line ) || line === null );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( line === null )
  return this.make();

  return line;
}

//

function adapterFrom( line )
{
  if( !this.is( line ) )
  debugger;
  _.assert( this.is( line ) );
  _.assert( arguments.length === 1, 'Expects single argument' );
  return this.tools.vectorAdapter.from( line );
}

//

/**
  * Check if input is a line. Returns true if it is a line and false if not.
  *
  * @param { Vector } line - Source line.
  *
  * @example
  * // returns true;
  * _.is( [ 0, 0, 1, 1 ] );
  *
  * @returns { Boolean } Returns true if the input is line.
  * @function is
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @memberof module:Tools/math/Concepts.wTools.lineImplicit
  */
function is( line )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  return ( _.longIs( line ) || _.vectorAdapterIs( line ) ) && ( line.length === 3 );
}

//

function eqWithPoints( srcPoint1, srcPoint2 )
{
  _.assert( arguments.length === 2 );
  _.assert( srcPoint1.length === srcPoint2.length );
  _.assert( srcPoint1.length == 2 );

  let srcPoint1View = this.tools.vectorAdapter.from( srcPoint1 );
  let srcPoint2View = this.tools.vectorAdapter.from( srcPoint2 );

  let result = this.tools.vectorAdapter.make( 3 );

  result.eSet( 0, srcPoint1View.eGet( 1 ) - srcPoint2View.eGet( 1 ) )
  result.eSet( 1, srcPoint2View.eGet( 0 ) - srcPoint1View.eGet( 0 ) )
  result.eSet( 2, srcPoint2View.eGet( 1 ) * srcPoint1View.eGet( 0 ) - srcPoint2View.eGet( 0 ) * srcPoint1View.eGet( 1 ) )

  return result;
}

eqWithPoints.shaderChunk =
`
  vec3 lineImplicit_eqWithPoints( vec2 point1, vec2 point2 )
  {
    vec3 result;

    result[ 0 ] = point1[ 1 ] - point2[ 1 ];
    result[ 1 ] = point2[ 0 ] - point1[ 0 ];
    result[ 2 ] = point2[ 1 ] * point1[ 0 ] - point2[ 0 ] * point1[ 1 ];

    return result;
  }
`
eqWithPoints.shaderChunkName = 'lineImplicit_eqWithPoints';

// --
// chunks injection
// --

function injectChunks( routines )
{

  _global_.w4d = _global_.w4d || Object.create( null );
  let Chunks = w4d.Chunks = w4d.Chunks || Object.create( null );

  for( let r in routines )
  {
    let routine = routines[ r ];

    if( !_.routineIs( routine ) )
    continue;

    if( !routine.shaderChunk )
    continue;

    _.assert( _.strIs( routine.shaderChunk ) );

    let shaderChunk = '';
    shaderChunk += '\n' + routine.shaderChunk + '\n';

    let chunkName = routine.shaderChunkName || r;

    Chunks[ chunkName ] = shaderChunk;

  }

}

// --
// extension
// --

let Extension = /* qqq : normalize order */
{

  make,
  makeZero,
  makeNil,

  zero,
  nil,

  from,
  adapterFrom,

  is,

  eqWithPoints,

  // ref

  tools : _,

}

_.mapExtend( Self, Extension );
injectChunks( Extension );

})();
