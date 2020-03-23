( function _LineImplicit_test_s_( ) {

'use strict';

// return;

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );
  _.include( 'wMathVector' );
  _.include( 'wMathMatrix' );

  require( '../l8/Concepts.s' );

}

//

var _ = _global_.wTools.withDefaultLong.Fx;
var Matrix = _.Matrix;
var vector = _.vectorAdapter;
var vec = _.vectorAdapter.fromLong;
var avector = _.avector;
var sqrt = _.math.sqrt;
var Parent = wTester;

_.assert( _.routineIs( sqrt ) );

// --
// test
// --

function make( test )
{
  test.case = 'srcDim undefined'; /* */

  var srcDim = undefined;
  var gotLine = _.lineImplicit.make( srcDim );
  var expected = _.lineImplicit.tools.longMake( [ 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  test.case = 'srcDim null'; /* */

  var srcDim = null;
  var gotLine = _.lineImplicit.make( srcDim );
  var expected = _.lineImplicit.tools.longMake( [ 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  test.case = 'srcDim 2'; /* */

  var srcDim = 2;
  var gotLine = _.lineImplicit.make( srcDim );
  var expected = _.lineImplicit.tools.longMake( [ 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  test.case = 'srcDim array'; /* */

  var srcDim = [ 0, 1, 2 ];
  var gotLine = _.lineImplicit.make( srcDim );
  var expected = _.lineImplicit.tools.longMake( [ 0, 1, 2 ] );
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  test.case = 'srcDim vector'; /* */

  var srcDim = _.vectorAdapter.fromLong([ 0, 1, 2 ]);
  var gotLine = _.lineImplicit.make( srcDim );
  var expected = _.lineImplicit.tools.longMake( [ 0, 1, 2 ] );
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.lineImplicit.make( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.lineImplicit.make( 'line' ));
}

//

function makeZero( test )
{
  test.case = 'srcDim undefined'; /* */

  var srcDim = undefined;
  var gotLine = _.lineImplicit.makeZero( srcDim );
  var expected = _.lineImplicit.tools.longMake( [ 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  test.case = 'srcDim null'; /* */

  var srcDim = null;
  var gotLine = _.lineImplicit.makeZero( srcDim );
  var expected = _.lineImplicit.tools.longMake( [ 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  test.case = 'srcDim 2'; /* */

  var srcDim = 2;
  var gotLine = _.lineImplicit.makeZero( srcDim );
  var expected = _.lineImplicit.tools.longMake( [ 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  test.case = 'srcDim array'; /* */

  var srcDim = [ 0, 1, 2 ];
  var gotLine = _.lineImplicit.makeZero( srcDim );
  var expected = _.lineImplicit.tools.longMake( [ 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  test.case = 'srcDim vector'; /* */

  var srcDim = _.vectorAdapter.fromLong([ 0, 1, 2 ]);
  var gotLine = _.lineImplicit.makeZero( srcDim );
  var expected = _.lineImplicit.tools.longMake( [ 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.lineImplicit.makeZero( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.lineImplicit.makeZero( 'line' ));

}

//

function makeNil( test )
{
  test.case = 'srcDim undefined'; /* */

  var srcDim = undefined;
  var gotLine = _.lineImplicit.makeNil( srcDim );
  var expected = _.lineImplicit.tools.longMake( [ Infinity, Infinity, -Infinity ] );
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  test.case = 'srcDim null'; /* */

  var srcDim = null;
  var gotLine = _.lineImplicit.makeNil( srcDim );
  var expected = _.lineImplicit.tools.longMake( [ Infinity, Infinity, -Infinity ] );
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  test.case = 'srcDim 2'; /* */

  var srcDim = 2;
  var gotLine = _.lineImplicit.makeNil( srcDim );
  var expected = _.lineImplicit.tools.longMake( [ Infinity, Infinity, -Infinity ] );
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  test.case = 'srcDim array'; /* */

  var srcDim = [ 0, 1, 2 ];
  var gotLine = _.lineImplicit.makeNil( srcDim );
  var expected = _.lineImplicit.tools.longMake( [ Infinity, Infinity, -Infinity ] );
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  test.case = 'srcDim vector'; /* */

  var srcDim = _.vectorAdapter.fromLong([ 0, 1, 2 ]);
  var gotLine = _.lineImplicit.makeNil( srcDim );
  var expected = _.lineImplicit.tools.longMake( [ Infinity, Infinity, -Infinity ] );
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.lineImplicit.makeNil( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.lineImplicit.makeNil( 'line' ));
}

//

function zero( test )
{
  test.case = 'srcLine undefined'; /* */

  var srcLine = undefined;
  var gotLine = _.lineImplicit.zero( srcLine );
  var expected = _.lineImplicit.tools.longMake( [ 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.is( gotLine !== srcLine );

  test.case = 'srcLine null'; /* */

  var srcLine = null;
  var gotLine = _.lineImplicit.zero( srcLine );
  var expected = _.lineImplicit.tools.longMake( [ 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.is( gotLine !== srcLine );

  test.case = 'srcLine 2'; /* */

  var srcLine = 2;
  var gotLine = _.lineImplicit.zero( srcLine );
  var expected = _.lineImplicit.tools.longMake( [ 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.is( gotLine !== srcLine );

  test.case = 'srcLine array'; /* */

  var srcLine = [ 0, 1, 2 ];
  var gotLine = _.lineImplicit.zero( srcLine );
  var expected = _.lineImplicit.tools.longMake( [ 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.is( gotLine === srcLine );

  test.case = 'srcLine vector'; /* */

  var srcLine = _.vectorAdapter.fromLong( [ 0, 1, 2 ] );
  var gotLine = _.lineImplicit.zero( srcLine );
  var expected = _.lineImplicit.tools.vectorAdapter.fromLong( [ 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.is( gotLine === srcLine );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.lineImplicit.zero( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.lineImplicit.zero( 'line' ));

}

//

function nil( test )
{
  test.case = 'srcLine undefined'; /* */

  var srcLine = undefined;
  var gotLine = _.lineImplicit.nil( srcLine );
  var expected = _.lineImplicit.tools.longMake( [ Infinity, Infinity, - Infinity ] );
  test.identical( gotLine, expected );
  test.is( gotLine !== srcLine );

  test.case = 'srcLine null'; /* */

  var srcLine = null;
  var gotLine = _.lineImplicit.nil( srcLine );
  var expected = _.lineImplicit.tools.longMake( [ Infinity, Infinity, - Infinity ] );
  test.identical( gotLine, expected );
  test.is( gotLine !== srcLine );

  test.case = 'srcLine 2'; /* */

  var srcLine = 2;
  var gotLine = _.lineImplicit.nil( srcLine );
  var expected = _.lineImplicit.tools.longMake( [ Infinity, Infinity, - Infinity ] );
  test.identical( gotLine, expected );
  test.is( gotLine !== srcLine );

  test.case = 'srcLine array'; /* */

  var srcLine = [ 0, 1, 2 ];
  var gotLine = _.lineImplicit.nil( srcLine );
  var expected = _.lineImplicit.tools.longMake( [ Infinity, Infinity, - Infinity ] );
  test.identical( gotLine, expected );
  test.is( gotLine != srcLine );

  test.case = 'srcLine vector'; /* */

  var srcLine = _.vectorAdapter.fromLong( [ 0, 1, 2 ] );
  var gotLine = _.lineImplicit.nil( srcLine );
  var expected = _.lineImplicit.tools.longMake( [ Infinity, Infinity, - Infinity ] );
  test.identical( gotLine, expected );
  test.is( gotLine != srcLine );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.lineImplicit.nil( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.lineImplicit.nil( 'line' ));
}

//

function from( test )
{
  test.case = 'Same instance returned - array'; /* */

  var srcLine = [ 0, 0, 2, 2 ];
  var expected = _.lineImplicit.tools.longMake( [ 0, 0, 2, 2 ] );

  var gotLine = _.lineImplicit.from( srcLine );
  test.identical( gotLine, expected );
  test.is( srcLine === gotLine );

  test.case = 'Different instance returned - vector -> array'; /* */

  var srcLine = _.vectorAdapter.fromLong( [ 0, 0, 2, 2 ] );
  var expected = _.lineImplicit.tools.vectorAdapter.fromLong( [ 0, 0, 2, 2 ] );

  var gotLine = _.lineImplicit.from( srcLine );
  test.identical( gotLine, expected );
  test.is( srcLine === gotLine );

  test.case = 'Same instance returned - empty array'; /* */

  var srcLine = [];
  var expected = _.lineImplicit.tools.longMake( [] );

  var gotLine = _.lineImplicit.from( srcLine );
  test.identical( gotLine, expected );
  test.is( srcLine === gotLine );

  test.case = 'Different instance returned - null -> array'; /* */

  var srcLine = null;
  var expected = _.lineImplicit.tools.longMake( [ 0, 0, 0, 0, 0, 0 ] );

  var gotLine = _.lineImplicit.from( srcLine );
  test.identical( gotLine, expected );
  test.is( srcLine !== gotLine );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.lineImplicit.from( ));
  test.shouldThrowErrorSync( () => _.lineImplicit.from( [ 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.lineImplicit.from( [ 0, 0, 0, 0 ], [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.lineImplicit.from( 'line' ));
  test.shouldThrowErrorSync( () => _.lineImplicit.from( NaN ));
  test.shouldThrowErrorSync( () => _.lineImplicit.from( undefined ));
}

//

function adapterFrom( test )
{
  test.case = 'Same instance returned - vector'; /* */

  var srcLine = [ 0, 0, 2, 2 ];
  var expected = _.lineImplicit.tools.vectorAdapter.from( [ 0, 0, 2, 2 ] );

  var gotLine = _.lineImplicit.adapterFrom( srcLine );
  test.identical( gotLine, expected );
  test.is( srcLine !== gotLine );

  test.case = 'Different instance returned - vector -> vector'; /* */

  var srcLine = _.lineImplicit.tools.vectorAdapter.from( [ 0, 0, 2, 2 ] );
  var expected = _.lineImplicit.tools.vectorAdapter.from( [ 0, 0, 2, 2 ] );

  var gotLine = _.lineImplicit.adapterFrom( srcLine );
  test.identical( gotLine, expected );
  test.is( srcLine === gotLine );

  test.case = 'Same instance returned - empty vector'; /* */

  var srcLine = [];
  var expected =  _.lineImplicit.tools.vectorAdapter.from( [] );

  var gotLine = _.lineImplicit.adapterFrom( srcLine );
  test.identical( gotLine, expected );
  test.is( srcLine !== gotLine );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.lineImplicit.adapterFrom( ));
  test.shouldThrowErrorSync( () => _.lineImplicit.adapterFrom( [ 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.lineImplicit.adapterFrom( [ 0, 0, 0, 0 ], [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.lineImplicit.adapterFrom( 'line' ));
  test.shouldThrowErrorSync( () => _.lineImplicit.adapterFrom( NaN ));
  test.shouldThrowErrorSync( () => _.lineImplicit.adapterFrom( null ));
  test.shouldThrowErrorSync( () => _.lineImplicit.adapterFrom( undefined ));
}

//

function fromPair( test )
{
  test.case = 'Pair stay unchanged'; /* */

  var pair = [ [ 0, 1, 2 ], [ 0, 2, 4 ] ];
  var expected = _.lineImplicit.tools.vectorAdapter.make( [ 0, 1, 2, 0, 1, 2 ] );

  var gotLine = _.lineImplicit.fromPair( pair );
  test.identical( gotLine, expected );

  var oldPair = [ [ 0, 1, 2 ], [ 0, 2, 4 ] ];
  test.identical( pair, oldPair );

  test.case = 'Line starts in origin'; /* */

  var pair = [ [ 0, 0, 0 ], [ 0, 1, 2 ] ];
  var expected = _.lineImplicit.tools.vectorAdapter.make( [ 0, 0, 0, 0, 1, 2 ] );

  var gotLine = _.lineImplicit.fromPair( pair );
  test.identical( gotLine, expected );

  test.case = 'Line is point'; /* */

  var pair = [ [ 0, 1, 2 ], [ 0, 1, 2 ] ];
  var expected = _.lineImplicit.tools.vectorAdapter.make( [ 0, 1, 2, 0, 0, 0 ] );

  var gotLine = _.lineImplicit.fromPair( pair );
  test.identical( gotLine, expected );

  test.case = 'Line of 1 dimension'; /* */

  var pair = [ [ 3 ], [ 4 ] ];
  var expected = _.lineImplicit.tools.vectorAdapter.make( [ 3, 1 ] );

  var gotLine = _.lineImplicit.fromPair( pair );
  test.identical( gotLine, expected );

  test.case = 'Line goes up in y and down in z'; /* */

  var pair = [ [ 0, 1, 2 ], [ 0, 3, 1 ] ];
  var expected = _.lineImplicit.tools.vectorAdapter.make( [ 0, 1, 2, 0, 2, -1 ] );

  var gotLine = _.lineImplicit.fromPair( pair );
  test.identical( gotLine, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.lineImplicit.fromPair( ));
  test.shouldThrowErrorSync( () => _.lineImplicit.fromPair( null ));
  test.shouldThrowErrorSync( () => _.lineImplicit.fromPair( [ 2, 4 ], [ 3, 6 ] ));
  test.shouldThrowErrorSync( () => _.lineImplicit.fromPair( [ 2, 4 ], [ 3, 6, 2 ] ));
  test.shouldThrowErrorSync( () => _.lineImplicit.fromPair( [ [ 2, 4 ], [ 3, 6 ], [ 3, 6 ] ] ));
  test.shouldThrowErrorSync( () => _.lineImplicit.fromPair( undefined ));

}

//

function is( test )
{
  debugger;
  test.case = 'array'; /* */

  test.is( _.lineImplicit.is( [] ) );
  test.is( _.lineImplicit.is([ 0, 0 ]) );
  test.is( _.lineImplicit.is([ 1, 2, 3, 4 ]) );
  test.is( _.lineImplicit.is([ 0, 0, 0, 0, 0, 0 ]) );

  test.case = 'vector'; /* */

  test.is( _.lineImplicit.is( _.vectorAdapter.fromLong([]) ) );
  test.is( _.lineImplicit.is( _.vectorAdapter.fromLong([ 0, 0 ]) ) );
  test.is( _.lineImplicit.is( _.vectorAdapter.fromLong([ 1, 2, 3, 4 ]) ) );
  test.is( _.lineImplicit.is( _.vectorAdapter.fromLong([ 0, 0, 0, 0, 0, 0 ]) ) );

  test.case = 'not line'; /* */

  test.is( !_.lineImplicit.is([ 0 ]) );
  test.is( !_.lineImplicit.is([ 0, 0, 0 ]) );

  test.is( !_.lineImplicit.is( _.vectorAdapter.fromLong([ 0 ]) ) );
  test.is( !_.lineImplicit.is( _.vectorAdapter.fromLong([ 0, 0, 0 ]) ) );

  test.is( !_.lineImplicit.is( 'abc' ) );
  test.is( !_.lineImplicit.is( { origin : [ 0, 0, 0 ], direction : [ 1, 1, 1 ] } ) );
  test.is( !_.lineImplicit.is( function( a, b, c ){} ) );

  test.is( !_.lineImplicit.is( null ) );
  test.is( !_.lineImplicit.is( undefined ) );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.lineImplicit.is( ));
  test.shouldThrowErrorSync( () => _.lineImplicit.is( [ 0, 0 ], [ 1, 1 ] ));

}

//

function dimGet( test )
{
  test.case = 'srcLine 1D - array'; /* */

  var srcLine = [ 0, 1 ];
  var gotDim = _.lineImplicit.dimGet( srcLine );
  var expected = 1;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcLine );

  test.case = 'srcLine 1D - vector'; /* */

  var srcLine = _.vectorAdapter.fromLong( [ 0, 1 ] );
  var gotDim = _.lineImplicit.dimGet( srcLine );
  var expected = 1;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcLine );

  test.case = 'srcLine 2D - array'; /* */

  var srcLine = [ 0, 1, 2, 3 ];
  var gotDim = _.lineImplicit.dimGet( srcLine );
  var expected = 2;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcLine );

  test.case = 'srcLine 2D - vector'; /* */

  var srcLine = _.vectorAdapter.fromLong( [ 0, 1, 2, 3 ] );
  var gotDim = _.lineImplicit.dimGet( srcLine );
  var expected = 2;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcLine );

  test.case = 'srcLine 3D - array'; /* */

  var srcLine = [ 0, 1, 2, 3, 4, 5 ];
  var gotDim = _.lineImplicit.dimGet( srcLine );
  var expected = 3;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcLine );

  test.case = 'srcLine 3D - vector'; /* */

  var srcLine = _.vectorAdapter.fromLong( [ 0, 1, 2, 3, 4, 5 ] );
  var gotDim = _.lineImplicit.dimGet( srcLine );
  var expected = 3;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcLine );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.lineImplicit.dimGet( ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.dimGet( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.dimGet( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.dimGet( 'line' ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.dimGet( 0 ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.dimGet( null ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.dimGet( undefined ) );

}

//

function originGet( test )
{
  test.case = 'Source line remains unchanged'; /* */

  var srcLine = [ 0, 0, 1, 1 ];
  var expected = _.lineImplicit.tools.vectorAdapter.from( [ 0, 0 ] );

  var gotOrigin = _.lineImplicit.originGet( srcLine );
  test.identical( gotOrigin, expected );

  var oldSrcLine = [ 0, 0, 1, 1 ];
  test.equivalent( srcLine, oldSrcLine );

  test.case = 'srcLine 1D - array'; /* */

  var srcLine = [ 0, 1 ];
  var gotOrigin = _.lineImplicit.originGet( srcLine );
  var expected = _.lineImplicit.tools.vectorAdapter.from( [ 0 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcLine );

  test.case = 'srcLine 1D - vector'; /* */

  var srcLine = _.vectorAdapter.fromLong( [ 0, 1 ] );
  var gotOrigin = _.lineImplicit.originGet( srcLine );
  var expected = _.lineImplicit.tools.vectorAdapter.from( [ 0 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcLine );

  test.case = 'srcLine 2D - array'; /* */

  var srcLine = [ 0, 1, 2, 3 ];
  var gotOrigin = _.lineImplicit.originGet( srcLine );
  var expected = _.lineImplicit.tools.vectorAdapter.from( [ 0, 1 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcLine );

  test.case = 'srcLine 2D - vector'; /* */

  var srcLine = _.vectorAdapter.fromLong( [ 0, 1, 2, 3 ] );
  var gotOrigin = _.lineImplicit.originGet( srcLine );
  var expected = _.lineImplicit.tools.vectorAdapter.from( [ 0, 1 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcLine );

  test.case = 'srcLine 3D - array'; /* */

  var srcLine = [ 0, 1, 2, 3, 4, 5 ];
  var gotOrigin = _.lineImplicit.originGet( srcLine );
  var expected = _.lineImplicit.tools.vectorAdapter.from( [ 0, 1, 2 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcLine );

  test.case = 'srcLine 3D - vector'; /* */

  var srcLine = _.vectorAdapter.fromLong( [ 0, 1, 2, 3, 4, 5 ] );
  var gotOrigin = _.lineImplicit.originGet( srcLine );
  var expected = _.lineImplicit.tools.vectorAdapter.from( [ 0, 1, 2 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcLine );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.lineImplicit.originGet( ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.originGet( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.originGet( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.originGet( 'line' ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.originGet( 0 ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.originGet( null ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.originGet( undefined ) );

}

//

function directionGet( test )
{
  test.case = 'Source line remains unchanged'; /* */

  var srcLine = [ 0, 0, 1, 1 ];
  var expected = _.lineImplicit.tools.vectorAdapter.from( [ 1, 1 ] );

  var gotDirection = _.lineImplicit.directionGet( srcLine );
  test.identical( gotDirection, expected );

  var oldSrcLine = [ 0, 0, 1, 1 ];
  test.equivalent( srcLine, oldSrcLine );

  test.case = 'srcLine 1D - array'; /* */

  var srcLine = [ 0, 1 ];
  var gotDirection = _.lineImplicit.directionGet( srcLine );
  var expected = _.lineImplicit.tools.vectorAdapter.from( [ 1 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcLine );

  test.case = 'srcLine 1D - vector'; /* */

  var srcLine = _.vectorAdapter.fromLong( [ 0, 1 ] );
  var gotDirection = _.lineImplicit.directionGet( srcLine );
  var expected = _.lineImplicit.tools.vectorAdapter.from( [ 1 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcLine );

  test.case = 'srcLine 2D - array'; /* */

  var srcLine = [ 0, 1, 2, 3 ];
  var gotDirection = _.lineImplicit.directionGet( srcLine );
  var expected = _.lineImplicit.tools.vectorAdapter.from( [ 2, 3 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcLine );

  test.case = 'srcLine 2D - vector'; /* */

  var srcLine = _.vectorAdapter.fromLong( [ 0, 1, 2, 3 ] );
  var gotDirection = _.lineImplicit.directionGet( srcLine );
  var expected = _.lineImplicit.tools.vectorAdapter.from( [ 2, 3 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcLine );

  test.case = 'srcLine 3D - array'; /* */

  var srcLine = [ 0, 1, 2, 3, 4, 5 ];
  var gotDirection = _.lineImplicit.directionGet( srcLine );
  var expected = _.lineImplicit.tools.vectorAdapter.from( [ 3, 4, 5 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcLine );

  test.case = 'srcLine 3D - vector'; /* */

  var srcLine = _.vectorAdapter.fromLong( [ 0, 1, 2, 3, 4, 5 ] );
  var gotDirection = _.lineImplicit.directionGet( srcLine );
  var expected = _.lineImplicit.tools.vectorAdapter.from( [ 3, 4, 5 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcLine );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.lineImplicit.directionGet( ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.directionGet( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.directionGet( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.directionGet( 'line' ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.directionGet( 0 ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.directionGet( null ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.directionGet( undefined ) );

}

//

function lineAt( test )
{
  test.case = 'Source line and factor remain unchanged'; /* */

  var srcLine = [ 0, 0, 1, 1 ];
  var factor = 1;
  var expected = _.lineImplicit.tools.longMake( [ 1, 1 ] );

  var gotPoint = _.lineImplicit.lineAt( srcLine, factor );
  test.identical( gotPoint, expected );

  var oldSrcLine = [ 0, 0, 1, 1 ];
  test.equivalent( srcLine, oldSrcLine );

  var oldFactor = 1;
  test.equivalent( factor, oldFactor );

  test.case = 'Factor = null, return origin'; /* */

  var srcLine = [ 0, 0, 1, 1 ];
  var factor = 0;
  var expected = _.lineImplicit.tools.longMake( [ 0, 0 ] );

  var gotPoint = _.lineImplicit.lineAt( srcLine, factor );
  test.identical( gotPoint, expected );

  test.case = 'Factor = 0, return origin'; /* */

  var srcLine = [ 0, 0, 1, 1 ];
  var factor = 0;
  var expected = _.lineImplicit.tools.longMake( [ 0, 0 ] );

  var gotPoint = _.lineImplicit.lineAt( srcLine, factor );
  test.identical( gotPoint, expected );

  test.case = 'Factor = 1, return origin + direction'; /* */

  var srcLine = [ 0, 1, 1, 1 ];
  var factor = 1;
  var expected = _.lineImplicit.tools.longMake( [ 1, 2 ] );

  var gotPoint = _.lineImplicit.lineAt( srcLine, factor );
  test.identical( gotPoint, expected );

  test.case = '3D line'; /* */

  var srcLine = [ 0, 1, 2, 1, 1, 1 ];
  var factor = 1;
  var expected = _.lineImplicit.tools.longMake( [ 1, 2, 3 ] );

  var gotPoint = _.lineImplicit.lineAt( srcLine, factor );
  test.identical( gotPoint, expected );

  test.case = 'factor smaller than 1'; /* */

  var srcLine = [ 0, 1, 2, 2, 2, 2 ];
  var factor = 0.5;
  var expected = _.lineImplicit.tools.longMake( [ 1, 2, 3 ] );

  var gotPoint = _.lineImplicit.lineAt( srcLine, factor );
  test.identical( gotPoint, expected );

  test.case = 'factor bigger than one'; /* */

  var srcLine = [ 0, 1, 2, 1, 1, 1 ];
  var factor = 5;
  var expected = _.lineImplicit.tools.longMake( [ 5, 6, 7 ] );

  var gotPoint = _.lineImplicit.lineAt( srcLine, factor );
  test.identical( gotPoint, expected );

  test.case = 'Negative factor'; /* */

  var srcLine = [ 0, 1, 2, 1, 1, 1 ];
  var factor = - 5;
  var expected = _.lineImplicit.tools.longMake( [ - 5, - 4, - 3 ] );

  var gotPoint = _.lineImplicit.lineAt( srcLine, factor );
  test.identical( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.lineImplicit.lineAt( ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.lineAt( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.lineAt( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.lineAt( 'line', 1 ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.lineAt( [ 0, 0 ], 'factor') );
  test.shouldThrowErrorSync( () => _.lineImplicit.lineAt( 0 ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.lineAt( null, 1 ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.lineAt( undefined, 1 ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.lineAt( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.lineAt( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function getFactor( test )
{

  test.case = 'Line and Point remain unchanged'; /* */

  var line = [  - 1, - 1 , 1, 1 ];
  var point = [ 0, 0 ];
  var expected = 1;

  var gotFactor = _.lineImplicit.getFactor( line, point );
  test.identical( gotFactor, expected );

  var oldLine = [  - 1, - 1 , 1, 1 ];
  test.identical( line, oldLine );

  var oldPoint = [ 0, 0 ];
  test.identical( point, oldPoint );

  test.case = 'Null line contains empty point'; /* */

  var line = null;
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotFactor = _.lineImplicit.getFactor( line, point );
  test.identical( gotFactor, expected );

  test.case = 'Point line contains Point'; /* */

  var line = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotFactor = _.lineImplicit.getFactor( line, point );
  test.identical( gotFactor, expected );

  test.case = 'Factor smaller than one'; /* */

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var point = [  1, 1, 1 ];
  var expected = 0.5;

  var gotFactor = _.lineImplicit.getFactor( line, point );
  test.identical( gotFactor, expected );

  test.case = 'Factor bigger than one'; /* */

  var line = [ 0, 0, 0, 1, 1, 1 ];
  var point = [  6, 6, 6 ];
  var expected = 6;

  var gotFactor = _.lineImplicit.getFactor( line, point );
  test.identical( gotFactor, expected );

  test.case = 'Negative factor'; /* */

  var line = [ 0, 0, 0, 1, 1, 1 ];
  var point = [  - 6, - 6, - 6 ];
  var expected = - 6;

  var gotFactor = _.lineImplicit.getFactor( line, point );
  test.identical( gotFactor, expected );


  test.case = 'Direction with different values'; /* */

  var line = [ 0, 0, 0, 1, 2, 3 ];
  var point = [  6, 12, 18 ];
  var expected = 6;

  var gotFactor = _.lineImplicit.getFactor( line, point );
  test.identical( gotFactor, expected );

  test.case = 'Direction with different values ( one of them 0 )'; /* */

  var line = [ 0, 0, 0, 1, 2, 0 ];
  var point = [  6, 12, 0 ];
  var expected = 6;

  var gotFactor = _.lineImplicit.getFactor( line, point );
  test.identical( gotFactor, expected );

  test.case = 'Direction with different values ( one of them 0 )'; /* */

  var line = [ 0, 0, 0, 0, 2, 3 ];
  var point = [  0, 12, 18 ];
  var expected = 6;

  var gotFactor = _.lineImplicit.getFactor( line, point );
  test.identical( gotFactor, expected );

  test.case = 'Direction with different values ( one of them 0 )'; /* */

  var line = [ 0, 0, 0, 1, 2, 0 ];
  var point = [  6, 12, 18];
  var expected = false;

  var gotFactor = _.lineImplicit.getFactor( line, point );
  test.identical( gotFactor, expected );

  test.case = 'Line under point'; /* */

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ 1, 1, 3 ];
  var expected = false;

  var gotFactor = _.lineImplicit.getFactor( line, point );
  test.identical( gotFactor, expected );

  test.case = 'Line ( normalized to 1 )'; /* */

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var point = [ 0.500, 0.500, 0.000 ];
  var expected = 1/ Math.sqrt( 2 );

  var gotFactor = _.lineImplicit.getFactor( line, point );
  test.equivalent( gotFactor, expected );

  test.case = 'Line of four dimensions'; /* */

  var line = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0, 0 ];
  var expected = 1;

  var gotFactor = _.lineImplicit.getFactor( line, point );
  test.identical( gotFactor, expected );

  test.case = 'Line of 7 dimensions'; /* */

  var line = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 1, 1, 1, 1, 1, 1, 1 ];
  var point = [ - 1, -1, -1, -1, -1, -1, -1 ];
  var expected = 1;

  var gotFactor = _.lineImplicit.getFactor( line, point );
  test.identical( gotFactor, expected );

  test.case = 'Line of 1 dimension contains point'; /* */

  var line = [ 0, 2 ];
  var point = [ 1 ];
  var expected = 0.5;

  var gotFactor = _.lineImplicit.getFactor( line, point );
  test.identical( gotFactor, expected );

  test.case = 'Line of 1 dimension always contains point '; /* */

  var line = [ 0, 2 ];
  var point = [ - 3 ];
  var expected = - 1.5;

  var gotFactor = _.lineImplicit.getFactor( line, point );
  test.identical( gotFactor, expected );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.lineImplicit.getFactor( ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.getFactor( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.getFactor( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.getFactor( [ 1, 1, 2, 2 ], 'factor') );
  test.shouldThrowErrorSync( () => _.lineImplicit.getFactor( 0 ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.getFactor( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.getFactor( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.getFactor( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.getFactor( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.lineImplicit.getFactor( [ 1, 1, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function eqWithPoints( test )
{
  var srcPoint1 = [ 0,0 ];
  var srcPoint2 = [ 0,0 ];
  var expected = _.lineImplicit.tools.vectorAdapter.from( [ 0, 0, 0 ] );
  var got = _.lineImplicit.eqWithPoints( srcPoint1, srcPoint2 );
  test.identical( got, expected );

  var srcPoint1 = [ 0,0 ];
  var srcPoint2 = [ 1,1 ];
  var expected = _.lineImplicit.tools.vectorAdapter.from( [ -1, 1, 0 ] );
  var got = _.lineImplicit.eqWithPoints( srcPoint1, srcPoint2 );
  test.identical( got, expected );

  var srcPoint1 = [ 1,1 ];
  var srcPoint2 = [ 0,0 ];
  var expected = _.lineImplicit.tools.vectorAdapter.from( [ -1, 0, 0 ] );
  var got = _.lineImplicit.eqWithPoints( srcPoint1, srcPoint2 );
  test.identical( got, expected );

  var srcPoint1 = [ 1,1 ];
  var srcPoint2 = [ 3,3 ];
  var expected = _.lineImplicit.tools.vectorAdapter.from( [ -2, 2, 0 ] );
  var got = _.lineImplicit.eqWithPoints( srcPoint1, srcPoint2 );
  test.identical( got, expected );

  var srcPoint1 = [ -1,-1 ];
  var srcPoint2 = [ 1,1 ];
  var expected = _.lineImplicit.tools.vectorAdapter.from( [ -2, 2, 0 ] );
  var got = _.lineImplicit.eqWithPoints( srcPoint1, srcPoint2 );
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'wrong number of arguments'
  test.shouldThrowErrorSync( () => _.lineImplicit.eqWithPoints( [] ) );
  test.case = 'wrong number of elements in src array'
  test.shouldThrowErrorSync( () => _.lineImplicit.eqWithPoints( [ 1 ], [ 1, 1 ] ) );
}

//

function eqWithPointAndTangent( test ) //qqq:cover with tests
{
  var srcPoint = [ 0,0 ];
  var srcTangent = [ 0,0 ];
  var expected = _.lineImplicit.tools.vectorAdapter.from( [ 0, 0, 0 ] );
  var got = _.lineImplicit.eqWithPointAndTangent( srcPoint, srcTangent );
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'wrong number of arguments'
  test.shouldThrowErrorSync( () => _.lineImplicit.eqWithPointAndTangent( [] ) );
  test.case = 'wrong number of elements in src array'
  test.shouldThrowErrorSync( () => _.lineImplicit.eqWithPointAndTangent( [ 1 ], [ 1, 1 ] ) );
}

//

function lineIntersection( test ) //qqq:cover with tests
{
  var srcLine1 = [ 0,0,0 ];
  var srcLine2 = [ 0,0,0 ];
  var expected = _.lineImplicit.tools.vectorAdapter.from( [ NaN, NaN ] );
  var got = _.lineImplicit.lineIntersection( srcLine1, srcLine2 );
  test.identical( got, expected );

  test.case = 'Lines are parallel ( different origin - same direction )'; /* */

  var src1Line = [ 0, 1, 0 ]; //0, 0, 1, 0
  var src2Line = [ 0, 1, -1 ];//0, 1, 1, 1
  var expected = _.lineImplicit.tools.vectorAdapter.from( [ NaN, NaN ] );
  var got = _.lineImplicit.lineIntersection( src1Line, src2Line );
  test.identical( got, expected );

  test.case = 'Lines intersect in origin'; /* */

  var src1Line = [ 7, -2, -7 ]; //3, 7, 1, 0
  var src2Line = [ 6, -2, 2 ];//3, 7, 0, 1
  var expected = _.lineImplicit.tools.vectorAdapter.from( [ 9, 28 ] );
  var got = _.lineImplicit.lineIntersection( src1Line, src2Line );
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'wrong number of arguments'
  test.shouldThrowErrorSync( () => _.lineImplicit.lineIntersection( [] ) );
  test.case = 'wrong number of elements in src array'
  test.shouldThrowErrorSync( () => _.lineImplicit.lineIntersection( [ 1 ], [ 1, 1 ] ) );
}

//

function pointDistance( test ) //qqq:cover with tests
{
  var srcLine = [ 0,0,0 ];
  var point = [ 0,0 ];
  var expected = 0;
  var got = _.lineImplicit.pointDistance( srcLine, point );
  test.identical( got, expected );

  var srcLine = [ 0,0,0 ];
  var point = [ 1,1 ];
  var expected = 1;
  var got = _.lineImplicit.pointDistance( srcLine, point );
  test.identical( got, expected );

  var srcLine = [ -1,3,-3 ];//0,1, 3,2
  var point = [ 3,2 ];
  var expected = 0;
  var got = _.lineImplicit.pointDistance( srcLine, point );
  test.identical( got, expected );

  var srcLine = [ -1,3,-3 ];//0,1, 3,2
  var point = [ 0,1 ];
  var expected = 0;
  var got = _.lineImplicit.pointDistance( srcLine, point );
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'wrong number of arguments'
  test.shouldThrowErrorSync( () => _.lineImplicit.pointDistance( [] ) );
  test.case = 'wrong number of elements in src array'
  test.shouldThrowErrorSync( () => _.lineImplicit.pointDistance( [ 1,1 ], [ 1, 1 ] ) );
}

// --
// define class
// --

var Self =
{

  name : 'Tools.Math.LineImplicit',
  silencing : 1,

  tests :
  {
    make,
    makeZero,
    makeNil,

    zero,
    nil,

    // from,
    // adapterFrom,
    // fromPair,

    // is,
    // dimGet,
    // originGet,
    // directionGet,

    // lineAt,
    // getFactor,

    eqWithPoints,
    eqWithPointAndTangent,

    lineIntersection,

    pointDistance
  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
