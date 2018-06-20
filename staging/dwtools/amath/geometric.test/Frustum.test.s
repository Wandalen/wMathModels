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

//

function boxIntersects( test )
{

  test.description = 'Frustum and box remain unchanged'; //

  var f = _.Space.make( [ 4, 6 ] ).copy
    ([ 1, 0, 0, - 1, 0, 0,
       0, 1, 0, 0, - 1, 0,
       0, 0, 1, 0, 0, - 1,
       1, 1, 1, 1, 1, 1 ] );

  var box = [ 1, 1, 1, 3, 3, 3 ];
  var oldf = _.Space.make( [ 4, 6 ] ).copy
    ([ 1, 0, 0, - 1, 0, 0,
       0, 1, 0, 0, - 1, 0,
       0, 0, 1, 0, 0, - 1,
       1, 1, 1, 1, 1, 1 ] );

  var oldbox = [ 1, 1, 1, 3, 3, 3 ];
  var expected = true;

  var result = _.frustum.boxIntersects( f, box );
  test.identical( result, expected );
  test.identical( f, oldf );
  test.identical( box, oldbox );

  test.description = 'Frustum and box intersect'; //

  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var result = _.frustum.boxIntersects( f, box );
  test.identical( result, expected );

  test.description = 'Frustum and box intersect, box bigger than frustum'; //

  var box = [ - 2, - 2, - 2, 2, 2, 2 ];
  var expected = true;

  var result = _.frustum.boxIntersects( f, box );
  test.identical( result, expected );

  test.description = 'Frustum and box not intersecting'; //

  var box = [ 4, 4, 4, 5, 5, 5 ];
  var expected = false;

  var result = _.frustum.boxIntersects( f, box );
  test.identical( result, expected );

  test.description = 'Frustum and box almost intersecting'; //

  var box = [ 1.1, 1.1, 1.1, 5 , 5, 5 ];
  var expected = false;

  var result = _.frustum.boxIntersects( f, box );
  test.identical( result, expected );

  test.description = 'Frustum and box just touching'; //

  var box = [ 1, 1, 1, 5 , 5, 5 ];
  var expected = true;

  var result = _.frustum.boxIntersects( f, box );
  test.identical( result, expected );

  test.description = 'Frustum and box just intersect'; //

  var box = [ 0.9, 0.9, 0.9, 5, 5, 5 ];
  var expected = true;

  var result = _.frustum.boxIntersects( f, box );
  test.identical( result, expected );

  test.description = 'Zero frustum, intersection'; //

  var f = _.frustum.make();
  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expected = true;

  var result = _.frustum.boxIntersects( f, box );
  test.identical( result, expected );

  test.description = 'Zero frustum, no intersection'; //

  var f = _.frustum.make();
  var box = [ 1, 1, 1, 2, 2, 2 ];
  var expected = true;

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

  box = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( f, box ));
  box = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( f, box ));
  box = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( f, box ));

}

//

function pointContains( test )
{

  test.description = 'Frustum and point remain unchanged'; //

  var f = _.Space.make( [ 4, 6 ] ).copy
    ([ 1, 0, 0, - 1, 0, 0,
       0, 1, 0, 0, - 1, 0,
       0, 0, 1, 0, 0, - 1,
       1, 1, 1, 1, 1, 1 ] );
  var point = [ 3, 3, 3 ];
  point = _.vector.from( point );
  var oldf = _.Space.make( [ 4, 6 ] ).copy
    ([ 1, 0, 0, - 1, 0, 0,
       0, 1, 0, 0, - 1, 0,
       0, 0, 1, 0, 0, - 1,
       1, 1, 1, 1, 1, 1 ] );

  var oldpoint = [ 3, 3, 3 ];
  oldpoint = _.vector.from( oldpoint );
  var expected = false;

  var result = _.frustum.pointContains( f, point );
  test.identical( result, expected );
  test.identical( f, oldf );
  test.identical( point, oldpoint );

  test.description = 'Frustum contains point'; //

  var point = [ 0, 0, 0 ];
  point = _.vector.from( point );
  var expected = true;

  var result = _.frustum.pointContains( f, point );
  test.identical( result, expected );

  test.description = 'Point near border'; //

  var point = [ 0.9, 0.9, 0.9 ];
  point = _.vector.from( point );
  var expected = true;

  var result = _.frustum.pointContains( f, point );
  test.identical( result, expected );

  test.description = 'Point in corner'; //

  var point = [ 1, 1, 1 ];
  point = _.vector.from( point );
  var expected = true;

  var result = _.frustum.pointContains( f, point );
  test.identical( result, expected );

  test.description = 'Point just outside frustum'; //

  var point = [ 1.1, 1.1, 1.1 ];
  point = _.vector.from( point );
  var expected = false;

  var result = _.frustum.pointContains( f, point );
  test.identical( result, expected );

  test.description = 'Point out os frustum'; //

  var point = [ 5 , 5, 5 ];
  point = _.vector.from( point );
  var expected = false;

  var result = _.frustum.pointContains( f, point );
  test.identical( result, expected );

  test.description = 'Zero frustum contains zero point'; //

  var f = _.frustum.make();
  var point = [ 0, 0, 0 ];
  point = _.vector.from( point );
  var expected = true;

  var result = _.frustum.pointContains( f, point );
  test.identical( result, expected );

  test.description = 'Zero frustum doesn´t contain point'; //

  var f = _.frustum.make();
  var point = [ 0, 0, 0.5 ];
  point = _.vector.from( point );
  var expected = true;

  var result = _.frustum.pointContains( f, point );
  test.identical( result, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.pointContains( ));
  test.shouldThrowErrorSync( () => _.frustum.pointContains( point ));
  test.shouldThrowErrorSync( () => _.frustum.pointContains( f ));
  test.shouldThrowErrorSync( () => _.frustum.pointContains( f, f, point ));
  test.shouldThrowErrorSync( () => _.frustum.pointContains( f, point, point ));
  test.shouldThrowErrorSync( () => _.frustum.pointContains( null, point ));
  test.shouldThrowErrorSync( () => _.frustum.pointContains( f, null));
  test.shouldThrowErrorSync( () => _.frustum.pointContains( NaN, point ));
  test.shouldThrowErrorSync( () => _.frustum.pointContains( f, NaN));

  point = [ 0, 1];
  point = _.vector.from( point );
  test.shouldThrowErrorSync( () => _.frustum.pointContains( f, point ));
  point = [ 0, 0, 1, 1];
  point = _.vector.from( point );
  test.shouldThrowErrorSync( () => _.frustum.pointContains( f, point ));

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
 //routine: 'pointContains',

 tests :
 {

 sphereIntersects : sphereIntersects,
 boxIntersects : boxIntersects,
 pointContains : pointContains,

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
