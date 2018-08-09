( function _Ray_test_s_( ) {

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
  test.case = 'srcDim undefined'; /* */

  var srcDim = undefined;
  var gotRay = _.ray.make( srcDim );
  var expected = [ 0, 0, 0, 0, 0, 0 ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  test.case = 'srcDim null'; /* */

  var srcDim = null;
  var gotRay = _.ray.make( srcDim );
  var expected = [ 0, 0, 0, 0, 0, 0 ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  test.case = 'srcDim 2'; /* */

  var srcDim = 2;
  var gotRay = _.ray.make( srcDim );
  var expected = [ 0, 0, 0, 0 ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  test.case = 'srcDim array'; /* */

  var srcDim = [ 0, 1, 2, 3 ];
  var gotRay = _.ray.make( srcDim );
  var expected = [ 0, 1, 2, 3 ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  test.case = 'srcDim vector'; /* */

  var srcDim = _.vector.fromArray([ 0, 1, 2, 3 ]);
  var gotRay = _.ray.make( srcDim );
  var expected = [ 0,1,2,3 ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.make( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.ray.make( 'ray' ));
}

//

function makeZero( test )
{
  test.case = 'srcDim undefined'; /* */

  var srcDim = undefined;
  var gotRay = _.ray.makeZero( srcDim );
  var expected = [ 0, 0, 0, 0, 0, 0 ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  test.case = 'srcDim null'; /* */

  var srcDim = null;
  var gotRay = _.ray.makeZero( srcDim );
  var expected = [ 0, 0, 0, 0, 0, 0 ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  test.case = 'srcDim 2'; /* */

  var srcDim = 2;
  var gotRay = _.ray.makeZero( srcDim );
  var expected = [ 0, 0, 0, 0 ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  test.case = 'srcDim array'; /* */

  var srcDim = [ 0, 1, 2, 3 ];
  var gotRay = _.ray.makeZero( srcDim );
  var expected = [ 0, 0, 0, 0 ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  test.case = 'srcDim vector'; /* */

  var srcDim = _.vector.fromArray([ 0, 1, 2, 3 ]);
  var gotRay = _.ray.makeZero( srcDim );
  var expected = [ 0, 0, 0, 0 ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.makeZero( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.ray.makeZero( 'ray' ));

}

//

function makeNil( test )
{
  test.case = 'srcDim undefined'; /* */

  var srcDim = undefined;
  var gotRay = _.ray.makeNil( srcDim );
  var expected = [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  test.case = 'srcDim null'; /* */

  var srcDim = null;
  var gotRay = _.ray.makeNil( srcDim );
  var expected = [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  test.case = 'srcDim 2'; /* */

  var srcDim = 2;
  var gotRay = _.ray.makeNil( srcDim );
  var expected = [ Infinity, Infinity, - Infinity, - Infinity ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  test.case = 'srcDim array'; /* */

  var srcDim = [ 0, 1, 2, 3 ];
  var gotRay = _.ray.makeNil( srcDim );
  var expected = [ Infinity, Infinity, - Infinity, - Infinity ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  test.case = 'srcDim vector'; /* */

  var srcDim = _.vector.fromArray([ 0, 1, 2, 3 ]);
  var gotRay = _.ray.makeNil( srcDim );
  var expected = [ Infinity, Infinity, - Infinity, - Infinity ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.makeNil( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.ray.makeNil( 'ray' ));
}

//

function zero( test )
{
  test.case = 'srcRay undefined'; /* */

  var srcRay = undefined;
  var gotRay = _.ray.zero( srcRay );
  var expected = [ 0, 0, 0, 0, 0, 0 ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcRay );

  test.case = 'srcRay null'; /* */

  var srcRay = null;
  var gotRay = _.ray.zero( srcRay );
  var expected = [ 0, 0, 0, 0, 0, 0 ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcRay );

  test.case = 'srcRay 2'; /* */

  var srcRay = 2;
  var gotRay = _.ray.zero( srcRay );
  var expected = [ 0, 0, 0, 0 ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcRay );

  test.case = 'srcRay array'; /* */

  var srcRay = [ 0, 1, 2, 3 ];
  var gotRay = _.ray.zero( srcRay );
  var expected = [ 0, 0, 0, 0 ];
  test.identical( gotRay, expected );
  test.is( gotRay === srcRay );

  test.case = 'srcRay vector'; /* */

  var srcRay = _.vector.fromArray( [ 0, 1, 2, 3 ] );
  var gotRay = _.ray.zero( srcRay );
  var expected =  _.vector.fromArray( [ 0, 0, 0, 0 ] );
  test.identical( gotRay, expected );
  test.is( gotRay === srcRay );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.zero( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.ray.zero( 'ray' ));

}

//

function nil( test )
{
  test.case = 'srcRay undefined'; /* */

  var srcRay = undefined;
  var gotRay = _.ray.nil( srcRay );
  var expected = [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcRay );

  test.case = 'srcRay null'; /* */

  var srcRay = null;
  var gotRay = _.ray.nil( srcRay );
  var expected = [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcRay );

  test.case = 'srcRay 2'; /* */

  var srcRay = 2;
  var gotRay = _.ray.nil( srcRay );
  var expected = [ Infinity, Infinity, - Infinity, - Infinity ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcRay );

  test.case = 'srcRay array'; /* */

  var srcRay = [ 0, 1, 2, 3 ];
  var gotRay = _.ray.nil( srcRay );
  var expected = [ Infinity, Infinity, - Infinity, - Infinity ];
  test.identical( gotRay, expected );
  test.is( gotRay === srcRay );

  test.case = 'srcRay vector'; /* */

  var srcRay = _.vector.fromArray( [ 0, 1, 2, 3 ] );
  var gotRay = _.ray.nil( srcRay );
  var expected = _.vector.fromArray( [ Infinity, Infinity, - Infinity, - Infinity ] );
  test.identical( gotRay, expected );
  test.is( gotRay === srcRay );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.nil( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.ray.nil( 'ray' ));
}

//

function from( test )
{
  test.case = 'Same instance returned - array'; /* */

  var srcRay = [ 0, 0, 2, 2 ];
  var expected = [ 0, 0, 2, 2 ];

  var gotRay = _.ray.from( srcRay );
  test.identical( gotRay, expected );
  test.is( srcRay === gotRay );

  test.case = 'Different instance returned - vector -> array'; /* */

  var srcRay = _.vector.fromArray( [ 0, 0, 2, 2 ] );
  var expected = _.vector.fromArray( [ 0, 0, 2, 2 ] );

  var gotRay = _.ray.from( srcRay );
  test.identical( gotRay, expected );
  test.is( srcRay === gotRay );

  test.case = 'Same instance returned - empty array'; /* */

  var srcRay = [];
  var expected =  [];

  var gotRay = _.ray.from( srcRay );
  test.identical( gotRay, expected );
  test.is( srcRay === gotRay );

  test.case = 'Different instance returned - null -> array'; /* */

  var srcRay = null;
  var expected =  [ 0, 0, 0, 0, 0, 0 ];

  var gotRay = _.ray.from( srcRay );
  test.identical( gotRay, expected );
  test.is( srcRay !== gotRay );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.from( ));
  test.shouldThrowErrorSync( () => _.ray.from( [ 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.ray.from( [ 0, 0, 0, 0 ], [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.ray.from( 'ray' ));
  test.shouldThrowErrorSync( () => _.ray.from( NaN ));
  test.shouldThrowErrorSync( () => _.ray.from( undefined ));
}

//

function _from( test )
{
  test.case = 'Same instance returned - vector'; /* */

  var srcRay = [ 0, 0, 2, 2 ];
  var expected = _.vector.from( [ 0, 0, 2, 2 ] );

  var gotRay = _.ray._from( srcRay );
  test.identical( gotRay, expected );
  test.is( srcRay !== gotRay );

  test.case = 'Different instance returned - vector -> vector'; /* */

  var srcRay = _.vector.from( [ 0, 0, 2, 2 ] );
  var expected = _.vector.from( [ 0, 0, 2, 2 ] );

  var gotRay = _.ray._from( srcRay );
  test.identical( gotRay, expected );
  test.is( srcRay === gotRay );

  test.case = 'Same instance returned - empty vector'; /* */

  var srcRay = [];
  var expected =  _.vector.from( [] );

  var gotRay = _.ray._from( srcRay );
  test.identical( gotRay, expected );
  test.is( srcRay !== gotRay );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray._from( ));
  test.shouldThrowErrorSync( () => _.ray._from( [ 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.ray._from( [ 0, 0, 0, 0 ], [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.ray._from( 'ray' ));
  test.shouldThrowErrorSync( () => _.ray._from( NaN ));
  test.shouldThrowErrorSync( () => _.ray._from( null ));
  test.shouldThrowErrorSync( () => _.ray._from( undefined ));
}

//

function fromPair( test )
{
  test.case = 'Pair stay unchanged'; /* */

  var pair = [ [ 0, 1, 2 ], [ 0, 2, 4 ] ];
  var expected = [ 0, 1, 2, 0, 1, 2 ];

  var gotRay = _.ray.fromPair( pair );
  test.identical( gotRay, expected );

  test.case = 'Ray starts in origin'; /* */

  var pair = [ [ 0, 0, 0 ], [ 0, 1, 2 ] ];
  var expected = [ 0, 0, 0, 0, 1, 2 ];

  var gotRay = _.ray.fromPair( pair );
  test.identical( gotRay, expected );

  test.case = 'Ray is point'; /* */

  var pair = [ [ 0, 1, 2 ], [ 0, 1, 2 ] ];
  var expected = [ 0, 1, 2, 0, 0, 0 ];

  var gotRay = _.ray.fromPair( pair );
  test.identical( gotRay, expected );

  test.case = 'Ray of 1 dimension'; /* */

  var pair = [ [ 3 ], [ 4 ] ];
  var expected = [ 3, 1 ];

  var gotRay = _.ray.fromPair( pair );
  test.identical( gotRay, expected );

  test.case = 'Ray goes up in y and down in z'; /* */

  var pair = [ [ 0, 1, 2 ], [ 0, 3, 1 ] ];
  var expected = [ 0, 1, 2, 0, 2, -1 ];

  var gotRay = _.ray.fromPair( pair );
  test.identical( gotRay, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.fromPair( ));
  test.shouldThrowErrorSync( () => _.ray.fromPair( null ));
  test.shouldThrowErrorSync( () => _.ray.fromPair( [ 2, 4 ], [ 3, 6 ] ));
  test.shouldThrowErrorSync( () => _.ray.fromPair( [ 2, 4 ], [ 3, 6, 2 ] ));
  test.shouldThrowErrorSync( () => _.ray.fromPair( [ [ 2, 4 ], [ 3, 6 ], [ 3, 6 ] ] ));
  test.shouldThrowErrorSync( () => _.ray.fromPair( undefined ));

}

//

function is( test )
{
  debugger;
  test.case = 'array'; /* */

  test.is( _.ray.is( [] ) );
  test.is( _.ray.is([ 0, 0 ]) );
  test.is( _.ray.is([ 1, 2, 3, 4 ]) );
  test.is( _.ray.is([ 0, 0, 0, 0, 0, 0 ]) );

  test.case = 'vector'; /* */

  test.is( _.ray.is( _.vector.fromArray([]) ) );
  test.is( _.ray.is( _.vector.fromArray([ 0, 0 ]) ) );
  test.is( _.ray.is( _.vector.fromArray([ 1, 2, 3, 4 ]) ) );
  test.is( _.ray.is( _.vector.fromArray([ 0, 0, 0, 0, 0, 0 ]) ) );

  test.case = 'not ray'; /* */

  test.is( !_.ray.is([ 0 ]) );
  test.is( !_.ray.is([ 0, 0, 0 ]) );

  test.is( !_.ray.is( _.vector.fromArray([ 0 ]) ) );
  test.is( !_.ray.is( _.vector.fromArray([ 0, 0, 0 ]) ) );

  test.is( !_.ray.is( 'abc' ) );
  test.is( !_.ray.is( { origin : [ 0, 0, 0 ], direction : [ 1, 1, 1 ] } ) );
  test.is( !_.ray.is( function( a, b, c ){} ) );

  test.is( !_.ray.is( null ) );
  test.is( !_.ray.is( undefined ) );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.is( ));
  test.shouldThrowErrorSync( () => _.ray.is( [ 0, 0 ], [ 1, 1 ] ));

}

//

function dimGet( test )
{
  test.case = 'srcRay 1D - array'; /* */

  var srcRay = [ 0, 1 ];
  var gotDim = _.ray.dimGet( srcRay );
  var expected = 1;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcRay );

  test.case = 'srcRay 1D - vector'; /* */

  var srcRay = _.vector.fromArray( [ 0, 1 ] );
  var gotDim = _.ray.dimGet( srcRay );
  var expected = 1;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcRay );

  test.case = 'srcRay 2D - array'; /* */

  var srcRay = [ 0, 1, 2, 3 ];
  var gotDim = _.ray.dimGet( srcRay );
  var expected = 2;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcRay );

  test.case = 'srcRay 2D - vector'; /* */

  var srcRay = _.vector.fromArray( [ 0, 1, 2, 3 ] );
  var gotDim = _.ray.dimGet( srcRay );
  var expected = 2;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcRay );

  test.case = 'srcRay 3D - array'; /* */

  var srcRay = [ 0, 1, 2, 3, 4, 5 ];
  var gotDim = _.ray.dimGet( srcRay );
  var expected = 3;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcRay );

  test.case = 'srcRay 3D - vector'; /* */

  var srcRay = _.vector.fromArray( [ 0, 1, 2, 3, 4, 5 ] );
  var gotDim = _.ray.dimGet( srcRay );
  var expected = 3;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcRay );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.dimGet( ) );
  test.shouldThrowErrorSync( () => _.ray.dimGet( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.dimGet( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.ray.dimGet( 'ray' ) );
  test.shouldThrowErrorSync( () => _.ray.dimGet( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.dimGet( null ) );
  test.shouldThrowErrorSync( () => _.ray.dimGet( undefined ) );

}

//

function originGet( test )
{
  test.case = 'Source ray remains unchanged'; /* */

  var srcRay = [ 0, 0, 1, 1 ];
  var expected = _.vector.from( [ 0, 0 ] );

  var gotOrigin = _.ray.originGet( srcRay );
  test.identical( gotOrigin, expected );

  var oldSrcRay = [ 0, 0, 1, 1 ];
  test.equivalent( srcRay, oldSrcRay );

  test.case = 'srcRay 1D - array'; /* */

  var srcRay = [ 0, 1 ];
  var gotOrigin = _.ray.originGet( srcRay );
  var expected = _.vector.from( [ 0 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcRay );

  test.case = 'srcRay 1D - vector'; /* */

  var srcRay = _.vector.fromArray( [ 0, 1 ] );
  var gotOrigin = _.ray.originGet( srcRay );
  var expected = _.vector.from( [ 0 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcRay );

  test.case = 'srcRay 2D - array'; /* */

  var srcRay = [ 0, 1, 2, 3 ];
  var gotOrigin = _.ray.originGet( srcRay );
  var expected = _.vector.from( [ 0, 1 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcRay );

  test.case = 'srcRay 2D - vector'; /* */

  var srcRay = _.vector.fromArray( [ 0, 1, 2, 3 ] );
  var gotOrigin = _.ray.originGet( srcRay );
  var expected = _.vector.from( [ 0, 1 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcRay );

  test.case = 'srcRay 3D - array'; /* */

  var srcRay = [ 0, 1, 2, 3, 4, 5 ];
  var gotOrigin = _.ray.originGet( srcRay );
  var expected = _.vector.from( [ 0, 1, 2 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcRay );

  test.case = 'srcRay 3D - vector'; /* */

  var srcRay = _.vector.fromArray( [ 0, 1, 2, 3, 4, 5 ] );
  var gotOrigin = _.ray.originGet( srcRay );
  var expected = _.vector.from( [ 0, 1, 2 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcRay );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.originGet( ) );
  test.shouldThrowErrorSync( () => _.ray.originGet( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.originGet( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.ray.originGet( 'ray' ) );
  test.shouldThrowErrorSync( () => _.ray.originGet( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.originGet( null ) );
  test.shouldThrowErrorSync( () => _.ray.originGet( undefined ) );

}

//

function directionGet( test )
{
  test.case = 'Source ray remains unchanged'; /* */

  var srcRay = [ 0, 0, 1, 1 ];
  var expected = _.vector.from( [ 1, 1 ] );

  var gotDirection = _.ray.directionGet( srcRay );
  test.identical( gotDirection, expected );

  var oldSrcRay = [ 0, 0, 1, 1 ];
  test.equivalent( srcRay, oldSrcRay );

  test.case = 'srcRay 1D - array'; /* */

  var srcRay = [ 0, 1 ];
  var gotDirection = _.ray.directionGet( srcRay );
  var expected = _.vector.from( [ 1 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcRay );

  test.case = 'srcRay 1D - vector'; /* */

  var srcRay = _.vector.fromArray( [ 0, 1 ] );
  var gotDirection = _.ray.directionGet( srcRay );
  var expected = _.vector.from( [ 1 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcRay );

  test.case = 'srcRay 2D - array'; /* */

  var srcRay = [ 0, 1, 2, 3 ];
  var gotDirection = _.ray.directionGet( srcRay );
  var expected = _.vector.from( [ 2, 3 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcRay );

  test.case = 'srcRay 2D - vector'; /* */

  var srcRay = _.vector.fromArray( [ 0, 1, 2, 3 ] );
  var gotDirection = _.ray.directionGet( srcRay );
  var expected = _.vector.from( [ 2, 3 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcRay );

  test.case = 'srcRay 3D - array'; /* */

  var srcRay = [ 0, 1, 2, 3, 4, 5 ];
  var gotDirection = _.ray.directionGet( srcRay );
  var expected = _.vector.from( [ 3, 4, 5 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcRay );

  test.case = 'srcRay 3D - vector'; /* */

  var srcRay = _.vector.fromArray( [ 0, 1, 2, 3, 4, 5 ] );
  var gotDirection = _.ray.directionGet( srcRay );
  var expected = _.vector.from( [ 3, 4, 5 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcRay );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.directionGet( ) );
  test.shouldThrowErrorSync( () => _.ray.directionGet( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.directionGet( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.ray.directionGet( 'ray' ) );
  test.shouldThrowErrorSync( () => _.ray.directionGet( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.directionGet( null ) );
  test.shouldThrowErrorSync( () => _.ray.directionGet( undefined ) );

}

//

function rayAt( test )
{
  test.case = 'Source ray and factor remain unchanged'; /* */

  var srcRay = [ 0, 0, 1, 1 ];
  var factor = 1;
  var expected = [ 1, 1 ];

  var gotPoint = _.ray.rayAt( srcRay, factor );
  test.identical( gotPoint, expected );

  var oldSrcRay = [ 0, 0, 1, 1 ];
  test.equivalent( srcRay, oldSrcRay );

  var oldFactor = 1;
  test.equivalent( factor, oldFactor );

  test.case = 'Factor = null, return origin'; /* */

  var srcRay = [ 0, 0, 1, 1 ];
  var factor = 0;
  var expected = [ 0, 0 ];

  var gotPoint = _.ray.rayAt( srcRay, factor );
  test.identical( gotPoint, expected );

  test.case = 'Factor = 0, return origin'; /* */

  var srcRay = [ 0, 0, 1, 1 ];
  var factor = 0;
  var expected = [ 0, 0 ];

  var gotPoint = _.ray.rayAt( srcRay, factor );
  test.identical( gotPoint, expected );

  test.case = 'Factor = 1, return origin + direction'; /* */

  var srcRay = [ 0, 1, 1, 1 ];
  var factor = 1;
  var expected = [ 1, 2 ];

  var gotPoint = _.ray.rayAt( srcRay, factor );
  test.identical( gotPoint, expected );

  test.case = '3D ray'; /* */

  var srcRay = [ 0, 1, 2, 1, 1, 1 ];
  var factor = 1;
  var expected = [ 1, 2, 3 ];

  var gotPoint = _.ray.rayAt( srcRay, factor );
  test.identical( gotPoint, expected );

  test.case = 'factor smaller than 1'; /* */

  var srcRay = [ 0, 1, 2, 2, 2, 2 ];
  var factor = 0.5;
  var expected = [ 1, 2, 3 ];

  var gotPoint = _.ray.rayAt( srcRay, factor );
  test.identical( gotPoint, expected );

  test.case = 'factor bigger than one'; /* */

  var srcRay = [ 0, 1, 2, 1, 1, 1 ];
  var factor = 5;
  var expected = [ 5, 6, 7 ];

  var gotPoint = _.ray.rayAt( srcRay, factor );
  test.identical( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.rayAt( ) );
  test.shouldThrowErrorSync( () => _.ray.rayAt( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayAt( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayAt( 'ray', 1 ) );
  test.shouldThrowErrorSync( () => _.ray.rayAt( [ 0, 0 ], 'factor') );
  test.shouldThrowErrorSync( () => _.ray.rayAt( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.rayAt( null, 1 ) );
  test.shouldThrowErrorSync( () => _.ray.rayAt( undefined, 1 ) );
  test.shouldThrowErrorSync( () => _.ray.rayAt( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.rayAt( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.rayAt( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function rayParallel( test )
{
  test.case = 'Source rays and accuracySqr remain unchanged'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 0, 0, 0, 2, 2, 2 ];
  var accuracySqr = 1E-10;
  var expected = true;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray, accuracySqr );
  test.identical( isParallel, expected );

  var oldSrc1Ray = [ 0, 0, 0, 1, 1, 1 ];
  test.equivalent( src1Ray, oldSrc1Ray );

  var oldSrc2Ray = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( src2Ray, oldSrc2Ray );

  var oldAccuracySqr = 1E-10;
  test.equivalent( accuracySqr, oldAccuracySqr );

  test.case = 'Rays are the same'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel ( different origin - same direction )'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 1, 1, 1 ];
  var expected = true;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel ( different origin - different direction )'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 7, 7, 7 ];
  var expected = true;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel ( different origin - opposite direction )'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, - 7, - 7, - 7 ];
  var expected = true;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel ( src2Ray is a point )'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 0, 0, 0 ];
  var expected = true;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are not parallel ( same origin - different direction )'; /* */

  var src1Ray = [ 3, 7, 1, 1, - 1, 1 ];
  var src2Ray = [ 3, 7, 1, 7, 7, 7 ];
  var expected = false;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are perpendicular'; /* */

  var src1Ray = [ 3, 7, 1, 1, 0, 0 ];
  var src2Ray = [ 3, 7, 1, 0, 0, 1 ];
  var expected = false;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.rayParallel( ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel( 'ray', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel( [ 0, 0 ], 'factor') );
  test.shouldThrowErrorSync( () => _.ray.rayParallel( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel( null, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2 ] ) );

}

//

function rayIntersectionFactors( test )
{
  test.case = 'Source rays remain unchanged'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 0, 0, 2, 2 ];
  var expected = [ 0, 0 ];

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  var oldSrc1Ray = [ 0, 0, 1, 1 ];
  test.equivalent( src1Ray, oldSrc1Ray );

  var oldSrc2Ray = [ 0, 0, 2, 2 ];
  test.equivalent( src2Ray, oldSrc2Ray );

  test.case = 'Rays are the same'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 0, 0, 1, 1 ];
  var expected = [ 0, 0 ];

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Rays are parallel ( different origin - same direction )'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 1 ];
  var expected = 0;

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Rays are parallel ( different origin - different direction )'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 7, 7, 7 ];
  var expected = 0;

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Rays don´t intersect'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 0, 2, -1 ];
  var expected = 0;

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Rays intersect in their origin'; /* */

  var src1Ray = [ 3, 7, 1, 0 ];
  var src2Ray = [ 3, 7, 0, 1 ];
  var expected = [ 0, 0 ];

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Rays intersect '; /* */

  var src1Ray = [ 0, 0, 1, 0 ];
  var src2Ray = [ -2, -6, 1, 2 ];
  var expected = [ 1, 3 ];

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Rays are perpendicular '; /* */

  var src1Ray = [ -3, 0, 1, 0 ];
  var src2Ray = [ 0, -2, 0, 1 ];
  var expected = [ 3, 2 ];

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors( ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors( 'ray', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors( [ 1, 1, 2, 2 ], 'ray') );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors( null, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function rayIntersectionPoints( test )
{
  test.case = 'Source rays remain unchanged'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 0, 0, 2, 2 ];
  var expected = [ [ 0, 0 ], [ 0, 0 ] ];

  var isIntersectionPoints = _.ray.rayIntersectionPoints( src1Ray, src2Ray );
  test.identical( isIntersectionPoints, expected );

  var oldSrc1Ray = [ 0, 0, 1, 1 ];
  test.equivalent( src1Ray, oldSrc1Ray );

  var oldSrc2Ray = [ 0, 0, 2, 2 ];
  test.equivalent( src2Ray, oldSrc2Ray );

  test.case = 'Rays are the same'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 0, 0, 1, 1 ];
  var expected = [ [ 0, 0 ], [ 0, 0 ] ];

  var isIntersectionPoints = _.ray.rayIntersectionPoints( src1Ray, src2Ray );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Rays are parallel ( different origin - same direction )'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 1 ];
  var expected = 0;

  var isIntersectionPoints = _.ray.rayIntersectionPoints( src1Ray, src2Ray );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Rays are parallel ( different origin - different direction )'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 7, 7, 7 ];
  var expected = 0;

  var isIntersectionPoints = _.ray.rayIntersectionPoints( src1Ray, src2Ray );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Rays don´t intersect'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 0, 2, -1 ];
  var expected = 0;

  var isIntersectionPoints = _.ray.rayIntersectionPoints( src1Ray, src2Ray );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Rays intersect in their origin'; /* */

  var src1Ray = [ 3, 7, 1, 0 ];
  var src2Ray = [ 3, 7, 0, 1 ];
  var expected = [ [ 3, 7 ], [ 3, 7 ] ];

  var isIntersectionPoints = _.ray.rayIntersectionPoints( src1Ray, src2Ray );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Rays intersect '; /* */

  var src1Ray = [ 0, 0, 1, 0 ];
  var src2Ray = [ -2, -6, 1, 2 ];
  var expected = [ [ 1, 0 ], [ 1, 0 ] ];

  var isIntersectionPoints = _.ray.rayIntersectionPoints( src1Ray, src2Ray );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Rays are perpendicular '; /* */

  var src1Ray = [ -3, 0, 1, 0 ];
  var src2Ray = [ 0, -2, 0, 1 ];
  var expected = [ [ 0, 0 ], [ 0, 0 ] ];

  var isIntersectionPoints = _.ray.rayIntersectionPoints( src1Ray, src2Ray );
  test.identical( isIntersectionPoints, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoints( ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoints( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoints( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoints( 'ray', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoints( [ 1, 1, 2, 2 ], 'ray') );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoints( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoints( null, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoints( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoints( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoints( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoints( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoints( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function rayIntersectionPoint( test )
{
  test.case = 'Source rays remain unchanged'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 0, 0, 2, 2 ];
  var expected = [ 0, 0 ];

  var isIntersectionPoint = _.ray.rayIntersectionPoint( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  var oldSrc1Ray = [ 0, 0, 1, 1 ];
  test.equivalent( src1Ray, oldSrc1Ray );

  var oldSrc2Ray = [ 0, 0, 2, 2 ];
  test.equivalent( src2Ray, oldSrc2Ray );

  test.case = 'Rays are the same'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 0, 0, 1, 1 ];
  var expected = [ 0, 0 ];

  var isIntersectionPoint = _.ray.rayIntersectionPoint( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays are parallel ( different origin - same direction )'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 1 ];
  var expected = 0;

  var isIntersectionPoint = _.ray.rayIntersectionPoint( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays are parallel ( different origin - different direction )'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 7, 7, 7 ];
  var expected = 0;

  var isIntersectionPoint = _.ray.rayIntersectionPoint( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays don´t intersect'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 0, 2, -1 ];
  var expected = 0;

  var isIntersectionPoint = _.ray.rayIntersectionPoint( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays intersect in their origin'; /* */

  var src1Ray = [ 3, 7, 1, 0 ];
  var src2Ray = [ 3, 7, 0, 1 ];
  var expected = [ 3, 7 ];

  var isIntersectionPoint = _.ray.rayIntersectionPoint( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays intersect '; /* */

  var src1Ray = [ 0, 0, 1, 0 ];
  var src2Ray = [ -2, -6, 1, 2 ];
  var expected = [ 1, 0 ];

  var isIntersectionPoint = _.ray.rayIntersectionPoint( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays are perpendicular '; /* */

  var src1Ray = [ -3, 0, 1, 0 ];
  var src2Ray = [ 0, -2, 0, 1 ];
  var expected = [ 0, 0 ];

  var isIntersectionPoint = _.ray.rayIntersectionPoint( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoint( ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoint( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoint( 'ray', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoint( [ 1, 1, 2, 2 ], 'ray') );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoint( null, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoint( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoint( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoint( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoint( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoint( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}


// --
// define class
// --

var Self =
{

  name : 'Tools/Math/Ray',
  silencing : 0,
  enabled : 1,
  // routine: 'is',

  tests :
  {
    make : make,
    makeZero : makeZero,
    makeNil : makeNil,

    zero : zero,
    nil : nil,

    is : is,

    from: from,
    _from : _from,
    fromPair : fromPair,

    dimGet : dimGet,
    originGet : originGet,
    directionGet : directionGet,

    rayAt : rayAt,

    rayParallel : rayParallel,
    rayIntersectionFactors : rayIntersectionFactors,
    rayIntersectionPoints : rayIntersectionPoints,
    rayIntersectionPoint : rayIntersectionPoint,

  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
