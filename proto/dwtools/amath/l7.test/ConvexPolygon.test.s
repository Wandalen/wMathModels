( function _ConvexPolygon_test_s_( ) {

'use strict';

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

 require( '../l8/Concepts.s' );

}

//

var _ = _global_.wTools.withArray.Float32;
var Space = _.Space;
var vector = _.vector;
var vec = _.vector.fromArray;
var avector = _.avector;
var sqrt = _.sqrt;
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

  var gotPolygon = _.convexPolygon.make( dim, vertices );

  var expected = _.Space.make( [ 3, 8 ] ).copy
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

  var gotPolygon = _.convexPolygon.make( dim, vertices );

  var expected = _.Space.make( [ 2, 3 ] ).copy
  ([
    0, 0, 0,
    0, 0, 0
  ]);
  test.equivalent( gotPolygon, expected );

  test.case = 'Square 3D'; //

  var dim = 3;
  var vertices = 4;

  var gotPolygon = _.convexPolygon.make( dim, vertices );

  var expected = _.Space.make( [ 3, 4 ] ).copy
  ([
    0, 0, 0, 0,
    0, 0, 0, 0,
    0, 0, 0, 0
  ]);
  test.equivalent( gotPolygon, expected );

  test.case = 'Pentagone 2D'; //

  var dim = 2;
  var vertices = 5;

  var gotPolygon = _.convexPolygon.make( dim, vertices );

  var expected = _.Space.make( [ 2, 5 ] ).copy
  ([
    0, 0, 0, 0, 0,
    0, 0, 0, 0, 0
  ]);
  test.equivalent( gotPolygon, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.convexPolygon.make( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( dim ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( dim, vertices, vertices ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( null, vertices ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( NaN, vertices ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( undefined, vertices ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( 'dim', vertices ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( [ 3 ], vertices ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( dim, null ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( dim, NaN ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( dim, undefined ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( dim, 'vertices' ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( dim, [ 3 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( 1, 3 ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( 4, 3 ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( 2, 2 ));

}

//

function isPolygon( test )
{

  test.case = 'Source polygon remains unchanged'; //

  var polygon = _.convexPolygon.make( 3, 3 );

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = true;
  test.identical( gotBool, expected );

  var oldPolygon = _.convexPolygon.make( 3, 3 );
  test.equivalent( oldPolygon, polygon );

  test.case = 'Triangle 2D'; //

  var polygon = _.convexPolygon.make( 2, 3 ).copy
  ([
    1, 0, 0,
    0, 0, 1
  ]);

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Square 3D'; //

  var polygon = _.convexPolygon.make( 3, 4 ).copy
  ([
    1, 1, 0, 0,
    0, 1, 1, 0,
    0, 0, 0, 0
  ]);

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = '4 points in 3D not coplanar'; //

  var polygon = _.convexPolygon.make( 3, 4 ).copy
  ([
    1, 1, 0, 0,
    0, 1, 1, 0,
    0, 0, 0, 1
  ]);

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Pentagone 2D'; //

  var polygon = _.convexPolygon.make( 2, 5 ).copy
  ([
    1, 0, 0, 0, 2,
    0, 0, 1, 2, 0
  ]);

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Dim < 2'; //

  var polygon = _.Space.make( [ 1, 5 ] ).copy
  ([
    1, 0, 0, 0, 2
  ]);

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Dim > 3'; //

  var polygon = _.Space.make( [ 4, 5 ] ).copy
  ([
    1, 0, 0, 0, 2,
    1, 0, 0, 0, 2,
    1, 0, 0, 0, 2,
    1, 0, 0, 0, 2
  ]);

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Vertices < 3'; //

  var polygon = _.Space.make( [ 2, 2 ] ).copy
  ([
    1, 0,
    0, 1
  ]);

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Three points are always coplanar'; //

  var polygon = _.convexPolygon.make( 3, 3 ).copy
  ([
    1, 0, 0,
    0, 1, 0,
    1, 1, 1,
  ]);

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Four coplanar points'; //

  var polygon = _.convexPolygon.make( 3, 4 ).copy
  ([
    0,   0,   0,   2,
    1, - 1,   -2,   0,
    1, - 1,   -2,   0
  ]);

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon = _.Space.make( [ 3, 3 ] );
  test.shouldThrowErrorSync( () => _.convexPolygon.isPolygon( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.isPolygon( polygon, polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.isPolygon( null ));
  test.shouldThrowErrorSync( () => _.convexPolygon.isPolygon( NaN ));
  test.shouldThrowErrorSync( () => _.convexPolygon.isPolygon( undefined ));
  test.shouldThrowErrorSync( () => _.convexPolygon.isPolygon( 'polygon' ));
  test.shouldThrowErrorSync( () => _.convexPolygon.isPolygon( [ 3 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.isPolygon( 3 ));

}

//

function is( test )
{

  test.case = 'Source polygon remains unchanged'; //

  var polygon = _.convexPolygon.make( 3, 3 );

  var gotBool = _.convexPolygon.is( polygon );

  var expected = true;
  test.identical( gotBool, expected );

  var oldPolygon = _.convexPolygon.make( 3, 3 );
  test.equivalent( oldPolygon, polygon );

  test.case = 'Triangle 2D'; //

  var polygon = _.convexPolygon.make( 2, 3 ).copy
  ([
    1, 0, 0,
    0, 0, 1
  ]);

  var gotBool = _.convexPolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Square 3D'; //

  var polygon = _.convexPolygon.make( 3, 4 ).copy
  ([
    1, 1, 0, 0,
    0, 1, 1, 0,
    0, 0, 0, 0
  ]);

  var gotBool = _.convexPolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = '4 points in 3D forming concave polygon'; //

  var polygon = _.convexPolygon.make( 3, 4 ).copy
  ([
    1, 1, 0.9, 0,
    0, 1, 0.1, 0,
    0, 0, 0, 0
  ]);

  var gotBool = _.convexPolygon.is( polygon );

  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Pentagone 2D'; //

  var polygon = _.convexPolygon.make( 2, 5 ).copy
  ([
    1, 0, 0, 0, 2,
    0, 0, 1, 2, 0
  ]);

  var gotBool = _.convexPolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Concave pentagone 2D'; //

  var polygon = _.convexPolygon.make( 2, 5 ).copy
  ([
    1, 0, 0, 2, 0,
    0, 0, 1, 0, 2
  ]);

  var gotBool = _.convexPolygon.is( polygon );

  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Wrong dim and vertices'; //

  var polygon = _.Space.make( [ 1, 2 ] ).copy
  ([
    1, 0
  ]);

  var gotBool = _.convexPolygon.is( polygon );

  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Three points are always coplanar'; //

  var polygon = _.convexPolygon.make( 3, 3 ).copy
  ([
    1, 0, 0,
    0, 1, 0,
    1, 1, 1,
  ]);

  var gotBool = _.convexPolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Four points convex'; //

  var polygon = _.convexPolygon.make( 3, 4 ).copy
  ([
    0,   0,   0,   2,
    1, - 1,   -2,   0,
    1, - 1,   -2,   0
  ]);

  var gotBool = _.convexPolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Four points concave'; //

  var polygon = _.convexPolygon.make( 3, 4 ).copy
  ([
    0,   1,   0,   2,
    1, - 1,   -2,   0,
    1, - 1,   -2,   0
  ]);

  var gotBool = _.convexPolygon.is( polygon );

  var expected = false;
  test.equivalent( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon = _.Space.make( [ 3, 3 ] );
  test.shouldThrowErrorSync( () => _.convexPolygon.is( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.is( polygon, polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.is( null ));
  test.shouldThrowErrorSync( () => _.convexPolygon.is( NaN ));
  test.shouldThrowErrorSync( () => _.convexPolygon.is( undefined ));
  test.shouldThrowErrorSync( () => _.convexPolygon.is( 'polygon' ));
  test.shouldThrowErrorSync( () => _.convexPolygon.is( [ 3 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.is( 3 ));

}

//

function angleThreePoints( test )
{

  test.case = 'Source points and normal remain unchanged'; //

  var pointOne = [ 1, 0, 0 ];
  var pointTwo = [ 0, 0, 0 ];
  var pointThree = [ 0, 1, 0 ];
  var normal = [ 0, 0, 1 ];

  var gotAngle = _.convexPolygon.angleThreePoints( pointOne, pointTwo, pointThree, normal );

  var expected = Math.PI / 2;
  test.identical( gotAngle, expected );

  var oldPointOne = [ 1, 0, 0 ];
  test.equivalent( oldPointOne, pointOne );

  var oldPointTwo = [ 0, 0, 0 ];
  test.equivalent( oldPointTwo, pointTwo );

  var oldPointThree = [ 0, 1, 0 ];
  test.equivalent( oldPointThree, pointThree );

  var oldNormal = [ 0, 0, 1 ];
  test.equivalent( oldNormal, normal );

  test.case = 'Zero angle'; //

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 1 ], [ 2, 2 ], [ 1, 1 ] );
  var expected = 0;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 1, 1 ], [ 2, 2, 2 ], [ 1, 1, 1 ], [ 1, 0, 0 ] );
  var expected = 0;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 1, 1 ], [ 2, 2, 2 ], [ 1, 1, 1 ], [ - 1, 0, 0 ] );
  var expected = 0;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 1, 1 ], [ 2, 2, 2 ], [ 1, 1, 1 ] );
  var expected = 0;
  test.identical( gotAngle, expected );

  test.case = '3D small angle ( no normal to set angle direction )'; //

  test.description = 'Angle = PI - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 1, 1 ], [ 2, 2, 2 ], [ 3, 3, 3 ] );
  var expected = Math.PI;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 3, 3, 3 ], [ 2, 2, 2 ], [ -1, -1, -1 ] );
  var expected = Math.PI;
  test.identical( gotAngle, expected );


  test.description = 'Angle = 3* PI / 4 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 2, 0 ], [ 0, 2, 0 ], [ -1, 2, 1 ] );
  var expected = 3 * Math.PI / 4;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ -1, 2, 1 ], [ 0, 2, 0 ], [ 1, 2, 0 ] );
  var expected = 3 * Math.PI / 4;
  test.identical( gotAngle, expected );

  test.description = 'Angle = PI / 2 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 0, 2 ], [ 0, 0, 2 ], [ 0, 1, 2 ] );
  var expected = Math.PI / 2;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 0, 1, 2 ], [ 0, 0, 2 ], [ 1, 0, 2 ] );
  var expected = Math.PI / 2;
  test.identical( gotAngle, expected );

  test.description = 'Angle = PI / 3 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 0, 2 ], [ 0, 0, 2 ], [ Math.cos( Math.PI / 3 ), Math.sin( Math.PI / 3 ), 2 ] );
  var expected = Math.PI / 3;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ Math.cos( Math.PI / 3 ), Math.sin( Math.PI / 3 ), 2 ], [ 0, 0, 2 ], [ 1, 0, 2 ] );
  var expected = Math.PI / 3;
  test.identical( gotAngle, expected );

  test.description = 'Angle = PI / 4 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 0, 2 ], [ 0, 0, 2 ], [ 4, 4, 2 ] );
  var expected = Math.PI / 4;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 1, 2 ], [ 0, 0, 2 ], [ 1, 0, 2 ] );
  var expected = Math.PI / 4;
  test.identical( gotAngle, expected );

  test.description = 'Angle = PI / 6 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 0, 2 ], [ 0, 0, 2 ], [ Math.cos( Math.PI / 6 ), Math.sin( Math.PI / 6 ), 2 ] );
  var expected = Math.PI / 6;
  test.equivalent( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 3* Math.cos( Math.PI / 6 ), 3* Math.sin( Math.PI / 6 ), 2 ], [ 0, 0, 2 ], [ 1, 0, 2 ] );
  var expected = Math.PI / 6;
  test.equivalent( gotAngle, expected );

  test.case = '3D small angle with direction'; //

  test.description = 'Angle = PI - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 1, 1 ], [ 2, 2, 2 ], [ 3, 3, 3 ], [ 0, 0, 1 ] );
  var expected = Math.PI;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 3, 3, 3 ], [ 2, 2, 2 ], [ 1, 1, 1 ], [ 0, 0, 1 ] );
  var expected = 2 * Math.PI - Math.PI;
  test.identical( gotAngle, expected );


  test.description = 'Angle = 3* PI / 4 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 2, 0 ], [ 0, 2, 0 ], [ -1, 2, 1 ], [ 0, - 1, 0 ] );
  var expected = 3 * Math.PI / 4;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ -1, 2, 1 ], [ 0, 2, 0 ], [ 1, 2, 0 ], [ 0, - 1, 0 ] );
  var expected = 2 * Math.PI - 3 * Math.PI / 4;
  test.identical( gotAngle, expected );

  test.description = 'Angle = PI / 2 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 0, 2 ], [ 0, 0, 2 ], [ 0, 1, 2 ], [ 0, 0, - 1 ] );
  var expected = 2 * Math.PI - Math.PI / 2;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 0, 1, 2 ], [ 0, 0, 2 ], [ 1, 0, 2 ], [ 0, 0, - 1 ] );
  var expected = Math.PI / 2;
  test.identical( gotAngle, expected );

  test.description = 'Angle = PI / 3 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 0, 2 ], [ 0, 0, 2 ], [ Math.cos( Math.PI / 3 ), Math.sin( Math.PI / 3 ), 2 ], [ 0, 0, 1 ] );
  var expected = Math.PI / 3;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ Math.cos( Math.PI / 3 ), Math.sin( Math.PI / 3 ), 2 ], [ 0, 0, 2 ], [ 1, 0, 2 ], [ 0, 0, 1 ] );
  var expected = 2 * Math.PI - Math.PI / 3;
  test.identical( gotAngle, expected );

  test.description = 'Angle = PI / 4 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 0, 2 ], [ 0, 0, 2 ], [ 4, 4, 2 ], [ 0, 0, 4 ] );
  var expected = Math.PI / 4;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 1, 2 ], [ 0, 0, 2 ], [ 1, 0, 2 ], [ 0, 0, 4 ] );
  var expected = 2 * Math.PI - Math.PI / 4;
  test.identical( gotAngle, expected );

  test.description = 'Angle = PI / 6 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 0, 2 ], [ 0, 0, 2 ], [ Math.cos( Math.PI / 6 ), Math.sin( Math.PI / 6 ), 2 ], [ 0, 0, 1 ] );
  var expected = Math.PI / 6;
  test.equivalent( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ Math.cos( Math.PI / 6 ), Math.sin( Math.PI / 6 ), 2 ], [ 0, 0, 2 ], [ 1, 0, 2 ], [ 0, 0, 1 ] );
  var expected = 2 * Math.PI - Math.PI / 6;
  test.equivalent( gotAngle, expected );

  test.case = '2D angle'; //

  test.description = 'Angle = PI '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 1 ], [ 2, 2 ], [ 3, 3 ] );
  var expected = Math.PI;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 3, 3 ], [ 2, 2 ], [ 1, 1 ] );
  var expected = 2 * Math.PI - Math.PI;
  test.identical( gotAngle, expected );


  test.description = 'Angle = 3* PI / 4 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 0 ], [ 0, 0 ], [ -1, 1 ] );
  var expected = 3 * Math.PI / 4;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ -1, 1 ], [ 0, 0 ], [ 1, 0 ] );
  var expected = 2 * Math.PI - 3 * Math.PI / 4;
  test.identical( gotAngle, expected );

  test.description = 'Angle = PI / 2 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 0 ], [ 0, 0 ], [ 0, 1 ] );
  var expected = Math.PI / 2;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 0, 1 ], [ 0, 0 ], [ 1, 0 ] );
  var expected = 2 * Math.PI - Math.PI / 2;
  test.identical( gotAngle, expected );

  test.description = 'Angle = PI / 3 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 0 ], [ 0, 0 ], [ Math.cos( Math.PI / 3 ), Math.sin( Math.PI / 3 ) ] );
  var expected = Math.PI / 3;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ Math.cos( Math.PI / 3 ), Math.sin( Math.PI / 3 ) ], [ 0, 0 ], [ 1, 0 ] );
  var expected = 2 * Math.PI - Math.PI / 3;
  test.identical( gotAngle, expected );

  test.description = 'Angle = PI / 4 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 0 ], [ 0, 0 ], [ 4, 4 ] );
  var expected = Math.PI / 4;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 1 ], [ 0, 0 ], [ 1, 0 ] );
  var expected = 2 * Math.PI - Math.PI / 4;
  test.identical( gotAngle, expected );

  test.description = 'Angle = PI / 6 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 0 ], [ 0, 0 ], [ Math.cos( Math.PI / 6 ), Math.sin( Math.PI / 6 ) ] );
  var expected = Math.PI / 6;
  test.equivalent( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ Math.cos( Math.PI / 6 ), Math.sin( Math.PI / 6 ) ], [ 0, 0 ], [ 1, 0 ] );
  var expected = 2 * Math.PI - Math.PI / 6;
  test.equivalent( gotAngle, expected );

  test.case = '2D angle'; //

  test.description = 'Angle = PI '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 1 ], [ 2, 2 ], [ 3, 3 ] );
  var expected = Math.PI;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 3, 3 ], [ 2, 2 ], [ 1, 1 ] );
  var expected = 2 * Math.PI - Math.PI;
  test.identical( gotAngle, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon = _.Space.make( [ 3, 3 ] );
  test.shouldThrowErrorSync( () => _.convexPolygon.angleThreePoints( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.angleThreePoints( [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.angleThreePoints( [ 1, 0, 0 ], [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.angleThreePoints( [ 1, 0, 0 ], [ 1, 0, 0 ], [ 1, 0, 0 ], [ 1, 0, 0 ], [ 1, 0, 0 ], ));
  test.shouldThrowErrorSync( () => _.convexPolygon.angleThreePoints( [ 1, 0, 0 ], [ 1, 0 ], [ 1, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.angleThreePoints( [ 1, 0, 0, 0 ], [ 1, 0, 1, 0 ], [ 1, 0, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.angleThreePoints( null, [ 1, 0, 0 ], [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.angleThreePoints( NaN, [ 1, 0, 0 ], [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.angleThreePoints( undefined, [ 1, 0, 0 ], [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.angleThreePoints( 'polygon', [ 1, 0, 0 ], [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.angleThreePoints( 3, [ 1, 0, 0 ], [ 1, 0, 0 ] ));

}

//

function pointContains( test )
{

  test.case = 'Source polygon and point remain unchanged'; //

  var polygon = _.convexPolygon.make( 3, 3 );
  var point = [ 1, 2, 3 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );

  var expected = false;
  test.identical( gotBool, expected );

  var oldPolygon = _.convexPolygon.make( 3, 3 );
  test.equivalent( oldPolygon, polygon );

  var oldPoint = [ 1, 2, 3 ];
  test.equivalent( oldPoint, point );

  test.case = 'Triangle'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 2, 3 ).copy
  ([
    1, 0, 0,
    0, 0, 1
  ]);
  var point = [ 0.5, 0.5 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = true;
  test.equivalent( gotBool, expected );

  var polygon = _.convexPolygon.make( 2, 3 ).copy
  ([
    1, 0, 0,
    0, 0, 1
  ]);
  var point = [ 0.5, 2.5 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = false;
  test.equivalent( gotBool, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 3, 3 ).copy
  ([
    1, 4, 2,
    3, 4, 1,
    2, 2, 2
  ]);
  var point = [ 1.5, 3, 2 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = true;
  test.equivalent( gotBool, expected );

  var polygon = _.convexPolygon.make( 3, 3 ).copy
  ([
    -1, 0, 0,
    0, 0, -1,
    0, 0, 0
  ]);
  var point = [ -0.5, -0.5, 2 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Square'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 2, 4 ).copy
  ([
    3, 3, 4, 4,
    3, 4, 4, 3
  ]);
  var point = [ 3.1, 3.9 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = true;
  test.equivalent( gotBool, expected );

  var polygon = _.convexPolygon.make( 2, 4 ).copy
  ([
    3, 3, 4, 4,
    3, 4, 4, 3
  ]);
  var point = [ 3.1, 4.1 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = false;
  test.equivalent( gotBool, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 3, 4 ).copy
  ([
    1, 0, 0, 1,
    0, 0, 1, 1,
    2, 2, 2, 2
  ]);
  var point = [ 0, 0.5, 2 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = true;
  test.equivalent( gotBool, expected );

  var polygon = _.convexPolygon.make( 3, 4 ).copy
  ([
    1, 0, 0, 1,
    0, 0, 1, 1,
    0, 0, 0, 0
  ]);
  var point = [ 0.5, 0.5, 2 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Pentagone 2D'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 2, 5 ).copy
  ([
    1, 0, 0, 1, 2,
    0, 0, 1, 1, 1
  ]);
  var point = [ 0, 0 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = true;
  test.equivalent( gotBool, expected );

  var polygon = _.convexPolygon.make( 2, 5 ).copy
  ([
    1, 0, 0, 1, 2,
    0, 0, 1, 1, 1
  ]);
  var point = [ - 0.1, 0.1 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = false;
  test.equivalent( gotBool, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 3, 5 ).copy
  ([
    1, 0, 0, 1, 2,
    0, 0, 1, 1, 1,
    2, 2, 2, 2, 2
  ]);
  var point = [ 0, 0.5, 2 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = true;
  test.equivalent( gotBool, expected );

  var polygon = _.convexPolygon.make( 3, 5 ).copy
  ([
    1, 0, 0, 1, 2,
    0, 0, 1, 1, 1,
    0, 0, 0, 0, 0
  ]);
  var point = [ 0.5, 0.5, 2 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Many vertices'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 2, 10 ).copy
  ([
    1,   0,  -1, -2, -2.1, -2,  -1,   0,   1, 2,
    0.1, 0, 0.1,  1,  1.5,  2, 2.5, 2.6, 2.5, 1
  ]);
  var pointT = [ 0, 0.1 ];
  var pointF = [ 0, - 0.1 ];

  var gotBool = _.convexPolygon.pointContains( polygon, pointT );
  var expected = true;
  test.equivalent( gotBool, expected );

  var gotBool = _.convexPolygon.pointContains( polygon, pointF );
  var expected = false;
  test.equivalent( gotBool, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 3, 10 ).copy
  ([
    1,   0,  -1, -2, -2.1, -2,  -1,   0,   1, 2,
    0.1, 0, 0.1,  1,  1.5,  2, 2.5, 2.6, 2.5, 1,
    4,   4,   4,  4,    4,  4,   4,   4,   4, 4
  ]);
  var pointT = [ 0, 0.1, 4 ];
  var pointF = [ 0, 0.1, 2 ];

  var gotBool = _.convexPolygon.pointContains( polygon, pointT );
  var expected = true;
  test.equivalent( gotBool, expected );

  var gotBool = _.convexPolygon.pointContains( polygon, pointF );
  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Point in vertex'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 2, 4 ).copy
  ([
    1,   0,  -1, -2,
    0.1, 0, 0.1,  1
  ]);
  var point = [ -1, 0.1 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Point close to vertex'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 2, 4 ).copy
  ([
    1,   0,  -1, -2,
    0.1, 0, 0.1,  1
  ]);
  var point = [ -1, 0 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Point in edge'; //

  var polygon = _.convexPolygon.make( 2, 4 ).copy
  ([
    1,   0,  -1, 0,
    0, 0,  1,  2
  ]);
  var point = [ 0.5, 0 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Point in edge line but outside polygon'; //

  var polygon = _.convexPolygon.make( 2, 4 ).copy
  ([
    1,   0,  -1, -2,
    0.1, 0, 0.1,  1
  ]);
  var pointOne = [ -2, 0 ];
  var pointTwo = [  2, 0 ];

  var gotBool = _.convexPolygon.pointContains( polygon, pointOne );
  var expected = false;
  test.equivalent( gotBool, expected );

  var gotBool = _.convexPolygon.pointContains( polygon, pointTwo );
  test.equivalent( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon = _.convexPolygon.make( 2, 4 ).copy
  ([
    1,   0,  -1, -2,
    0.1, 0, 0.1,  1
  ]);
  test.shouldThrowErrorSync( () => _.convexPolygon.pointContains( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointContains( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointContains( polygon, [ 1, 0 ], [ 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointContains( polygon, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointContains( null, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointContains( NaN, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointContains( undefined, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointContains( 'polygon', [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointContains( [ 3 ], [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointContains( 3, [ 1, 0, 0 ] ));

  var polygon = _.convexPolygon.make( 2, 4 ).copy
  ([
    1, 0, 0, 0.1,
    0, 0, 1, 0.1
  ]);
  test.shouldThrowErrorSync( () => _.convexPolygon.pointContains( polygon, [ 1, 0 ] ));

  var polygon = _.Space.make( [ 1, 2 ] );
  test.shouldThrowErrorSync( () => _.convexPolygon.pointContains( polygon, [ 1 ] ));
}

//

function pointDistance( test )
{

  test.case = 'Source polygon and point remain unchanged'; //

  var polygon = _.convexPolygon.make( 3, 3 );
  var point = [ 1, 2, 3 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );

  var expected = Math.sqrt( 14 );
  test.identical( gotDist, expected );

  var oldPolygon = _.convexPolygon.make( 3, 3 );
  test.equivalent( oldPolygon, polygon );

  var oldPoint = [ 1, 2, 3 ];
  test.equivalent( oldPoint, point );

  test.case = 'Triangle'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 2, 3 ).copy
  ([
    1, 0, 0,
    0, 0, 1
  ]);
  var point = [ 0.5, 0.5 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 0;
  test.equivalent( gotDist, expected );

  var polygon = _.convexPolygon.make( 2, 3 ).copy
  ([
    1, 0, 0,
    0, 0, 1
  ]);
  var point = [ 0.5, 2.5 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = Math.sqrt( 1.5*1.5 + 0.25 );
  test.equivalent( gotDist, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 3, 3 ).copy
  ([
    1, 4, 2,
    3, 4, 1,
    2, 2, 2
  ]);
  var point = [ 1.5, 3, 2 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 0;
  test.equivalent( gotDist, expected );

  var polygon = _.convexPolygon.make( 3, 3 ).copy
  ([
    -1, 0, 0,
    0, 0, -1,
    0, 0, 0
  ]);
  var point = [ -0.5, -0.5, 2 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 2;
  test.equivalent( gotDist, expected );

  test.case = 'Square'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 2, 4 ).copy
  ([
    3, 3, 4, 4,
    3, 4, 4, 3
  ]);
  var point = [ 3.1, 3.9 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 0;
  test.equivalent( gotDist, expected );

  var polygon = _.convexPolygon.make( 2, 4 ).copy
  ([
    3, 3, 4, 4,
    3, 4, 4, 3
  ]);
  var point = [ 3.1, 4.1 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 0.1;
  test.equivalent( gotDist, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 3, 4 ).copy
  ([
    1, 0, 0, 1,
    0, 0, 1, 1,
    2, 2, 2, 2
  ]);
  var point = [ 0, 0.5, 2 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 0;
  test.equivalent( gotDist, expected );

  var polygon = _.convexPolygon.make( 3, 4 ).copy
  ([
    1, 0, 0, 1,
    0, 0, 1, 1,
    0, 0, 0, 0
  ]);
  var point = [ 0.5, 0.5, 2 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 2;
  test.equivalent( gotDist, expected );

  test.case = 'Pentagone 2D'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 2, 5 ).copy
  ([
    1, 0, 0, 1, 2,
    0, 0, 1, 1, 1
  ]);
  var point = [ 0, 0 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 0;
  test.equivalent( gotDist, expected );

  var polygon = _.convexPolygon.make( 2, 5 ).copy
  ([
    1, 0, 0, 1, 2,
    0, 0, 1, 1, 1
  ]);
  var point = [ - 0.1, 0.1 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 0.1;
  test.equivalent( gotDist, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 3, 5 ).copy
  ([
    1, 0, 0, 1, 2,
    0, 0, 1, 1, 1,
    2, 2, 2, 2, 2
  ]);
  var point = [ 0, 0.5, 2 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 0;
  test.equivalent( gotDist, expected );

  var polygon = _.convexPolygon.make( 3, 5 ).copy
  ([
    1, 0, 0, 1, 2,
    0, 0, 1, 1, 1,
    0, 0, 0, 0, 0
  ]);
  var point = [ 0.5, 0.5, 2 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 2;
  test.equivalent( gotDist, expected );

  test.case = 'Many vertices'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 2, 10 ).copy
  ([
    1,   0,  -1, -2, -2.1, -2,  -1,   0,   1, 2,
    0.1, 0, 0.1,  1,  1.5,  2, 2.5, 2.6, 2.5, 1
  ]);
  var pointT = [ 0, 0.1 ];
  var pointF = [ 0, - 0.1 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, pointT );
  var expected = 0;
  test.equivalent( gotDist, expected );

  var gotDist = _.convexPolygon.pointDistance( polygon, pointF );
  var expected = 0.1;
  test.equivalent( gotDist, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 3, 10 ).copy
  ([
    1,   0,  -1, -2, -2.1, -2,  -1,   0,   1, 2,
    0.1, 0, 0.1,  1,  1.5,  2, 2.5, 2.6, 2.5, 1,
    4,   4,   4,  4,    4,  4,   4,   4,   4, 4
  ]);
  var pointT = [ 0, 0.1, 4 ];
  var pointF = [ 0, 0.1, 2 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, pointT );
  var expected = 0;
  test.equivalent( gotDist, expected );

  var gotDist = _.convexPolygon.pointDistance( polygon, pointF );
  var expected = 2;
  test.equivalent( gotDist, expected );

  test.case = 'Point in vertex'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 2, 4 ).copy
  ([
    1,   0,  -1, -2,
    0.1, 0, 0.1,  1
  ]);
  var point = [ -1, 0.1 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 0;
  test.equivalent( gotDist, expected );

  test.case = 'Point close to vertex'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 2, 4 ).copy
  ([
    1,   0,  -1, -2,
    0.1, 0, 0.1,  1
  ]);
  var point = [ -1, 0 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 0.09950372048903948;
  test.equivalent( gotDist, expected );

  test.case = 'Point in edge'; //

  var polygon = _.convexPolygon.make( 2, 4 ).copy
  ([
    1,   0,  -1, 0,
    0, 0,  1,  2
  ]);
  var point = [ 0.5, 0 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 0;
  test.equivalent( gotDist, expected );

  test.case = 'Point in edge line but outside polygon'; //

  var polygon = _.convexPolygon.make( 2, 4 ).copy
  ([
    1,   0,  -1, -2,
    0.1, 0, 0.1,  1
  ]);
  var pointOne = [ -2, 0 ];
  var pointTwo = [  2, 0 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, pointOne );
  var expected = 0.7432941467979041;
  test.equivalent( gotDist, expected );

  var gotDist = _.convexPolygon.pointDistance( polygon, pointTwo );
  var expected = Math.sqrt( 1.01 );
  test.equivalent( gotDist, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon = _.convexPolygon.make( 2, 4 ).copy
  ([
    1,   0,  -1, -2,
    0.1, 0, 0.1,  1
  ]);
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistance( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistance( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistance( polygon, [ 1, 0 ], [ 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistance( polygon, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistance( null, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistance( NaN, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistance( undefined, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistance( 'polygon', [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistance( [ 3 ], [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistance( 3, [ 1, 0, 0 ] ));

  var polygon = _.convexPolygon.make( 2, 4 ).copy
  ([
    1, 0, 0, 0.1,
    0, 0, 1, 0.1
  ]);
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistance( polygon, [ 1, 0 ] ));

  var polygon = _.Space.make( [ 1, 2 ] );
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistance( polygon, [ 1 ] ));
}

//

function pointClosestPoint( test )
{

  test.case = 'Source polygon and point remain unchanged'; //

  var polygon = _.convexPolygon.make( 2, 3 ).copy
  ([
    1, 0, 0,
    0, 0, 1
  ]);
  var point = [ 1, 2 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );

  var expected = [ 0, 1 ];
  test.identical( gotClosestPoint, expected );

  var oldPolygon = _.convexPolygon.make( 2, 3 ).copy
  ([
    1, 0, 0,
    0, 0, 1
  ]);
  test.equivalent( oldPolygon, polygon );

  var oldPoint = [ 1, 2 ];
  test.equivalent( oldPoint, point );

  test.case = 'Triangle'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 2, 3 ).copy
  ([
    1, 0, 0,
    0, 0, 1
  ]);
  var point = [ 0.5, 0.5 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = [ 0.5, 0.5 ];
  test.equivalent( gotClosestPoint, expected );

  var polygon = _.convexPolygon.make( 2, 3 ).copy
  ([
    1, 0, 0,
    0, 0, 1
  ]);
  var point = [ 0.5, 2.5 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = [ 0, 1 ];
  test.equivalent( gotClosestPoint, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 3, 3 ).copy
  ([
    1, 4, 2,
    3, 4, 1,
    2, 2, 2
  ]);
  var point = [ 1.5, 3, 2 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = [ 1.5, 3, 2 ];
  test.equivalent( gotClosestPoint, expected );

  var polygon = _.convexPolygon.make( 3, 3 ).copy
  ([
    -1, 0, 0,
    0, 0, -1,
    0, 0, 0
  ]);
  var point = [ -0.5, -0.5, 2 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = [ -0.5, -0.5, 0 ];
  test.equivalent( gotClosestPoint, expected );

  test.case = 'Square'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 2, 4 ).copy
  ([
    3, 3, 4, 4,
    3, 4, 4, 3
  ]);
  var point = [ 3.1, 3.9 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = [ 3.1, 3.9 ];
  test.equivalent( gotClosestPoint, expected );

  var polygon = _.convexPolygon.make( 2, 4 ).copy
  ([
    3, 3, 4, 4,
    3, 4, 4, 3
  ]);
  var point = [ 3.1, 4.1 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = [ 3.1, 4 ];
  test.equivalent( gotClosestPoint, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 3, 4 ).copy
  ([
    1, 0, 0, 1,
    0, 0, 1, 1,
    2, 2, 2, 2
  ]);
  var point = [ 0, 0.5, 2 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = [ 0, 0.5, 2 ];
  test.equivalent( gotClosestPoint, expected );

  var polygon = _.convexPolygon.make( 3, 4 ).copy
  ([
    1, 0, 0, 1,
    0, 0, 1, 1,
    0, 0, 0, 0
  ]);
  var point = [ 0.5, 2, 2 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = [ 0.5, 1, 0 ];
  test.equivalent( gotClosestPoint, expected );

  test.case = 'Pentagone 2D'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 2, 5 ).copy
  ([
    1, 0, 0, 1, 2,
    0, 0, 1, 1, 1
  ]);
  var point = [ 0, 0 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = [ 0, 0 ];
  test.equivalent( gotClosestPoint, expected );

  var polygon = _.convexPolygon.make( 2, 5 ).copy
  ([
    1, 0, 0, 1, 2,
    0, 0, 1, 1, 1
  ]);
  var point = [ - 0.1, 0.1 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = [ 0, 0.1 ];
  test.equivalent( gotClosestPoint, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 3, 5 ).copy
  ([
    1, 0, 0, 1, 2,
    0, 0, 1, 1, 1,
    2, 2, 2, 2, 2
  ]);
  var point = [ 0, 0.5, 2 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = [ 0, 0.5, 2 ];
  test.equivalent( gotClosestPoint, expected );

  var polygon = _.convexPolygon.make( 3, 5 ).copy
  ([
    1, 0, 0, 1, 2,
    0, 0, 1, 1, 1,
    0, 0, 0, 0, 0
  ]);
  var point = [ 0.5, 0.5, 2 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = [ 0.5, 0.5, 0 ];
  test.equivalent( gotClosestPoint, expected );

  test.case = 'Many vertices'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 2, 10 ).copy
  ([
    1,   0,  -1, -2, -2.1, -2,  -1,   0,   1, 2,
    0.1, 0, 0.1,  1,  1.5,  2, 2.5, 2.6, 2.5, 1
  ]);
  var pointT = [ 0, 0.1 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, pointT );
  var expected = [ 0, 0.1 ];
  test.equivalent( gotClosestPoint, expected );

  var pointF = [ 0, - 0.1 ];
  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, pointF );
  var expected = [ 0, 0 ];
  test.equivalent( gotClosestPoint, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 3, 10 ).copy
  ([
    1,   0,  -1, -2, -2.1, -2,  -1,   0,   1, 2,
    0.1, 0, 0.1,  1,  1.5,  2, 2.5, 2.6, 2.5, 1,
    4,   4,   4,  4,    4,  4,   4,   4,   4, 4
  ]);
  var pointT = [ 0, 0.1, 4 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, pointT );
  var expected = [ 0, 0.1, 4 ];
  test.equivalent( gotClosestPoint, expected );

  var pointF = [ -3, 3, 2 ];
  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, pointF );
  var expected = [ -2, 2, 4 ];
  test.equivalent( gotClosestPoint, expected );

  test.case = 'Point in vertex'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 2, 4 ).copy
  ([
    1,   0,  -1, -2,
    0.1, 0, 0.1,  1
  ]);
  var point = [ -1, 0.1 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = [ -1, 0.1 ];
  test.equivalent( gotClosestPoint, expected );

  test.case = 'Point close to vertex'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 2, 4 ).copy
  ([
    1,   0,  -1, -2,
    0.25, 0, 0.25,  1
  ]);
  var point = [ -1, 0 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = [ -0.9411764705882353, 0.23529411764705882 ];
  test.equivalent( gotClosestPoint, expected );

  test.case = 'Point in edge'; //

  var polygon = _.convexPolygon.make( 2, 4 ).copy
  ([
    1,   0,  -1, 0,
    0, 0,  1,  2
  ]);
  var point = [ 0.5, 0 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = [ 0.5, 0 ];
  test.equivalent( gotClosestPoint, expected );

  test.case = 'Point in edge line but outside polygon'; //

  var polygon = _.convexPolygon.make( 2, 4 ).copy
  ([
    1,   0,  -1, -2,
    0.15, 0, 0.15,  1
  ]);

  var pointOne = [ -2, 0 ];
  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, pointOne );
  var expected = [ -1.5065312052018862, 0.5805515273629065 ];
  test.equivalent( gotClosestPoint, expected );

  var pointTwo = [  2, 0 ];
  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, pointTwo );
  var expected = [ 1, 0.15 ];
  test.equivalent( gotClosestPoint, expected );

  test.case = 'Dst point is array'; //

  var polygon = _.convexPolygon.make( 2, 4 ).copy
  ([
    1,   0,  -1, -2,
    0.15, 0, 0.15,  1
  ]);
  var srcPoint = _.vector.from( [ -2, 0 ] );
  var dstPoint = [ 5, 5 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, srcPoint, dstPoint );
  var expected = [ -1.5065312052018862, 0.5805515273629065 ];
  test.equivalent( gotClosestPoint, expected );

  test.case = 'Dst point is vector'; //

  var polygon = _.convexPolygon.make( 2, 4 ).copy
  ([
    1,   0,  -1, -2,
    0.15, 0, 0.15,  1
  ]);
  var srcPoint = _.vector.from( [ -2, 0 ] );
  var dstPoint = _.vector.from( [ 5, 5 ] );

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, srcPoint, dstPoint );
  var expected = _.vector.from( [ -1.5065312052018862, 0.5805515273629065 ] );
  test.equivalent( gotClosestPoint, expected );


  /* */

  if( !Config.debug )
  return;

  var polygon = _.convexPolygon.make( 2, 4 ).copy
  ([
    1,   0,  -1, -2,
    0.1, 0, 0.1,  1
  ]);
  test.shouldThrowErrorSync( () => _.convexPolygon.pointClosestPoint( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointClosestPoint( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointClosestPoint( polygon, [ 1, 0 ], [ 1, 0 ], [ 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointClosestPoint( polygon, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointClosestPoint( null, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointClosestPoint( NaN, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointClosestPoint( undefined, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointClosestPoint( 'polygon', [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointClosestPoint( [ 3 ], [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointClosestPoint( 3, [ 1, 0, 0 ] ));

  var polygon = _.convexPolygon.make( 2, 4 ).copy
  ([
    1, 0, 0, 0.1,
    0, 0, 1, 0.1
  ]);
  test.shouldThrowErrorSync( () => _.convexPolygon.pointClosestPoint( polygon, [ 1, 0 ] ));

  var polygon = _.Space.make( [ 1, 2 ] )
  test.shouldThrowErrorSync( () => _.convexPolygon.pointClosestPoint( polygon, [ 1 ] ));
}

//

function boxIntersects( test )
{

  test.description = 'Polygon and box remain unchanged'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1, 1, 1, 3, 3, 3 ];
  var expected = false;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  var oldBox = [ 1, 1, 1, 3, 3, 3 ];
  test.identical( box, oldBox );

  var oldPolygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and box intersect'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 0, 0, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.description = 'Polygon and box intersect, box bigger than polygon'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ - 2, - 2, 2, 2 ];
  var expected = true;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.description = 'Polygon and box intersect, box smaller than polygon'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ - 0.2, - 0.2, 0.2, 0.2 ];
  var expected = true;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.description = 'Polygon and box not intersecting'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1, 1, 5, 5 ];
  var expected = false;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.description = 'Polygon and box almost intersecting'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1.1, 0, 2, 2 ];
  var expected = false;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.description = 'polygon in box edge'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var box = [ 0, 0, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.description = 'polygon in box vertex'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var box = [ 2, 1, 3, 2 ];
  var expected = true;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.case = '3D';//

  test.description = 'Polygon and box intersect'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.description = 'Polygon and box intersect, box bigger than polygon'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ - 2, - 2, - 2, 2, 2, 2 ];
  var expected = true;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.description = 'Polygon and box intersect, box smaller than polygon'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ - 0.2, - 0.2, - 0.2, 0.2, 0.2, 0.2 ];
  var expected = true;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.description = 'Polygon and box not intersecting'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1, 1, 1, 5, 5, 5 ];
  var expected = false;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.description = 'Polygon and box almost intersecting'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 0.1, 0, 0, 1, 1, 1 ];
  var expected = false;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.description = 'polygon in box side'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.description = 'polygon in box edge'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.description = 'polygon in box vertex'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var box = [ 2, 2, 1, 3, 3, 2 ];
  var expected = true;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.boxIntersects( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxIntersects( box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxIntersects( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxIntersects( polygon, polygon, box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxIntersects( polygon, box, box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxIntersects( null, box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxIntersects( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxIntersects( NaN, box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxIntersects( polygon, NaN));

  box = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.boxIntersects( polygon, box ));
  box = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.convexPolygon.boxIntersects( polygon, box ));
  box = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.boxIntersects( polygon, box ));

}

//

function boxDistance( test )
{

  test.description = 'Polygon and box remain unchanged'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1, 1, 1, 3, 3, 3 ];
  var expected = Math.sqrt( 1.5 );

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  var oldBox = [ 1, 1, 1, 3, 3, 3 ];
  test.identical( box, oldBox );

  var oldPolygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and box intersect'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 0, 0, 1, 1 ];
  var expected = 0;

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and box not intersecting'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1, 1, 5, 5 ];
  var expected = Math.sqrt( 0.5 );

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and box almost intersecting'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1.1, 0, 2, 2 ];
  var expected = 0.1;

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to box edge'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var box = [ 3, -3, 4, 4 ];
  var expected = 1;

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to box edge'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    0,   0,   1,   1,
    0,   1,   1,   0
  ]);
  var box = [ 2, -2, 4, 2 ];
  var expected = 1;

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to box vertex'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var box = [ 2, 3, 3, 4 ];
  var expected = 2;

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to box vertex'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1, 1, 2, 2 ];
  var expected = Math.sqrt( 0.5 );

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.case = '3D';//

  test.description = 'Polygon and box intersect'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and box not intersecting'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1, 1, 1, 5, 5, 5 ];
  var expected = Math.sqrt( 1.5 );

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and box almost intersecting'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 0.1, 0, 0, 1, 1, 1 ];
  var expected = 0.1;

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to box side'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1,
    0,   0,   0,   0
  ]);
  var box = [ 2, -2, -2, 4, 2, 2 ];
  var expected = 1;

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to box side'; //

  var polygon =  _.Space.make( [ 3, 3 ] ).copy
  ([
    1,   1,   0,
   -1,   1,   0,
    0,   0,   0
  ]);
  var box = [ 2, -2, -2, 4, 2, 2 ];
  var expected = 1;

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to box edge'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    2,   3,   3,   2,
    2,   3,   4,   3,
    2,   3,   3,   2
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = Math.sqrt( 3 );

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to box edge'; //

  var polygon =  _.Space.make( [ 3, 3 ] ).copy
  ([
    0,   1,   1,
    0,   0,   1,
    2,   2,   4
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 1;

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to box vertex'; //

  var polygon =  _.Space.make( [ 3, 5 ] ).copy
  ([
    2,   3,   4,   3,   2,
    2,   3,   4,   4,   3,
    2,   3,   4,   5,   4
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = Math.sqrt( 3 );

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to box vertex'; //

  var polygon =  _.Space.make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = Math.sqrt( 2 ) / 2;

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Space.make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.boxDistance( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxDistance( box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxDistance( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxDistance( polygon, polygon, box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxDistance( polygon, box, box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxDistance( null, box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxDistance( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxDistance( NaN, box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxDistance( polygon, NaN));

  box = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.boxDistance( polygon, box ));
  box = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.convexPolygon.boxDistance( polygon, box ));
  box = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.boxDistance( polygon, box ));

}
boxDistance.timeOut = 9000;

//

function boxClosestPoint( test )
{

  test.description = 'Polygon and box remain unchanged'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1, 1, 1, 3, 3, 3 ];
  var expected = [ 0, 0.5, 0.5 ];

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  var oldBox = [ 1, 1, 1, 3, 3, 3 ];
  test.identical( box, oldBox );

  var oldPolygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and box intersect'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 0, 0, 1, 1 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and box not intersecting'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1, 1, 5, 5 ];
  var expected = [ 0.5, 0.5 ];

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and box almost intersecting'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1.1, 0, 2, 2 ];
  var expected = [ 1, 0 ];

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to box edge'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var box = [ 3, -3, 4, 4 ];
  var expected = [ 2, 1 ];

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to box edge'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    0,   0,   1,   1,
    0,   1,   1,   0
  ]);
  var box = [ 2, -2, 4, 2 ];
  var expected = [ 1, 1 ];

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to box vertex'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var box = [ 2, 3, 3, 4 ];
  var expected = [ 2, 1 ];

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to box vertex'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1, 1, 2, 2 ];
  var expected = [ 0.5, 0.5 ];

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.case = '3D';//

  test.description = 'Polygon and box intersect'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and box not intersecting'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1, 1, 1, 5, 5, 5 ];
  var expected = [ 0, 0.5, 0.5 ];

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and box almost intersecting'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 0.1, 0, 0, 1, 1, 1 ];
  var expected = [ 0, 1, 0 ];

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to box side'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1,
    0,   0,   0,   0
  ]);
  var box = [ 2, -2, -2, 4, 2, 2 ];
  var expected = [ 1, 0, 0 ];

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to box side'; //

  var polygon =  _.Space.make( [ 3, 3 ] ).copy
  ([
    1,   1,   0,
   -1,   1,   0,
    0,   0,   0
  ]);
  var box = [ 2, -2, -2, 4, 2, 2 ];
  var expected = [ 1, -1, 0 ];

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to box edge'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    2,   3,   3,   2,
    2,   3,   4,   3,
    2,   3,   3,   2
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = [ 2, 2, 2 ];

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to box edge'; //

  var polygon =  _.Space.make( [ 3, 3 ] ).copy
  ([
    0,   1,   1,
    0,   0,   1,
    2,   2,   4
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = [ 0, 0, 2 ];

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to box vertex'; //

  var polygon =  _.Space.make( [ 3, 5 ] ).copy
  ([
    2,   3,   4,   3,   2,
    2,   3,   4,   4,   3,
    2,   3,   4,   5,   4
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = [ 2, 2, 2 ];

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to box vertex'; //

  var polygon =  _.Space.make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = [ 0, 1.5, 1.5 ];

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Space.make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.boxClosestPoint( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxClosestPoint( box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxClosestPoint( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxClosestPoint( polygon, polygon, box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxClosestPoint( polygon, box, box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxClosestPoint( null, box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxClosestPoint( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxClosestPoint( NaN, box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxClosestPoint( polygon, NaN));

  box = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.boxClosestPoint( polygon, box ));
  box = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.convexPolygon.boxClosestPoint( polygon, box ));
  box = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.boxClosestPoint( polygon, box ));

}

//

function capsuleIntersects( test )
{

  test.description = 'Polygon and capsule remain unchanged'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 1, 1, 1, 3, 3, 3, 1 ];
  var expected = false;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  var oldCapsule = [ 1, 1, 1, 3, 3, 3, 1 ];
  test.identical( capsule, oldCapsule );

  var oldPolygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and capsule intersect'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 0, 0, 1, 1, 0.5 ];
  var expected = true;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  test.description = 'Polygon and capsule intersect, capsule bigger than polygon'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ - 2, - 2, 2, 2, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  test.description = 'Polygon and capsule intersect, capsule smaller than polygon'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ - 0.2, - 0.2, 0.2, 0.2, 0.1 ];
  var expected = true;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  test.description = 'Polygon and capsule not intersecting'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 1, 1, 5, 5, 0.5 ];
  var expected = false;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  test.description = 'Polygon and capsule almost intersecting'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 1.1, 0, 2, 2, 0.05 ];
  var expected = false;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  test.description = 'capsule is polygon´s edge'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var capsule = [ 0, 0, 0, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  test.description = 'polygon in capsule vertex'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var capsule = [ -1, 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  test.case = '3D';//

  test.description = 'Polygon and capsule intersect'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 0, 0, 0, 1, 1, 1, 0.5 ];
  var expected = true;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  test.description = 'Polygon and capsule intersect, capsule bigger than polygon'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ - 2, - 2, - 2, 2, 2, 2, 2 ];
  var expected = true;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  test.description = 'Polygon and capsule intersect, capsule smaller than polygon'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ - 0.2, - 0.2, - 0.2, 0.2, 0.2, 0.2, 0.2 ];
  var expected = true;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  test.description = 'Polygon and capsule not intersecting'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 1, 1, 1, 5, 5, 5, 1 ];
  var expected = false;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  test.description = 'Polygon and capsule almost intersecting'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 0.1, 0, 0, 1, 1, 1, 0.05 ];
  var expected = false;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  test.description = 'polygon in capsule side'; //

  var polygon =  _.Space.make( [ 3, 3 ] ).copy
  ([
    1,   3,   2,
    1,   1,   2,
    0,   0,   1
  ]);
  var capsule = [ 0, 0, 0, 1, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  test.description = 'polygon in capsule vertex'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var capsule = [ 3, 2, 1, 3, 3, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleIntersects( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleIntersects( capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleIntersects( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleIntersects( polygon, polygon, capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleIntersects( polygon, capsule, capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleIntersects( null, capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleIntersects( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleIntersects( NaN, capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleIntersects( polygon, NaN));

  capsule = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleIntersects( polygon, capsule ));
  capsule = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleIntersects( polygon, capsule ));
  capsule = [ 0, 0, 1, 1, 2, 2, - 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleIntersects( polygon, capsule ));
  capsule = [ 0, 0, 1, 1, 2, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleIntersects( polygon, capsule ));

}

//

function capsuleDistance( test )
{

  test.description = 'Polygon and capsule remain unchanged'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 1, 1, 1, 3, 3, 3, 0.5 ];
  var expected = Math.sqrt( 1.5 ) - 0.5;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  var oldCapsule = [ 1, 1, 1, 3, 3, 3, 0.5 ];
  test.identical( capsule, oldCapsule );

  var oldPolygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and capsule intersect'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 0, 0, 1, 1, 0.5 ];
  var expected = 0;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and capsule not intersecting'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 1, 1, 5, 5, 0.1 ];
  var expected = Math.sqrt( 0.5 ) - 0.1;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and capsule almost intersecting'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 1.1, 0, 2, 2, 0.05 ];
  var expected = 0.05;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to capsule origin'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var capsule = [ 0, 0, -4, -4, 0.5 ];
  var expected = 0.5;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to capsule end'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    0,   0,   1,   1,
    0,   1,   1,   0
  ]);
  var capsule = [ 0.5, -2, 0.5, -1, 0.3 ];
  var expected = 0.7;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to capsule'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var capsule = [ 0, 0.5, 1, -0.5, 0.01 ];
  var expected = Math.sqrt( 0.125 ) - 0.01;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to capsule'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 3, 0, 0, 3, 1 ];
  var expected = Math.sqrt( 2 ) - 1;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.case = '3D';//

  test.description = 'Polygon and capsule intersect'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 0, 0, 0, 1, 1, 1, 0.2 ];
  var expected = 0;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and capsule not intersecting'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 1, 1, 1, 5, 5, 5, 0.3 ];
  var expected = Math.sqrt( 1.5 ) - 0.3;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and capsule almost intersecting'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 0.1, 0, 0, 1, 1, 1, 0.05 ];
  var expected = 0.05;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to capsule'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    2,   3,   3,   2,
    2,   3,   4,   3,
    2,   3,   3,   2
  ]);
  var capsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var expected = Math.sqrt( 3 ) - 1;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to capsule origin'; //

  var polygon =  _.Space.make( [ 3, 3 ] ).copy
  ([
    0,   1,   1,
    0,   0,   1,
    2,   2,   4
  ]);
  var capsule = [ 0.5, 0, 0.5, 0.5, 1, - 1, 0.5 ];
  var expected = 1;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to capsule end'; //

  var polygon =  _.Space.make( [ 3, 5 ] ).copy
  ([
    2,   3,   4,   3,   2,
    2,   3,   4,   4,   3,
    2,   3,   4,   5,   4
  ]);
  var capsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var expected = Math.sqrt( 3 ) - 1;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to capsule'; //

  var polygon =  _.Space.make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);
  var capsule = [ -1, 0, 0, 1, 0, 0, 1 ];
  var expected = Math.sqrt( 4.5 ) - 1;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to capsule'; //

  var polygon =  _.Space.make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);
  var capsule = [ -1, 3, -1, 1, 3, -1, 0.5 ];
  var expected = 0.5;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Space.make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleDistance( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleDistance( capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleDistance( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleDistance( polygon, polygon, capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleDistance( polygon, capsule, capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleDistance( null, capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleDistance( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleDistance( NaN, capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleDistance( polygon, NaN));

  capsule = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleDistance( polygon, capsule ));
  capsule = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleDistance( polygon, capsule ));
  capsule = [ 0, 0, 1, 1, 2, 2, - 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleDistance( polygon, capsule ));
  capsule = [ 0, 0, 1, 1, 2, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleDistance( polygon, capsule ));

}
capsuleDistance.timeOut = 9000;

//

function capsuleClosestPoint( test )
{

  test.description = 'Polygon and capsule remain unchanged'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 1, 1, 1, 3, 3, 3, 1 ];
  var expected = [ 0, 0.5, 0.5 ];

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  var oldCapsule = [ 1, 1, 1, 3, 3, 3, 1 ];
  test.identical( capsule, oldCapsule );

  var oldPolygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and capsule intersect'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 0, 0, 1, 1, 0.5 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and capsule not intersecting'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 1, 1, 5, 5, 0.3 ];
  var expected = [ 0.5, 0.5 ];

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and capsule almost intersecting'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 1.1, 0, 2, 2, 0.05 ];
  var expected = [ 1, 0 ];

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to capsule origin'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var capsule = [ 0, 0, -1, -1, 0.5 ];
  var expected = [ 1, 0 ];

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to capsule end'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    0,   0,   1,   1,
    0,   1,   1,   0
  ]);
  var capsule = [ 0.5, -2, 0.5, -1, 0.5 ];
  var expected = [ 0.5, 0 ];

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to capsule'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    0,   0,   1,   1,
    0,   1,   1,   0
  ]);
  var capsule = [ 0, 3, 3, 0, 0.2 ];
  var expected = [ 1, 1 ];

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to capsule'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 0, 3, 3, 0, 0.2 ];
  var expected = [ 1, 0 ];

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  test.case = '3D';//

  test.description = 'Polygon and capsule intersect'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 0, 0, 0, 1, 1, 1, 0.5 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and capsule not intersecting'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 1, 1, 1, 5, 5, 5, 1 ];
  var expected = [ 0, 0.5, 0.5 ];

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and capsule almost intersecting'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 0.1, 0, 0, 1, 1, 1, 0.05 ];
  var expected = [ 0, 0, 0 ];

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to capsule origin'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1,
    0,   0,   0,   0
  ]);
  var capsule = [ 1, 0, 2, 4, 3, 4, 1 ];
  var expected = [ 1, 0, 0 ];

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to capsule end'; //

  var polygon =  _.Space.make( [ 3, 3 ] ).copy
  ([
    1,   1,   0,
   -1,   1,   0,
    0,   0,   0
  ]);
  var capsule = [ 2, 0, 3, 2, 0, 0, 0.5 ];
  var expected = [ 1, 0, 0 ];

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to capsule'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    2,   3,   3,   2,
    2,   3,   4,   3,
    2,   3,   3,   2
  ]);
  var capsule = [ 0, 1, 0, 0, 1, 5, 1 ];
  var expected = [ 2, 2, 2 ];

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to capsule'; //

  var polygon =  _.Space.make( [ 3, 3 ] ).copy
  ([
    0,   1,   1,
    0,   0,   1,
    2,   2,   4
  ]);
  var capsule = [ 2, -1, 3, 2, 1, 3, 0.2 ];
  var expected = [ 1, 0.6, 3.2 ];

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Space.make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleClosestPoint( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleClosestPoint( capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleClosestPoint( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleClosestPoint( polygon, polygon, capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleClosestPoint( polygon, capsule, capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleClosestPoint( null, capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleClosestPoint( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleClosestPoint( NaN, capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleClosestPoint( polygon, NaN));

  capsule = [ 0, 0, 1, 1, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleClosestPoint( polygon, capsule ));
  capsule = [ 0, 0, 1, 1, 2, 1 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleClosestPoint( polygon, capsule ));
  capsule = [ 0, 0, 1, 1, 2, 2, - 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleClosestPoint( polygon, capsule ));
  capsule = [ 0, 0, 1, 1, 2, 2, 2, 1 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleClosestPoint( polygon, capsule ));

}

//

function segmentIntersects( test )
{

  test.description = 'Polygon and segment remain unchanged'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 1, 1, 1, 3, 3, 3 ];
  var expected = false;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  var oldSegment = [ 1, 1, 1, 3, 3, 3 ];
  test.identical( segment, oldSegment );

  var oldPolygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and segment intersect'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 0, 0, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'Polygon and segment intersect, segment bigger than polygon'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ - 2, - 2, 2, 2 ];
  var expected = true;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'Polygon and segment intersect, segment smaller than polygon'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ - 0.2, - 0.2, 0.2, 0.2 ];
  var expected = true;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'Polygon and segment not intersecting'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 1, 1, 5, 5 ];
  var expected = false;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'Polygon and segment almost intersecting'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 1.1, 0, 2, 2 ];
  var expected = false;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'segment is polygon´s edge'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var segment = [ 1, 0, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'polygon in segment vertex'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var segment = [ 0, 0, 1, 0 ];
  var expected = true;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.case = '3D';//

  test.description = 'Polygon and segment intersect'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'Polygon and segment intersect, segment bigger than polygon'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ - 2, - 2, - 2, 2, 2, 2 ];
  var expected = true;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'Polygon and segment intersect, segment smaller than polygon'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ - 0.2, - 0.2, - 0.2, 0.2, 0.2, 0.2 ];
  var expected = true;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'Polygon and segment not intersecting'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 1, 1, 1, 5, 5, 5 ];
  var expected = false;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'Polygon and segment almost intersecting'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 0.1, 0, 0, 1, 1, 1 ];
  var expected = false;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'polygon in segment side'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'polygon in segment edge'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var segment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'polygon in segment vertex'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var segment = [ 2, 2, 1, 3, 3, 2 ];
  var expected = true;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.segmentIntersects( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentIntersects( segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentIntersects( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentIntersects( polygon, polygon, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentIntersects( polygon, segment, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentIntersects( null, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentIntersects( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentIntersects( NaN, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentIntersects( polygon, NaN));

  segment = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentIntersects( polygon, segment ));
  segment = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentIntersects( polygon, segment ));
  segment = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentIntersects( polygon, segment ));

}

//

function segmentDistance( test )
{

  test.description = 'Polygon and segment remain unchanged'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 1, 1, 1, 3, 3, 3 ];
  var expected = Math.sqrt( 1.5 );

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  var oldSegment = [ 1, 1, 1, 3, 3, 3 ];
  test.identical( segment, oldSegment );

  var oldPolygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and segment intersect'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 0, 0, 1, 1 ];
  var expected = 0;

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and segment not intersecting'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 1, 1, 5, 5 ];
  var expected = Math.sqrt( 0.5 );

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and segment almost intersecting'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 1.1, 0, 2, 2 ];
  var expected = 0.1;

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to segment origin'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var segment = [ 0, 0, -4, -4 ];
  var expected = 1;

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to segment end'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    0,   0,   1,   1,
    0,   1,   1,   0
  ]);
  var segment = [ 0.5, -2, 0.5, -1 ];
  var expected = 1;

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to segment'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var segment = [ 0, 0.5, 1, -0.5 ];
  var expected = Math.sqrt( 0.125 );

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to segment'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 3, 0, 0, 3 ];
  var expected = Math.sqrt( 2 );

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.case = '3D';//

  test.description = 'Polygon and segment intersect'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and segment not intersecting'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 1, 1, 1, 5, 5, 5 ];
  var expected = Math.sqrt( 1.5 );

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and segment almost intersecting'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 0.1, 0, 0, 1, 1, 1 ];
  var expected = 0.1;

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to segment edge'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    2,   3,   3,   2,
    2,   3,   4,   3,
    2,   3,   3,   2
  ]);
  var segment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = Math.sqrt( 3 );

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to segment origin'; //

  var polygon =  _.Space.make( [ 3, 3 ] ).copy
  ([
    0,   1,   1,
    0,   0,   1,
    2,   2,   4
  ]);
  var segment = [ 0.5, 0, 0.5, 0.5, 1, - 1 ];
  var expected = 1.5;

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to segment end'; //

  var polygon =  _.Space.make( [ 3, 5 ] ).copy
  ([
    2,   3,   4,   3,   2,
    2,   3,   4,   4,   3,
    2,   3,   4,   5,   4
  ]);
  var segment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = Math.sqrt( 3 );

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to segment'; //

  var polygon =  _.Space.make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);
  var segment = [ -1, 0, 0, 1, 0, 0 ];
  var expected = Math.sqrt( 4.5 );

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to segment'; //

  var polygon =  _.Space.make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);
  var segment = [ -1, 3, -1, 1, 3, -1 ];
  var expected = 1;

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Space.make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.segmentDistance( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentDistance( segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentDistance( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentDistance( polygon, polygon, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentDistance( polygon, segment, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentDistance( null, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentDistance( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentDistance( NaN, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentDistance( polygon, NaN));

  segment = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentDistance( polygon, segment ));
  segment = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentDistance( polygon, segment ));
  segment = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentDistance( polygon, segment ));

}
segmentDistance.timeOut = 9000;

//

function segmentClosestPoint( test )
{

  test.description = 'Polygon and segment remain unchanged'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 1, 1, 1, 3, 3, 3 ];
  var expected = [ 0, 0.5, 0.5 ];

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  var oldSegment = [ 1, 1, 1, 3, 3, 3 ];
  test.identical( segment, oldSegment );

  var oldPolygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and segment intersect'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 0, 0, 1, 1 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and segment not intersecting'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 1, 1, 5, 5 ];
  var expected = [ 0.5, 0.5 ];

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and segment almost intersecting'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 1.1, 0, 2, 2 ];
  var expected = [ 1, 0 ];

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to segment origin'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var segment = [ 0, 0, -1, -1 ];
  var expected = [ 1, 0 ];

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to segment end'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    0,   0,   1,   1,
    0,   1,   1,   0
  ]);
  var segment = [ 0.5, -2, 0.5, -1 ];
  var expected = [ 0.5, 0 ];

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to segment'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    0,   0,   1,   1,
    0,   1,   1,   0
  ]);
  var segment = [ 0, 3, 3, 0 ];
  var expected = [ 1, 1 ];

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to segment'; //

  var polygon =  _.Space.make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 2, - 1, 2, 2 ];
  var expected = [ 1, 0 ];

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  test.case = '3D';//

  test.description = 'Polygon and segment intersect'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and segment not intersecting'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 1, 1, 1, 5, 5, 5 ];
  var expected = [ 0, 0.5, 0.5 ];

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and segment almost intersecting'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 0.1, 0, 0, 1, 1, 1 ];
  var expected = [ 0, 0, 0 ];

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to segment origin'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1,
    0,   0,   0,   0
  ]);
  var segment = [ 1, 0, 2, 4, 3, 4 ];
  var expected = [ 1, 0, 0 ];

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to segment end'; //

  var polygon =  _.Space.make( [ 3, 3 ] ).copy
  ([
    1,   1,   0,
   -1,   1,   0,
    0,   0,   0
  ]);
  var segment = [ 2, 0, 3, 2, 0, 0 ];
  var expected = [ 1, 0, 0 ];

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to segment'; //

  var polygon =  _.Space.make( [ 3, 4 ] ).copy
  ([
    2,   3,   3,   2,
    2,   3,   4,   3,
    2,   3,   3,   2
  ]);
  var segment = [ 0, 1, 0, 0, 1, 5 ];
  var expected = [ 2, 2, 2 ];

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to segment'; //

  var polygon =  _.Space.make( [ 3, 3 ] ).copy
  ([
    0,   1,   1,
    0,   0,   1,
    2,   2,   4
  ]);
  var segment = [ 2, -1, 3, 2, 1, 3 ];
  var expected = [ 1, 0.6, 3.2 ];

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Space.make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.segmentClosestPoint( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentClosestPoint( segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentClosestPoint( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentClosestPoint( polygon, polygon, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentClosestPoint( polygon, segment, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentClosestPoint( null, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentClosestPoint( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentClosestPoint( NaN, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentClosestPoint( polygon, NaN));

  segment = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentClosestPoint( polygon, segment ));
  segment = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentClosestPoint( polygon, segment ));
  segment = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentClosestPoint( polygon, segment ));

}



// --
// declare
// --

var Self =
{

  name : 'Tools/Math/ConvexPolygon',
  silencing : 1,
  enabled : 1,
  // verbosity : 7,
  // debug : 1,

  tests :
  {

    make : make,
    isPolygon : isPolygon,
    is : is,
    angleThreePoints : angleThreePoints,

    pointContains : pointContains,
    pointDistance : pointDistance,
    pointClosestPoint : pointClosestPoint,

    boxIntersects : boxIntersects,
    boxDistance : boxDistance,
    boxClosestPoint : boxClosestPoint,

    capsuleIntersects : capsuleIntersects,
    capsuleDistance : capsuleDistance,
    capsuleClosestPoint : capsuleClosestPoint,

    segmentIntersects : segmentIntersects,
    segmentDistance : segmentDistance,
    segmentClosestPoint : segmentClosestPoint,

  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
