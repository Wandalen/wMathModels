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

  var f =  _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   0,   0,
       0,   0,   1, - 1,   0,   0,
     - 1,   0, - 1,   0,   0, - 1 ] );

  var box = [ 1, 1, 1, 3, 3, 3 ];
  var oldf =  _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   0,   0,
       0,   0,   1, - 1,   0,   0,
     - 1,   0, - 1,   0,   0, - 1 ] );

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

  test.description = 'Frustum and box intersect, box smaller than frustum'; //

  var box = [ - 0.2, - 0.2, - 0.2, 0.2, 0.2, 0.2 ];
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
  var f = _.frustum.make();
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( f, [ 0, 0, 0, 1, 1, 1] ));

}

//

function frustumIntersects( test )
{

  test.description = 'Frustums remain unchanged'; //

  var f = _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   0,   0,
       0,   0,   1, - 1,   0,   0,
     - 1,   0, - 1,   0,   0, - 1 ] );
  var frustum = _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   0,   0,
       0,   0,   1, - 1,   0,   0,
     - 1, - 1, - 1, - 1, - 1, - 1 ] );
  var oldf = _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   0,   0,
       0,   0,   1, - 1,   0,   0,
     - 1,   0, - 1,   0,   0, - 1 ] );
  var oldfrustum = _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   0,   0,
       0,   0,   1, - 1,   0,   0,
     - 1, - 1, - 1, - 1, - 1, - 1 ] );
  var expected = true;

  var result = _.frustum.frustumIntersects( f, frustum );
  test.identical( result, expected );
  test.identical( f, oldf );
  test.identical( frustum, oldfrustum );

  test.description = 'Frustum intersects with itself'; //

  var frustum = _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   0,   0,
       0,   0,   1, - 1,   0,   0,
     - 1,   0, - 1,   0,   0, - 1 ] );
  var expected = true;

  var result = _.frustum.frustumIntersects( f, frustum );
  test.identical( result, expected );

  test.description = 'Frustums intersect'; //

  var frustum = _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   0,   0,
       0,   0,   1, - 1,   0,   0,
     - 0.5, - 0.5, - 0.5, - 0.5, - 0.5, - 0.5 ] );
  var expected = true;

  var result = _.frustum.frustumIntersects( f, frustum );
  test.identical( result, expected );

  test.description = 'Frustums don´t intersec'; //

  var frustum = _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   0,   0,
       0,   0,   1, - 1,   0,   0,
     - 3,   4, - 3,   4,   4, - 3 ] );
  var expected = false;

  var result = _.frustum.frustumIntersects( f, frustum );
  test.identical( result, expected );

  test.description = 'Frustums almost intersecting'; //

  var frustum = _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   0,   0,
       0,   0,   1, - 1,   0,   0,
     - 2,   1.1, - 2,   1.1,   1.1, - 2 ] );
  var expected = false;

  var result = _.frustum.frustumIntersects( f, frustum );
  test.identical( result, expected );

  test.description = 'Frustums just touching'; //

  var frustum = _.Space.make( [ 4, 6 ] ).copy(
      [ 0,   0,   0,   0, - 1,   1,
        1, - 1,   0,   0,   0,   0,
        0,   0,   1, - 1,   0,   0,
      - 2,   1, - 2,   1,   1, - 2 ] );

  var expected = true;

  var result = _.frustum.frustumIntersects( f, frustum );
  test.identical( result, expected );

  test.description = 'Frustums just intersect'; //

  var frustum = _.Space.make( [ 4, 6 ] ).copy(
      [ 0,   0,   0,   0, - 1,   1,
        1, - 1,   0,   0,   0,   0,
        0,   0,   1, - 1,   0,   0,
      - 2, 0.9, - 2, 0.9,   1, 0.9 ] );

  var expected = true;

  var result = _.frustum.frustumIntersects( f, frustum );
  test.identical( result, expected );

  test.description = 'Zero frustum, intersection'; //

  var frustum = _.frustum.make();
  var expected = true;

  var result = _.frustum.frustumIntersects( f, frustum );
  test.identical( result, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( ));
  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( f ));
  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( f, f, frustum ));
  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( null, frustum ));
  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( f, null));
  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( NaN, frustum ));
  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( f, NaN));
  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( [], f));
  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], f));

}

//

