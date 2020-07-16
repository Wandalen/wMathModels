(function _LineImplicit_s_(){

'use strict';

let _ = _global_.wTools;
// let this.tools.avector = this.tools.avector;
// let vector = this.tools.vectorAdapter;
let Self = _.lineImplicit = _.lineImplicit || Object.create( _.avector );

/**
 * @description
 * A implicit line is a straight line defined by a linear equation whose general form is w + a * x + b * y = 0,
 * where a, b are not both 0.
 * For the following functions, implicit line must be represented by shape [ w,a,b ]
 * @namespace wTools.lineImplicit
  * @module Tools/math/Concepts
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

function makeSingular( dim )
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
  //qqq
  // if( this.is( line ) )
  // {
  //   let lineView = this.adapterFrom( line );
  //   let min = this.originGet( lineView );
  //   let max = this.directionGet( lineView );

  //   this.tools.vectorAdapter.assign( min, +Infinity );
  //   this.tools.vectorAdapter.assign( max, -Infinity );

  //   return line;
  // }

  return this.makeSingular( line );
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
  * Returns implicit representation of a line based on two points.
  * The pair of points stays untouched.
  *
  * @param { Array } pair - The source points.
  *
  * @example
  * // returns   this.tools.vectorAdapter.from( [ 1, 2, 1, 2 ] )
  * _.lineImplicit.fromPair( [ 1, 2 ], [ 3, 4 ] );
  *
  * @returns { Vector } Returns the line containing the two points.
  * @function fromPair
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( pair ) is not array.
  * @namespace wTools.lineImplicit
  * @module Tools/math/Concepts
  */

 function fromPair( pair )
 {
   _.assert( arguments.length === 1, 'Expects single argument' );
   _.assert( pair.length === 2, 'Expects two points' );
   _.assert( pair[ 0 ].length === pair[ 1 ].length, 'Expects two points' );

   return this.eqWithPoints( pair[ 0 ], pair[ 1 ] );
 }

//

/**
  * Check if input is a implicit representation of a straight line. Returns true or false.
  *
  * @param { Vector } line - Source line.
  *
  * @example
  * // returns true;
  * _.lineImplicit.is( [ 1,1,0 ] );
  *
  * @returns { Boolean } Returns true if the input is a implicit representation of a straight line.
  * @function is
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @namespace wTools.lineImplicit
  * @module Tools/math/Concepts
  */
function is( line )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  return ( _.longIs( line ) || _.vectorAdapterIs( line ) ) && ( !line.length || line.length >= 3 );
}

//

/**
  * Get line dimension. Returns the dimension of the line. Line stays untouched.
  *
  * @param { Vector } line - The source line.
  *
  * @example
  * // returns 2
  * _.dimGet( [ 1, 1, 0 ] );
  *
  * @returns { Number } Returns the dimension of the line.
  * @function dimGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( line ) is not line.
  * @namespace wTools.lineImplicit
  * @module Tools/math/Concepts
  */
 function dimGet( line )
 {
   _.assert( arguments.length === 1, 'Expects single argument' );
   _.assert( this.is( line ) );
   return line.length - 1;
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

  //(𝑦𝐴−𝑦𝐵)𝑥 − (𝑥𝐴−𝑥𝐵)𝑦 + 𝑥𝐴𝑦𝐵 − 𝑥𝐵𝑦𝐴 = 0

  result.eSet( 0, srcPoint2View.eGet( 1 ) * srcPoint1View.eGet( 0 ) - srcPoint2View.eGet( 0 ) * srcPoint1View.eGet( 1 ) )
  result.eSet( 1, srcPoint1View.eGet( 1 ) - srcPoint2View.eGet( 1 ) )
  result.eSet( 2, srcPoint2View.eGet( 0 ) - srcPoint1View.eGet( 0 ) )

  return result;
}

eqWithPoints.shaderChunk =
`
  vec3 lineImplicit_eqWithPoints( vec2 point1, vec2 point2 )
  {
    vec3 result;

    result[ 0 ] = point2[ 1 ] * point1[ 0 ] - point2[ 0 ] * point1[ 1 ];
    result[ 1 ] = point1[ 1 ] - point2[ 1 ];
    result[ 2 ] = point2[ 0 ] - point1[ 0 ];

    return result;
  }
`
eqWithPoints.shaderChunkName = 'lineImplicit_eqWithPoints';

//

function eqWithPointAndTangent( srcPoint, tangent )
{
  _.assert( arguments.length === 2 );
  _.assert( srcPoint.length === tangent.length );
  _.assert( srcPoint.length === 2 );

  let srcPointView = this.tools.vectorAdapter.from( srcPoint );
  let tangentView = this.tools.vectorAdapter.from( tangent );

  let result = this.tools.vectorAdapter.make( 3 );

  result.eSet( 1, - tangentView.eGet( 1 ) );
  result.eSet( 2, + tangentView.eGet( 0 ) );
  result.eSet( 0, ( srcPointView.eGet( 1 ) + tangentView.eGet( 1 ) ) * srcPointView.eGet( 0 ) );
  result.eSet( 0, result.eGet( 0 ) - ( srcPointView.eGet( 0 ) + tangentView.eGet( 0 ) ) * srcPointView.eGet( 1 ) )

  // result[ 0 ] = - tangent[ 1 ];
  // result[ 1 ] = + tangent[ 0 ];
  // result[ 2 ] = ( point[ 1 ]+tangent[ 1 ] ) * point[ 0 ] - ( point[ 0 ]+tangent[ 0 ] ) * point[ 1 ];

  return result;
}

eqWithPointAndTangent.shaderChunk =
`
  vec3 lineImplicit_eqWithPointAndTangent( vec2 point, vec2 tangent )
  {
    vec3 result;

    result[ 1 ] = - tangent[ 1 ];
    result[ 2 ] = + tangent[ 0 ];
    result[ 0 ] = ( point[ 1 ]+tangent[ 1 ] ) * point[ 0 ] - ( point[ 0 ]+tangent[ 0 ] ) * point[ 1 ];

    return result;
  }
`
eqWithPointAndTangent.shaderChunkName = 'lineImplicit_eqWithPointAndTangent';

//

function lineIntersection( lineImplicit1, lineImplicit2 )
{
  _.assert( arguments.length === 2 );
  _.assert( this.is( lineImplicit1 ) );
  _.assert( this.is( lineImplicit2 ) );
  _.assert( lineImplicit1.length === lineImplicit1.length );
  _.assert( lineImplicit1.length === 3, 'not implemented' );

  let line1View = this.adapterFrom( lineImplicit1.slice() );
  let line2View = this.adapterFrom( lineImplicit2.slice() );

  let result = this.tools.vectorAdapter.make( lineImplicit1.length - 1 );

  let d = line1View.eGet( 1 )*line2View.eGet( 2 ) - line1View.eGet( 2 )*line2View.eGet( 1 );
  let x = line1View.eGet( 2 )*line2View.eGet( 0 ) - line1View.eGet( 0 )*line2View.eGet( 2 );
  let y = line1View.eGet( 0 )*line2View.eGet( 1 ) - line1View.eGet( 1 )*line2View.eGet( 0 );

  // let d = lineGeneralEq1[ 0 ]*lineGeneralEq2[ 1 ] - lineGeneralEq1[ 1 ]*lineGeneralEq2[ 0 ];
  // let x = lineGeneralEq1[ 1 ]*lineGeneralEq2[ 2 ] - lineGeneralEq1[ 2 ]*lineGeneralEq2[ 1 ];
  // let y = lineGeneralEq1[ 2 ]*lineGeneralEq2[ 0 ] - lineGeneralEq1[ 0 ]*lineGeneralEq2[ 2 ];

  result.eSet( 0, x / d );
  result.eSet( 1, y / d );

  return result;
}

lineIntersection.shaderChunk =

`
  vec2 lineImplicit_lineIntersection( vec3 lineGeneralEq1, vec3 lineGeneralEq2 )
  {
    vec2 result;

    float d = lineGeneralEq1[ 1 ]*lineGeneralEq2[ 2 ] - lineGeneralEq1[ 2 ]*lineGeneralEq2[ 1 ];
    float x = lineGeneralEq1[ 2 ]*lineGeneralEq2[ 0 ] - lineGeneralEq1[ 0 ]*lineGeneralEq2[ 2 ];
    float y = lineGeneralEq1[ 0 ]*lineGeneralEq2[ 1 ] - lineGeneralEq1[ 1 ]*lineGeneralEq2[ 0 ];

    result[ 0 ] = x / d;
    result[ 1 ] = y / d;

    return result;
  }
`
lineIntersection.shaderChunkName = 'lineImplicit_lineIntersection'

//

function pointDistance( lineImplicit, point )
{
  _.assert( arguments.length === 2 );

  if( lineImplicit === null )
  lineImplicit = this.make( point.length );

  _.assert( this.is( lineImplicit ) );
  _.assert( lineImplicit.length === 3, 'not implemented' );
  _.assert( point.length === 2, 'not implemented' );

  let lineView = this.adapterFrom( lineImplicit.slice() );
  let pointView = this.tools.vectorAdapter.from( point );

  let n = this.tools.vectorAdapter.from( [ lineView.eGet( 1 ), lineView.eGet( 2 ) ] );
  let d = Math.sqrt( lineView.eGet( 1 )*lineView.eGet( 1 ) + lineView.eGet( 2 )*lineView.eGet( 2 ));

  let result = ( lineView.eGet( 0 ) + this.tools.vectorAdapter.dot( n, pointView ) ) / d;

  // let n = [ lineGeneralEq[ 0 ], lineGeneralEq[ 1 ] ];
  // let d = _sqrt( lineGeneralEq[ 0 ]*lineGeneralEq[ 0 ] + lineGeneralEq[ 1 ]*lineGeneralEq[ 1 ] );

  // let result = ( lineGeneralEq[ 2 ] + _.avector.dot( n, point ) ) / d;

  return result;
}

// --
// chunks injection
// --

function injectChunks( routines )
{

  _global_.SRT = _global_.SRT || Object.create( null );
  _global_.SRT.gl = _global_.SRT.gl || Object.create( null );
  let Chunks = SRT.gl.Chunks = SRT.gl.Chunks || Object.create( null );

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
  makeSingular,

  zero,
  nil,

  from,
  adapterFrom,

  fromPair,

  is,

  dimGet,

  eqWithPoints,
  eqWithPointAndTangent,

  lineIntersection,

  pointDistance,

  // ref

  tools : _,

}

_.mapExtend( Self, Extension );
injectChunks( Extension );

})();
