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

function fromPoints( test )
{

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.fromPoints( ));
  test.shouldThrowErrorSync( () => _.ray.fromPoints( null ));
  test.shouldThrowErrorSync( () => _.ray.fromPoints( undefined ));
  test.shouldThrowErrorSync( () => _.ray.fromPoints( [ 0, 0 ], [ 1, 1 ], [ 2, 2 ] ));

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

    dimGet : dimGet,
    originGet : originGet,
    directionGet : directionGet,

    fromPoints : fromPoints,

  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
