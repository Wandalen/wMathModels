( function _ConcavePolygon_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../../dwtools/Tools.s' );

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

  test.case = 'Dim and vertices remain unchanged'; //

  var dim = 3;
  var vertices = 8;

  var gotPolygon = _.concavePolygon.make( dim, vertices );

  var expected = _.Matrix.Make( [ 3, 8 ] ).copy
  ([
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0
  ]);
  test.equivalent( gotPolygon, expected );

  var oldDim = 3;
  test.identical( dim, oldDim );

  var oldVertices = 8;
  test.identical( vertices, oldVertices );

  test.case = 'Triangle 2D'; //

  var dim = 2;
  var vertices = 3;

  var gotPolygon = _.concavePolygon.make( dim, vertices );

  var expected = _.Matrix.Make( [ 2, 3 ] ).copy
  ([
    0, 0, 0,
    0, 0, 0
  ]);
  test.equivalent( gotPolygon, expected );

  test.case = 'Square 3D'; //

  var dim = 3;
  var vertices = 4;

  var gotPolygon = _.concavePolygon.make( dim, vertices );

  var expected = _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0, 0, 0, 0,
    0, 0, 0, 0,
    0, 0, 0, 0
  ]);
  test.equivalent( gotPolygon, expected );

  test.case = 'Pentagone 2D'; //

  var dim = 2;
  var vertices = 5;

  var gotPolygon = _.concavePolygon.make( dim, vertices );

  var expected = _.Matrix.Make( [ 2, 5 ] ).copy
  ([
    0, 0, 0, 0, 0,
    0, 0, 0, 0, 0
  ]);
  test.equivalent( gotPolygon, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.concavePolygon.make( ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( dim ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( dim, vertices, vertices ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( null, vertices ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( NaN, vertices ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( undefined, vertices ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( 'dim', vertices ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( [ 3 ], vertices ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( dim, null ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( dim, NaN ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( dim, undefined ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( dim, 'vertices' ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( dim, [ 3 ] ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( 1, 3 ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( 4, 3 ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( 2, 2 ));

}

//

function isPolygon( test )
{

  test.case = 'Source polygon remains unchanged'; //

  var polygon = _.concavePolygon.make( 3, 3 );

  var gotBool = _.concavePolygon.isPolygon( polygon );

  var expected = true;
  test.identical( gotBool, expected );

  var oldPolygon = _.concavePolygon.make( 3, 3 );
  test.equivalent( oldPolygon, polygon );

  test.case = 'Triangle 2D'; //

  var polygon = _.concavePolygon.make( 2, 3 ).copy
  ([
    1, 0, 0,
    0, 0, 1
  ]);

  var gotBool = _.concavePolygon.isPolygon( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Square 3D'; //

  var polygon = _.concavePolygon.make( 3, 4 ).copy
  ([
    1, 1, 0, 0,
    0, 1, 1, 0,
    0, 0, 0, 0
  ]);

  var gotBool = _.concavePolygon.isPolygon( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = '4 points in 3D not coplanar'; //

  var polygon = _.concavePolygon.make( 3, 4 ).copy
  ([
    1, 1, 0, 0,
    0, 1, 1, 0,
    0, 0, 0, 1
  ]);

  var gotBool = _.concavePolygon.isPolygon( polygon );

  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Pentagone 2D'; //

  var polygon = _.concavePolygon.make( 2, 5 ).copy
  ([
    1, 0, 0, 0, 2,
    0, 0, 1, 2, 0
  ]);

  var gotBool = _.concavePolygon.isPolygon( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Dim < 2'; //

  var polygon = _.Matrix.Make( [ 1, 5 ] ).copy
  ([
    1, 0, 0, 0, 2
  ]);

  var gotBool = _.concavePolygon.isPolygon( polygon );

  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Dim > 3'; //

  var polygon = _.Matrix.Make( [ 4, 5 ] ).copy
  ([
    1, 0, 0, 0, 2,
    1, 0, 0, 0, 2,
    1, 0, 0, 0, 2,
    1, 0, 0, 0, 2
  ]);

  var gotBool = _.concavePolygon.isPolygon( polygon );

  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Vertices < 3'; //

  var polygon = _.Matrix.Make( [ 2, 2 ] ).copy
  ([
    1, 0,
    0, 1
  ]);

  var gotBool = _.concavePolygon.isPolygon( polygon );

  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Three points are always coplanar'; //

  var polygon = _.concavePolygon.make( 3, 3 ).copy
  ([
    1, 0, 0,
    0, 1, 0,
    1, 1, 1,
  ]);

  var gotBool = _.concavePolygon.isPolygon( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Four coplanar points'; //

  var polygon = _.concavePolygon.make( 3, 4 ).copy
  ([
    0,   0,   0,   2,
    1, - 1,   -2,   0,
    1, - 1,   -2,   0
  ]);

  var gotBool = _.concavePolygon.isPolygon( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon = _.Matrix.Make( [ 3, 3 ] );
  test.shouldThrowErrorSync( () => _.concavePolygon.isPolygon( ));
  test.shouldThrowErrorSync( () => _.concavePolygon.isPolygon( polygon, polygon ));
  test.shouldThrowErrorSync( () => _.concavePolygon.isPolygon( null ));
  test.shouldThrowErrorSync( () => _.concavePolygon.isPolygon( NaN ));
  test.shouldThrowErrorSync( () => _.concavePolygon.isPolygon( undefined ));
  test.shouldThrowErrorSync( () => _.concavePolygon.isPolygon( 'polygon' ));
  test.shouldThrowErrorSync( () => _.concavePolygon.isPolygon( [ 3 ] ));
  test.shouldThrowErrorSync( () => _.concavePolygon.isPolygon( 3 ));

}

//

function is( test )
{

  test.case = 'Source polygon remains unchanged'; //

  var polygon = _.concavePolygon.make( 3, 3 );

  var gotBool = _.concavePolygon.is( polygon );

  var expected = true;
  test.identical( gotBool, expected );

  var oldPolygon = _.concavePolygon.make( 3, 3 );
  test.equivalent( oldPolygon, polygon );

  test.case = 'Triangle 2D'; //

  var polygon = _.concavePolygon.make( 2, 3 ).copy
  ([
    1, 0, 0,
    0, 0, 1
  ]);

  var gotBool = _.concavePolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Square 3D'; //

  var polygon = _.concavePolygon.make( 3, 4 ).copy
  ([
    1, 1, 0, 0,
    0, 1, 1, 0,
    0, 0, 0, 0
  ]);

  var gotBool = _.concavePolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = '4 points in 3D forming concave polygon'; //

  var polygon = _.concavePolygon.make( 3, 4 ).copy
  ([
    1, 1, 0.9, 0,
    0, 1, 0.1, 0,
    0, 0, 0, 0
  ]);

  var gotBool = _.concavePolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Pentagone 2D'; //

  var polygon = _.concavePolygon.make( 2, 5 ).copy
  ([
    1, 0, 0, 0, 2,
    0, 0, 1, 2, 0
  ]);

  var gotBool = _.concavePolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Concave pentagone 2D'; //

  var polygon = _.concavePolygon.make( 2, 5 ).copy
  ([
    1, 0, 0, 2, 0,
    0, 0, 1, 0, 2
  ]);

  var gotBool = _.concavePolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Wrong dim and vertices'; //

  var polygon = _.Matrix.Make( [ 1, 2 ] ).copy
  ([
    1, 0
  ]);

  var gotBool = _.concavePolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Three points are always coplanar'; //

  var polygon = _.concavePolygon.make( 3, 3 ).copy
  ([
    1, 0, 0,
    0, 1, 0,
    1, 1, 1,
  ]);

  var gotBool = _.concavePolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Four points convex'; //

  var polygon = _.concavePolygon.make( 3, 4 ).copy
  ([
    0,   0,   0,   2,
    1, - 1,   -2,   0,
    1, - 1,   -2,   0
  ]);

  var gotBool = _.concavePolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Four points concave'; //

  var polygon = _.concavePolygon.make( 3, 4 ).copy
  ([
    0,   1,   0,   2,
    1, - 1,   -2,   0,
    1, - 1,   -2,   0
  ]);

  var gotBool = _.concavePolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  //

  test.is( !_.concavePolygon.is( ) );
  test.is( !_.concavePolygon.is( null ) );
  test.is( !_.concavePolygon.is( NaN ) );
  test.is( !_.concavePolygon.is( undefined ) );
  test.is( !_.concavePolygon.is( 'polygon' ) );
  test.is( !_.concavePolygon.is( [ 3 ] ) );
  test.is( !_.concavePolygon.is( 3 ) );

}

//

function pointDistance( test )//qqq:extend
{

  var polygon =
  [
    0,1,
    0,1
  ]
  var point = [ 0.5,0 ]
  var expected = 0;
  var gotDistance = _.concavePolygon.pointDistance( polygon, point );

  test.identical( gotDistance, expected );

}

//

function isClockwise( test )
{
  test.case = 'concave counter clockwise'

  var polygon =
  _.concavePolygon.make( 2, 4 ).copy
  ([
    6.84, 1.26, 2.32, 5.46,
    0.64, 1.54, 4.71, 4.93,
  ]);
  test.is( !_.concavePolygon.isClockwise( polygon ) );

  test.case = 'concave clockwise'
  var polygon = _.concavePolygon.make( 2, 4 ).copy
  ([
    5.46,2.32,1.26,6.84,
    4.93,4.71,1.54,0.64
  ])
  test.is( _.concavePolygon.isClockwise( polygon ) );

}

// --
// declare
// --

var Self =
{

  name : 'Tools/Math/concavePolygon',
  silencing : 1,
  enabled : 1,
  // verbosity : 7,
  // debug : 1,

  tests :
  {
    make,
    isPolygon,
    is,

    pointDistance,

    isClockwise,
  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
