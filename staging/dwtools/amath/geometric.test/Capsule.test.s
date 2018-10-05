( function _Capsule_test_s_( ) {

'use strict';

// return;

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      toolsPath = require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }


  var _ = _global_.wTools;

  _.include( 'wTesting' );
  _.include( 'wMathVector' );
  _.include( 'wMathSpace' );

  require( '../geometric/aConcepts.s' );

}

//

var _ = _global_.wTools.withArray.Float32;
var Space = _.Space;
var vector = _.vector;
var vec = _.vector.fromArray;
var avector = _.avector;
var sqrt = _.sqrt;
var Parent = _.Tester;

_.assert( _.routineIs( sqrt ) );

// --
// test
// --

function make( test )
{
  test.case = 'Default'; /* */

  var gotCapsule = _.capsule.make();
  var expected = [ 0, 0, 0, 0, 0, 0, 0 ];
  test.identical( gotCapsule, expected );

  test.case = 'srcDim undefined'; /* */

  var srcDim = undefined;
  var gotCapsule = _.capsule.make( srcDim );
  var expected = [ 0, 0, 0, 0, 0, 0, 0 ];
  test.identical( gotCapsule, expected );
  test.is( gotCapsule !== srcDim );

  test.case = 'srcDim null'; /* */

  var srcDim = null;
  var gotCapsule = _.capsule.make( srcDim );
  var expected = [ 0, 0, 0, 0, 0, 0, 0 ];
  test.identical( gotCapsule, expected );
  test.is( gotCapsule !== srcDim );

  test.case = 'srcDim 2'; /* */

  var srcDim = 2;
  var gotCapsule = _.capsule.make( srcDim );
  var expected = [ 0, 0, 0, 0, 0 ];
  test.identical( gotCapsule, expected );
  test.is( gotCapsule !== srcDim );

  test.case = 'srcDim array'; /* */

  var srcDim = [ 0, 1, 2, 3, 4 ];
  var gotCapsule = _.capsule.make( srcDim );
  var expected = [ 0, 1, 2, 3, 4 ];
  test.identical( gotCapsule, expected );
  test.is( gotCapsule !== srcDim );

  test.case = 'srcDim vector'; /* */

  var srcDim = _.vector.fromArray( [ 0, 1, 2, 3, 4 ] );
  var gotCapsule = _.capsule.make( srcDim );
  var expected = [ 0, 1, 2, 3, 4 ];
  test.identical( gotCapsule, expected );
  test.is( gotCapsule !== srcDim );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.capsule.make( [ 0, 0, 0 ], [ 1, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.capsule.make( [ 0, 0, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.capsule.make( 'capsule' ));
}

//

function makeZero( test )
{
  test.case = 'Default'; /* */

  var gotCapsule = _.capsule.makeZero();
  var expected = [ 0, 0, 0, 0, 0, 0, 0 ];
  test.identical( gotCapsule, expected );

  test.case = 'srcDim undefined'; /* */

  var srcDim = undefined;
  var gotCapsule = _.capsule.makeZero( srcDim );
  var expected = [ 0, 0, 0, 0, 0, 0, 0 ];
  test.identical( gotCapsule, expected );
  test.is( gotCapsule !== srcDim );

  test.case = 'srcDim null'; /* */

  var srcDim = null;
  var gotCapsule = _.capsule.makeZero( srcDim );
  var expected = [ 0, 0, 0, 0, 0, 0, 0 ];
  test.identical( gotCapsule, expected );
  test.is( gotCapsule !== srcDim );

  test.case = 'srcDim 2'; /* */

  var srcDim = 2;
  var gotCapsule = _.capsule.makeZero( srcDim );
  var expected = [ 0, 0, 0, 0, 0 ];
  test.identical( gotCapsule, expected );
  test.is( gotCapsule !== srcDim );

  test.case = 'srcDim array'; /* */

  var srcDim = [ 0, 1, 2, 3, 4 ];
  var gotCapsule = _.capsule.makeZero( srcDim );
  var expected = [ 0, 0, 0, 0, 0 ];
  test.identical( gotCapsule, expected );
  test.is( gotCapsule !== srcDim );

  test.case = 'srcDim vector'; /* */

  var srcDim = _.vector.fromArray( [ 0, 1, 2, 3, 4 ] );
  var gotCapsule = _.capsule.makeZero( srcDim );
  var expected = [ 0, 0, 0, 0, 0 ];
  test.identical( gotCapsule, expected );
  test.is( gotCapsule !== srcDim );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.capsule.makeZero( [ 0, 0, 0 ], [ 1, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.capsule.makeZero( [ 0, 0, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.capsule.makeZero( 'capsule' ));

}

//

function makeNil( test )
{
  test.case = 'Default'; /* */

  var gotCapsule = _.capsule.makeNil();
  var expected = [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotCapsule, expected );

  test.case = 'srcDim undefined'; /* */

  var srcDim = undefined;
  var gotCapsule = _.capsule.makeNil( srcDim );
  var expected = [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotCapsule, expected );
  test.is( gotCapsule !== srcDim );

  test.case = 'srcDim null'; /* */

  var srcDim = null;
  var gotCapsule = _.capsule.makeNil( srcDim );
  var expected = [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotCapsule, expected );
  test.is( gotCapsule !== srcDim );

  test.case = 'srcDim 2'; /* */

  var srcDim = 2;
  var gotCapsule = _.capsule.makeNil( srcDim );
  var expected = [ Infinity, Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotCapsule, expected );
  test.is( gotCapsule !== srcDim );

  test.case = 'srcDim array'; /* */

  var srcDim = [ 0, 1, 2, 3, 4 ];
  var gotCapsule = _.capsule.makeNil( srcDim );
  var expected = [ Infinity, Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotCapsule, expected );
  test.is( gotCapsule !== srcDim );

  test.case = 'srcDim vector'; /* */

  var srcDim = _.vector.fromArray( [ 0, 1, 2, 3, 4 ] );
  var gotCapsule = _.capsule.makeNil( srcDim );
  var expected = [ Infinity, Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotCapsule, expected );
  test.is( gotCapsule !== srcDim );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.capsule.makeNil( [ 0, 0, 0 ], [ 1, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.capsule.makeNil( [ 0, 0, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.capsule.makeNil( 'capsule' ));
}

//

function zero( test )
{
  test.case = 'Default'; /* */

  var gotCapsule = _.capsule.zero();
  var expected = [ 0, 0, 0, 0, 0, 0, 0 ];
  test.identical( gotCapsule, expected );

  test.case = 'srcCapsule undefined'; /* */

  var srcCapsule = undefined;
  var gotCapsule = _.capsule.zero( srcCapsule );
  var expected = [ 0, 0, 0, 0, 0, 0, 0 ];
  test.identical( gotCapsule, expected );
  test.is( gotCapsule !== srcCapsule );

  test.case = 'srcCapsule null'; /* */

  var srcCapsule = null;
  var gotCapsule = _.capsule.zero( srcCapsule );
  var expected = [ 0, 0, 0, 0, 0, 0, 0 ];
  test.identical( gotCapsule, expected );
  test.is( gotCapsule !== srcCapsule );

  test.case = 'srcCapsule 2'; /* */

  var srcCapsule = 2;
  var gotCapsule = _.capsule.zero( srcCapsule );
  var expected = [ 0, 0, 0, 0, 0 ];
  test.identical( gotCapsule, expected );
  test.is( gotCapsule !== srcCapsule );

  test.case = 'srcCapsule array'; /* */

  var srcCapsule = [ 0, 1, 2, 3, 4 ];
  var gotCapsule = _.capsule.zero( srcCapsule );
  var expected = [ 0, 0, 0, 0, 0 ];
  test.identical( gotCapsule, expected );
  test.is( gotCapsule === srcCapsule );

  test.case = 'srcCapsule vector'; /* */

  var srcCapsule = _.vector.fromArray( [ 0, 1, 2, 3, 4 ] );
  var gotCapsule = _.capsule.zero( srcCapsule );
  var expected =  _.vector.fromArray( [ 0, 0, 0, 0, 0 ] );
  test.identical( gotCapsule, expected );
  test.is( gotCapsule === srcCapsule );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.capsule.zero( [ 0, 0, 1 ], [ 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.capsule.zero( [ 0, 0, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.capsule.zero( 'capsule' ));

}

//

function nil( test )
{
  test.case = 'Default'; /* */

  var gotCapsule = _.capsule.nil();
  var expected = [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotCapsule, expected );

  test.case = 'srcCapsule undefined'; /* */

  var srcCapsule = undefined;
  var gotCapsule = _.capsule.nil( srcCapsule );
  var expected = [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotCapsule, expected );
  test.is( gotCapsule !== srcCapsule );

  test.case = 'srcCapsule null'; /* */

  var srcCapsule = null;
  var gotCapsule = _.capsule.nil( srcCapsule );
  var expected = [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotCapsule, expected );
  test.is( gotCapsule !== srcCapsule );

  test.case = 'srcCapsule 2'; /* */

  var srcCapsule = 2;
  var gotCapsule = _.capsule.nil( srcCapsule );
  var expected = [ Infinity, Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotCapsule, expected );
  test.is( gotCapsule !== srcCapsule );

  test.case = 'srcCapsule array'; /* */

  var srcCapsule = [ 0, 1, 2, 3, 4 ];
  var gotCapsule = _.capsule.nil( srcCapsule );
  var expected = [ Infinity, Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotCapsule, expected );
  test.is( gotCapsule === srcCapsule );

  test.case = 'srcCapsule vector'; /* */

  var srcCapsule = _.vector.fromArray( [ 0, 1, 2, 3, 4 ] );
  var gotCapsule = _.capsule.nil( srcCapsule );
  var expected = _.vector.fromArray( [ Infinity, Infinity, - Infinity, - Infinity, - Infinity ] );
  test.identical( gotCapsule, expected );
  test.is( gotCapsule === srcCapsule );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.capsule.nil( [ 0, 0, 1 ], [ 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.capsule.nil( [ 0, 0, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.capsule.nil( 'capsule' ));
}

//

function from( test )
{
  test.case = 'Same instance returned - array'; /* */

  var srcCapsule = [ 0, 0, 2, 2, 1 ];
  var expected = [ 0, 0, 2, 2, 1 ];

  var gotCapsule = _.capsule.from( srcCapsule );
  test.identical( gotCapsule, expected );
  test.is( srcCapsule === gotCapsule );

  test.case = 'Different instance returned - vector -> array'; /* */

  var srcCapsule = _.vector.fromArray( [ 0, 0, 2, 2, 1 ] );
  var expected = _.vector.fromArray( [ 0, 0, 2, 2, 1 ] );

  var gotCapsule = _.capsule.from( srcCapsule );
  test.identical( gotCapsule, expected );
  test.is( srcCapsule === gotCapsule );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.from( ));
  test.shouldThrowErrorSync( () => _.capsule._from( [] ));
  test.shouldThrowErrorSync( () => _.capsule.from( [ 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.capsule.from( [ 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.capsule.from( 'capsule' ));
  test.shouldThrowErrorSync( () => _.capsule.from( NaN ));
  test.shouldThrowErrorSync( () => _.capsule.from( undefined ));
}

//

function _from( test )
{
  test.case = 'Same instance returned - vector'; /* */

  var srcCapsule = [ 0, 0, 2, 2, 1 ];
  var expected = _.vector.from( [ 0, 0, 2, 2, 1 ] );

  var gotCapsule = _.capsule._from( srcCapsule );
  test.identical( gotCapsule, expected );
  test.is( srcCapsule !== gotCapsule );

  test.case = 'Different instance returned - vector -> vector'; /* */

  var srcCapsule = _.vector.from( [ 0, 0, 2, 2, 1 ] );
  var expected = _.vector.from( [ 0, 0, 2, 2, 1 ] );

  var gotCapsule = _.capsule._from( srcCapsule );
  test.identical( gotCapsule, expected );
  test.is( srcCapsule === gotCapsule );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule._from( ));
    test.shouldThrowErrorSync( () => _.capsule._from( [] ));
  test.shouldThrowErrorSync( () => _.capsule._from( [ 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.capsule._from( [ 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.capsule._from( 'capsule' ));
  test.shouldThrowErrorSync( () => _.capsule._from( NaN ));
  test.shouldThrowErrorSync( () => _.capsule._from( null ));
  test.shouldThrowErrorSync( () => _.capsule._from( undefined ));
}

//

function is( test )
{
  debugger;
  test.case = 'array'; /* */

  test.is( _.capsule.is([ 0, 0, 0 ]) );
  test.is( _.capsule.is([ 0, 1, 2, 3, 4 ]) );
  test.is( _.capsule.is([ 0, 0, 0, 0, 0, 0, 0 ]) );

  test.case = 'vector'; /* */

  test.is( _.capsule.is( _.vector.fromArray([ 0, 0, 0 ]) ) );
  test.is( _.capsule.is( _.vector.fromArray([ 0, 1, 2, 3, 4 ]) ) );
  test.is( _.capsule.is( _.vector.fromArray([ 0, 0, 0, 0, 0, 0, 0 ]) ) );

  test.case = 'not capsule'; /* */

  test.is( !_.capsule.is([ 0, 0 ]) );
  test.is( !_.capsule.is([ 0, 0, 0, 0 ]) );

  test.is( !_.capsule.is( _.vector.fromArray([ 0, 0 ]) ) );
  test.is( !_.capsule.is( _.vector.fromArray([ 0, 0, 0, 0 ]) ) );

  test.is( !_.capsule.is( 'abc' ) );
  test.is( !_.capsule.is( { start : [ 0, 0, 0 ], end : [ 1, 1, 1 ], radius : 1 } ) );
  test.is( !_.capsule.is( function( a, b, c ){} ) );

  test.is( !_.capsule.is( [] ) );
  test.is( !_.capsule.is( _.vector.fromArray([]) ) );
  test.is( !_.capsule.is( null ) );
  test.is( !_.capsule.is( NaN ) );
  test.is( !_.capsule.is( undefined ) );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.capsule.is( ));
  test.shouldThrowErrorSync( () => _.capsule.is( [ 0, 0, 0 ], [ 0, 2, 1 ] ));

}

//

function dimGet( test )
{
  test.case = 'srcCapsule 1D - array'; /* */

  var srcCapsule = [ 0, 1, 1 ];
  var gotDim = _.capsule.dimGet( srcCapsule );
  var expected = 1;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcCapsule );

  test.case = 'srcCapsule 1D - vector'; /* */

  var srcCapsule = _.vector.fromArray( [ 0, 1, 1 ] );
  var gotDim = _.capsule.dimGet( srcCapsule );
  var expected = 1;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcCapsule );

  test.case = 'srcCapsule 2D - array'; /* */

  var srcCapsule = [ 0, 1, 2, 3, 4 ];
  var gotDim = _.capsule.dimGet( srcCapsule );
  var expected = 2;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcCapsule );

  test.case = 'srcCapsule 2D - vector'; /* */

  var srcCapsule = _.vector.fromArray( [ 0, 1, 2, 3, 4 ] );
  var gotDim = _.capsule.dimGet( srcCapsule );
  var expected = 2;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcCapsule );

  test.case = 'srcCapsule 3D - array'; /* */

  var srcCapsule = [ 0, 1, 2, 3, 4, 5, 6 ];
  var gotDim = _.capsule.dimGet( srcCapsule );
  var expected = 3;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcCapsule );

  test.case = 'srcCapsule 3D - vector'; /* */

  var srcCapsule = _.vector.fromArray( [ 0, 1, 2, 3, 4, 5, 6 ] );
  var gotDim = _.capsule.dimGet( srcCapsule );
  var expected = 3;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcCapsule );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.capsule.dimGet( ) );
  test.shouldThrowErrorSync( () => _.capsule.dimGet( [] ) );
  test.shouldThrowErrorSync( () => _.capsule.dimGet( [ 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.dimGet( [ 0, 0, 0 ], [ 1, 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.dimGet( 'capsule' ) );
  test.shouldThrowErrorSync( () => _.capsule.dimGet( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.dimGet( null ) );
  test.shouldThrowErrorSync( () => _.capsule.dimGet( NaN ) );
  test.shouldThrowErrorSync( () => _.capsule.dimGet( undefined ) );

}

//

function originGet( test )
{
  test.case = 'Source capsule remains unchanged'; /* */

  var srcCapsule = [ 0, 0, 1, 1, 1 ];
  var expected = _.vector.from( [ 0, 0 ] );

  var gotOrigin = _.capsule.originGet( srcCapsule );
  test.identical( gotOrigin, expected );

  var oldSrcCapsule = [ 0, 0, 1, 1, 1 ];
  test.equivalent( srcCapsule, oldSrcCapsule );

  test.case = 'srcCapsule 1D - array'; /* */

  var srcCapsule = [ 0, 1, 2 ];
  var gotOrigin = _.capsule.originGet( srcCapsule );
  var expected = _.vector.from( [ 0 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcCapsule );

  test.case = 'srcCapsule 1D - vector'; /* */

  var srcCapsule = _.vector.fromArray( [ 0, 1, 1 ] );
  var gotOrigin = _.capsule.originGet( srcCapsule );
  var expected = _.vector.from( [ 0 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcCapsule );

  test.case = 'srcCapsule 2D - array'; /* */

  var srcCapsule = [ 0, 1, 2, 3, 4 ];
  var gotOrigin = _.capsule.originGet( srcCapsule );
  var expected = _.vector.from( [ 0, 1 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcCapsule );

  test.case = 'srcCapsule 2D - vector'; /* */

  var srcCapsule = _.vector.fromArray( [ 0, 1, 2, 3, 4 ] );
  var gotOrigin = _.capsule.originGet( srcCapsule );
  var expected = _.vector.from( [ 0, 1 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcCapsule );

  test.case = 'srcCapsule 3D - array'; /* */

  var srcCapsule = [ 0, 1, 2, 3, 4, 5, 6 ];
  var gotOrigin = _.capsule.originGet( srcCapsule );
  var expected = _.vector.from( [ 0, 1, 2 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcCapsule );

  test.case = 'srcCapsule 3D - vector'; /* */

  var srcCapsule = _.vector.fromArray( [ 0, 1, 2, 3, 4, 5, 6 ] );
  var gotOrigin = _.capsule.originGet( srcCapsule );
  var expected = _.vector.from( [ 0, 1, 2 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcCapsule );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.capsule.originGet( ) );
  test.shouldThrowErrorSync( () => _.capsule.originGet( [ 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.originGet( [ 0, 0, 1 ], [ 1, 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.originGet( 'capsule' ) );
  test.shouldThrowErrorSync( () => _.capsule.originGet( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.originGet( null ) );
  test.shouldThrowErrorSync( () => _.capsule.originGet( NaN ) );
  test.shouldThrowErrorSync( () => _.capsule.originGet( undefined ) );

}

//

function endPointGet( test )
{
  test.case = 'Source capsule remains unchanged'; /* */

  var srcCapsule = [ 0, 0, 1, 1, 2 ];
  var expected = _.vector.from( [ 1, 1 ] );

  var gotDirection = _.capsule.endPointGet( srcCapsule );
  test.identical( gotDirection, expected );

  var oldSrcCapsule = [ 0, 0, 1, 1, 2 ];
  test.equivalent( srcCapsule, oldSrcCapsule );

  test.case = 'srcCapsule 1D - array'; /* */

  var srcCapsule = [ 0, 1, 2 ];
  var gotDirection = _.capsule.endPointGet( srcCapsule );
  var expected = _.vector.from( [ 1 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcCapsule );

  test.case = 'srcCapsule 1D - vector'; /* */

  var srcCapsule = _.vector.fromArray( [ 0, 1, 2 ] );
  var gotDirection = _.capsule.endPointGet( srcCapsule );
  var expected = _.vector.from( [ 1 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcCapsule );

  test.case = 'srcCapsule 2D - array'; /* */

  var srcCapsule = [ 0, 1, 2, 3, 4 ];
  var gotDirection = _.capsule.endPointGet( srcCapsule );
  var expected = _.vector.from( [ 2, 3 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcCapsule );

  test.case = 'srcCapsule 2D - vector'; /* */

  var srcCapsule = _.vector.fromArray( [ 0, 1, 2, 3, 4 ] );
  var gotDirection = _.capsule.endPointGet( srcCapsule );
  var expected = _.vector.from( [ 2, 3 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcCapsule );

  test.case = 'srcCapsule 3D - array'; /* */

  var srcCapsule = [ 0, 1, 2, 3, 4, 5, 6 ];
  var gotDirection = _.capsule.endPointGet( srcCapsule );
  var expected = _.vector.from( [ 3, 4, 5 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcCapsule );

  test.case = 'srcCapsule 3D - vector'; /* */

  var srcCapsule = _.vector.fromArray( [ 0, 1, 2, 3, 4, 5, 6 ] );
  var gotDirection = _.capsule.endPointGet( srcCapsule );
  var expected = _.vector.from( [ 3, 4, 5 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcCapsule );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.capsule.endPointGet( ) );
  test.shouldThrowErrorSync( () => _.capsule.endPointGet( [ 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.endPointGet( [ 0, 0, 1 ], [ 1, 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.endPointGet( 'capsule' ) );
  test.shouldThrowErrorSync( () => _.capsule.endPointGet( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.endPointGet( null ) );
  test.shouldThrowErrorSync( () => _.capsule.endPointGet( NaN ) );
  test.shouldThrowErrorSync( () => _.capsule.endPointGet( undefined ) );

}

//

function radiusGet( test )
{

  test.case = 'Source capsule remains unchanged'; /* */

  var srcCapsule = [ 0, 0, 1, 1, 2 ];
  var oldSrcCapsule = srcCapsule.slice();
  var expected =  2;

  var gotRadius = _.capsule.radiusGet( srcCapsule );

  test.equivalent( srcCapsule, oldSrcCapsule );
  test.identical( gotRadius, expected );

  test.case = 'One dimension capsule'; /* */

  var capsule = [ 0, 1, 2 ];
  var expected =  2 ;

  var gotRadius = _.capsule.radiusGet( capsule );
  test.identical( gotRadius, expected );

  test.case = 'Two dimension capsule'; /* */

  var capsule = [ 0, 0, 1, 1, 2 ];
  var expected = 2;

  var gotRadius = _.capsule.radiusGet( capsule );
  test.identical( gotRadius, expected );

  test.case = 'Three dimension capsule'; /* */

  var capsule = [ 0, - 1, - 2, 2, 2, 2, 3 ];
  var expected = 3;

  var gotRadius = _.capsule.radiusGet( capsule );
  test.identical( gotRadius, expected );

  test.case = 'Four dimension capsule'; /* */

  var capsule = [ 0, - 1, - 2, 2, 4, 4, 4, 4, 3 ];
  var expected =  3;

  var gotRadius = _.capsule.radiusGet( capsule );
  test.identical( gotRadius, expected );

  test.case = 'negative radius'; /* */

  var capsule = [ 1, 2, 3, 4, - 3 ];
  var expected = - 3;

  var gotRadius = _.capsule.radiusGet( capsule );
  test.identical( gotRadius, expected );


  test.case = 'NaN radius'; /* */

  var capsule = [ 1, 2, 3, 4, NaN ];
  var expected = NaN;

  var gotRadius = _.capsule.radiusGet( capsule );
  test.identical( gotRadius, expected );

  test.case = 'NaN capsule'; /* */

  var capsule = [ NaN, NaN, NaN ];
  var expected = NaN;

  var gotRadius = _.capsule.radiusGet( capsule );
  test.identical( gotRadius, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.capsule.radiusGet( ) );
  test.shouldThrowErrorSync( () => _.capsule.radiusGet( [ ] ) );
  test.shouldThrowErrorSync( () => _.capsule.radiusGet( [ 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.radiusGet( [ 0, 0, 1 ], [ 1, 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.radiusGet( 'capsule' ) );
  test.shouldThrowErrorSync( () => _.capsule.radiusGet( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.radiusGet( null ) );
  test.shouldThrowErrorSync( () => _.capsule.radiusGet( NaN ) );
  test.shouldThrowErrorSync( () => _.capsule.radiusGet( undefined ) );

}




// --
// define class
// --

var Self =
{

  name : 'Tools/Math/Capsule',
  silencing : 1,
  enabled : 1,
  accuracy : 1E-6,
  // routine: 'is',

  tests :
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
    radiusGet : radiusGet,


  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