function pointContains( test )
{

  test.description = 'Frustum and point remain unchanged'; //

  var f = _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   0,   0,
       0,   0,   1, - 1,   0,   0,
     - 1,   0, - 1,   0,   0, - 1 ] );
  var point = [ 3, 3, 3 ];
  point = _.vector.from( point );
  var oldf = _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   0,   0,
       0,   0,   1, - 1,   0,   0,
     - 1,   0, - 1,   0,   0, - 1 ] );

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

  test.description = 'Point out of frustum'; //

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

  test.description = 'Zero frustum contains  all points'; //

  var f = _.frustum.make();
  var point = [ 0, - 10, 5 ];
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

//

function frustumCorners( test )
{

  test.description = 'Frustum remains unchanged'; //

  var f = _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   0,   0,
       0,   0,   1, - 1,   0,   0,
     - 1,   0, - 1,   0,   0, - 1 ] );
  var oldf = _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   0,   0,
       0,   0,   1, - 1,   0,   0,
     - 1,   0, - 1,   0,   0, - 1 ] );
  var expected = _.Space.make( [ 3, 8 ] ).copy
    ([ 0, 0, 0, 0, 1, 1, 1, 1,
       1, 0, 1, 0, 1, 0, 1, 0,
       1, 1, 0, 0, 1, 1, 0, 0 ] );

  var result = _.frustum.frustumCorners( f );
  test.equivalent( result, expected );
  test.identical( f, oldf );


  test.description = 'Frustrum as box (0,0,0,1,1,1)'; //

  var f = _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   0,   0,
       0,   0,   1, - 1,   0,   0,
     - 1,   0, - 1,   0,   0, - 1 ] );
  var expected = _.Space.make( [ 3, 8 ] ).copy
    ([ 0, 0, 0, 0, 1, 1, 1, 1,
       1, 0, 1, 0, 1, 0, 1, 0,
       1, 1, 0, 0, 1, 1, 0, 0 ] );

  var result = _.frustum.frustumCorners( f );
  test.identical( result, expected );

  test.description = 'Frustrum as point (1,1,1)'; //

  var f = _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   0,   0,
       0,   0,   1, - 1,   0,   0,
     - 1,   1, - 1,   1,   1, - 1 ] );
  var expected = _.Space.make( [ 3, 8 ] ).copy
    ([ 1, 1, 1, 1, 1, 1, 1, 1,
       1, 1, 1, 1, 1, 1, 1, 1,
       1, 1, 1, 1, 1, 1, 1, 1 ] );

  var result = _.frustum.frustumCorners( f );
  test.identical( result, expected );

  test.description = 'Frustrum as box (-1,-1,-1,1,1,1)'; //

  var f = _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   0,   0,
       0,   0,   1, - 1,   0,   0,
     - 1, - 1, - 1, - 1, - 1, - 1 ] );
  var expected = _.Space.make( [ 3, 8 ] ).copy
    ([ -1, -1, -1, -1, 1, 1, 1, 1,
       1, -1, 1, -1, 1, -1, 1, -1,
       1, 1, -1, -1, 1, 1, -1, -1 ] );

  var result = _.frustum.frustumCorners( f );
  test.identical( result, expected );

  test.description = 'Frustrum with inclined side'; //

  var f = _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   0,   0,
       0,   2,   1, - 1,   0,   0,
     - 1,   0, - 1,   0,   0, - 1 ] );
  var expected = _.Space.make( [ 3, 8 ] ).copy
    ([ 0, 0, 0, 0, 1, 1, 1, 1,
       1, 2, 1, 0, 1, 2, 1, 0,
       1, 1, 0, 0, 1, 1, 0, 0 ] );

  var result = _.frustum.frustumCorners( f );
  test.identical( result, expected );

  test.description = 'Frustrum with two inclined sides'; //

  var f = _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   2,   0,
       0,   2,   1, - 1,   0,   0,
     - 1,   0, - 1,   0,   0, - 1 ] );
  var expected = _.Space.make( [ 3, 8 ] ).copy
    ([ 2, 4, 2, 0, 1, 1, 1, 1,
       1, 2, 1, 0, 1, 2, 1, 0,
       1, 1, 0, 0, 1, 1, 0, 0 ] );

  var result = _.frustum.frustumCorners( f );
  test.identical( result, expected );

  test.description = 'Frustrum with three inclined sides'; //

  var f = _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   2,   0,
       0,   2,   1, - 1,   0, 0.5,
     - 1,   0, - 1,   0,   0, - 1 ] );
  var expected = _.Space.make( [ 3, 8 ] ).copy
    ([ 2, 4, 2, 0, 0.5, 0.5, 1, 1,
       1, 2, 1, 0, 1, 2, 1, 0,
       1, 1, 0, 0, 1, 1, 0, 0 ] );

  var result = _.frustum.frustumCorners( f );
  test.equivalent( result, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.frustumCorners( ));
  test.shouldThrowErrorSync( () => _.frustum.frustumCorners( f, f ));
  test.shouldThrowErrorSync( () => _.frustum.frustumCorners( null ));
  test.shouldThrowErrorSync( () => _.frustum.frustumCorners( NaN ));
  test.shouldThrowErrorSync( () => _.frustum.frustumCorners( f, [ 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.frustum.frustumCorners( [ 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.frustum.frustumCorners( [ ] ));


}


//

function pointClosestPoint( test )
{

  test.description = 'Frustum and point remain unchanged'; //

  var f = _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   0,   0,
       0,   0,   1, - 1,   0,   0,
     - 1,   0, - 1,   0,   0, - 1 ] );
  var point = [ -1, -1, -1 ];
  var oldf = _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   0,   0,
       0,   0,   1, - 1,   0,   0,
     - 1,   0, - 1,   0,   0, - 1 ] );
  var oldpoint = [ -1, -1, -1 ];
  var expected = _.vector.from( [ 0, 0, 0 ] );

  var result = _.frustum.pointClosestPoint( f, point );
  test.equivalent( result, expected );
  test.identical( f, oldf );
  test.identical( point, oldpoint );

  test.description = 'Frustrum as box ( 0, 0, 0, 1, 1, 1 ) - corner ( 1, 1, 1 )'; //

  var f = _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   0,   0,
       0,   0,   1, - 1,   0,   0,
     - 1,   0, - 1,   0,   0, - 1 ] );
  var point = [ -1, -1, -1 ];
  var expected = _.vector.from( [ 0, 0, 0 ] );

  var result = _.frustum.pointClosestPoint( f, point );
  test.identical( result, expected );

  test.description = 'Frustrum as box ( 0, 0, 0, 1, 1, 1 ) - center of side side'; //

  var f = _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   0,   0,
       0,   0,   1, - 1,   0,   0,
     - 1,   0, - 1,   0,   0, - 1 ] );
  var point = [ 0.5, 0.5, -3 ];
  var expected = [ 0.5, 0.5, 0 ];
  var expected = _.vector.from( expected );

  var result = _.frustum.pointClosestPoint( f, point );
  test.identical( result, expected );

  test.description = 'Point inside frustum'; //

  var f = _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   0,   0,
       0,   0,   1, - 1,   0,   0,
     - 1,   0, - 1,   0,   0, - 1 ] );
  var point = [ 0.5, 0.6, 0.2 ];
  var expected = [ 0.5, 0.6, 0.2 ];
  var expected = _.vector.from( expected );

  var result = _.frustum.pointClosestPoint( f, point );
  test.identical( result, expected );

  test.description = 'Point under frustum'; //

  var f = _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   0,   0,
       0,   0,   1, - 1,   0,   0,
     - 1,   0, - 1,   0,   0, - 1 ] );
  var point = [ -1, -1, -1 ];
  var expected = [ 0, 0, 0 ];
  var expected = _.vector.from( expected );

  var result = _.frustum.pointClosestPoint( f, point );
  test.identical( result, expected );

  test.description = 'Diagonal frustum plane'; //

  var f = _.Space.make( [ 4, 6 ] ).copy(
     [ 0,   0,   0,   0, - 1,   1,
       1, - 1,   0,   0,   0,   0,
       0,   2,   1, - 1,   0,   0,
     - 1,   0, - 1,   0,   0, - 1 ] );
  var point = [ 0, 0, 2 ];
  var expected = [ 0, 0.79999, 0.40000 ];
  var expected = _.vector.from( expected );

  var result = _.frustum.pointClosestPoint( f, point );
  test.equivalent( result, expected );


  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( f, f ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( null ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( NaN ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( f, [ 0, 0, 2, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( [ 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( [ ] ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( null, [ 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( NaN , [ 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( f, null ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( f, NaN ));


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
 // routine: 'boxIntersects',

 tests :
 {

 sphereIntersects : sphereIntersects,
 boxIntersects : boxIntersects,
 pointContains : pointContains,

 frustumCorners : frustumCorners,
 frustumIntersects : frustumIntersects,
 pointClosestPoint : pointClosestPoint,
 //boxClosestPoint : boxClosestPoint,
 //sphereClosestPoint : sphereClosestPoint,

 }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
