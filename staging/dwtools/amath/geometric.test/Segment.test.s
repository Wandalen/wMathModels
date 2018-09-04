( function _Segment_test_s_( ) {

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
  var gotSegment = _.segment.make( srcDim );
  var expected = [ 0, 0, 0, 0, 0, 0 ];
  test.identical( gotSegment, expected );
  test.is( gotSegment !== srcDim );

  test.case = 'srcDim null'; /* */

  var srcDim = null;
  var gotSegment = _.segment.make( srcDim );
  var expected = [ 0, 0, 0, 0, 0, 0 ];
  test.identical( gotSegment, expected );
  test.is( gotSegment !== srcDim );

  test.case = 'srcDim 2'; /* */

  var srcDim = 2;
  var gotSegment = _.segment.make( srcDim );
  var expected = [ 0, 0, 0, 0 ];
  test.identical( gotSegment, expected );
  test.is( gotSegment !== srcDim );

  test.case = 'srcDim array'; /* */

  var srcDim = [ 0, 1, 2, 3 ];
  var gotSegment = _.segment.make( srcDim );
  var expected = [ 0, 1, 2, 3 ];
  test.identical( gotSegment, expected );
  test.is( gotSegment !== srcDim );

  test.case = 'srcDim vector'; /* */

  var srcDim = _.vector.fromArray([ 0, 1, 2, 3 ]);
  var gotSegment = _.segment.make( srcDim );
  var expected = [ 0,1,2,3 ];
  test.identical( gotSegment, expected );
  test.is( gotSegment !== srcDim );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.segment.make( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.segment.make( 'segment' ));
}

//

function makeZero( test )
{
  test.case = 'srcDim undefined'; /* */

  var srcDim = undefined;
  var gotSegment = _.segment.makeZero( srcDim );
  var expected = [ 0, 0, 0, 0, 0, 0 ];
  test.identical( gotSegment, expected );
  test.is( gotSegment !== srcDim );

  test.case = 'srcDim null'; /* */

  var srcDim = null;
  var gotSegment = _.segment.makeZero( srcDim );
  var expected = [ 0, 0, 0, 0, 0, 0 ];
  test.identical( gotSegment, expected );
  test.is( gotSegment !== srcDim );

  test.case = 'srcDim 2'; /* */

  var srcDim = 2;
  var gotSegment = _.segment.makeZero( srcDim );
  var expected = [ 0, 0, 0, 0 ];
  test.identical( gotSegment, expected );
  test.is( gotSegment !== srcDim );

  test.case = 'srcDim array'; /* */

  var srcDim = [ 0, 1, 2, 3 ];
  var gotSegment = _.segment.makeZero( srcDim );
  var expected = [ 0, 0, 0, 0 ];
  test.identical( gotSegment, expected );
  test.is( gotSegment !== srcDim );

  test.case = 'srcDim vector'; /* */

  var srcDim = _.vector.fromArray([ 0, 1, 2, 3 ]);
  var gotSegment = _.segment.makeZero( srcDim );
  var expected = [ 0, 0, 0, 0 ];
  test.identical( gotSegment, expected );
  test.is( gotSegment !== srcDim );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.segment.makeZero( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.segment.makeZero( 'segment' ));

}

//

function makeNil( test )
{
  test.case = 'srcDim undefined'; /* */

  var srcDim = undefined;
  var gotSegment = _.segment.makeNil( srcDim );
  var expected = [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotSegment, expected );
  test.is( gotSegment !== srcDim );

  test.case = 'srcDim null'; /* */

  var srcDim = null;
  var gotSegment = _.segment.makeNil( srcDim );
  var expected = [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotSegment, expected );
  test.is( gotSegment !== srcDim );

  test.case = 'srcDim 2'; /* */

  var srcDim = 2;
  var gotSegment = _.segment.makeNil( srcDim );
  var expected = [ Infinity, Infinity, - Infinity, - Infinity ];
  test.identical( gotSegment, expected );
  test.is( gotSegment !== srcDim );

  test.case = 'srcDim array'; /* */

  var srcDim = [ 0, 1, 2, 3 ];
  var gotSegment = _.segment.makeNil( srcDim );
  var expected = [ Infinity, Infinity, - Infinity, - Infinity ];
  test.identical( gotSegment, expected );
  test.is( gotSegment !== srcDim );

  test.case = 'srcDim vector'; /* */

  var srcDim = _.vector.fromArray([ 0, 1, 2, 3 ]);
  var gotSegment = _.segment.makeNil( srcDim );
  var expected = [ Infinity, Infinity, - Infinity, - Infinity ];
  test.identical( gotSegment, expected );
  test.is( gotSegment !== srcDim );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.segment.makeNil( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.segment.makeNil( 'segment' ));
}

//

function zero( test )
{
  test.case = 'srcSegment undefined'; /* */

  var srcSegment = undefined;
  var gotSegment = _.segment.zero( srcSegment );
  var expected = [ 0, 0, 0, 0, 0, 0 ];
  test.identical( gotSegment, expected );
  test.is( gotSegment !== srcSegment );

  test.case = 'srcSegment null'; /* */

  var srcSegment = null;
  var gotSegment = _.segment.zero( srcSegment );
  var expected = [ 0, 0, 0, 0, 0, 0 ];
  test.identical( gotSegment, expected );
  test.is( gotSegment !== srcSegment );

  test.case = 'srcSegment 2'; /* */

  var srcSegment = 2;
  var gotSegment = _.segment.zero( srcSegment );
  var expected = [ 0, 0, 0, 0 ];
  test.identical( gotSegment, expected );
  test.is( gotSegment !== srcSegment );

  test.case = 'srcSegment array'; /* */

  var srcSegment = [ 0, 1, 2, 3 ];
  var gotSegment = _.segment.zero( srcSegment );
  var expected = [ 0, 0, 0, 0 ];
  test.identical( gotSegment, expected );
  test.is( gotSegment === srcSegment );

  test.case = 'srcSegment vector'; /* */

  var srcSegment = _.vector.fromArray( [ 0, 1, 2, 3 ] );
  var gotSegment = _.segment.zero( srcSegment );
  var expected =  _.vector.fromArray( [ 0, 0, 0, 0 ] );
  test.identical( gotSegment, expected );
  test.is( gotSegment === srcSegment );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.segment.zero( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.segment.zero( 'segment' ));

}

//

function nil( test )
{
  test.case = 'srcSegment undefined'; /* */

  var srcSegment = undefined;
  var gotSegment = _.segment.nil( srcSegment );
  var expected = [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotSegment, expected );
  test.is( gotSegment !== srcSegment );

  test.case = 'srcSegment null'; /* */

  var srcSegment = null;
  var gotSegment = _.segment.nil( srcSegment );
  var expected = [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotSegment, expected );
  test.is( gotSegment !== srcSegment );

  test.case = 'srcSegment 2'; /* */

  var srcSegment = 2;
  var gotSegment = _.segment.nil( srcSegment );
  var expected = [ Infinity, Infinity, - Infinity, - Infinity ];
  test.identical( gotSegment, expected );
  test.is( gotSegment !== srcSegment );

  test.case = 'srcSegment array'; /* */

  var srcSegment = [ 0, 1, 2, 3 ];
  var gotSegment = _.segment.nil( srcSegment );
  var expected = [ Infinity, Infinity, - Infinity, - Infinity ];
  test.identical( gotSegment, expected );
  test.is( gotSegment === srcSegment );

  test.case = 'srcSegment vector'; /* */

  var srcSegment = _.vector.fromArray( [ 0, 1, 2, 3 ] );
  var gotSegment = _.segment.nil( srcSegment );
  var expected = _.vector.fromArray( [ Infinity, Infinity, - Infinity, - Infinity ] );
  test.identical( gotSegment, expected );
  test.is( gotSegment === srcSegment );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.segment.nil( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.segment.nil( 'segment' ));
}

//

function from( test )
{
  test.case = 'Same instance returned - array'; /* */

  var srcSegment = [ 0, 0, 2, 2 ];
  var expected = [ 0, 0, 2, 2 ];

  var gotSegment = _.segment.from( srcSegment );
  test.identical( gotSegment, expected );
  test.is( srcSegment === gotSegment );

  test.case = 'Different instance returned - vector -> array'; /* */

  var srcSegment = _.vector.fromArray( [ 0, 0, 2, 2 ] );
  var expected = _.vector.fromArray( [ 0, 0, 2, 2 ] );

  var gotSegment = _.segment.from( srcSegment );
  test.identical( gotSegment, expected );
  test.is( srcSegment === gotSegment );

  test.case = 'Same instance returned - empty array'; /* */

  var srcSegment = [];
  var expected =  [];

  var gotSegment = _.segment.from( srcSegment );
  test.identical( gotSegment, expected );
  test.is( srcSegment === gotSegment );

  test.case = 'Different instance returned - null -> array'; /* */

  var srcSegment = null;
  var expected =  [ 0, 0, 0, 0, 0, 0 ];

  var gotSegment = _.segment.from( srcSegment );
  test.identical( gotSegment, expected );
  test.is( srcSegment !== gotSegment );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.segment.from( ));
  test.shouldThrowErrorSync( () => _.segment.from( [ 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.segment.from( [ 0, 0, 0, 0 ], [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.segment.from( 'segment' ));
  test.shouldThrowErrorSync( () => _.segment.from( NaN ));
  test.shouldThrowErrorSync( () => _.segment.from( undefined ));
}

//

function _from( test )
{
  test.case = 'Same instance returned - vector'; /* */

  var srcSegment = [ 0, 0, 2, 2 ];
  var expected = _.vector.from( [ 0, 0, 2, 2 ] );

  var gotSegment = _.segment._from( srcSegment );
  test.identical( gotSegment, expected );
  test.is( srcSegment !== gotSegment );

  test.case = 'Different instance returned - vector -> vector'; /* */

  var srcSegment = _.vector.from( [ 0, 0, 2, 2 ] );
  var expected = _.vector.from( [ 0, 0, 2, 2 ] );

  var gotSegment = _.segment._from( srcSegment );
  test.identical( gotSegment, expected );
  test.is( srcSegment === gotSegment );

  test.case = 'Same instance returned - empty vector'; /* */

  var srcSegment = [];
  var expected =  _.vector.from( [] );

  var gotSegment = _.segment._from( srcSegment );
  test.identical( gotSegment, expected );
  test.is( srcSegment !== gotSegment );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.segment._from( ));
  test.shouldThrowErrorSync( () => _.segment._from( [ 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.segment._from( [ 0, 0, 0, 0 ], [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.segment._from( 'segment' ));
  test.shouldThrowErrorSync( () => _.segment._from( NaN ));
  test.shouldThrowErrorSync( () => _.segment._from( null ));
  test.shouldThrowErrorSync( () => _.segment._from( undefined ));
}

//

function is( test )
{
  debugger;
  test.case = 'array'; /* */

  test.is( _.segment.is( [] ) );
  test.is( _.segment.is([ 0, 0 ]) );
  test.is( _.segment.is([ 1, 2, 3, 4 ]) );
  test.is( _.segment.is([ 0, 0, 0, 0, 0, 0 ]) );

  test.case = 'vector'; /* */

  test.is( _.segment.is( _.vector.fromArray([]) ) );
  test.is( _.segment.is( _.vector.fromArray([ 0, 0 ]) ) );
  test.is( _.segment.is( _.vector.fromArray([ 1, 2, 3, 4 ]) ) );
  test.is( _.segment.is( _.vector.fromArray([ 0, 0, 0, 0, 0, 0 ]) ) );

  test.case = 'not segment'; /* */

  test.is( !_.segment.is([ 0 ]) );
  test.is( !_.segment.is([ 0, 0, 0 ]) );

  test.is( !_.segment.is( _.vector.fromArray([ 0 ]) ) );
  test.is( !_.segment.is( _.vector.fromArray([ 0, 0, 0 ]) ) );

  test.is( !_.segment.is( 'abc' ) );
  test.is( !_.segment.is( { origin : [ 0, 0, 0 ], direction : [ 1, 1, 1 ] } ) );
  test.is( !_.segment.is( function( a, b, c ){} ) );

  test.is( !_.segment.is( null ) );
  test.is( !_.segment.is( undefined ) );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.segment.is( ));
  test.shouldThrowErrorSync( () => _.segment.is( [ 0, 0 ], [ 1, 1 ] ));

}

//

function dimGet( test )
{
  test.case = 'srcSegment 1D - array'; /* */

  var srcSegment = [ 0, 1 ];
  var gotDim = _.segment.dimGet( srcSegment );
  var expected = 1;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcSegment );

  test.case = 'srcSegment 1D - vector'; /* */

  var srcSegment = _.vector.fromArray( [ 0, 1 ] );
  var gotDim = _.segment.dimGet( srcSegment );
  var expected = 1;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcSegment );

  test.case = 'srcSegment 2D - array'; /* */

  var srcSegment = [ 0, 1, 2, 3 ];
  var gotDim = _.segment.dimGet( srcSegment );
  var expected = 2;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcSegment );

  test.case = 'srcSegment 2D - vector'; /* */

  var srcSegment = _.vector.fromArray( [ 0, 1, 2, 3 ] );
  var gotDim = _.segment.dimGet( srcSegment );
  var expected = 2;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcSegment );

  test.case = 'srcSegment 3D - array'; /* */

  var srcSegment = [ 0, 1, 2, 3, 4, 5 ];
  var gotDim = _.segment.dimGet( srcSegment );
  var expected = 3;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcSegment );

  test.case = 'srcSegment 3D - vector'; /* */

  var srcSegment = _.vector.fromArray( [ 0, 1, 2, 3, 4, 5 ] );
  var gotDim = _.segment.dimGet( srcSegment );
  var expected = 3;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcSegment );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.segment.dimGet( ) );
  test.shouldThrowErrorSync( () => _.segment.dimGet( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.segment.dimGet( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.segment.dimGet( 'segment' ) );
  test.shouldThrowErrorSync( () => _.segment.dimGet( 0 ) );
  test.shouldThrowErrorSync( () => _.segment.dimGet( null ) );
  test.shouldThrowErrorSync( () => _.segment.dimGet( undefined ) );

}

//

function originGet( test )
{
  test.case = 'Source segment remains unchanged'; /* */

  var srcSegment = [ 0, 0, 1, 1 ];
  var expected = _.vector.from( [ 0, 0 ] );

  var gotOrigin = _.segment.originGet( srcSegment );
  test.identical( gotOrigin, expected );

  var oldSrcSegment = [ 0, 0, 1, 1 ];
  test.equivalent( srcSegment, oldSrcSegment );

  test.case = 'srcSegment 1D - array'; /* */

  var srcSegment = [ 0, 1 ];
  var gotOrigin = _.segment.originGet( srcSegment );
  var expected = _.vector.from( [ 0 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcSegment );

  test.case = 'srcSegment 1D - vector'; /* */

  var srcSegment = _.vector.fromArray( [ 0, 1 ] );
  var gotOrigin = _.segment.originGet( srcSegment );
  var expected = _.vector.from( [ 0 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcSegment );

  test.case = 'srcSegment 2D - array'; /* */

  var srcSegment = [ 0, 1, 2, 3 ];
  var gotOrigin = _.segment.originGet( srcSegment );
  var expected = _.vector.from( [ 0, 1 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcSegment );

  test.case = 'srcSegment 2D - vector'; /* */

  var srcSegment = _.vector.fromArray( [ 0, 1, 2, 3 ] );
  var gotOrigin = _.segment.originGet( srcSegment );
  var expected = _.vector.from( [ 0, 1 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcSegment );

  test.case = 'srcSegment 3D - array'; /* */

  var srcSegment = [ 0, 1, 2, 3, 4, 5 ];
  var gotOrigin = _.segment.originGet( srcSegment );
  var expected = _.vector.from( [ 0, 1, 2 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcSegment );

  test.case = 'srcSegment 3D - vector'; /* */

  var srcSegment = _.vector.fromArray( [ 0, 1, 2, 3, 4, 5 ] );
  var gotOrigin = _.segment.originGet( srcSegment );
  var expected = _.vector.from( [ 0, 1, 2 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcSegment );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.segment.originGet( ) );
  test.shouldThrowErrorSync( () => _.segment.originGet( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.segment.originGet( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.segment.originGet( 'segment' ) );
  test.shouldThrowErrorSync( () => _.segment.originGet( 0 ) );
  test.shouldThrowErrorSync( () => _.segment.originGet( null ) );
  test.shouldThrowErrorSync( () => _.segment.originGet( undefined ) );

}

//

function endPointGet( test )
{
  test.case = 'Source segment remains unchanged'; /* */

  var srcSegment = [ 0, 0, 1, 1 ];
  var expected = _.vector.from( [ 1, 1 ] );

  var gotDirection = _.segment.endPointGet( srcSegment );
  test.identical( gotDirection, expected );

  var oldSrcSegment = [ 0, 0, 1, 1 ];
  test.equivalent( srcSegment, oldSrcSegment );

  test.case = 'srcSegment 1D - array'; /* */

  var srcSegment = [ 0, 1 ];
  var gotDirection = _.segment.endPointGet( srcSegment );
  var expected = _.vector.from( [ 1 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcSegment );

  test.case = 'srcSegment 1D - vector'; /* */

  var srcSegment = _.vector.fromArray( [ 0, 1 ] );
  var gotDirection = _.segment.endPointGet( srcSegment );
  var expected = _.vector.from( [ 1 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcSegment );

  test.case = 'srcSegment 2D - array'; /* */

  var srcSegment = [ 0, 1, 2, 3 ];
  var gotDirection = _.segment.endPointGet( srcSegment );
  var expected = _.vector.from( [ 2, 3 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcSegment );

  test.case = 'srcSegment 2D - vector'; /* */

  var srcSegment = _.vector.fromArray( [ 0, 1, 2, 3 ] );
  var gotDirection = _.segment.endPointGet( srcSegment );
  var expected = _.vector.from( [ 2, 3 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcSegment );

  test.case = 'srcSegment 3D - array'; /* */

  var srcSegment = [ 0, 1, 2, 3, 4, 5 ];
  var gotDirection = _.segment.endPointGet( srcSegment );
  var expected = _.vector.from( [ 3, 4, 5 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcSegment );

  test.case = 'srcSegment 3D - vector'; /* */

  var srcSegment = _.vector.fromArray( [ 0, 1, 2, 3, 4, 5 ] );
  var gotDirection = _.segment.endPointGet( srcSegment );
  var expected = _.vector.from( [ 3, 4, 5 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcSegment );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.segment.endPointGet( ) );
  test.shouldThrowErrorSync( () => _.segment.endPointGet( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.segment.endPointGet( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.segment.endPointGet( 'segment' ) );
  test.shouldThrowErrorSync( () => _.segment.endPointGet( 0 ) );
  test.shouldThrowErrorSync( () => _.segment.endPointGet( null ) );
  test.shouldThrowErrorSync( () => _.segment.endPointGet( undefined ) );

}


// --
// define class
// --

var Self =
{

  name : 'Tools/Math/Segment',
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

    is : is,
    dimGet : dimGet,
    originGet : originGet,
    endPointGet : endPointGet,

  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
