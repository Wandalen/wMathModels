( function _Frustum_test_s_( ) {

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

 require( '../geometric/Plane.s' );
 require( '../geometric/Sphere.s' );
 require( '../geometric/Box.s' );
 require( '../geometric/Frustum.s' );

}

//

var _ = _global_.wTools.withArray.Float32;
var Space = _.Space;
var vector = _.vector;
var vec = _.vector.fromArray;
var avector = _.avector;
var sqrt = _.sqrt;
var Parent = _.Tester;

_.assert( sqrt );

// --
// test
// --

function sphereIntersects( test )
{

  test.description = 'Frustum and sphere remain unchanged'; //

  var f = _.Space.make( [ 4, 6 ] ).copy(
     [ 1, 0, 0, - 1, 0, 0,
       0, 1, 0, 0, - 1, 0,
       0, 0, 1, 0, 0, - 1,
       1, 1, 1, 1, 1, 1 ] );

  var sphere = [ 3, 3, 3, 1 ];
  var oldf = _.Space.make( [ 4, 6 ] ).copy(
     [ 1, 0, 0, - 1, 0, 0,
       0, 1, 0, 0, - 1, 0,
       0, 0, 1, 0, 0, - 1,
       1, 1, 1, 1, 1, 1 ] );

  var oldSphere = [ 3, 3, 3, 1 ];
  var expected = false;

  var result = _.frustum.sphereIntersects( f, sphere );
  test.identical( result, expected );
  test.identical( f, oldf );
  test.identical( sphere, oldSphere );

  test.description = 'Frustum and sphere intersect'; //

  var sphere = [ 1, 1, 1, 1 ];
  var expected = true;

  var result = _.frustum.sphereIntersects( f, sphere );
  test.identical( result, expected );

  test.description = 'Frustum and sphere intersect, sphere bigger than frustum'; //

  var sphere = [ 1, 1, 1, 7 ];
  var expected = true;

  var result = _.frustum.sphereIntersects( f, sphere );
  test.identical( result, expected );

  test.description = 'Frustum and sphere not intersecting'; //

  var sphere = [ 5, 5, 5, 1 ];
  var expected = false;

  var result = _.frustum.sphereIntersects( f, sphere );
  test.identical( result, expected );

  test.description = 'Frustum and sphere almost intersecting'; //

  var sphere = [ 5 , 5, 5, 3.9 ];
  var expected = false;

  var result = _.frustum.sphereIntersects( f, sphere );
  test.identical( result, expected );

  test.description = 'Frustum and sphere just touching'; //

  var sphere = [ 5 , 5, 5, 4 ];
  var expected = false;

  var result = _.frustum.sphereIntersects( f, sphere );
  test.identical( result, expected );

  test.description = 'Frustum and sphere just intersect'; //

  var sphere = [ 5, 5, 5, 4.1 ];
  var expected = true;

  var result = _.frustum.sphereIntersects( f, sphere );
  test.identical( result, expected );

  test.description = 'Zero frustum, no intersection'; //

  var f = _.frustum.make();
  var sphere = [ 0, 0, 0, 2 ];
  var expected = false;

  var result = _.frustum.sphereIntersects( f, sphere );
  test.identical( result, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( ));
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( sphere ));
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( f ));
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( f, f, sphere ));
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( f, sphere, sphere ));
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( null, sphere ));
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( f, null));
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( NaN, sphere ));
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( f, NaN));

  sphere = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( f, sphere ));

}


