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

function getFactor( test )
{

  test.case = 'Ray and Point remain unchanged'; /* */

  var ray = [  - 1,  - 1 , 1, 1 ];
  var point = [ 0, 0 ];
  var expected = 1;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor, expected );

  var oldray = [  - 1,  - 1 , 1, 1 ];
  test.identical( ray, oldray );

  var oldPoint = [ 0, 0 ];
  test.identical( point, oldPoint );

  test.case = 'Null ray contains empty point'; /* */

  var ray = null;
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor,  expected );

  test.case = 'Point ray contains Point'; /* */

  var ray = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor,  expected );

  test.case = 'Factor smaller than one'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var point = [  1, 1, 1 ];
  var expected = 0.5;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor,  expected );

  test.case = 'Factor bigger than one'; /* */

  var ray = [ 0, 0, 0, 1, 1, 1 ];
  var point = [  6, 6, 6 ];
  var expected = 6;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor,  expected );

  test.case = 'Direction with different values'; /* */

  var ray = [ 0, 0, 0, 1, 2, 3 ];
  var point = [  6, 12, 18 ];
  var expected = 6;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor,  expected );

  test.case = 'Direction with different values ( one of them 0 )'; /* */

  var ray = [ 0, 0, 0, 1, 2, 0 ];
  var point = [  6, 12, 0 ];
  var expected = 6;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor,  expected );

  test.case = 'Direction with different values ( one of them 0 )'; /* */

  var ray = [ 0, 0, 0, 0, 2, 3 ];
  var point = [  0, 12, 18 ];
  var expected = 6;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor,  expected );

  test.case = 'Direction with different values ( one of them 0 )'; /* */

  var ray = [ 0, 0, 0, 1, 2, 0 ];
  var point = [  6, 12, 18];
  var expected = false;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor,  expected );

  test.case = 'Ray under point'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ 1, 1, 3 ];
  var expected = false;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor,  expected );

  test.case = 'Ray ( normalized to 1 )'; /* */

  var ray = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var point = [ 0.500, 0.500, 0.000 ];
  var expected = 1/ Math.sqrt( 2 );

  var gotFactor = _.ray.getFactor( ray, point );
  test.equivalent( gotFactor,  expected );

  test.case = 'Ray of four dimensions'; /* */

  var ray = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0, 0 ];
  var expected = 1;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor,  expected );

  test.case = 'Ray of 7 dimensions'; /* */

  var ray = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 1, 1, 1, 1, 1, 1, 1 ];
  var point = [ - 1, -1, -1, -1, -1, -1, -1 ];
  var expected = 1;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor,  expected );

  test.case = 'Ray of 1 dimension contains point'; /* */

  var ray = [ 0, 2 ];
  var point = [ 1 ];
  var expected = 0.5;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor,  expected );

  test.case = 'Ray of 1 dimension desn´t contain point '; /* */

  var ray = [ 0, 2 ];
  var point = [ - 3 ];
  var expected = false;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor,  expected );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.getFactor( ) );
  test.shouldThrowErrorSync( () => _.ray.getFactor( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.getFactor( 'ray', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.getFactor( [ 1, 1, 2, 2 ], 'factor') );
  test.shouldThrowErrorSync( () => _.ray.getFactor( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.getFactor( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.getFactor( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.getFactor( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.getFactor( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.getFactor( [ 1, 1, 2, 2 ], [ 1, 2, 3, 4 ] ) );

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

  test.case = 'Rays are parallel ( src1Ray is a point )'; /* */

  var src1Ray = [ 3, 7, 1, 0, 0, 0 ];
  var src2Ray = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel ( src2Ray is a point )'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 0, 0, 0 ];
  var expected = true;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel ( src2Ray is a point - 4D )'; /* */

  var src1Ray = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 1, 0, 0, 0, 0 ];
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

  test.case = 'Rays are parallel to x'; /* */

  var src1Ray = [ 3, 7, 1, 1, 0, 0 ];
  var src2Ray = [ 3, 7, 1, 1, 0, 0 ];
  var expected = true;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel but in a opposite direction'; /* */

  var src1Ray = [ 3, 7, 1, 1, 0, 0 ];
  var src2Ray = [ 3, 7, 1, - 1, 0, 0 ];
  var expected = true;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel 2D'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 7, - 2, - 2 ];
  var expected = true;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are not parallel 2D'; /* */

  var src1Ray = [ 3, 7, 1, - 1 ];
  var src2Ray = [ 3, 7, 7, 7 ];
  var expected = false;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel 4D'; /* */

  var src1Ray = [ 0, 0, 1, 1, 0, 1, 2, 3 ];
  var src2Ray = [ 3, 7, - 2, - 2, 0, 2, 4, 6 ];
  var expected = true;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are not parallel 4D'; /* */

  var src1Ray = [ 3, 7, 1, - 1, 3, 7, 1, - 1 ];
  var src2Ray = [ 3, 7, 7, 7, 3, 7, 7, 7 ];
  var expected = false;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel 6D'; /* */

  var src1Ray = [ 0, 0, 1, 1, 1, 1, 0, 1, 2, 3, 4, 5 ];
  var src2Ray = [ 3, 7, - 2, - 2, 0, 0, 0, 2, 4, 6, 8, 10 ];
  var expected = true;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are not parallel 6D'; /* */

  var src1Ray = [ 0, 0, 1, 1, 1, 1, 0, 1, 2, 3, 4, 5 ];
  var src2Ray = [ 3, 7, - 2, - 2, 0, 0, 0, 2, 8, 6, 8, 10 ];
  var expected = false;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.rayParallel( ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel( [ 0, 0, 0 ] ) );
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
  var expected = _.vector.from( [ 0, 0 ] );

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  var oldSrc1Ray = [ 0, 0, 1, 1 ];
  test.equivalent( src1Ray, oldSrc1Ray );

  var oldSrc2Ray = [ 0, 0, 2, 2 ];
  test.equivalent( src2Ray, oldSrc2Ray );

  test.case = 'Rays are the same'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 0, 0, 1, 1 ];
  var expected = _.vector.from( [ 0, 0 ] );

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
  var expected = _.vector.from( [ 0, 0 ] );

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Rays intersect '; /* */

  var src1Ray = [ 0, 0, 1, 0 ];
  var src2Ray = [ -2, -6, 1, 2 ];
  var expected = _.vector.from( [ 1, 3 ] );

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.equivalent( isIntersectionFactors, expected );

  test.case = 'Rays are perpendicular '; /* */

  var src1Ray = [ -3, 0, 1, 0 ];
  var src2Ray = [ 0, -2, 0, 1 ];
  var expected = _.vector.from( [ 3, 2 ] );

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.equivalent( isIntersectionFactors, expected );

  test.case = 'Rays 3D intersection'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 3, 3, 0, 1, 4 ];
  var expected = _.vector.from( [ 3, 0 ] );

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.equivalent( isIntersectionFactors, expected );

  test.case = 'Rays 3D no intersection'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 3, 5, 0, 1, 4 ];
  var expected = 0;

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Rays 4D intersection'; /* */

  var src1Ray = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Ray = [ 3, 3, 3, 3, 0, 2, 1, 4 ];
  var expected = _.vector.from( [ 3, 0 ] );

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.equivalent( isIntersectionFactors, expected );

  test.case = 'Rays 4D no intersection'; /* */

  var src1Ray = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Ray = [ 3, 3, 5, 3, 0, 0, 1, 4 ];
  var expected = 0;

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Rays 4D no intersection out of 3D intersection'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1, 1, -1 ];
  var src2Ray = [ 3, 3, 3, 2, 0, 1, 4, 3 ];
  var expected = 0;

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Rays 8D intersection'; /* */

  var src1Ray = [ 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1  ];
  var src2Ray = [ 3, 3, 3, 3, 3, 3, 3, 3, 0, 2, 1, 4, 0, 2, 1, 4 ];
  var expected = _.vector.from( [ 3, 0 ] );

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.equivalent( isIntersectionFactors, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors( ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors( [ 0, 0, 0 ] ) );
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

function rayIntersectionFactors2( test )
{
  test.case = 'Source rays remain unchanged'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 0, 0, 2, 2 ];
  var expected = [ 0, 0 ];

  var isIntersectionFactors = _.ray.rayIntersectionFactors2( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  var oldSrc1Ray = [ 0, 0, 1, 1 ];
  test.equivalent( src1Ray, oldSrc1Ray );

  var oldSrc2Ray = [ 0, 0, 2, 2 ];
  test.equivalent( src2Ray, oldSrc2Ray );

  test.case = 'Rays are the same'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 0, 0, 1, 1 ];
  var expected = [ 0, 0 ];

  var isIntersectionFactors = _.ray.rayIntersectionFactors2( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Rays are parallel ( different origin - same direction )'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 1 ];
  var expected = 0;

  var isIntersectionFactors = _.ray.rayIntersectionFactors2( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Rays are parallel ( different origin - different direction )'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 7, 7, 7 ];
  var expected = 0;

  var isIntersectionFactors = _.ray.rayIntersectionFactors2( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Rays don´t intersect'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 0, 2, -1 ];
  var expected = 0;

  var isIntersectionFactors = _.ray.rayIntersectionFactors2( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Rays intersect in their origin'; /* */

  var src1Ray = [ 3, 7, 1, 0 ];
  var src2Ray = [ 3, 7, 0, 1 ];
  var expected = [ 0, 0 ];

  var isIntersectionFactors = _.ray.rayIntersectionFactors2( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Rays intersect '; /* */

  var src1Ray = [ 0, 0, 1, 0 ];
  var src2Ray = [ -2, -6, 1, 2 ];
  var expected = [ 1, 3 ];

  var isIntersectionFactors = _.ray.rayIntersectionFactors2( src1Ray, src2Ray );
  test.equivalent( isIntersectionFactors, expected );

  test.case = 'Rays are perpendicular '; /* */

  var src1Ray = [ -3, 0, 1, 0 ];
  var src2Ray = [ 0, -2, 0, 1 ];
  var expected = [ 3, 2 ];

  var isIntersectionFactors = _.ray.rayIntersectionFactors2( src1Ray, src2Ray );
  test.equivalent( isIntersectionFactors, expected );

  test.case = 'Rays 3D intersection'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 3, 3, 0, 1, 4 ];
  var expected = [ 3, 0 ];

  var isIntersectionFactors = _.ray.rayIntersectionFactors2( src1Ray, src2Ray );
  test.equivalent( isIntersectionFactors, expected );

  test.case = 'Rays 3D no intersection'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 3, 5, 0, 1, 4 ];
  var expected = 0;

  var isIntersectionFactors = _.ray.rayIntersectionFactors2( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Rays 4D intersection'; /* */

  var src1Ray = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Ray = [ 3, 3, 3, 3, 0, 2, 1, 4 ];
  var expected = [ 3, 0 ];

  var isIntersectionFactors = _.ray.rayIntersectionFactors2( src1Ray, src2Ray );
  test.equivalent( isIntersectionFactors, expected );

  test.case = 'Rays 4D no intersection'; /* */

  var src1Ray = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Ray = [ 3, 3, 5, 3, 0, 0, 1, 4 ];
  var expected = 0;

  var isIntersectionFactors = _.ray.rayIntersectionFactors2( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Rays 4D no intersection out of 3D intersection'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1, 1, -1 ];
  var src2Ray = [ 3, 3, 3, 2, 0, 1, 4, 3 ];
  var expected = 0;

  var isIntersectionFactors = _.ray.rayIntersectionFactors2( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Rays 8D intersection'; /* */

  var src1Ray = [ 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1  ];
  var src2Ray = [ 3, 3, 3, 3, 3, 3, 3, 3, 0, 2, 1, 4, 0, 2, 1, 4 ];
  var expected = [ 3, 0 ];

  var isIntersectionFactors = _.ray.rayIntersectionFactors2( src1Ray, src2Ray );
  test.equivalent( isIntersectionFactors, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors2( ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors2( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors2( 'ray', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors2( [ 1, 1, 2, 2 ], 'ray') );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors2( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors2( null, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors2( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors2( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors2( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors2( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors2( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

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

  test.case = 'Rays don´t intersect 3D'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 0, 1, 2, 2, -1 ];
  var expected = 0;

  var isIntersectionPoints = _.ray.rayIntersectionPoints( src1Ray, src2Ray );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Rays intersect 3D'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 3, 1, 4 ];
  var expected = [ [ 9, 9, 9 ], [ 9, 9, 9 ] ];

  var isIntersectionPoints = _.ray.rayIntersectionPoints( src1Ray, src2Ray );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Rays don´t intersect 4D'; /* */

  var src1Ray = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Ray = [ 3, 0, 1, 4, 2, 2, 2, -1 ];
  var expected = 0;

  var isIntersectionPoints = _.ray.rayIntersectionPoints( src1Ray, src2Ray );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Rays intersect 4D'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 4, 3, 1, 4, 3 ];
  var expected = [ [ 9, 9, 9, 10 ], [ 9, 9, 9, 10 ] ];

  var isIntersectionPoints = _.ray.rayIntersectionPoints( src1Ray, src2Ray );
  test.identical( isIntersectionPoints, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoints( ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoints( [ 0, 0, 0 ] ) );
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

  test.case = 'Rays don´t intersect 3D'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 0, 1, 2, 2, -1 ];
  var expected = 0;

  var isIntersectionPoint = _.ray.rayIntersectionPoint( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays intersect 3D'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 3, 1, 4 ];
  var expected = [ 9, 9, 9 ];

  var isIntersectionPoint = _.ray.rayIntersectionPoint( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays don´t intersect 4D'; /* */

  var src1Ray = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Ray = [ 3, 0, 1, 4, 2, 2, 2, -1 ];
  var expected = 0;

  var isIntersectionPoint = _.ray.rayIntersectionPoint( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays intersect 4D'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 4, 3, 1, 4, 3 ];
  var expected = [ 9, 9, 9, 10 ];

  var isIntersectionPoint = _.ray.rayIntersectionPoint( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoint( ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoint( [ 0, 0, 0 ] ) );
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

//

function rayIntersectionPointAccurate( test )
{
  test.case = 'Source rays remain unchanged'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 0, 0, 2, 2 ];
  var expected = [ 0, 0 ];

  var isIntersectionPoint = _.ray.rayIntersectionPointAccurate( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  var oldSrc1Ray = [ 0, 0, 1, 1 ];
  test.equivalent( src1Ray, oldSrc1Ray );

  var oldSrc2Ray = [ 0, 0, 2, 2 ];
  test.equivalent( src2Ray, oldSrc2Ray );

  test.case = 'Rays are the same'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 0, 0, 1, 1 ];
  var expected = [ 0, 0 ];

  var isIntersectionPoint = _.ray.rayIntersectionPointAccurate( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays are parallel ( different origin - same direction )'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 1 ];
  var expected = 0;

  var isIntersectionPoint = _.ray.rayIntersectionPointAccurate( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays are parallel ( different origin - different direction )'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 7, 7, 7 ];
  var expected = 0;

  var isIntersectionPoint = _.ray.rayIntersectionPointAccurate( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays don´t intersect'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 0, 2, -1 ];
  var expected = 0;

  var isIntersectionPoint = _.ray.rayIntersectionPointAccurate( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays intersect in their origin'; /* */

  var src1Ray = [ 3, 7, 1, 0 ];
  var src2Ray = [ 3, 7, 0, 1 ];
  var expected = [ 3, 7 ];

  var isIntersectionPoint = _.ray.rayIntersectionPointAccurate( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays intersect '; /* */

  var src1Ray = [ 0, 0, 1, 0 ];
  var src2Ray = [ -2, -6, 1, 2 ];
  var expected = [ 1, 0 ];

  var isIntersectionPoint = _.ray.rayIntersectionPointAccurate( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays are perpendicular '; /* */

  var src1Ray = [ -3, 0, 1, 0 ];
  var src2Ray = [ 0, -2, 0, 1 ];
  var expected = [ 0, 0 ];

  var isIntersectionPoint = _.ray.rayIntersectionPointAccurate( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays don´t intersect 3D'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 0, 1, 2, 2, -1 ];
  var expected = 0;

  var isIntersectionPoint = _.ray.rayIntersectionPointAccurate( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays intersect 3D'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 3, 1, 4 ];
  var expected = [ 9, 9, 9 ];

  var isIntersectionPoint = _.ray.rayIntersectionPointAccurate( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays don´t intersect 4D'; /* */

  var src1Ray = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Ray = [ 3, 0, 1, 4, 2, 2, 2, -1 ];
  var expected = 0;

  var isIntersectionPoint = _.ray.rayIntersectionPointAccurate( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays intersect 4D'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 4, 3, 1, 4, 3 ];
  var expected = [ 9, 9, 9, 10 ];

  var isIntersectionPoint = _.ray.rayIntersectionPointAccurate( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPointAccurate( ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPointAccurate( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPointAccurate( 'ray', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPointAccurate( [ 1, 1, 2, 2 ], 'ray') );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPointAccurate( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPointAccurate( null, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPointAccurate( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPointAccurate( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPointAccurate( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPointAccurate( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPointAccurate( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function pointContains( test )
{

  test.case = 'Ray and Point remain unchanged'; /* */

  var ray = [  - 1,  - 1 , 1, 1 ];
  var point = [ 0, 0 ];
  var expected = true;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool, expected );

  var oldRay = [  - 1,  - 1 , 1, 1 ];
  test.identical( ray, oldRay );

  var oldPoint = [ 0, 0 ];
  test.identical( point, oldPoint );

  test.case = 'Null ray contains empty point'; /* */

  var ray = null;
  var point = [ 0, 0, 0 ];
  var expected = true;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool,  expected );

  test.case = 'Point ray contains Point'; /* */

  var ray = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = true;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool,  expected );

  test.case = 'Ray contains point'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var point = [  1, 1, 1 ];
  var expected = true;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool,  expected );

  test.case = 'Ray over point'; /* */

  var ray = [ 0, 0, 0, 0, 0, 2 ];
  var point = [ 0, 1, 4 ];
  var expected = false;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool,  expected );

  test.case = 'Point closer to origin'; /* */

  var ray = [ 0, 0, 0, 0, 0, 2 ];
  var point = [ 0, 0, -2 ];
  var expected = false;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool,  expected );

  test.case = 'Ray ( normalized to 1 ) contains point'; /* */

  var ray = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var point = [ 0.500, 0.500, 0.000 ];
  var expected = true;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool,  expected );

  test.case = 'Ray ( normalized to 1 ) doesn´t contain point'; /* */

  var ray = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var point = [ 0.050, 0.500, - 0.303 ];
  var expected = false;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool,  expected );

  test.case = 'Ray of four dimensions contains point'; /* */

  var ray = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0 , 0 ];
  var expected = true;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool,  expected );

  test.case = 'Ray of four dimensions doesn´t contain point'; /* */

  var ray = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, - 2, 0 , 2 ];
  var expected = false;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool,  expected );

  test.case = 'Ray of 7 dimensions contains point'; /* */

  var ray = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 1, 1, 1, 1, 1, 1, 1 ];
  var point = [ - 1, -1, -1, -1, -1, -1, -1 ];
  var expected = true;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool,  expected );

  test.case = 'Ray of 7 dimensions doesn´t contain point'; /* */

  var ray = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 1, 1, 1, 1, 1, 1, 1 ];
  var point = [ 0, 4, 3.5, 0, 5, 2, 2 ];
  var expected = false;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool,  expected );

  test.case = 'Ray of 1 dimension contains point'; /* */

  var ray = [ 0, 2 ];
  var point = [ 1 ];
  var expected = true;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool,  expected );

  test.case = 'Ray of 1 dimension desn´t contain point '; /* */

  var ray = [ 0, 2 ];
  var point = [ - 3 ];
  var expected = false;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool,  expected );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.pointContains( ) );
  test.shouldThrowErrorSync( () => _.ray.pointContains( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.pointContains( 'ray', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.pointContains( [ 1, 1, 2, 2 ], 'ray') );
  test.shouldThrowErrorSync( () => _.ray.pointContains( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.pointContains( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.pointContains( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.pointContains( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.pointContains( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.pointContains( [ 1, 1, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function pointDistance( test )
{

  test.case = 'Ray and Point remain unchanged'; /* */

  var ray = [  - 1,  - 1 , 1, 1 ];
  var point = [ 0, 0 ];
  var expected = 0;

  var gotDistance = _.ray.pointDistance( ray, point );
  test.identical( gotDistance, expected );

  var oldRay = [  - 1,  - 1 , 1, 1 ];
  test.identical( ray, oldRay );

  var oldPoint = [ 0, 0 ];
  test.identical( point, oldPoint );

  test.case = 'Null ray Distance empty point'; /* */

  var ray = null;
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotDistance = _.ray.pointDistance( ray, point );
  test.identical( gotDistance,  expected );

  test.case = 'Point ray Distance same Point'; /* */

  var ray = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotDistance = _.ray.pointDistance( ray, point );
  test.identical( gotDistance,  expected );

  test.case = 'Point ray Distance other Point'; /* */

  var ray = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 3, 4, 0 ];
  var expected = 5;

  var gotDistance = _.ray.pointDistance( ray, point );
  test.identical( gotDistance,  expected );

  test.case = 'Ray contains point'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var point = [  1, 1, 1 ];
  var expected = 0;

  var gotDistance = _.ray.pointDistance( ray, point );
  test.identical( gotDistance,  expected );

  test.case = 'Ray over point'; /* */

  var ray = [ 0, 0, 0, 0, 0, 2 ];
  var point = [ 0, 1, 4 ];
  var expected = 1;

  var gotDistance = _.ray.pointDistance( ray, point );
  test.identical( gotDistance,  expected );

  test.case = 'Point closer to origin'; /* */

  var ray = [ 0, 0, 0, 0, 0, 2 ];
  var point = [ 0, 0, -2 ];
  var expected = 2;

  var gotDistance = _.ray.pointDistance( ray, point );
  test.identical( gotDistance,  expected );

  test.case = 'Ray ( normalized to 1 ) Distance point'; /* */

  var ray = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var point = [ 0.500, 0.500, 0.000 ];
  var expected = 0;

  var gotDistance = _.ray.pointDistance( ray, point );
  test.identical( gotDistance,  expected );

  test.case = 'Ray ( normalized to 1 ) doesn´t contain point'; /* */

  var ray = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var point = [ 0.050, 0.500, - 0.303 ];
  var expected = 0.568342039793567;

  var gotDistance = _.ray.pointDistance( ray, point );
  test.equivalent( gotDistance,  expected );

  test.case = 'Ray of four dimensions distance '; /* */

  var ray = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0 , 4 ];
  var expected = Math.sqrt( 12 );

  var gotDistance = _.ray.pointDistance( ray, point );
  test.identical( gotDistance,  expected );

  test.case = 'Ray of 7 dimensions distance'; /* */

  var ray = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 0, 0, 0, 0, 0, 0, 1 ];
  var point = [ 2, 2, 2, 2, 2, 2, 2 ];
  var expected = Math.sqrt( 96 );

  var gotDistance = _.ray.pointDistance( ray, point );
  test.identical( gotDistance,  expected );

  test.case = 'Ray of 1 dimension contains point'; /* */

  var ray = [ 0, 2 ];
  var point = [ 1 ];
  var expected = 0;

  var gotDistance = _.ray.pointDistance( ray, point );
  test.identical( gotDistance,  expected );

  test.case = 'Ray of 1 dimension distance'; /* */

  var ray = [ 0, 2 ];
  var point = [ - 3 ];
  var expected = 3;

  var gotDistance = _.ray.pointDistance( ray, point );
  test.identical( gotDistance,  expected );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.pointDistance( ) );
  test.shouldThrowErrorSync( () => _.ray.pointDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.pointDistance( 'ray', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.pointDistance( [ 1, 1, 2, 2 ], 'ray') );
  test.shouldThrowErrorSync( () => _.ray.pointDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.pointDistance( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.pointDistance( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.pointDistance( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.pointDistance( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.pointDistance( [ 1, 1, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function pointClosestPoint( test )
{

  test.case = 'Ray and Point remain unchanged'; /* */

  var ray = [  - 1,  - 1 , 1, 1 ];
  var point = [ 0, 0 ];
  var expected = [ 0, 0 ];

  var gotClosestPoint = _.ray.pointClosestPoint( ray, point );
  test.identical( gotClosestPoint, expected );

  var oldRay = [  - 1,  - 1 , 1, 1 ];
  test.identical( ray, oldRay );

  var oldPoint = [ 0, 0 ];
  test.identical( point, oldPoint );

  test.case = 'Null ray - empty point'; /* */

  var ray = null;
  var point = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0 ];

  var gotClosestPoint = _.ray.pointClosestPoint( ray, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Point ray - same Point'; /* */

  var ray = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0 ];

  var gotClosestPoint = _.ray.pointClosestPoint( ray, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Point ray - other Point'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var point = [ 3, 4, 0 ];
  var expected = [ 1, 2, 3 ];

  var gotClosestPoint = _.ray.pointClosestPoint( ray, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Ray contains point'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ 1, 1, 1 ];
  var expected = [ 1, 1, 1 ];

  var gotClosestPoint = _.ray.pointClosestPoint( ray, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Ray over point'; /* */

  var ray = [ 0, 0, 0, 0, 0, 2 ];
  var point = [ 0, 1, 4 ];
  var expected = [ 0, 0, 4 ];

  var gotClosestPoint = _.ray.pointClosestPoint( ray, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Point closer to origin'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ - 2, - 2, - 2 ];
  var expected = [ 0, 0, 0 ];

  var gotClosestPoint = _.ray.pointClosestPoint( ray, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Ray ( normalized to 1 ) Distance point'; /* */

  var ray = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var point = [ 0.500, 0.500, 0.000 ];
  var expected = [ 0.5, 0.5, 0 ];

  var gotClosestPoint = _.ray.pointClosestPoint( ray, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Ray ( normalized to 1 ) doesn´t contain point'; /* */

  var ray = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var point = [ 0.050, 0.500, - 0.303 ];
  var expected = [ 0.02572500470627867, 0.10157398765468795, 0.10157398765468795 ];

  var gotClosestPoint = _.ray.pointClosestPoint( ray, point );
  test.equivalent( gotClosestPoint,  expected );

  test.case = 'Ray of four dimensions distance '; /* */

  var ray = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0 , 4 ];
  var expected = [ 1, 1, 1, 1 ];

  var gotClosestPoint = _.ray.pointClosestPoint( ray, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Ray of 7 dimensions distance'; /* */

  var ray = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 0, 0, 0, 0, 0, 0, 1 ];
  var point = [ 2, 2, 2, 2, 2, 2, 2 ];
  var expected = [ - 2, - 2, - 2, - 2, - 2, - 2, 2 ];

  var gotClosestPoint = _.ray.pointClosestPoint( ray, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Ray of 1 dimension contains point'; /* */

  var ray = [ 0, 2 ];
  var point = [ 1 ];
  var expected = [ 1 ];

  var gotClosestPoint = _.ray.pointClosestPoint( ray, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Ray of 1 dimension distance'; /* */

  var ray = [ 0, 2 ];
  var point = [ - 3 ];
  var expected = [ 0 ];

  var gotClosestPoint = _.ray.pointClosestPoint( ray, point );
  test.identical( gotClosestPoint,  expected );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.pointClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.ray.pointClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.pointClosestPoint( 'ray', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.pointClosestPoint( [ 1, 1, 2, 2 ], 'ray') );
  test.shouldThrowErrorSync( () => _.ray.pointClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.pointClosestPoint( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.pointClosestPoint( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.pointClosestPoint( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.pointClosestPoint( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.pointClosestPoint( [ 1, 1, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function boxIntersects( test )
{

  test.case = 'Ray and box remain unchanged'; /* */

  var ray = [  - 1,  - 1, -1, 1, 1, 1 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.ray.boxIntersects( ray, box );
  test.identical( gotBool, expected );

  var oldRay = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( ray, oldRay );

  var oldbox = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( box, oldbox );

  test.case = 'Null ray - empty box'; /* */

  var ray = null;
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = true;

  var gotBool = _.ray.boxIntersects( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'box ray - same box'; /* */

  var ray = [ 0, 0, 0, 0, 0, 0 ];
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = true;

  var gotBool = _.ray.boxIntersects( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'point ray - no intersection'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var box = [ 1, 2, 4, 3, 4, 0 ];
  var expected = false;

  var gotBool = _.ray.boxIntersects( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'point ray in box'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var box = [ 1, 2, 2, 3, 4, 4 ];
  var expected = true;

  var gotBool = _.ray.boxIntersects( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'Ray and box intersect'; /* */

  var ray = [ -2, -2, -2, 2, 2, 2 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.ray.boxIntersects( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'Ray over box'; /* */

  var ray = [ 0, 0, 4, 0, 0, 2 ];
  var box = [ 0, 1, 1, 3, 7, 3 ];
  var expected = false;

  var gotBool = _.ray.boxIntersects( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'box closer to origin'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var box = [ - 2, - 2, - 2, -1, -1, -1 ];
  var expected = false;

  var gotBool = _.ray.boxIntersects( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'Ray ( normalized to 1 ) intersection'; /* */

  var ray = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var box = [ 0.500, 0.123, 0, 0.734, 0.900, 0.837 ];
  var expected = true;

  var gotBool = _.ray.boxIntersects( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'Ray ( normalized to 1 ) doesn´t contain box'; /* */

  var ray = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var box = [ 0.12322, 0.03232, 0, 0.050, 0.500, - 0.303 ];
  var expected = false;

  var gotBool = _.ray.boxIntersects( ray, box );
  test.equivalent( gotBool,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.boxIntersects( ) );
  test.shouldThrowErrorSync( () => _.ray.boxIntersects( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.boxIntersects( 'ray', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.boxIntersects( [ 1, 1, 2, 2 ], 'box') );
  test.shouldThrowErrorSync( () => _.ray.boxIntersects( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.boxIntersects( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.boxIntersects( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.boxIntersects( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.boxIntersects( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.boxIntersects( [ 1, 1, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function boxDistance( test )
{
  test.case = 'Ray and box remain unchanged'; /* */

  var ray = [  - 1,  - 1, -1, 1, 1, 1 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotBool = _.ray.boxDistance( ray, box );
  test.identical( gotBool, expected );

  var oldRay = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( ray, oldRay );

  var oldbox = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( box, oldbox );

  test.case = 'Null ray - empty box'; /* */

  var ray = null;
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = 0;

  var gotBool = _.ray.boxDistance( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'box ray - same box'; /* */

  var ray = [ 0, 0, 0, 0, 0, 0 ];
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = 0;

  var gotBool = _.ray.boxDistance( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'point ray'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var box = [ 1, 2, 4, 3, 4, 0 ];
  var expected = 1;

  var gotBool = _.ray.boxDistance( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'point ray in box'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var box = [ 1, 2, 2, 3, 4, 4 ];
  var expected = 0;

  var gotBool = _.ray.boxDistance( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'Ray and box intersect'; /* */

  var ray = [ -2, -2, -2, 2, 2, 2 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotBool = _.ray.boxDistance( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'Ray over box'; /* */

  var ray = [ 0, 0, 4, 0, 0, 2 ];
  var box = [ 0, 1, 1, 3, 7, 3 ];
  var expected = Math.sqrt( 2 );

  var gotBool = _.ray.boxDistance( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'box corner closer to origin'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var box = [ - 2, - 2, - 2, -1, -1, -1 ];
  var expected = Math.sqrt( 3 );

  var gotBool = _.ray.boxDistance( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'box side closer to origin'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var box = [ -1, -1, -1, 0.5, 0.5, - 0.1 ];
  var expected = 0.1;

  var gotBool = _.ray.boxDistance( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'Ray ( normalized to 1 ) intersection'; /* */

  var ray = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var box = [ 0.500, 0.123, 0, 0.734, 0.900, 0.837 ];
  var expected = 0;

  var gotBool = _.ray.boxDistance( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'Ray ( normalized to 1 ) doesn´t contain box'; /* */

  var ray = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var box = [ 0.12322, 0.03232, 0, 0.050, 0.500, - 0.303 ];
  var expected = 0.050638706410019246;

  var gotBool = _.ray.boxDistance( ray, box );
  test.equivalent( gotBool,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.boxDistance( ) );
  test.shouldThrowErrorSync( () => _.ray.boxDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.boxDistance( 'ray', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.boxDistance( [ 1, 1, 2, 2 ], 'box') );
  test.shouldThrowErrorSync( () => _.ray.boxDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.boxDistance( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.boxDistance( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.boxDistance( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.boxDistance( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.boxDistance( [ 1, 1, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function boxClosestPoint( test )
{
  test.case = 'Ray and box remain unchanged'; /* */

  var ray = [  - 1,  - 1, -1, 1, 1, 1 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotPoint = _.ray.boxClosestPoint( ray, box );
  test.identical( gotPoint, expected );

  var oldRay = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( ray, oldRay );

  var oldbox = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( box, oldbox );

  test.case = 'Null ray - empty box'; /* */

  var ray = null;
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = 0;

  var gotPoint = _.ray.boxClosestPoint( ray, box );
  test.identical( gotPoint,  expected );

  test.case = 'box ray - same box'; /* */

  var ray = [ 0, 0, 0, 0, 0, 0 ];
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = 0;

  var gotPoint = _.ray.boxClosestPoint( ray, box );
  test.identical( gotPoint,  expected );

  test.case = 'point ray'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var box = [ 1, 2, 4, 3, 4, 0 ];
  var expected = [ 1, 2, 3 ];

  var gotPoint = _.ray.boxClosestPoint( ray, box );
  test.identical( gotPoint,  expected );

  test.case = 'point ray in box'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var box = [ 1, 2, 2, 3, 4, 4 ];
  var expected = 0;

  var gotPoint = _.ray.boxClosestPoint( ray, box );
  test.identical( gotPoint,  expected );

  test.case = 'Ray and box intersect'; /* */

  var ray = [ -2, -2, -2, 2, 2, 2 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotPoint = _.ray.boxClosestPoint( ray, box );
  test.identical( gotPoint,  expected );

  test.case = 'Ray over box'; /* */

  var ray = [ 0, 0, 4, 0, 0, 2 ];
  var box = [ 0, 1, 1, 3, 7, 3 ];
  var expected = [ 0, 0, 4 ];

  var gotPoint = _.ray.boxClosestPoint( ray, box );
  test.identical( gotPoint,  expected );

  test.case = 'box corner closer to origin'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var box = [ - 2, - 2, - 2, -1, -1, -1 ];
  var expected = [ 0, 0, 0 ];

  var gotPoint = _.ray.boxClosestPoint( ray, box );
  test.identical( gotPoint,  expected );

  test.case = 'box side closer to origin'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var box = [ -1, -1, -1, 0.5, 0.5, - 0.1 ];
  var expected = [ 0, 0, 0 ];

  var gotPoint = _.ray.boxClosestPoint( ray, box );
  test.identical( gotPoint,  expected );

  test.case = 'box corner not close to origin'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var box = [ 6, 7, 8, 6, 9, 10 ];
  var expected = [ 7, 7, 7 ];

  var gotPoint = _.ray.boxClosestPoint( ray, box );
  test.identical( gotPoint,  expected );

  test.case = 'Ray ( normalized to 1 ) intersection'; /* */

  var ray = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var box = [ 0.500, 0.123, 0, 0.734, 0.900, 0.837 ];
  var expected = 0;

  var gotPoint = _.ray.boxClosestPoint( ray, box );
  test.identical( gotPoint,  expected );

  test.case = 'Ray ( normalized to 1 ) doesn´t contain box'; /* */

  var ray = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var box = [ 0.12322, 0.03232, 0, 0.050, 0.500, - 0.303 ];
  var expected = [ 0.005519293548276563, 0.021792674525669315, 0.021792674525669315 ];

  var gotPoint = _.ray.boxClosestPoint( ray, box );
  test.equivalent( gotPoint,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.boxClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.ray.boxClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.boxClosestPoint( 'ray', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.boxClosestPoint( [ 1, 1, 2, 2 ], 'box') );
  test.shouldThrowErrorSync( () => _.ray.boxClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.boxClosestPoint( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.boxClosestPoint( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.boxClosestPoint( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.boxClosestPoint( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.boxClosestPoint( [ 1, 1, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function sphereIntersects( test )
{

  test.case = 'Ray and sphere remain unchanged'; /* */

  var ray = [  - 1,  - 1, -1, 1, 1, 1 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.ray.sphereIntersects( ray, sphere );
  test.identical( gotBool, expected );

  var oldRay = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( ray, oldRay );

  var oldsphere = [ 0, 0, 0, 1 ];
  test.identical( sphere, oldsphere );

  test.case = 'Null ray - empty sphere'; /* */

  var ray = null;
  var sphere = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.ray.sphereIntersects( ray, sphere );
  test.identical( gotBool,  expected );

  test.case = 'point ray center of sphere'; /* */

  var ray = [ 0, 0, 0, 0, 0, 0 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.ray.sphereIntersects( ray, sphere );
  test.identical( gotBool,  expected );

  test.case = 'point ray - no intersection'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var sphere = [ 4, 3, 4, 1 ];
  var expected = false;

  var gotBool = _.ray.sphereIntersects( ray, sphere );
  test.identical( gotBool,  expected );

  test.case = 'point ray in sphere'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var sphere = [ 2, 2, 2, 2 ];
  var expected = true;

  var gotBool = _.ray.sphereIntersects( ray, sphere );
  test.identical( gotBool,  expected );

  test.case = 'Ray and sphere intersect'; /* */

  var ray = [ -2, -2, -2, 2, 2, 2 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.ray.sphereIntersects( ray, sphere );
  test.identical( gotBool,  expected );

  test.case = 'Ray over sphere'; /* */

  var ray = [ 0, -6, 4, 0, 1, 0 ];
  var sphere = [ 0, 0, 0, 3 ];
  var expected = false;

  var gotBool = _.ray.sphereIntersects( ray, sphere );
  test.identical( gotBool,  expected );

  test.case = 'sphere closer to origin'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var sphere = [ - 2, - 2, - 2, 0.5 ];
  var expected = false;

  var gotBool = _.ray.sphereIntersects( ray, sphere );
  test.identical( gotBool,  expected );

  test.case = 'Ray ( normalized to 1 ) intersection'; /* */

  var ray = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var sphere = [ 0, 2, 0, 2 ];
  var expected = true;

  var gotBool = _.ray.sphereIntersects( ray, sphere );
  test.identical( gotBool,  expected );

  test.case = 'Ray ( normalized to 1 ) no intersection'; /* */

  var ray = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var sphere = [ 3, 3, 3, 1 ];
  var expected = false;

  var gotBool = _.ray.sphereIntersects( ray, sphere );
  test.equivalent( gotBool,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.sphereIntersects( ) );
  test.shouldThrowErrorSync( () => _.ray.sphereIntersects( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.sphereIntersects( 'ray', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.sphereIntersects( [ 1, 1, 1, 2, 2, 2 ], 'sphere') );
  test.shouldThrowErrorSync( () => _.ray.sphereIntersects( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.sphereIntersects( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.sphereIntersects( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.sphereIntersects( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.sphereIntersects( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.sphereIntersects( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4, 5, 6 ] ) );

}

//

function sphereDistance( test )
{

  test.case = 'Ray and sphere remain unchanged'; /* */

  var ray = [  - 1,  - 1, -1, 1, 1, 1 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.ray.sphereDistance( ray, sphere );
  test.identical( gotDistance, expected );

  var oldRay = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( ray, oldRay );

  var oldsphere = [ 0, 0, 0, 1 ];
  test.identical( sphere, oldsphere );

  test.case = 'Null ray - empty sphere'; /* */

  var ray = null;
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.ray.sphereDistance( ray, sphere );
  test.identical( gotDistance,  expected );

  test.case = 'point ray center of sphere'; /* */

  var ray = [ 0, 0, 0, 0, 0, 0 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.ray.sphereDistance( ray, sphere );
  test.identical( gotDistance,  expected );

  test.case = 'point ray - no intersection'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var sphere = [ 4, 3, 4, 1 ];
  var expected = Math.sqrt( 11 ) - 1;

  var gotDistance = _.ray.sphereDistance( ray, sphere );
  test.identical( gotDistance,  expected );

  test.case = 'point ray in sphere'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var sphere = [ 2, 2, 2, 2 ];
  var expected = 0;

  var gotDistance = _.ray.sphereDistance( ray, sphere );
  test.identical( gotDistance,  expected );

  test.case = 'Ray and sphere intersect'; /* */

  var ray = [ -2, -2, -2, 2, 2, 2 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.ray.sphereDistance( ray, sphere );
  test.identical( gotDistance,  expected );

  test.case = 'Ray over sphere'; /* */

  var ray = [ 0, -6, 4, 0, 1, 0 ];
  var sphere = [ 0, 0, 0, 3 ];
  var expected = 1;

  var gotDistance = _.ray.sphereDistance( ray, sphere );
  test.identical( gotDistance,  expected );

  test.case = 'sphere closer to origin'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var sphere = [ - 2, - 2, - 2, 0.5 ];
  var expected = Math.sqrt( 12 ) - 0.5;

  var gotDistance = _.ray.sphereDistance( ray, sphere );
  test.identical( gotDistance,  expected );

  test.case = 'Ray ( normalized to 1 ) intersection'; /* */

  var ray = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var sphere = [ 0, 2, 0, 2 ];
  var expected = 0;

  var gotDistance = _.ray.sphereDistance( ray, sphere );
  test.identical( gotDistance,  expected );

  test.case = 'Ray ( normalized to 1 ) no intersection'; /* */

  var ray = [ 0, 0, 0, 1 / Math.sqrt( 3 ), 1 / Math.sqrt( 3 ), 1 / Math.sqrt( 3 ) ];
  var sphere = [ 3, 0, 0, 1 ];
  var expected = Math.sqrt( 6 ) - 1;

  var gotDistance = _.ray.sphereDistance( ray, sphere );
  test.equivalent( gotDistance,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.sphereDistance( ) );
  test.shouldThrowErrorSync( () => _.ray.sphereDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.sphereDistance( 'ray', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.sphereDistance( [ 1, 1, 1, 2, 2, 2 ], 'sphere') );
  test.shouldThrowErrorSync( () => _.ray.sphereDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.sphereDistance( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.sphereDistance( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.sphereDistance( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.sphereDistance( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.sphereDistance( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4, 5, 6 ] ) );

}





// --
// define class
// --

var Self =
{

  name : 'Tools/Math/Ray',
  silencing : 1,
  enabled : 1,
  // routine: 'is',

  tests :
  {
    make : make,
    makeZero : makeZero,
    makeNil : makeNil,

    zero : zero,
    nil : nil,

    from: from,
    _from : _from,
    fromPair : fromPair,

    is : is,
    dimGet : dimGet,
    originGet : originGet,
    directionGet : directionGet,

    rayAt : rayAt,
    getFactor : getFactor,

    rayParallel : rayParallel,
    rayIntersectionFactors : rayIntersectionFactors,
    rayIntersectionFactors2 : rayIntersectionFactors2,
    rayIntersectionPoints : rayIntersectionPoints,
    rayIntersectionPoint : rayIntersectionPoint,
    rayIntersectionPointAccurate : rayIntersectionPointAccurate,

    pointContains : pointContains,
    pointDistance : pointDistance,
    pointClosestPoint : pointClosestPoint,

    boxIntersects : boxIntersects,
    boxDistance : boxDistance,
    boxClosestPoint : boxClosestPoint,

    sphereIntersects : sphereIntersects,
    sphereDistance : sphereDistance,

  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
