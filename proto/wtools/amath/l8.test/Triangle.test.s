( function _Triangle_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../../wtools/Tools.s' );

  _.include( 'wTesting' );
  _.include( 'wMathVector' );
  _.include( 'wMathMatrix' );

  require( '../l8/Concepts.s' );

}

//

let _ = _global_.wTools.withDefaultLong.Fx;
var Matrix = _.Matrix;
var vector = _.vectorAdapter;
var vec = _.vectorAdapter.fromArray;
var avector = _.avector;
var sqrt = _.math.sqrt;
let Parent = wTester;

_.assert( _.routineIs( sqrt ) );

// --
// test
// --


function make( test )
{

  test.case = 'Triangle 2D'; //

  var dim = 2;
  var gotTriangle = _.triangle.make( dim );

  var expected = _.triangle.tools.longMake( [ 0, 0, 0, 0, 0, 0 ] );
  test.identical( gotTriangle, expected );

  /* */

  if( !Config.debug )
  return;

  var vertices = 3;

  test.shouldThrowErrorSync( () => _.triangle.make( dim, vertices, vertices ));
  test.shouldThrowErrorSync( () => _.triangle.make( null, vertices ));
  test.shouldThrowErrorSync( () => _.triangle.make( NaN, vertices ));
  test.shouldThrowErrorSync( () => _.triangle.make( undefined, vertices ));
  test.shouldThrowErrorSync( () => _.triangle.make( 'dim', vertices ));
  test.shouldThrowErrorSync( () => _.triangle.make( [ 3 ], vertices ));
  test.shouldThrowErrorSync( () => _.triangle.make( dim, null ));
  test.shouldThrowErrorSync( () => _.triangle.make( dim, NaN ));
  test.shouldThrowErrorSync( () => _.triangle.make( dim, undefined ));
  test.shouldThrowErrorSync( () => _.triangle.make( dim, 'vertices' ));
  test.shouldThrowErrorSync( () => _.triangle.make( dim, [ 3 ] ));
  test.shouldThrowErrorSync( () => _.triangle.make( 1, 3 ));
  test.shouldThrowErrorSync( () => _.triangle.make( 4, 3 ));
  test.shouldThrowErrorSync( () => _.triangle.make( 2, 2 ));

}

//


function from( test )
{
  /* */

  test.case = 'Same instance returned - array';

  var srcTriangle = [ 0, 0, 1, 1, 2, 0 ];
  var expected = _.triangle.tools.longMake( [ 0, 0, 1, 1, 2, 0 ] );

  var gotTriangle = _.triangle.from( srcTriangle );
  test.identical( gotTriangle, expected );
  test.is( srcTriangle === gotTriangle );

  /* */

  test.case = 'Different instance returned - vector -> array';

  var srcTriangle = _.vectorAdapter.fromLong( [  0, 0, 1, 1, 2, 0 ] );
  var expected = _.triangle.tools.vectorAdapter.fromLong( [ 0, 0, 1, 1, 2, 0 ] );

  var gotTriangle = _.triangle.from( srcTriangle );
  test.identical( gotTriangle, expected );
  test.is( srcTriangle === gotTriangle );

  /* */

  test.case = 'Different instance returned - null -> array';

  var srcTriangle = null;
  var expected = _.triangle.tools.longMake( [ 0, 0, 0, 0, 0, 0 ] );

  var gotTriangle = _.triangle.from( srcTriangle );
  test.identical( gotTriangle, expected );
  test.is( srcTriangle !== gotTriangle );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.triangle.from( ));
  test.shouldThrowErrorSync( () => _.triangle.from( [ 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.triangle.from( [ 0, 0, 0, 0 ], [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.triangle.from( 'triangle' ));
  test.shouldThrowErrorSync( () => _.triangle.from( NaN ));
  test.shouldThrowErrorSync( () => _.triangle.from( undefined ));
}

//

function is( test )
{

  test.case = 'Triangle 2D'; //

  test.is( _.triangle.is( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.is( _.triangle.is( [ 0, 0, 1, 1, 2, 0 ] ) );

  //

  test.is( !_.triangle.is( null ) );
  test.is( !_.triangle.is( NaN ) );
  test.is( !_.triangle.is( undefined ) );
  test.is( !_.triangle.is( 'polygon' ) );
  test.is( !_.triangle.is( [ 3 ] ) );
  test.is( !_.triangle.is( 3 ) );

}

//

function pointContains( test )
{
  let triangle = [ 0, 0, 1, 1, 2, 0 ];

  test.is( _.triangle.pointContains( triangle, [ 0, 0 ] ) )
  test.is( _.triangle.pointContains( triangle, [ 1, 0 ] ) )
  test.is( _.triangle.pointContains( triangle, [ 2, 0 ] ) )
  test.is( _.triangle.pointContains( triangle, [ 1, 1 ] ) )
  test.is( _.triangle.pointContains( triangle, [ 1, 0.5 ] ) )

  test.is( !_.triangle.pointContains( triangle, [ -1, 0 ] ) )
  test.is( !_.triangle.pointContains( triangle, [ 3, 0 ] ) )
  test.is( !_.triangle.pointContains( triangle, [ 1, -1 ] ) )
  test.is( !_.triangle.pointContains( triangle, [ 1, 2 ] ) )

}

//

function pointDistance( test )//qqq vova: extend
{
  test.open( 'triangle contains point' )

  var triangle = [ 0, 0, 0, 1, 1, 0, 2, 0, 0 ];
  var point = [ 0, 0, 0 ]
  var expected = 0;

  var gotDistance = _.triangle.pointDistance( triangle, point );
  test.identical( gotDistance, expected );

  //

  var triangle = [ 0, 0, 0, 1, 1, 0, 2, 0, 0 ];
  var point = [ 1, 0, 0 ]
  var expected = 0;

  var gotDistance = _.triangle.pointDistance( triangle, point );
  test.identical( gotDistance, expected );

  //

  var triangle = [ 0, 0, 0, 1, 1, 0, 2, 0, 0 ];
  var point = [ 2, 0, 0 ]
  var expected = 0;

  var gotDistance = _.triangle.pointDistance( triangle, point );
  test.identical( gotDistance, expected );

  //

  var triangle = [ 0, 0, 0, 1, 1, 0, 2, 0, 0 ];
  var point = [ 1, 1, 0 ]
  var expected = 0;

  var gotDistance = _.triangle.pointDistance( triangle, point );
  test.identical( gotDistance, expected );

  //

  var triangle = [ 0, 0, 0, 1, 1, 0, 2, 0, 0 ];
  var point = [ 1, 0.5, 0  ]
  var expected = 0;

  var gotDistance = _.triangle.pointDistance( triangle, point );
  test.identical( gotDistance, expected );

  test.close( 'triangle contains point' )

  var triangle = [ 0, 0, 0, 1, 1, 0, 2, 0, 0 ];
  var point = [ 1, 1, 1  ]
  var expected = 1;

  var gotDistance = _.triangle.pointDistance( triangle, point );
  test.identical( gotDistance, expected );

}

//

// --
// declare
// --

let Self =
{

  name : 'Tools/Math/Triangle',
  silencing : 1,
  enabled : 1,
  // verbosity : 7,
  // debug : 1,

  tests :
  {
    make,
    is,
    from,

    pointContains,
    pointDistance,
  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