function boxIntersects( test )
{

  test.description = 'Frustum and box remain unchanged'; //

  var Spa = _.Space.make([ 4,4 ]);
  Spa.atomSet( [ 0, 0 ], 1 ); Spa.atomSet( [ 1, 0 ], - 1 ); Spa.atomSet( [ 2, 0 ], 1 ); Spa.atomSet( [ 3, 0 ], 1 );
  Spa.atomSet( [ 0, 1 ], 1 ); Spa.atomSet( [ 1, 1 ], 1 ); Spa.atomSet( [ 2, 1 ], - 1 ); Spa.atomSet( [ 3, 1 ], 1 );
  Spa.atomSet( [ 0, 2 ], 1 ); Spa.atomSet( [ 1, 2 ], 1 ); Spa.atomSet( [ 2, 2 ], 1 ); Spa.atomSet( [ 3, 2 ], - 1 );
  Spa.atomSet( [ 0, 3 ], - 1 ); Spa.atomSet( [ 1, 3 ], 0 ); Spa.atomSet( [ 2, 3 ], 1 ); Spa.atomSet( [ 3, 3 ], 1 );

  var f = _.frustum.fromMatrixHomogenous( null , Spa);
  var box = [ 2, 2, 2, 4, 4, 4 ];
  box = _.vector.from( box);
  var oldf = _.frustum.fromMatrixHomogenous( null , Spa);
  var oldbox = [ 2, 2, 2, 4, 4, 4 ];
  var expected = true;

  var result = _.frustum.boxIntersects( f, box );
  test.identical( result, expected );
  test.identical( f, oldf );
  test.identical( box, oldbox );

  test.description = 'Frustum and box intersect'; //

  var f = _.frustum.fromMatrixHomogenous( null , Spa);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var result = _.frustum.boxIntersects( f, box );
  test.identical( result, expected );

  test.description = 'Frustum and box intersect, box bigger than frustum'; //

  var f = _.frustum.fromMatrixHomogenous( null , Spa);
  var box = [ - 10, - 10, - 10, 10, 10, 10 ];
  var expected = true;

  var result = _.frustum.boxIntersects( f, box );
  test.identical( result, expected );

  test.description = 'Frustum and box not intersecting'; //

  var f = _.frustum.fromMatrixHomogenous( null , Spa);
  var box = [ 8, 8, 8, 9, 9, 9 ];
  var expected = false;

  var result = _.frustum.boxIntersects( f, box );
  test.identical( result, expected );

  Spa.atomSet( [ 0, 0 ], 2 ); Spa.atomSet( [ 1, 0 ], 3 ); Spa.atomSet( [ 2, 0 ], 4 ); Spa.atomSet( [ 3, 0 ], 5 );
  Spa.atomSet( [ 0, 1 ], 2 ); Spa.atomSet( [ 1, 1 ], 3 ); Spa.atomSet( [ 2, 1 ], 4 ); Spa.atomSet( [ 3, 1 ], 5);
  Spa.atomSet( [ 0, 2 ], 2 ); Spa.atomSet( [ 1, 2 ], 3 ); Spa.atomSet( [ 2, 2 ], 4 ); Spa.atomSet( [ 3, 2 ], 5 );
  Spa.atomSet( [ 0, 3 ], 2 ); Spa.atomSet( [ 1, 3 ], 3 ); Spa.atomSet( [ 2, 3 ], 4 ); Spa.atomSet( [ 3, 3 ], 5 );

  test.description = 'Frustum and box don´t intersect'; //

  var f = _.frustum.fromMatrixHomogenous( null , Spa);
  var box = [ -3 , - 3, - 3, - 2, - 2, - 2 ];
  var expected = false;

  var result = _.frustum.boxIntersects( f, box );
  test.identical( result, expected );

  test.description = 'Frustum and box don´t intersect'; //

  var f = _.frustum.fromMatrixHomogenous( null , Spa);
  var box = [ 14, 14, 14, 14, 14, 14 ];
  var expected = false;

  var result = _.frustum.boxIntersects( f, box );
  test.identical( result, expected );

  test.description = 'Zero frustum, no intersection'; //

  var f = _.frustum.make();
  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expected = false;

  var result = _.frustum.boxIntersects( f, box );
  test.identical( result, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( ));
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( box ));
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( f ));
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( f, f, box ));
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( f, box, box ));
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( null, box ));
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( f, null));
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( NaN, box ));
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( f, NaN));

  box = [ 0, 0, 1, 1, 2 ];
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( f, box ));

  box = [ 0, 0, 1, 1, 2, 3, 4 ];
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( f, box ));

}

// --
// define class
// --

var Self =
{

 name : 'Math.Frustum',
 silencing : 1,
 // verbosity : 7,
 // debug : 1,
 routine: 'sphereIntersects',

 tests :
 {

 sphereIntersects : sphereIntersects,
 boxIntersects : boxIntersects,
 //pointContains : pointContains,

 //frustumIntersects : frustumIntersects,
 //pointClosestPoint : pointClosestPoint,
 //boxClosestPoint : boxClosestPoint,
 //sphereClosestPoint : sphereClosestPoint,

 }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
