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

  test.description = 'Dim and vertices remain unchanged'; //

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

  test.description = 'Triangle 2D'; //

  var dim = 2;
  var vertices = 3;

  var gotPolygon = _.convexPolygon.make( dim, vertices );

  var expected = _.Space.make( [ 2, 3 ] ).copy
  ([
    0, 0, 0,
    0, 0, 0
  ]);
  test.equivalent( gotPolygon, expected );

  test.description = 'Square 3D'; //

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

  test.description = 'Pentagone 2D'; //

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

  test.description = 'Source polygon remains unchanged'; //

  var polygon = _.convexPolygon.make( 3, 3 );

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = true;
  test.identical( gotBool, expected );

  var oldPolygon = _.convexPolygon.make( 3, 3 );
  test.equivalent( oldPolygon, polygon );

  test.description = 'Triangle 2D'; //

  var polygon = _.convexPolygon.make( 2, 3 ).copy
  ([
    1, 0, 0,
    0, 0, 1
  ]);

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.description = 'Square 3D'; //

  var polygon = _.convexPolygon.make( 3, 4 ).copy
  ([
    1, 1, 0, 0,
    0, 1, 1, 0,
    0, 0, 0, 0
  ]);

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.description = '4 points in 3D not coplanar'; //

  var polygon = _.convexPolygon.make( 3, 4 ).copy
  ([
    1, 1, 0, 0,
    0, 1, 1, 0,
    0, 0, 0, 1
  ]);

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = false;
  test.equivalent( gotBool, expected );

  test.description = 'Pentagone 2D'; //

  var polygon = _.convexPolygon.make( 2, 5 ).copy
  ([
    1, 0, 0, 0, 2,
    0, 0, 1, 2, 0
  ]);

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.description = 'Dim < 2'; //

  var polygon = _.Space.make( [ 1, 5 ] ).copy
  ([
    1, 0, 0, 0, 2
  ]);

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = false;
  test.equivalent( gotBool, expected );

  test.description = 'Dim > 3'; //

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

  test.description = 'Vertices < 3'; //

  var polygon = _.Space.make( [ 2, 2 ] ).copy
  ([
    1, 0,
    0, 1
  ]);

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = false;
  test.equivalent( gotBool, expected );

  test.description = 'Three points are always coplanar'; //

  var polygon = _.convexPolygon.make( 3, 3 ).copy
  ([
    1, 0, 0,
    0, 1, 0,
    1, 1, 1,
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

    //angleThreePoints : angleThreePoints,

  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
