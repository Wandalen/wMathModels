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

_.assert( _.routineIs( sqrt ) );

// --
// test
// --


function cornersGet( test )
{

  test.description = 'Frustum remains unchanged'; //

  var f = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var expected = _.Space.make( [ 3, 8 ] ).copy
  ([
    0, 0, 0, 0, 1, 1, 1, 1,
    1, 0, 1, 0, 1, 0, 1, 0,
    1, 1, 0, 0, 1, 1, 0, 0
  ]);

  var gotCorners = _.frustum.cornersGet( f );
  test.equivalent( gotCorners, expected );

  var oldF = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  test.identical( f, oldF );

  test.description = 'Frustrum as box (0,0,0,1,1,1)'; //

  var f = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var expected = _.Space.make( [ 3, 8 ] ).copy
  ([
    0, 0, 0, 0, 1, 1, 1, 1,
    1, 0, 1, 0, 1, 0, 1, 0,
    1, 1, 0, 0, 1, 1, 0, 0 ]
  );

  var gotCorners = _.frustum.cornersGet( f );
  test.identical( gotCorners, expected );

  test.description = 'Frustrum as point (1,1,1)'; //

  var f = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   1, - 1,   1,   1, - 1 ]
  );
  var expected = _.Space.make( [ 3, 8 ] ).copy
  ([
    1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1 ]
  );

  var gotCorners = _.frustum.cornersGet( f );
  test.identical( gotCorners, expected );

  test.description = 'Frustrum as box (-1,-1,-1,1,1,1)'; //

  var f = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1, - 1, - 1, - 1, - 1, - 1 ]
  );
  var expected = _.Space.make( [ 3, 8 ] ).copy
  ([
    -1, -1, -1, -1, 1, 1, 1, 1,
    1, -1, 1, -1, 1, -1, 1, -1,
    1, 1, -1, -1, 1, 1, -1, -1
  ]);

  var gotCorners = _.frustum.cornersGet( f );
  test.identical( gotCorners, expected );

  test.description = 'Frustrum with inclined side'; //

  var f = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   2,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var expected = _.Space.make( [ 3, 8 ] ).copy
  ([
    0, 0, 0, 0, 1, 1, 1, 1,
    1, 2, 1, 0, 1, 2, 1, 0,
    1, 1, 0, 0, 1, 1, 0, 0 ]
  );

  var gotCorners = _.frustum.cornersGet( f );
  test.identical( gotCorners, expected );

  test.description = 'Frustrum with two inclined sides'; //

  var f = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   2,   0,
    0,   2,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var expected = _.Space.make( [ 3, 8 ] ).copy
  ([
    2, 4, 2, 0, 1, 1, 1, 1,
    1, 2, 1, 0, 1, 2, 1, 0,
    1, 1, 0, 0, 1, 1, 0, 0
  ]);

  var gotCorners = _.frustum.cornersGet( f );
  test.identical( gotCorners, expected );

  test.description = 'Frustrum with three inclined sides'; //

  var f = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   2,   0,
    0,   2,   1, - 1,   0, 0.5,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var expected = _.Space.make( [ 3, 8 ] ).copy
  ([
    2, 4, 2, 0, 0.5, 0.5, 1, 1,
    1, 2, 1, 0, 1, 2, 1, 0,
    1, 1, 0, 0, 1, 1, 0, 0 ]
  );

  var gotCorners = _.frustum.cornersGet( f );
  test.equivalent( gotCorners, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.cornersGet( ));
  test.shouldThrowErrorSync( () => _.frustum.cornersGet( f, f ));
  test.shouldThrowErrorSync( () => _.frustum.cornersGet( null ));
  test.shouldThrowErrorSync( () => _.frustum.cornersGet( NaN ));
  test.shouldThrowErrorSync( () => _.frustum.cornersGet( f, [ 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.frustum.cornersGet( [ 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.frustum.cornersGet( [ ] ));


}

//

function pointContains( test )
{

  test.description = 'Frustum and point remain unchanged'; //

  var f =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var point = [ 3, 3, 3 ];
  var oldPoint = point.slice();
  point = _.vector.from( point );
  oldPoint = _.vector.from( oldPoint );

  var expected = false;

  var gotBool = _.frustum.pointContains( f, point );
  test.identical( gotBool, expected );
  test.identical( point, oldPoint );

  var oldF =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  test.identical( f, oldF );

  test.description = 'Frustum contains point'; //

  var f =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var point = [ 0, 0, 0 ];
  point = _.vector.from( point );
  var expected = true;

  var gotBool = _.frustum.pointContains( f, point );
  test.identical( gotBool, expected );

  test.description = 'Point near border'; //

  var f =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var point = [ 0.9, 0.9, 0.9 ];
  point = _.vector.from( point );
  var expected = true;

  var gotBool = _.frustum.pointContains( f, point );
  test.identical( gotBool, expected );

  test.description = 'Point in corner'; //

  var f =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var point = [ 1, 1, 1 ];
  point = _.vector.from( point );
  var expected = true;

  var gotBool = _.frustum.pointContains( f, point );
  test.identical( gotBool, expected );

  test.description = 'Point just outside frustum'; //

  var f =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var point = [ 1.1, 1.1, 1.1 ];
  point = _.vector.from( point );
  var expected = false;

  var gotBool = _.frustum.pointContains( f, point );
  test.identical( gotBool, expected );

  test.description = 'Point out of frustum'; //

  var f =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var point = [ 5 , 5, 5 ];
  point = _.vector.from( point );
  var expected = false;

  var gotBool = _.frustum.pointContains( f, point );
  test.identical( gotBool, expected );

  test.description = 'Zero frustum contains zero point'; //

  var f = _.frustum.make();
  var point = [ 0, 0, 0 ];
  point = _.vector.from( point );
  var expected = true;

  var gotBool = _.frustum.pointContains( f, point );
  test.identical( gotBool, expected );

  test.description = 'Zero frustum contains  all points'; //

  var f = _.frustum.make();
  var point = [ 0, - 10, 5 ];
  point = _.vector.from( point );
  var expected = true;

  var gotBool = _.frustum.pointContains( f, point );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var f =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var point = [ 0, - 10, 5 ];
  point = _.vector.from( point );
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

function pointDistance( test )
{

  test.description = 'Frustum and point remain unchanged'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var point = [ 3, 3, 3 ];

  var expected = Math.sqrt( 12 );

  var gotDistance = _.frustum.pointDistance( srcFrustum, point );
  test.identical( gotDistance, expected );

  var oldPoint = point.slice();
  test.identical( point, oldPoint );

  var oldFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  test.identical( srcFrustum, oldFrustum );

  test.description = 'Frustum contains point in corner'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotDistance = _.frustum.pointDistance( srcFrustum, point );
  test.identical( gotDistance, expected );

  test.description = 'Point near border'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var point = [ 0.9, 0.9, 0.9 ];
  var expected = 0;

  var gotDistance = _.frustum.pointDistance( srcFrustum, point );
  test.identical( gotDistance, expected );

  test.description = 'Point on side'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var point = [ 0.5, 0.5, 1 ];
  var expected = 0;

  var gotDistance = _.frustum.pointDistance( srcFrustum, point );
  test.identical( gotDistance, expected );

  test.description = 'Point just outside frustum'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var point = [ 1, 1, 1.1 ];
  var expected = 0.1;

  var gotDistance = _.frustum.pointDistance( srcFrustum, point );
  test.equivalent( gotDistance, expected );

  test.description = 'Point out of frustum - 1D'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var point = [ 0.5 , 0.5, 5 ];
  var expected = 4;

  var gotDistance = _.frustum.pointDistance( srcFrustum, point );
  test.identical( gotDistance, expected );

  test.description = 'Point out of frustum - 2D'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var point = [ 1 , 4, 5 ];
  var expected = 5;

  var gotDistance = _.frustum.pointDistance( srcFrustum, point );
  test.equivalent( gotDistance, expected );

  test.description = 'Point out of frustum - 3D'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var point = [ 5, 5, 5 ];
  var expected = Math.sqrt( 48 );

  var gotDistance = _.frustum.pointDistance( srcFrustum, point );
  test.equivalent( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;

  var f =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var point = [ 0, - 10, 5 ];
  point = _.vector.from( point );
  test.shouldThrowErrorSync( () => _.frustum.pointDistance( ));
  test.shouldThrowErrorSync( () => _.frustum.pointDistance( point ));
  test.shouldThrowErrorSync( () => _.frustum.pointDistance( f ));
  test.shouldThrowErrorSync( () => _.frustum.pointDistance( f, f, point ));
  test.shouldThrowErrorSync( () => _.frustum.pointDistance( f, point, point ));
  test.shouldThrowErrorSync( () => _.frustum.pointDistance( null, point ));
  test.shouldThrowErrorSync( () => _.frustum.pointDistance( f, null));
  test.shouldThrowErrorSync( () => _.frustum.pointDistance( NaN, point ));
  test.shouldThrowErrorSync( () => _.frustum.pointDistance( f, NaN));

  point = [ 0, 1];
  point = _.vector.from( point );
  test.shouldThrowErrorSync( () => _.frustum.pointDistance( f, point ));
  point = [ 0, 0, 1, 1];
  point = _.vector.from( point );
  test.shouldThrowErrorSync( () => _.frustum.pointDistance( f, point ));

}

//

function pointClosestPoint( test )
{

  test.description = 'Source frustum and source point remain unchanged'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var srcPoint = [ -1, -1, -1 ];
  var oldPoint = srcPoint.slice();
  var expected = [ 0, 0, 0 ];

  var closestPoint = _.frustum.pointClosestPoint( srcFrustum, srcPoint );
  test.equivalent( closestPoint, expected );
  test.identical( srcPoint, oldPoint );

  var oldF = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  test.identical( srcFrustum, oldF );

  test.description = 'Frustrum as box ( 0, 0, 0, 1, 1, 1 ) - corner ( 1, 1, 1 )'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var srcPoint = [ -1, -1, -1 ];
  var expected = [ 0, 0, 0 ];

  var closestPoint = _.frustum.pointClosestPoint( srcFrustum, srcPoint );
  test.identical( closestPoint, expected );

  test.description = 'Frustrum as box ( 0, 0, 0, 1, 1, 1 ) - center of side side'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var srcPoint = [ 0.5, 0.5, -3 ];
  var expected = [ 0.5, 0.5, 0 ];

  var closestPoint = _.frustum.pointClosestPoint( srcFrustum, srcPoint );
  test.identical( closestPoint, expected );

  test.description = 'Point inside frustum'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var srcPoint = [ 0.5, 0.6, 0.2 ];
  var expected = [ 0.5, 0.6, 0.2 ];

  var closestPoint = _.frustum.pointClosestPoint( srcFrustum, srcPoint );
  test.identical( closestPoint, expected );

  test.description = 'Point under frustum'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var srcPoint = [ -1, -1, -1 ];
  var expected = [ 0, 0, 0 ];

  var closestPoint = _.frustum.pointClosestPoint( srcFrustum, srcPoint );
  test.identical( closestPoint, expected );

  test.description = 'Diagonal frustum plane'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   2,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var srcPoint = [ 0, 0, 2 ];
  var expected = [ 0, 0.4, 0.2 ];

  var closestPoint = _.frustum.pointClosestPoint( srcFrustum, srcPoint );
  test.equivalent( closestPoint, expected );

  test.description = 'dstPoint Array returns array'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   2,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var srcPoint = [ 0, 0, 2 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = [ 0, 0.4, 0.2 ];

  var closestPoint = _.frustum.pointClosestPoint( srcFrustum, srcPoint, dstPoint );
  test.equivalent( closestPoint, expected );
  test.identical( closestPoint, dstPoint );

  test.description = 'dstPointVector returns vector'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   2,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var srcPoint = [ 0, 0, 2 ];
  var dstPoint = _.vector.from( [ 0, 0, 0 ] );
  var expected = _.vector.from( [ 0, 0.4, 0.2 ] );

  var closestPoint = _.frustum.pointClosestPoint( srcFrustum, srcPoint, dstPoint );
  test.equivalent( closestPoint, expected );
  test.identical( closestPoint, dstPoint );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( srcFrustum, srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( null ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( NaN ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( srcFrustum, [ 0, 0, 2, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( [ 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( [ ] ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( null, [ 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( NaN , [ 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( srcFrustum, null ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( srcFrustum, NaN ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( srcFrustum, [ 0, 0, 2 ], null ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( srcFrustum, [ 0, 0, 2 ], undefined ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( srcFrustum, [ 0, 0, 2 ], NaN ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( srcFrustum, [ 0, 0, 2 ], [ 0, 0, 2, 3 ] ));

}

//

function boxContains( test )
{

  test.description = 'Frustum and box remain unchanged'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ 1, 1, 1, 3, 3, 3 ];
  var oldBox = box.slice();
  var expected = false;

  var gotBool = _.frustum.boxContains( srcFrustum, box );
  test.identical( gotBool, expected );
  test.identical( box, oldBox );

  var oldFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  test.identical( srcFrustum, oldFrustum );

  test.description = 'Same dimensions'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.frustum.boxContains( srcFrustum, box );
  test.identical( gotBool, expected );

  test.description = 'Frustum and box intersect'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ 0.5, 0.5, 0.5, 1.5, 1.5, 1.5 ];
  var expected = false;

  var gotBool = _.frustum.boxContains( srcFrustum, box );
  test.identical( gotBool, expected );

  test.description = 'Box bigger than frustum'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ - 2, - 2, - 2, 2, 2, 2 ];
  var expected = false;

  var gotBool = _.frustum.boxContains( srcFrustum, box );
  test.identical( gotBool, expected );

  test.description = 'Frustum bigger than frustum'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ 0.2, 0.2, 0.2, 0.4, 0.4, 0.4 ];
  var expected = true;

  var gotBool = _.frustum.boxContains( srcFrustum, box );
  test.identical( gotBool, expected );

  test.description = 'Frustum and box not intersecting'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ 4, 4, 4, 5, 5, 5 ];
  var expected = false;

  var gotBool = _.frustum.boxContains( srcFrustum, box );
  test.identical( gotBool, expected );

  test.description = 'Box and Frustum with common side - contained'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ 0, 0, 0, 0.6 , 0.6, 0.6 ];
  var expected = true;

  var gotBool = _.frustum.boxContains( srcFrustum, box );
  test.identical( gotBool, expected );

  test.description = 'Frustum and box with common corner - not contained'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ 1, 1, 1, 5 , 5, 5 ];
  var expected = false;

  /* */

  if( !Config.debug )
  return;

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );

  test.shouldThrowErrorSync( () => _.frustum.boxContains( ));
  test.shouldThrowErrorSync( () => _.frustum.boxContains( box ));
  test.shouldThrowErrorSync( () => _.frustum.boxContains( srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.boxContains( srcFrustum, srcFrustum, box ));
  test.shouldThrowErrorSync( () => _.frustum.boxContains( srcFrustum, box, box ));
  test.shouldThrowErrorSync( () => _.frustum.boxContains( null, box ));
  test.shouldThrowErrorSync( () => _.frustum.boxContains( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.frustum.boxContains( NaN, box ));
  test.shouldThrowErrorSync( () => _.frustum.boxContains( srcFrustum, NaN));

  box = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.frustum.boxContains( srcFrustum, box ));
  box = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.frustum.boxContains( srcFrustum, box ));
  box = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.frustum.boxContains( srcFrustum, box ));

}

//

function boxIntersects( test )
{

  test.description = 'Frustum and box remain unchanged'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ 1, 1, 1, 3, 3, 3 ];
  var oldBox = box.slice();
  var expected = true;

  var gotBool = _.frustum.boxIntersects( srcFrustum, box );
  test.identical( gotBool, expected );
  test.identical( box, oldBox );

  var oldF =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  test.identical( srcFrustum, oldF );


  test.description = 'Frustum and box intersect'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.frustum.boxIntersects( srcFrustum, box );
  test.identical( gotBool, expected );

  test.description = 'Frustum and box intersect, box bigger than frustum'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ - 2, - 2, - 2, 2, 2, 2 ];
  var expected = true;

  var gotBool = _.frustum.boxIntersects( srcFrustum, box );
  test.identical( gotBool, expected );

  test.description = 'Frustum and box intersect, box smaller than frustum'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ - 0.2, - 0.2, - 0.2, 0.2, 0.2, 0.2 ];
  var expected = true;

  var gotBool = _.frustum.boxIntersects( srcFrustum, box );
  test.identical( gotBool, expected );

  test.description = 'Frustum and box not intersecting'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ 4, 4, 4, 5, 5, 5 ];
  var expected = false;

  var gotBool = _.frustum.boxIntersects( srcFrustum, box );
  test.identical( gotBool, expected );

  test.description = 'Frustum and box almost intersecting'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ 1.1, 1.1, 1.1, 5 , 5, 5 ];
  var expected = false;

  var gotBool = _.frustum.boxIntersects( srcFrustum, box );
  test.identical( gotBool, expected );

  test.description = 'Frustum and box just touching'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ 1, 1, 1, 5 , 5, 5 ];
  var expected = true;

  var gotBool = _.frustum.boxIntersects( srcFrustum, box );
  test.identical( gotBool, expected );

  test.description = 'Frustum and box just intersect'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ 0.9, 0.9, 0.9, 5, 5, 5 ];
  var expected = true;

  var gotBool = _.frustum.boxIntersects( srcFrustum, box );
  test.identical( gotBool, expected );

  test.description = 'Frustum and box just intersect'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ 0.9, 0.9, 0.9, 5, 5, 5 ];
  var expected = true;

  var gotBool = _.frustum.boxIntersects( srcFrustum, box );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );

  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( ));
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( box ));
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( srcFrustum, srcFrustum, box ));
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( srcFrustum, box, box ));
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( null, box ));
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( NaN, box ));
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( srcFrustum, NaN));

  box = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( srcFrustum, box ));
  box = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( srcFrustum, box ));
  box = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( srcFrustum, box ));

}

