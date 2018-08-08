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

function is( test )
{
  debugger;
  test.case = 'array'; /* */

  test.is( _.ray.is( [] ) );
  test.is( _.ray.is([ 0,0 ]) );
  test.is( _.ray.is([ 1,2,3,4 ]) );
  test.is( _.ray.is([ 0,0,0,0,0,0 ]) );

  test.case = 'vector'; /* */

  test.is( _.ray.is( _.vector.fromArray([]) ) );
  test.is( _.ray.is( _.vector.fromArray([ 0,0 ]) ) );
  test.is( _.ray.is( _.vector.fromArray([ 1,2,3,4 ]) ) );
  test.is( _.ray.is( _.vector.fromArray([ 0,0,0,0,0,0 ]) ) );

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
    is : is,

    fromPoints : fromPoints,

  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
