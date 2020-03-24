( function _Pair_test_s_( ) {

'use strict';

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
var vec = _.vectorAdapter.fromArray;
var avector = _.avector;
var sqrt = _.math.sqrt;
var Parent = wTester;

_.assert( _.routineIs( sqrt ) );

// --
// test
// --


function make( test )
{

  test.case = 'pair 2D'; //

  var dim = 2;
  var gotPair = _.pair.make( dim );

  var expected = _.pair.tools.longMake( [ [ 0, 0 ], [ 0, 0 ] ] );
  test.identical( gotPair, expected );

  /* */

  if( !Config.debug )
  return;

  var vertices = 3;

  test.shouldThrowErrorSync( () => _.pair.make( dim, vertices, vertices ));
  test.shouldThrowErrorSync( () => _.pair.make( null, vertices ));
  test.shouldThrowErrorSync( () => _.pair.make( NaN, vertices ));
  test.shouldThrowErrorSync( () => _.pair.make( undefined, vertices ));
  test.shouldThrowErrorSync( () => _.pair.make( 'dim', vertices ));
  test.shouldThrowErrorSync( () => _.pair.make( [ 3 ], vertices ));
  test.shouldThrowErrorSync( () => _.pair.make( dim, null ));
  test.shouldThrowErrorSync( () => _.pair.make( dim, NaN ));
  test.shouldThrowErrorSync( () => _.pair.make( dim, undefined ));
  test.shouldThrowErrorSync( () => _.pair.make( dim, 'vertices' ));
  test.shouldThrowErrorSync( () => _.pair.make( dim, [ 3 ] ));
  test.shouldThrowErrorSync( () => _.pair.make( 1, 3 ));
  test.shouldThrowErrorSync( () => _.pair.make( 4, 3 ));
  test.shouldThrowErrorSync( () => _.pair.make( 2, 2 ));

}

//


function from( test )
{
  test.case = 'Same instance returned - array'; /* */

  var srcPair = [ [ 0, 0, 1 ], [ 1, 2, 0 ] ];
  var expected = _.pair.tools.longMake( [ [ 0, 0, 1 ], [ 1, 2, 0 ] ] );

  var gotPair = _.pair.from( srcPair );
  test.identical( gotPair, expected );
  test.is( srcPair === gotPair );

  var srcPair = null;
  var expected = _.pair.tools.longMake( [ [ 0, 0 ], [ 0, 0 ] ] );

  var gotPair = _.pair.from( srcPair );
  test.identical( gotPair, expected );
  test.is( srcPair !== gotPair );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.pair.from( ));
  test.shouldThrowErrorSync( () => _.pair.from( [] ));
  test.shouldThrowErrorSync( () => _.pair.from( [ 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.pair.from( [ 0, 0, 0, 0 ], [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.pair.from( 'pair' ));
  test.shouldThrowErrorSync( () => _.pair.from( NaN ));
  test.shouldThrowErrorSync( () => _.pair.from( undefined ));
}

//

function is( test )
{

  test.is( _.pair.is( [ [ 0, 0 ], [ 0, 0 ] ] ) );

  //

  test.is( !_.pair.is( [ 0, 0, 1, 1, 2, 0 ] ) );
  test.is( !_.pair.is( null ) );
  test.is( !_.pair.is( NaN ) );
  test.is( !_.pair.is( undefined ) );
  test.is( !_.pair.is( 'polygon' ) );
  test.is( !_.pair.is( [ 3 ] ) );
  test.is( !_.pair.is( 3 ) );

}

//

function fromRay( test )
{
  var src = [ [ 0,0 ], [ 1,1 ] ]
  var got = _.pair.fromRay( src );
  var expected = _.pair.tools.longMake([ [ 0,0 ], [ 1,1 ] ] );
  test.identical( got, expected );
  test.is( got !== src );

  var src = [ [ 1,1 ], [ 1,1 ] ]
  var got = _.pair.fromRay( src );
  var expected = _.pair.tools.longMake([ [ 1,1 ], [ 2,2 ] ] );
  test.identical( got, expected );
  test.is( got !== src );
}

//

// --
// declare
// --

var Self =
{

  name : 'Tools/Math/Pair',
  silencing : 1,
  enabled : 1,
  // verbosity : 7,
  // debug : 1,

  tests :
  {
    make,
    is,
    from,

    fromRay,
  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