//

function boxClosestPoint( test )
{

  test.description = 'Frustum and box remain unchanged'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var box = [ 0.5, 0.5, 0.5, 1.5, 1.5, 1.5 ];
  var oldBox = box.slice();
  var expected = 0;

  var closestPoint = _.frustum.boxClosestPoint( srcFrustum, box );
  test.equivalent( closestPoint, expected );
  test.identical( box, oldBox );

  var oldF = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  test.identical( srcFrustum, oldF );

  test.description = 'Frustrum as box ( 0, 0, 0, 1, 1, 1 ) - corner ( 1, 1, 1 )'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var box = [ 1.5, 1.5, 1.5, 2.5, 2.5, 2.5 ];
  var expected = _.vector.from( [ 1, 1, 1 ] );

  var closestPoint = _.frustum.boxClosestPoint( srcFrustum, box );
  test.equivalent( closestPoint, expected );

  test.description = 'Frustrum as box ( 0, 0, 0, 1, 1, 1 ) - corner ( 0, 0, 0 )'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var box = [ -1, -1, -1, -0.5, -0.5, -0.5 ];
  var expected = [ 0, 0, 0 ];
  expected = _.vector.from( expected );

  var closestPoint = _.frustum.boxClosestPoint( srcFrustum, box );
  test.equivalent( closestPoint, expected );

  test.description = 'Box and frustum intersect'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var box = [ -1, -1, -1, 0.5, 0.5, 0.5 ];
  var expected = 0;

  var closestPoint = _.frustum.boxClosestPoint( srcFrustum, box );
  test.identical( closestPoint, expected );

  test.description = 'Point in inclined frustum side'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   2,   1, - 1,   0,   0,
    - 3,   0, - 1,   0,   0, - 1
  ]);
  var box = [ -1, -1, 1, 0.5, 1.5, 2 ];
  var expected = [ 0.5, 1.6, 0.79999999 ];

  var closestPoint = _.frustum.boxClosestPoint( srcFrustum, box );
  test.equivalent( closestPoint, expected );

  test.description = 'Diagonal frustum plane'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   2,   1, - 1,   0,   0,
    - 3,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ -2, -2, 2, 0, 0, 4 ];
  var expected = [ 0, 0.4, 0.20000 ];

  var closestPoint = _.frustum.boxClosestPoint( srcFrustum, box );
  test.equivalent( closestPoint, expected );

  test.description = 'PointBox'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   2,   1, - 1,   0,   0,
    - 3,   0, - 1,   0,   0, - 1
  ]);
  var box = [ -2, -2, -2, -2, -2, -2 ];
  var expected = [ 0, 0, 0 ];
  var expected = _.vector.from( expected );

  var closestPoint = _.frustum.boxClosestPoint( srcFrustum, box );
  test.equivalent( closestPoint, expected );

  test.description = 'PointBox on side'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var box = [ 1.1, 0.5, 0.5, 1.1, 0.5, 0.5 ];
  var expected = [ 1, 0.5, 0.5 ];

  var closestPoint = _.frustum.boxClosestPoint( srcFrustum, box );
  test.equivalent( closestPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.boxClosestPoint( ));
  test.shouldThrowErrorSync( () => _.frustum.boxClosestPoint( srcFrustum, srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.boxClosestPoint( null ));
  test.shouldThrowErrorSync( () => _.frustum.boxClosestPoint( NaN ));
  test.shouldThrowErrorSync( () => _.frustum.boxClosestPoint( srcFrustum, [ 0, 0, 2, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.boxClosestPoint( [ 0, 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.frustum.boxClosestPoint( [ ] ));
  test.shouldThrowErrorSync( () => _.frustum.boxClosestPoint( null, [ 0, 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.frustum.boxClosestPoint( NaN , [ 0, 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.frustum.boxClosestPoint( srcFrustum, null ));
  test.shouldThrowErrorSync( () => _.frustum.boxClosestPoint( srcFrustum, NaN ));
  test.shouldThrowErrorSync( () => _.frustum.boxClosestPoint( srcFrustum, srcFrustum, [ 0, 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.frustum.boxClosestPoint( srcFrustum, [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ] ));

}

//

function sphereContains( test )
{

  test.description = 'Frustum and sphere remain unchanged'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var sphere = [ 3, 3, 3, 1 ];
  var oldSphere = sphere.slice();
  var expected = false;

  var gotBool = _.frustum.sphereContains( srcFrustum, sphere );
  test.identical( gotBool, expected );
  test.identical( sphere, oldSphere );

  var oldFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  test.identical( srcFrustum, oldFrustum );

  test.description = 'Frustum contains sphere'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var sphere = [ 0.5, 0.5, 0.5, 0.4 ];
  var expected = true;

  var gotBool = _.frustum.sphereContains( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Sphere bigger than frustum'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var sphere = [ 0.5, 0.5, 0.5, 1 ];
  var expected = false;

  var gotBool = _.frustum.sphereContains( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Frustum and sphere don´t intersect'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var sphere = [ 5, 5, 5, 2 ];
  var expected = false;

  var gotBool = _.frustum.sphereContains( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Frustum and sphere intersect'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var sphere = [ 1, 1, 1, 0.5 ];
  var expected = false;

  var gotBool = _.frustum.sphereContains( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Frustum contains sphere not in the middle'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var sphere = [ 0.4, 0.3, 0.6, 0.1 ];
  var expected = true;

  var gotBool = _.frustum.sphereContains( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Frustum and sphere contained and touching'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var sphere = [ 0.5, 0.5, 0.5, 0.5 ];
  var expected = true;

  var gotBool = _.frustum.sphereContains( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Zero sphere'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var sphere = _.sphere.makeZero();
  var expected = true;

  var gotBool = _.frustum.sphereContains( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Zero frustum'; //

  var srcFrustum = _.frustum.make();
  var sphere = [ 0, 0, 0, 2 ];
  var expected = true;

  var gotBool = _.frustum.sphereContains( srcFrustum, sphere );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var sphere = [ 0, 0, 1, 2];
  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );

  test.shouldThrowErrorSync( () => _.frustum.sphereContains( ));
  test.shouldThrowErrorSync( () => _.frustum.sphereContains( sphere ));
  test.shouldThrowErrorSync( () => _.frustum.sphereContains( srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.sphereContains( srcFrustum, srcFrustum, sphere ));
  test.shouldThrowErrorSync( () => _.frustum.sphereContains( srcFrustum, sphere, sphere ));
  test.shouldThrowErrorSync( () => _.frustum.sphereContains( null, sphere ));
  test.shouldThrowErrorSync( () => _.frustum.sphereContains( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.frustum.sphereContains( NaN, sphere ));
  test.shouldThrowErrorSync( () => _.frustum.sphereContains( srcFrustum, NaN));

  var sphere = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.frustum.sphereContains( srcFrustum, sphere ));

}

//

function sphereIntersects( test )
{

  test.description = 'Frustum and sphere remain unchanged'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var sphere = [ 3, 3, 3, 1 ];
  var oldSphere = sphere.slice();
  var expected = false;

  var gotBool = _.frustum.sphereIntersects( srcFrustum, sphere );
  test.identical( gotBool, expected );
  test.identical( sphere, oldSphere );

  var oldF = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  test.identical( srcFrustum, oldF );

  test.description = 'Frustum and sphere intersect'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var sphere = [ 1, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.frustum.sphereIntersects( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Frustum and sphere intersect, sphere bigger than frustum'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var sphere = [ 1, 1, 1, 7 ];
  var expected = true;

  var gotBool = _.frustum.sphereIntersects( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Frustum and sphere intersect, frustum bigger than sphere'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var sphere = [ 0.5, 0.5, 0.5, 0.1 ];
  var expected = true;

  var gotBool = _.frustum.sphereIntersects( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Frustum and sphere not intersecting'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var sphere = [ 5, 5, 5, 1 ];
  var expected = false;

  var gotBool = _.frustum.sphereIntersects( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Frustum and sphere almost intersecting'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var sphere = [ 5 , 5, 5, 6.9 ];
  var expected = false;

  var gotBool = _.frustum.sphereIntersects( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Frustum and sphere just touching'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var sphere = [ 5 , 5, 5, 6.93 ];
  var expected = true;

  var gotBool = _.frustum.sphereIntersects( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Frustum and sphere just intersect'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var sphere = [ 5, 5, 5, 7 ];
  var expected = true;

  var gotBool = _.frustum.sphereIntersects( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Zero frustum, intersection'; //

  var srcFrustum = _.frustum.make();
  var sphere = [ 0, 0, 0, 2 ];
  var expected = true;

  var gotBool = _.frustum.sphereIntersects( srcFrustum, sphere );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var sphere = [ 0, 0, 1, 2];
  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );

  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( ));
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( sphere ));
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( srcFrustum, srcFrustum, sphere ));
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( srcFrustum, sphere, sphere ));
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( null, sphere ));
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( NaN, sphere ));
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( srcFrustum, NaN));

  var sphere = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( srcFrustum, sphere ));

}

//

function sphereClosestPoint( test )
{

  test.description = 'Frustum and sphere remain unchanged'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var sphere = [ 0.5, 0.5, 0.5, 0.5 ];
  var oldSphere = sphere.slice();
  var expected = 0;

  var closestPoint = _.frustum.sphereClosestPoint( srcFrustum, sphere );
  test.equivalent( closestPoint, expected );
  test.identical( sphere, oldSphere );

  var oldF = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  test.identical( srcFrustum, oldF );

  test.description = 'Frustrum as sphere ( 0, 0, 0, 1, 1, 1 ) - corner ( 1, 1, 1 )'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var sphere = [ 2.5, 2.5, 2.5, 0.5 ];
  var expected = [ 1, 1, 1 ];

  var closestPoint = _.frustum.sphereClosestPoint( srcFrustum, sphere );
  test.equivalent( closestPoint, expected );

  test.description = 'Frustrum as sphere ( 0, 0, 0, 1, 1, 1 ) - corner ( 0, 0, 0 )'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var sphere = [ -1, -1, -1, 0.5 ];
  var expected = [ 0, 0, 0 ];

  var closestPoint = _.frustum.sphereClosestPoint( srcFrustum, sphere );
  test.equivalent( closestPoint, expected );

  test.description = 'sphere and frustum intersect'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var sphere = [ -1, -1, -1, 1.8 ];
  var expected = 0;

  var closestPoint = _.frustum.sphereClosestPoint( srcFrustum, sphere );
  test.identical( closestPoint, expected );

  test.description = 'Point in inclined frustum side'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   2,   1, - 1,   0,   0,
    - 3,   0, - 1,   0,   0, - 1
  ]);
  var sphere = [ 0.5, 1.5, 1, 0.01 ];
  var expected = [ 0.5, 1.6, 0.79999999 ];

  var closestPoint = _.frustum.sphereClosestPoint( srcFrustum, sphere );
  test.equivalent( closestPoint, expected );

  test.description = 'Diagonal frustum plane'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   2,   1, - 1,   0,   0,
    - 3,   0, - 1,   0,   0, - 1
  ]);
  var sphere = [ 0, 0, 2, 0.01 ];
  var expected = [ 0, 0.4, 0.20000 ];
  var closestPoint = _.frustum.sphereClosestPoint( srcFrustum, sphere );
  test.equivalent( closestPoint, expected );

  test.description = 'Pointsphere'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   2,   1, - 1,   0,   0,
    - 3,   0, - 1,   0,   0, - 1
  ]);
  var sphere = [ -2, -2, -2, 0 ];
  var expected = [ 0, 0, 0 ];

  var closestPoint = _.frustum.sphereClosestPoint( srcFrustum, sphere );
  test.equivalent( closestPoint, expected );

  test.description = 'Pointsphere on side'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,  0, - 1,   0,   0, - 1
  ]);
  var sphere = [ 1.1, 0.5, 0.5, 0 ];
  var expected = [ 1, 0.5, 0.5 ];
  var closestPoint = _.frustum.sphereClosestPoint( srcFrustum, sphere );
  test.equivalent( closestPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.sphereClosestPoint( ));
  test.shouldThrowErrorSync( () => _.frustum.sphereClosestPoint( srcFrustum, srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.sphereClosestPoint( null ));
  test.shouldThrowErrorSync( () => _.frustum.sphereClosestPoint( NaN ));
  test.shouldThrowErrorSync( () => _.frustum.sphereClosestPoint( srcFrustum, [ 0, 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.sphereClosestPoint( [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.sphereClosestPoint( [ ] ));
  test.shouldThrowErrorSync( () => _.frustum.sphereClosestPoint( null, [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.sphereClosestPoint( NaN , [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.sphereClosestPoint( srcFrustum, null ));
  test.shouldThrowErrorSync( () => _.frustum.sphereClosestPoint( srcFrustum, NaN ));
  test.shouldThrowErrorSync( () => _.frustum.sphereClosestPoint( srcFrustum, srcFrustum, [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.sphereClosestPoint( srcFrustum, [ 0, 0, 0, 1 ], [ 0, 0, 0, 1 ] ));

}

//

function planeIntersects( test )
{

  test.description = 'Frustum and plane remain unchanged'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var plane = [ 1, 0, 0, 2 ];
  var expected = false;

  var gotBool = _.frustum.planeIntersects( srcFrustum, plane );
  test.identical( gotBool, expected );

  var oldFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  test.identical( srcFrustum, oldFrustum );

  var oldPlane = [ 1, 0, 0, 2 ];
  test.identical( plane, oldPlane );

  test.description = 'Frustum and plane intersect'; //

  var plane = [ 1, 0, 0, - 0.4 ];
  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var expected = true;

  var gotBool = _.frustum.planeIntersects( srcFrustum, plane );
  test.identical( gotBool, expected );

  test.description = 'Plane cuts Frustum in diagonal'; //

  var plane = [ 0.3, 0.3, 0.3, 0 ];
  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var expected = true;

  var gotBool = _.frustum.planeIntersects( srcFrustum, plane );
  test.identical( gotBool, expected );

  test.description = 'Plane is frustum side'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var plane = [ 0, 1, 0, 0];
  var expected = true;

  var gotBool = _.frustum.planeIntersects( srcFrustum, plane );
  test.identical( gotBool, expected );

  test.description = 'Frustum and plane don´t intersect'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var plane = [ 0, 1, 2, 4 ];
  var expected = false;

  var gotBool = _.frustum.planeIntersects( srcFrustum, plane );
  test.identical( gotBool, expected );

  test.description = 'Frustums almost intersecting'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var plane = [ 0 , 1, 0, - 1.1 ];
  var expected = false;

  var gotBool = _.frustum.planeIntersects( srcFrustum, plane );
  test.identical( gotBool, expected );

  test.description = 'Frustum and plane don´t intersect'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var plane = [ 0, 2, 0, 1 ];
  var expected = false;

  var gotBool = _.frustum.planeIntersects( srcFrustum, plane );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.planeIntersects( ));
  test.shouldThrowErrorSync( () => _.frustum.planeIntersects( srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.planeIntersects( srcFrustum, [ 0, 0, 1, 1 ], [ 0, 1, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.planeIntersects( null, [ 1, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.planeIntersects( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.frustum.planeIntersects( NaN, [ 1, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.planeIntersects( srcFrustum, NaN ));
  test.shouldThrowErrorSync( () => _.frustum.planeIntersects( [], [ 1, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.planeIntersects( [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 1, 0, 0, 1 ] ));

}

//

function frustumIntersects( test )
{

  test.description = 'Frustums remain unchanged'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var frustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var expected = true;

  var gotBool = _.frustum.frustumIntersects( srcFrustum, frustum );
  test.identical( gotBool, expected );

  var oldF = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  test.identical( srcFrustum, oldF );

  var oldFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  test.identical( frustum, oldFrustum );

  test.description = 'Frustum intersects with itself'; //

  var frustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var expected = true;

  var gotBool = _.frustum.frustumIntersects( srcFrustum, frustum );
  test.identical( gotBool, expected );

  test.description = 'Frustums intersect'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var frustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 0.5, - 0.5, - 0.5, - 0.5, - 0.5, - 0.5 ]
  );
  var expected = true;

  var gotBool = _.frustum.frustumIntersects( srcFrustum, frustum );
  test.identical( gotBool, expected );

  test.description = 'Frustums don´t intersec'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var frustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 3,   4, - 3,   4,   4, - 3 ]
  );
  var expected = false;

  var gotBool = _.frustum.frustumIntersects( srcFrustum, frustum );
  test.identical( gotBool, expected );

  test.description = 'Frustums almost intersecting'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var frustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 2,   1.1, - 2,   1.1,   1.1, - 2 ]
  );
  var expected = false;

  var gotBool = _.frustum.frustumIntersects( srcFrustum, frustum );
  test.identical( gotBool, expected );

  test.description = 'Frustums just touching'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var frustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 2,   1, - 2,   1,   1, - 2 ]
  );
  var expected = true;

  var gotBool = _.frustum.frustumIntersects( srcFrustum, frustum );
  test.identical( gotBool, expected );

  test.description = 'Frustums just intersect'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var frustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 2, 0.9, - 2, 0.9,   1, 0.9
  ]);
  var expected = true;

  var gotBool = _.frustum.frustumIntersects( srcFrustum, frustum );
  test.identical( gotBool, expected );

  test.description = 'Zero frustum, intersection'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var frustum = _.frustum.make();
  var expected = true;

  var gotBool = _.frustum.frustumIntersects( srcFrustum, frustum );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( ));
  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( srcFrustum, srcFrustum, frustum ));
  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( null, frustum ));
  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( NaN, frustum ));
  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( srcFrustum, NaN));
  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( [], srcFrustum));
  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], srcFrustum));

}


// --
// define class
// --

var Self =
{

  name : 'Tools/Math/Frustum',
  silencing : 1,
  enabled : 1,
  // verbosity : 7,
  // debug : 1,
  routine: 'planeIntersects',

  tests :
  {

    cornersGet : cornersGet,

    pointContains : pointContains,
    pointDistance : pointDistance,
    pointClosestPoint : pointClosestPoint,

    boxContains : boxContains,
    boxIntersects : boxIntersects,
    boxClosestPoint : boxClosestPoint,

    sphereContains : sphereContains,
    sphereIntersects : sphereIntersects,
    sphereClosestPoint : sphereClosestPoint,

    planeIntersects : planeIntersects,

    frustumIntersects : frustumIntersects,

  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
