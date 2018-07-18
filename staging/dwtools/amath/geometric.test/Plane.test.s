( function _Plane_test_s_( ) {

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

  require( '../geometric/aConcepts.s' );
  require( '../geometric/Plane.s' );
  require( '../geometric/Sphere.s' );
  require( '../geometric/Box.s' );

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

function from( test )
{

  test.case = 'Src plane, normal and bias stay unchanged, dst plane changes'; /* */

  var dstPlane = [ 0, 0 , 1, 2 ];
  var srcPlane = [ 0, 1, 2, 3 ];
  var oldSrcPlane = srcPlane.slice();
  var normal = [ 0, 1, 2 ];
  var oldNormal = normal.slice();
  var bias = 3;
  var expected = [ 0, 1, 2, 3 ];

  var gotPlane = _.plane.from( dstPlane, srcPlane );
  test.identical( gotPlane, dstPlane );
  test.identical( expected, dstPlane );
  test.identical( srcPlane, oldSrcPlane );
  test.identical( normal, oldNormal );

  var oldBias = 3;
  test.identical( bias, oldBias );

  test.case = 'null plane'; /* */

  var dstPlane = null;
  var srcPlane = [ 0, 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0 ];

  var gotPlane = _.plane.from( dstPlane, srcPlane );
  test.identical( gotPlane, expected );

  test.case = 'null plane fron normal and bias'; /* */

  var dstPlane = null;
  var normal = [ 0, 0, 0 ];
  var bias = 0;
  var expected = [ 0, 0, 0, 0 ];

  var gotPlane = _.plane.from( dstPlane, normal, bias );
  test.identical( gotPlane, expected );

  test.case = 'NaN normal'; /* */

  var dstPlane = [ 0, 0, 0, 0 ];
  var normal = [ NaN, NaN, NaN ];
  var bias = 2;
  var expected = [ NaN, NaN, NaN, 2 ];

  var gotPlane = _.plane.from( dstPlane, normal, bias );
  test.identical( gotPlane, expected );

  test.case = 'NaN bias'; /* */

  var dstPlane = [ 0, 0, 0, 0 ];
  var normal = [ 0, 1, 0 ];
  var bias = NaN;
  var expected = [ 0, 1, 0, NaN ];

  var gotPlane = _.plane.from( dstPlane, normal, bias );
  test.identical( gotPlane, expected );

  test.case = 'Erase plane'; /* */

  var dstPlane = [ 1, 1, 1, 1 ];
  var srcPlane = [ 0, 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0 ];

  var gotPlane = _.plane.from( dstPlane, srcPlane );
  test.identical( gotPlane, expected );

  test.case = 'Erase plane form normal and bias'; /* */

  var dstPlane = [ 1, 1, 1, 1 ];
  var normal = [ 0, 0, 0 ];
  var bias = 0;
  var expected = [ 0, 0, 0, 0 ];

  var gotPlane = _.plane.from( dstPlane, normal, bias );
  test.identical( gotPlane, expected );

  test.case = 'Change plane'; /* */

  var dstPlane = [ 1, 0, 1, 2 ];
  var srcPlane = [ 0, 1, 0, 1 ];
  var expected = [ 0, 1, 0, 1 ];

  var gotPlane = _.plane.from( dstPlane, srcPlane );
  test.identical( gotPlane, expected );

  test.case = 'Change plane from normal and bias'; /* */

  var dstPlane = [ 1, 0, 1, 2 ];
  var normal = [ 1, 2, 1 ];
  var bias = 1;
  var expected = [ 1, 2, 1, 1 ];

  var gotPlane = _.plane.from( dstPlane, normal, bias );
  test.identical( gotPlane, expected );

  test.case = 'Change plane 2D'; /* */

  var dstPlane = [ 0, 0, 0 ];
  var srcPlane = [ 0, 1, 1 ];
  var expected = [ 0, 1, 1 ];

  var gotPlane = _.plane.from( dstPlane, srcPlane );
  test.identical( gotPlane, expected );

  test.case = 'Change plane 2D'; /* */

  var dstPlane = [ 0, 0, 0 ];
  var normal = [ 0, 1 ];
  var bias = 1;
  var expected = [ 0, 1, 1 ];

  var gotPlane = _.plane.from( dstPlane, normal, bias );
  test.identical( gotPlane, expected );

  test.case = 'Change plane 4D'; /* */

  var dstPlane = [ 0, 0, 0, 0, 0 ];
  var srcPlane = [ 0, 1, 1, 0, 1 ];
  var expected = [ 0, 1, 1, 0, 1 ];

  var gotPlane = _.plane.from( dstPlane, srcPlane );
  test.identical( gotPlane, expected );

  test.case = 'Change plane 4D'; /* */

  var dstPlane = [ 0, 0, 0, 0, 0 ];
  var normal = [ 0, 1, 1, 0 ];
  var bias = 1;
  var expected = [ 0, 1, 1, 0, 1 ];

  var gotPlane = _.plane.from( dstPlane, normal, bias );
  test.identical( gotPlane, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.from( ));
  test.shouldThrowErrorSync( () => _.plane.from( [ 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.from( [ 0, 0, 0, 0 ], [ 0, 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.from( [ 0, 0, 0, 0 ], [ 0, 0, 0, 1 ], 2 ));
  test.shouldThrowErrorSync( () => _.plane.from( [ 0, 0, 0, 0 ], [ 0, 0, 1 ], [ 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.from( [ 0, 0, 0, 0 ], null ));
  test.shouldThrowErrorSync( () => _.plane.from( [ 0, 0, 0, 0 ], null, 1 ));
  test.shouldThrowErrorSync( () => _.plane.from( [ 0, 0, 0, 0 ], [ 1, 1, 1 ], null ));
  test.shouldThrowErrorSync( () => _.plane.from( NaN, [ 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.from( [ 0, 0, 0, 0 ], NaN, 1 ));
  test.shouldThrowErrorSync( () => _.plane.from( [ 0, 0, 0, 0 ], [ 0, 0, 1 ], 2, 3 ));

}

function fromNormalAndPoint( test )
{

  test.case = 'Normal and point stay unchanged, dst plane changes'; /* */

  var dstPlane = [ 0, 0 , 1, 2 ];
  var normal = [ 0, 1, 0 ];
  var oldNormal = normal.slice();
  var point = [ 0, 3, 4 ];
  var oldPoint = point.slice();
  var expected = [ 0, 1, 0, - 3 ];

  var gotPlane = _.plane.fromNormalAndPoint( dstPlane, normal, point );
  test.identical( gotPlane, dstPlane );
  test.identical( expected, dstPlane );
  test.identical( normal, oldNormal );
  test.identical( point, oldPoint );

  test.case = 'NaN plane from normal and point'; /* */

  var dstPlane = [ NaN, NaN, NaN, NaN ];
  var normal = [ 0, 0, 1 ];
  var point = [ 0, 0, 2 ];
  var expected = [ 0, 0, 1, - 2 ];

  var gotPlane = _.plane.fromNormalAndPoint( dstPlane, normal, point );
  test.identical( gotPlane, expected );

  test.case = 'null plane from normal and point'; /* */

  var dstPlane = null;
  var normal = [ 0, 0, 1 ];
  var point = [ 0, 0, 2 ];
  var expected = [ 0, 0, 1, - 2 ];

  var gotPlane = _.plane.fromNormalAndPoint( dstPlane, normal, point );
  test.identical( gotPlane, expected );

  test.case = 'NaN normal array'; /* */

  var dstPlane = [ 0, 0, 0, 0 ];
  var normal = [ NaN, NaN, NaN ];
  var point = [ 0, 0, 2 ];
  var expected = [ NaN, NaN, NaN, NaN ];

  var gotPlane = _.plane.fromNormalAndPoint( dstPlane, normal, point );
  test.identical( gotPlane, expected );

  test.case = 'NaN normal'; /* */

  var dstPlane = [ 0, 0, 0, 0 ];
  var normal = NaN ;
  var point = [ 0, 0, 2 ];
  var expected = [ NaN, NaN, NaN, NaN ];

  var gotPlane = _.plane.fromNormalAndPoint( dstPlane, normal, point );
  test.identical( gotPlane, expected );

  test.case = 'NaN point'; /* */

  var dstPlane = [ 0, 0, 0, 0 ];
  var normal = [ 0, 1, 0 ];
  var point = [ NaN, NaN, NaN ];
  var expected = [ 0, 1, 0, NaN ];

  var gotPlane = _.plane.fromNormalAndPoint( dstPlane, normal, point );
  test.identical( gotPlane, expected );

  test.case = 'Erase plane'; /* */

  var dstPlane = [ 1, 1, 1, 1 ];
  var normal = [ 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0 ];

  var gotPlane = _.plane.fromNormalAndPoint( dstPlane, normal, point );
  test.equivalent( gotPlane, expected );

  test.case = 'Change plane'; /* */

  var dstPlane = [ 1, 0, 1, 2 ];
  var normal = [ 1, 2, 1 ];
  var point = [ 0, 3, 0 ];
  var expected = [ 1, 2, 1, - 6 ];

  var gotPlane = _.plane.fromNormalAndPoint( dstPlane, normal, point );
  test.identical( gotPlane, expected );

  test.case = 'Change plane 2D'; /* */

  var dstPlane = [ 0, 0, 0 ];
  var normal = [ 0, 1 ];
  var point = [ 1, 0 ];
  var expected = [ 0, 1, 0 ];

  var gotPlane = _.plane.fromNormalAndPoint( dstPlane, normal, point );
  test.equivalent( gotPlane, expected );

  test.case = 'Change plane 4D'; /* */

  var dstPlane = [ 0, 0, 0, 0, 0 ];
  var normal = [ 0, 1, 1, 0 ];
  var point = [ 0, 0, 0, 4 ];
  var expected = [ 0, 1, 1, 0, 0 ];

  var gotPlane = _.plane.fromNormalAndPoint( dstPlane, normal, point );
  test.equivalent( gotPlane, expected );

  test.case = 'Negative numbers'; /* */

  var dstPlane = [ - 1, - 3, - 1 ];
  var normal = [ - 1, 0 ];
  var point = [ 4, - 4 ];
  var expected = [ - 1, 0, 4 ];

  var gotPlane = _.plane.fromNormalAndPoint( dstPlane, normal, point );
  test.identical( gotPlane, expected );

  test.case = 'Decimal numbers'; /* */

  var dstPlane = [ 0.2, 0.3, - 0.1 ];
  var normal = [ 0.57, 0.57 ];
  var point = [ 0, 0.500 ];
  var expected = [ 0.57, 0.57, - 0.285 ];

  var gotPlane = _.plane.fromNormalAndPoint( dstPlane, normal, point );
  test.equivalent( gotPlane, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.fromNormalAndPoint( ));
  test.shouldThrowErrorSync( () => _.plane.fromNormalAndPoint( [ 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromNormalAndPoint( [ 0, 0, 0, 0 ], [ 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromNormalAndPoint( [ 0, 0, 0, 0 ], [ 0, 0, 0, 1 ], [ 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromNormalAndPoint( [ 0, 0, 0, 0 ], [ 0, 0, 1 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromNormalAndPoint( [ 0, 0, 0, 0, 1 ], [ 0, 0, 1 ], [ 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromNormalAndPoint( [ 0, 0, 0, 0 ], [ 0, 0, 1 ], [ 0, 1, 0 ], [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromNormalAndPoint( [ 0, 0, 0, 0 ], null, [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromNormalAndPoint( [ 0, 0, 0, 0 ], [ 0, 0, 1 ], null ));
  test.shouldThrowErrorSync( () => _.plane.fromNormalAndPoint( NaN, [ 0, 0, 1 ], [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromNormalAndPoint( [ 0, 0, 0, 0 ], [ 0, 0, 1 ], NaN ));
}


function fromPoints( test )
{

  test.case = 'Points stay unchanged, dst plane changes'; /* */

  var dstPlane = [ 0, 0 , 1, 2 ];
  var a = [ 0, 1, 0 ];
  var oldA = a.slice();
  var b = [ 0, 3, 4 ];
  var oldB = b.slice();
  var c = [ 0, 2, 0 ];
  var oldC = c.slice();
  var expected = [ 1, 0, 0, 0 ];

  var gotPlane = _.plane.fromPoints( dstPlane, a, b, c );
  test.identical( gotPlane, dstPlane );
  test.equivalent( expected, dstPlane );
  test.identical( a, oldA );
  test.identical( b, oldB );
  test.identical( c, oldC );

  test.case = 'NaN plane'; /* */

  var dstPlane = [ NaN, NaN, NaN, NaN ];
  var a = [ 2, 1, 0 ];
  var b = [ 2, 3, 4 ];
  var c = [ 2, 2, 0 ];
  var expected = [ 1, 0, 0, - 2 ];

  var gotPlane = _.plane.fromPoints( dstPlane, a, b, c  );
  test.identical( gotPlane, expected );

  test.case = 'null plane from normal and point'; /* */

  var dstPlane = null;
  var a = [ 0, 1, 0 ];
  var b = [ 0, 3, 4 ];
  var c = [ 0, 2, 0 ];
  var expected = [ 1, 0, 0, 0 ];

  var gotPlane = _.plane.fromPoints( dstPlane, a, b, c  );
  test.equivalent( gotPlane, expected );

  test.case = 'NaN point'; /* */

  var dstPlane = [ 0, 0, 0, 0 ];
  var a = [ NaN, NaN, NaN ];
  var b = [ 0, 3, 4 ];
  var c = [ 0, 2, 0 ];
  var expected = [ NaN, NaN, NaN, NaN ];

  var gotPlane = _.plane.fromPoints( dstPlane, a, b, c  );
  test.identical( gotPlane, expected );

  test.case = 'Erase plane'; /* */

  var dstPlane = [ 1, 1, 1, 1 ];
  var a = [ 0, 0, 0 ];
  var b = [ 0, 0, 0 ];
  var c = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0 ];

  var gotPlane = _.plane.fromPoints( dstPlane, a, b, c  );
  test.equivalent( gotPlane, expected );

  test.case = 'Change plane'; /* */

  var dstPlane = [ 1, 0, 1, 2 ];
  var a = [ 1, 3, 0 ];
  var b = [ 1, 3, 4 ];
  var c = [ 1, 2, 0 ];
  var expected = [ - 1, 0, 0, 1 ];

  var gotPlane = _.plane.fromPoints( dstPlane, a, b, c  );
  test.equivalent( gotPlane, expected );

  test.case = 'Negative numbers'; /* */

  var dstPlane = [ - 1, - 3, - 1, 3 ];
  var a = [ 2, 0, 2 ];
  var b = [ 2, - 2, - 2 ];
  var c = [ 2, 2, 0 ];
  var expected = [ - 1, 0, 0, 2 ];

  var gotPlane = _.plane.fromPoints( dstPlane, a, b, c  );
  test.identical( gotPlane, expected );

  test.case = 'Decimal numbers'; /* */

  var dstPlane = [ 0.2, 0.3, - 0.1, 0 ];
  var a = [ 0, 0.2, 0.6 ];
  var b = [ 0, 0, 4.2 ];
  var c = [ 0, 0.3, 0 ];
  var expected = [ 1, 0, 0, 0 ];

  var gotPlane = _.plane.fromPoints( dstPlane, a, b, c  );
  test.equivalent( gotPlane, expected );

  test.case = 'Points in same direction - no plane'; /* */

  var dstPlane = [ 0.2, 0.3, - 0.1, 0 ];
  var a = [ 0, 0, 1 ];
  var b = [ 0, 0, 2 ];
  var c = [ 0, 0, 3 ];
  var expected = [ 0, 0, 0, 0 ];

  var gotPlane = _.plane.fromPoints( dstPlane, a, b, c  );
  test.equivalent( gotPlane, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.fromPoints( ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0 ], [ 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0 ], [ 0, 0, 1 ], [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0 ], [ 0, 0, 1 ], [ 0, 1, 0 ], [ 1, 0, 0 ], [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0, 0 ], [ 0, 0, 1 ], [ 0, 0, 2 ], [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 1 ], [ 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0 ], [ 0, 0, 1 ], [ 0, 0, 1, 2 ], [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 1 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0 ], null, [ 1, 0, 0 ], [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0 ], [ 0, 1, 0 ], null, [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0 ], [ 1, 0, 0 ], [ 0, 0, 1 ], null ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0 ], NaN, [ 0, 0, 1 ], [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0 ], [ 0, 0, 1 ], NaN, [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 1 ], NaN ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0 ], [ 0, 4 ], [ 0, 1 ], [ 0, 2 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0, 0 ], [ 0, 4, 1, 0 ], [ 0, 0, 1, 1 ], [ 0, 2, 2, 0 ] ));
}

function pointDistance( test )
{

  test.case = 'Point and plane stay unchanged'; /* */

  var plane = [ 0, 0 , 1, 2 ];
  var oldPlane = plane.slice();
  var point = [ 0, 1, 0 ];
  var oldPoint = point.slice();
  oldPoint = _.vector.from( point );
  point = _.vector.from( point );
  var expected = 2;

  var distance = _.plane.pointDistance( plane, point );
  test.identical( expected, distance );
  test.identical( plane, oldPlane );
  test.identical( point, oldPoint );

  test.case = 'NaN plane'; /* */

  var plane = [ NaN, NaN, NaN, NaN ];
  var point = [ 2, 1, 0 ];
  point = _.vector.from( point );
  var expected = NaN;

  var distance = _.plane.pointDistance( plane, point );
  test.identical( distance, expected );

  test.case = 'NaN point'; /* */

  var plane = [ 0, 0, 0, 0 ];
  var point = [ NaN, NaN, NaN ];
  point = _.vector.from( point );
  var expected = NaN;

  var distance = _.plane.pointDistance( plane, point );
  test.identical( distance, expected );

  test.case = 'Trivial'; /* */

  var plane = [ 0, 1, 0, 2 ];
  var point = [ 1, 1, 1 ];
  point = _.vector.from( point );
  var expected = 3;

  var distance = _.plane.pointDistance( plane, point );
  test.identical( distance, expected );

  test.case = 'Point under plane'; /* */

  var plane = [ 0, 0, 1, 1 ];
  var point = [ 0, 0, - 2 ];
  point = _.vector.from( point );
  var expected = - 1;

  var distance = _.plane.pointDistance( plane, point );
  test.identical( distance, expected );

  test.case = 'Point over plane'; /* */

  var plane = [ 0, 0, 1, 1 ];
  var point = [ 0, 0, 2 ];
  point = _.vector.from( point );
  var expected = 3;

  var distance = _.plane.pointDistance( plane, point );
  test.identical( distance, expected );

  test.case = 'Decimal numbers'; /* */

  var plane = [ 0.2, 0.3, - 0.1, 0 ];
  var point = [ 0, 0.2, 0.6 ];
  point = _.vector.from( point );
  var expected = 0;

  var distance = _.plane.pointDistance( plane, point );
  test.equivalent( distance, expected );

  test.case = 'Points in plane'; /* */

  var plane = [ 0.2, 0.3, - 0.1, 0 ];
  var a = [ 0, 0, 1 ];
  var b = [ 0, 1, 0 ];
  var c = [ 0, 0, 3 ];
  var expected = [ - 1, 0, 0, 0 ];

  var plane = _.plane.fromPoints( plane, a, b, c );
  test.equivalent( plane, expected );

  a = _.vector.from( a );
  b = _.vector.from( b );
  c = _.vector.from( c );
  expected = 0;

  var dist = _.plane.pointDistance( plane, a );
  test.equivalent( dist, expected );
  var dist = _.plane.pointDistance( plane, b );
  test.equivalent( dist, expected );
  var dist = _.plane.pointDistance( plane, c );
  test.equivalent( dist, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.pointDistance( ));
  test.shouldThrowErrorSync( () => _.plane.pointDistance( [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointDistance( [ 0, 0, 1, 0 ], [ 0, 0, 1 ], [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointDistance( [ 1, 0, 0 ], [ 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointDistance( [ 0, 0, 1, 0, 0 ], [ 2, 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointDistance( [ 0, 0, 1, 0 ], [ 0, 0, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointDistance( [ 0, 0, 1, 0 ], [ 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointDistance( [ 0, 0, 1, 0 ], null ));
  test.shouldThrowErrorSync( () => _.plane.pointDistance( null, [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointDistance( [ 0, 0, 1, 0 ], NaN ));
  test.shouldThrowErrorSync( () => _.plane.pointDistance( NaN, [ 0, 1, 0 ] ));
}

//


function pointCoplanarGet( test )
{

  test.case = 'Plane remains unchanged, point changes'; /* */

  var plane = [ 1, 0 , 0, 1 ];
  var oldPlane = plane.slice();
  var point = [ 2, 0, 2 ];
  var expected = [ - 1, 0, 2 ];

  var gotPoint = _.plane.pointCoplanarGet( plane, point );
  test.identical( expected, point );
  test.identical( expected, gotPoint );
  test.identical( plane, oldPlane );

  test.case = 'No point'; /* */

  var plane = [ 1, 0 , 0, 1 ];
  var expected = [ - 1, 0, 0 ];

  var gotPoint = _.plane.pointCoplanarGet( plane );
  test.identical( expected, gotPoint );

  test.case = 'Null point'; /* */

  var plane = [ 1, 0 , 0, 1 ];
  var point = null;
  var expected = [ - 1, 0, 0 ];

  var gotPoint = _.plane.pointCoplanarGet( plane, point );
  test.identical( expected, gotPoint );

  test.case = 'NaN point'; /* */

  var plane = [ 1, 0 , 0, 1 ];
  var point = NaN;
  var expected = [ - 1, 0, 0 ];

  var gotPoint = _.plane.pointCoplanarGet( plane, point );
  test.identical( expected, gotPoint );

  test.case = 'NaN array point'; /* */

  var plane = [ 1, 0 , 0, 1 ];
  var point = [ NaN, NaN, NaN ];
  var expected = [ NaN, NaN, NaN ];

  var gotPoint = _.plane.pointCoplanarGet( plane, point );
  test.identical( expected, gotPoint );

  test.case = 'Trivial'; /* */

  var plane = [ 1, 0 , 0, 1 ];
  var point = [ 1, 3, 2 ];
  var expected = [ - 1, 3, 2 ];

  var gotPoint = _.plane.pointCoplanarGet( plane, point );
  test.identical( expected, gotPoint );

  test.case = 'Trivial 2'; /* */

  var plane = [ 1, 0 , - 1, 0 ];
  var point = [ 2, 3, 2 ];
  var expected = [ 2, 3, 2 ];

  var gotPoint = _.plane.pointCoplanarGet( plane, point );
  test.identical( expected, gotPoint );

  test.case = 'Proyection 3D'; /* */

  var plane = [ 2, - 1 , 3, 1 ];
  var point = [ 4, 1, -3 ];
  var expected = [ 29/7, 13/14, -39/14  ];

  var gotPoint = _.plane.pointCoplanarGet( plane, point );
  test.equivalent( expected, gotPoint );

  test.case = 'Point in plane'; /* */

  var plane = [ 1, 0 , 0, 1 ];
  var point = [ - 1, 2, 3 ];
  var expected = [ - 1, 2, 3 ];

  gotPoint = _.plane.pointCoplanarGet( plane, point );
  test.identical( expected, gotPoint );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.pointCoplanarGet( ));
  test.shouldThrowErrorSync( () => _.plane.pointCoplanarGet( [ 0, 0, 1, 0 ], [ 0, 0, 1 ], [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointCoplanarGet( [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointCoplanarGet( [ 0, 0, 1 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointCoplanarGet( null, [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointCoplanarGet( NaN, [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointCoplanarGet( NaN, 'point' ));

}

//

function sphereDistance( test )
{

  test.case = 'Sphere and plane stay unchanged'; /* */

  var plane = [ 1, 0 , 0, 1 ];
  var oldPlane = plane.slice();
  var sphere = [ 2, 0, 0, 1 ];
  var oldSphere = sphere.slice();
  var expected = 2;

  var distance = _.plane.sphereDistance( plane, sphere );
  test.identical( expected, distance );
  test.identical( plane, oldPlane );
  test.identical( sphere, oldSphere );

  test.case = 'Trivial'; /* */

  var sphere = [ 2, 0, 0, 1 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = 2;

  var distance = _.plane.sphereDistance( plane, sphere );
  test.identical( distance, expected );

  test.case = 'Trivial 2'; /* */

  var plane = [ 0, 2, 0, 2 ];
  var sphere = [ 1, 1, 1, 1 ];
  var expected = 1;

  var distance = _.plane.sphereDistance( plane, sphere );
  test.identical( distance, expected );

  test.case = 'Center in plane'; /* */

  var plane = [ 0, 2, 0, 2 ];
  var sphere = [ 0, - 1, 0, 1 ];
  var expected = - 1;

  var distance = _.plane.sphereDistance( plane, sphere );
  test.identical( distance, expected );

  test.case = 'Sphere cuts plane'; /* */

  var plane = [ 0, 2, 0, 2 ];
  var sphere = [ 0, 0, 0, 1.5 ];
  var expected = - 0.5;

  var distance = _.plane.sphereDistance( plane, sphere );
  test.identical( distance, expected );

  test.case = 'Sphere touches plane'; /* */

  var plane = [ 0, 2, 0, 2 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var distance = _.plane.sphereDistance( plane, sphere );
  test.identical( distance, expected );

  test.case = 'Sphere under plane'; /* */

  var plane = [ 0, - 2, 0, 2 ];
  var sphere = [ - 1, - 1, - 1, 1 ];
  var expected = 1;

  var distance = _.plane.sphereDistance( plane, sphere );
  test.identical( distance, expected );

  test.case = 'Sphere over plane'; /* */

  var plane = [ 0, - 2, 0, 2 ];
  var sphere = [ 0, 3, 0, 1 ];
  var expected = 1;

  var distance = _.plane.sphereDistance( plane, sphere );
  test.identical( distance, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.sphereDistance( ));
  test.shouldThrowErrorSync( () => _.plane.sphereDistance( [ 0, 1, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereDistance( [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereDistance( [ 0, 0, 1, 0 ], [ 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereDistance( [ 0, 0, 1 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereDistance( [ 0, 0, 1, 0 ], null ));
  test.shouldThrowErrorSync( () => _.plane.sphereDistance( null, [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereDistance( [ 0, 0, 1, 0 ], NaN ));
  test.shouldThrowErrorSync( () => _.plane.sphereDistance( NaN, [ 0, 1, 0 ] ));

}

//

function sphereIntersects( test )
{

  test.case = 'Sphere and plane stay unchanged'; /* */

  var plane = [ 1, 0 , 0, 1 ];
  var oldPlane = plane.slice();
  var sphere = [ 2, 0, 0, 1 ];
  var oldSphere = sphere.slice();
  var expected = false;

  var gotBool = _.plane.sphereIntersects( plane, sphere );
  test.identical( expected, gotBool );
  test.identical( plane, oldPlane );
  test.identical( sphere, oldSphere );

  test.case = 'Trivial - no intersection'; /* */

  var sphere = [ 2, 0, 0, 1 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = false;

  var gotBool = _.plane.sphereIntersects( plane, sphere );
  test.identical( gotBool, expected );

  test.case = 'Trivial - intersection'; /* */

  var plane = [ 0, 2, 0, - 2 ];
  var sphere = [ 1, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.plane.sphereIntersects( plane, sphere );
  test.identical( gotBool, expected );

  test.case = 'Center in plane'; /* */

  var plane = [ 0, 2, 0, 2 ];
  var sphere = [ 0, - 1, 0, 1 ];
  var expected = true;

  var gotBool = _.plane.sphereIntersects( plane, sphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere cuts plane'; /* */

  var plane = [ 0, 2, 0, 2 ];
  var sphere = [ 0, 0, 0, 1.5 ];
  var expected = true;

  var gotBool = _.plane.sphereIntersects( plane, sphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere touches plane'; /* */

  var plane = [ 0, 2, 0, 2 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.plane.sphereIntersects( plane, sphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere under plane'; /* */

  var plane = [ 0, - 2, 0, 2 ];
  var sphere = [ - 1, - 1, - 1, 1 ];
  var expected = false;

  var gotBool = _.plane.sphereIntersects( plane, sphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere over plane'; /* */

  var plane = [ 0, - 2, 0, 2 ];
  var sphere = [ 0, 3, 0, 1 ];
  var expected = false;

  var gotBool = _.plane.sphereIntersects( plane, sphere );
  test.identical( gotBool, expected );

  test.case = 'Zero sphere'; /* */

  var plane = [ 0, - 2, 0, 2 ];
  var sphere = _.sphere.makeZero();
  var expected = false;

  var gotBool = _.plane.sphereIntersects( plane, sphere );
  test.identical( gotBool, expected );

  test.case = 'Nil sphere'; /* */

  var plane = [ 0, - 2, 0, 2 ];
  var sphere = _.sphere.makeNil();
  var expected = false;

  var gotBool = _.plane.sphereIntersects( plane, sphere );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.sphereIntersects( ));
  test.shouldThrowErrorSync( () => _.plane.sphereIntersects( [ 0, 1, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereIntersects( [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereIntersects( [ 0, 0, 1, 0 ], [ 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereIntersects( [ 0, 0, 1 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereIntersects( [ 0, 0, 1, 0 ], null ));
  test.shouldThrowErrorSync( () => _.plane.sphereIntersects( null, [ 0, 1, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereIntersects( [ 0, 0, 1, 0 ], NaN ));
  test.shouldThrowErrorSync( () => _.plane.sphereIntersects( NaN, [ 0, 1, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereIntersects( [ 0, 0, 1, 0 ], 'sphere' ));
  test.shouldThrowErrorSync( () => _.plane.sphereIntersects( 'plane', [ 0, 1, 0, 1 ] ));

}

//

function boxIntersects( test )
{

  test.case = 'box and plane stay unchanged'; /* */

  var plane = [ 1, 0 , 0, 1 ];
  var oldPlane = plane.slice();
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var oldbox = box.slice();
  var expected = false;

  var gotBool = _.plane.boxIntersects( plane, box );
  test.identical( expected, gotBool );
  test.identical( plane, oldPlane );
  test.identical( box, oldbox );

  test.case = 'No intersection'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = false;

  var gotBool = _.plane.boxIntersects( plane, box );
  test.identical( gotBool, expected );


  test.case = 'No intersection diagonal plane'; /* */

  var plane = [ - 1, 1, 0, - 2 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = false;

  var gotBool = _.plane.boxIntersects( plane, box );
  test.identical( gotBool, expected );


  test.case = 'Intersection x'; /* */

  var plane = [ 3, 0, 0, - 2 ];
  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expected = true;

  var gotBool = _.plane.boxIntersects( plane, box );
  test.identical( gotBool, expected );

  test.case = 'Intersection y'; /* */

  var plane = [ 0, 2, 0, - 2 ];
  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expected = true;

  var gotBool = _.plane.boxIntersects( plane, box );
  test.identical( gotBool, expected );


  test.case = 'Intersection z'; /* */

  var plane = [ 0, 0, 1, - 2 ];
  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expected = true;

  var gotBool = _.plane.boxIntersects( plane, box );
  test.identical( gotBool, expected );


  test.case = 'Intersection diagonal plane'; /* */

  var plane = [ 1, - 1, 0, 0 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.plane.boxIntersects( plane, box );
  test.identical( gotBool, expected );

  test.case = 'Intersection one side of box in plane'; /* */

  var plane = [ 0, 2, 0, 2 ];
  var box = [ 0, - 2, 0, 1, 3, 3 ];
  var expected = true;

  var gotBool = _.plane.boxIntersects( plane, box );
  test.identical( gotBool, expected );

  test.case = 'Intersection one edge of box in plane'; /* */

  var plane = [ 1, - 1, 0, 0 ];
  var box = [ 1, 1, - 1, 2, 1, 0 ];
  var expected = true;

  var gotBool = _.plane.boxIntersects( plane, box );
  test.identical( gotBool, expected );

  test.case = 'Zero box no intersection'; /* */

  var plane = [ 0, - 2, 0, 2 ];
  var box = _.box.makeZero( 3 );
  var expected = false;

  var gotBool = _.plane.boxIntersects( plane, box );
  test.identical( gotBool, expected );

  test.case = 'Zero box intersection'; /* */

  var plane = [ 4, - 2, 1, 0 ];
  var box = _.box.makeZero( 3 );
  var expected = true;

  var gotBool = _.plane.boxIntersects( plane, box );
  test.identical( gotBool, expected );


  test.case = 'Nil box'; /* */

  var plane = [ 0, - 2, 0, 2 ];
  var box = _.box.makeNil();
  var expected = false;

  var gotBool = _.plane.boxIntersects( plane, box );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.boxIntersects( ));
  test.shouldThrowErrorSync( () => _.plane.boxIntersects( [ 0, 1, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.boxIntersects( [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 1, 0, 2, 2 ] ));
  test.shouldThrowErrorSync( () => _.plane.boxIntersects( [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.boxIntersects( [ 0, 0, 1 ], [ 0, 0, 1, 0, 2, 2 ] ));
  test.shouldThrowErrorSync( () => _.plane.boxIntersects( [ 0, 0, 1, 0 ], null ));
  test.shouldThrowErrorSync( () => _.plane.boxIntersects( null, [ 0, 1, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.boxIntersects( [ 0, 0, 1, 0 ], NaN ));
  test.shouldThrowErrorSync( () => _.plane.boxIntersects( NaN, [ 0, 1, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.boxIntersects( [ 0, 0, 1, 0 ], 'box' ));
  test.shouldThrowErrorSync( () => _.plane.boxIntersects( 'plane', [ 0, 1, 0, 1 ] ));

}

//

function lineIntersects( test )
{

  test.case = 'Plane and line remain unchanged'; /* */

  var plane = [ 1, 0 , 0, 1 ];
  var oldPlane = plane.slice();
  var line = [ [ 1, 0, 1 ], [ 2, 1, 2 ] ];
  var expected = false;

  var interBool = _.plane.lineIntersects( plane, line );
  test.identical( expected, interBool );
  test.identical( plane, oldPlane );

  var oldLine = [ [ 1, 0, 1 ], [ 2, 1, 2 ] ];
  test.identical( line, oldLine );

  test.case = 'Line and plane intersect'; /* */

  var plane = [ 1, 0 , 0, 1 ];
  var line = [ [ - 2, - 2, - 2 ], [ 2, 2, 2 ] ];
  var expected = true;

  var interBool = _.plane.lineIntersects( plane, line );
  test.identical( expected, interBool );

  test.case = 'Line and Plane intersect'; /* */

  var plane = [ 1, 0 , - 1, 0 ];
  var line = [ [ 2, 2, 2 ], [ 3, 3, 3 ] ];
  var expected = true;

  var interBool = _.plane.lineIntersects( plane, line );
  test.identical( expected, interBool );

  test.case = 'Line and Plane don´t intersect'; /* */

  var plane = [ 1, 0 , - 1, 0 ];
  var line = [ [ 2, 2, 3 ], [ 3, 3, 4 ] ];
  var expected = false;

  var interBool = _.plane.lineIntersects( plane, line );
  test.identical( expected, interBool );

  test.case = 'Line in Plane'; /* */

  var plane = [ 1, 0 , 0, 0 ];
  var line = [ [ 0, 2, 3 ], [ 0, 5, 7 ] ];
  var expected = true;

  var interBool = _.plane.lineIntersects( plane, line );
  test.equivalent( expected, interBool );

  test.case = 'Perpendicular line intersects'; /* */

  var plane = [ 1, 0 , 0, 0 ];
  var line = [ [ - 2, 2, 2 ], [ 2, 2, 2 ] ];
  var expected = true;

  var interBool = _.plane.lineIntersects( plane, line );
  test.identical( expected, interBool );

  test.case = 'Perpendicular line touches plane'; /* */

  var plane = [ 1, 0 , 0, 0 ];
  var line = [ [ - 2, 2, 2 ], [ 0, 2, 2 ] ];
  var expected = true;

  var interBool = _.plane.lineIntersects( plane, line );
  test.identical( expected, interBool );

  test.case = 'Perpendicular doesn´t intersect'; /* */

  var plane = [ 1, 0 , 0, 0 ];
  var line = [ [ - 2, 2, 2 ], [ - 1, 2, 2 ] ];
  var expected = false;

  var interBool = _.plane.lineIntersects( plane, line );
  test.identical( expected, interBool );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.lineIntersects( ));
  test.shouldThrowErrorSync( () => _.plane.lineIntersects( [ 0, 0, 1, 0 ], [ 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.lineIntersects( [ 0, 0, 1, 0 ], [ 0, 0, 1 ], [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.lineIntersects( [ 0, 0, 1, 0 ], [ [ 0, - 1, 0 ], [ 0, 3, 1, 2 ] ] ));
  test.shouldThrowErrorSync( () => _.plane.lineIntersects( [ 0, 0, 1, 0, 2 ], [ [ 0, - 1, 0 ], [ 3, 1, 2 ] ] ));
  test.shouldThrowErrorSync( () => _.plane.lineIntersects( [ 0, 0, 1, 0 ], [ [ 0, - 1, 0 ], [ 0, 3, 1 ] ], [ [ 0, - 1, 0 ], [ 0, 3, 1 ] ]  ));
  test.shouldThrowErrorSync( () => _.plane.lineIntersects( null , [ [ 0, - 1, 0 ], [ 3, 1, 2 ] ] ));
  test.shouldThrowErrorSync( () => _.plane.lineIntersects( NaN, [ [ 0, - 1, 0 ], [ 3, 1, 2 ] ] ));
  test.shouldThrowErrorSync( () => _.plane.lineIntersects( [ 0, 2, 0, 1 ] , null ));
  test.shouldThrowErrorSync( () => _.plane.lineIntersects( [ 0, - 1, 0, 2 ], NaN ));
  test.shouldThrowErrorSync( () => _.plane.lineIntersects( [ 0, - 1, 0, 2 ], [ NaN, NaN ] ));
  test.shouldThrowErrorSync( () => _.plane.lineIntersects( 'plane', 'line' ));
}

//

function translate( test )
{

  test.case = 'Offset remains unchanged, plane changes'; /* */

  var plane = [ 1, 0 , 0, 1 ];
  var offset = [ 1, 0, 1 ];
  var oldOffset = offset.slice();
  var expected = [ 1, 0, 0, 0 ];

  var newPlane = _.plane.translate( plane, offset );
  test.identical( expected, newPlane );
  test.identical( plane, newPlane );
  test.identical( offset, oldOffset );

  test.case = 'No change (normal and offset are perpendicular)'; /* */

  var plane = [ 1, 0 , 0, 1 ];
  var offset = [ 0, 2, 3 ];
  var expected = [ 1, 0 , 0, 1 ];

  var gotOffset = _.plane.translate( plane, offset );
  test.identical( expected, gotOffset );

  test.case = 'No change'; /* */

  var plane = [ 1, 0 , - 1, 0 ];
  var offset = [ 2, 2, 2 ];
  var expected = [ 1, 0 , - 1, 0 ];

  var gotOffset = _.plane.translate( plane, offset );
  test.identical( expected, gotOffset );

  test.case = 'Trivial translation'; /* */

  var plane = [ 1, 0 , 0, 0 ];
  var offset = [ 3, 2, 3 ];
  var expected =  [ 1, 0 , 0, - 3 ];

  var gotOffset = _.plane.translate( plane, offset );
  test.equivalent( expected, gotOffset );

  test.case = 'Negative offset'; /* */

  var plane = [ 1, 0 , 0, 0 ];
  var offset = [ - 3, - 2, - 3 ];
  var expected =  [ 1, 0 , 0, 3 ];

  var gotOffset = _.plane.translate( plane, offset );
  test.equivalent( expected, gotOffset );

  test.case = 'More dimensions'; /* */

  var plane = [ 1, 0 , 0, 2, 3, 4, 0 ];
  var offset = [ - 2, - 2, - 2, 2, 2, 2 ];
  var expected = [ 1, 0 , 0, 2, 3, 4, -16 ];

  var gotOffset = _.plane.translate( plane, offset );
  test.identical( expected, gotOffset );

  test.case = 'NaN offset'; /* */

  var plane = [ 1, 0 , 0, 0 ];
  var offset = [ NaN, NaN, NaN ];
  var expected =  [ 1, 0 , 0, NaN ];

  var gotOffset = _.plane.translate( plane, offset );
  test.equivalent( expected, gotOffset );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.translate( ));
  test.shouldThrowErrorSync( () => _.plane.translate( [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.translate( [ 0, 0, 1, 0 ], [ 0, 0, 1 ], [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.translate( [ 0, 0, 1, 0 ], [ 0, 0, 1, 2 ] ));
  test.shouldThrowErrorSync( () => _.plane.translate( [ 0, 0, 1, 0 ], [ 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.translate( null, [ 0, 0, 2 ] ));
  test.shouldThrowErrorSync( () => _.plane.translate( NaN, [ 0, 0, 2 ] ));
  test.shouldThrowErrorSync( () => _.plane.translate( [ 0, 0, 2 ], null ));
  test.shouldThrowErrorSync( () => _.plane.translate( [ 0, 0, 2 ], NaN));
  test.shouldThrowErrorSync( () => _.plane.translate( 'plane', 'offset' ));

}

//

function normalize( test )
{

  test.case = 'Plane changes'; /* */

  var plane = [ 2, 0 , 0, 1 ];
  var expected = [ 1, 0, 0, 0.5 ];

  var newPlane = _.plane.normalize( plane );
  test.identical( expected, newPlane );
  test.identical( plane, newPlane );

  test.case = 'Trivial '; /* */

  var plane = [ 2, 0 , 0, 4 ];
  var expected =  [ 1, 0 , 0, 2 ];

  var normalized = _.plane.normalize( plane );
  test.equivalent( expected, normalized );

  test.case = 'Trivial'; /* */

  var plane = [ 2, 2 , 2, 4 ];
  var expected = [ 2/Math.sqrt( 12 ), 2/Math.sqrt( 12 ), 2/Math.sqrt( 12 ), 4/Math.sqrt( 12 ) ];

  var normalized = _.plane.normalize( plane );
  test.equivalent( expected, normalized );

  test.case = 'Already normalized 1D'; /* */

  var plane = [ 1, 0 , 0, 3 ];
  var expected = [ 1, 0 , 0, 3 ];

  var normalized = _.plane.normalize( plane );
  test.identical( expected, normalized );

  test.case = 'Already normalized'; /* */

  var plane = [ 1/Math.sqrt( 2 ), 1/Math.sqrt( 2 ), 0, 2/Math.sqrt( 2 ) ];
  var expected = [1/Math.sqrt( 2 ), 1/Math.sqrt( 2 ), 0, 2/Math.sqrt( 2 ) ];

  var normalized = _.plane.normalize( plane );
  test.equivalent( expected, normalized );

  test.case = 'Negative coordinates'; /* */

  var plane = [ - 3, - 6 , 0, 8 ];
  var expected =  [ - 3/Math.sqrt( 45 ), - 6/Math.sqrt( 45 ) , 0, 8/Math.sqrt( 45 ) ];

  var normalized = _.plane.normalize( plane );
  test.equivalent( expected, normalized );

  test.case = 'More dimensions'; /* */

  var plane = [ 4, 0 , 0, 4, 0, 4, 8 ];
  var expected = [ 4/Math.sqrt( 48 ), 0 , 0, 4/Math.sqrt( 48 ), 0, 4/Math.sqrt( 48 ), 8/Math.sqrt( 48 ) ];

  var normalized = _.plane.normalize( plane );
  test.identical( expected, normalized );

  test.case = 'NaN result'; /* */

  var plane = [ NaN, NaN, NaN, NaN ];
  var expected =  [ NaN, NaN, NaN, NaN ];

  var normalized = _.plane.normalize( plane );
  test.equivalent( expected, normalized );

  test.case = 'Plane  [ 0 ]'; /* */

  var plane = [ 0 ];
  var expected =  [ NaN ];

  var normalized = _.plane.normalize( plane );
  test.equivalent( expected, normalized );

  test.case = 'Null coordinate'; /* */

  var plane = [ 1, null, 0, 0 ];
  var expected =  [ 1, 0, 0, 0 ];

  var normalized = _.plane.normalize( plane );
  test.equivalent( expected, normalized );

  test.case = 'NaN coordinates'; /* */

  var plane = [ 1, NaN, 0, 0 ];
  var expected =  [ NaN, NaN, NaN, NaN ];

  var normalized = _.plane.normalize( plane );
  test.equivalent( expected, normalized );

  test.case = 'String coordinates'; /* */

  var plane = [ 1, 'string', 0, 0 ];
  var expected =  [ NaN, NaN, NaN, NaN ];

  var normalized = _.plane.normalize( plane );
  test.equivalent( expected, normalized );


  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.normalize( ));
  test.shouldThrowErrorSync( () => _.plane.normalize( [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.normalize( null ));
  test.shouldThrowErrorSync( () => _.plane.normalize( NaN ));
  test.shouldThrowErrorSync( () => _.plane.normalize( 'plane' ));

}

//

function negate( test )
{

  test.case = 'Zero'; /* */

  var plane = [ 0, 0 , 0, 0 ];
  var expected = [ 0, 0, 0, 0 ];

  var newPlane = _.plane.negate( plane );
  test.equivalent( expected, newPlane );
  test.identical( plane, newPlane );

  test.case = 'Plane changes'; /* */

  var plane = [ 2, 0 , 0, 1 ];
  var expected = [ - 2, 0, 0, - 1 ];

  var newPlane = _.plane.negate( plane );
  test.equivalent( expected, newPlane );
  test.identical( plane, newPlane );

  test.case = 'Trivial '; /* */

  var plane = [ 2, 0 , 0, 4 ];
  var expected =  [ - 2, 0 , 0, - 4 ];

  var negated = _.plane.negate( plane );
  test.equivalent( expected, negated );

  test.case = 'Trivial'; /* */

  var plane = [ 2, 2 , 2, 4 ];
  var expected = [ - 2, - 2, - 2, - 4 ];

  var negated = _.plane.negate( plane );
  test.equivalent( expected, negated );

  test.case = 'Negate 1D'; /* */

  var plane = [ 1, 0 , 0, 3 ];
  var expected = [ - 1, 0 , 0, - 3 ];

  var negated = _.plane.negate( plane );
  test.equivalent( expected, negated );

  test.case = 'Negate'; /* */

  var plane = [ 1/Math.sqrt( 2 ), 1/Math.sqrt( 2 ), 0, 2/Math.sqrt( 2 ) ];
  var expected = [ - 1/Math.sqrt( 2 ), - 1/Math.sqrt( 2 ), 0, - 2/Math.sqrt( 2 ) ];

  var negated = _.plane.negate( plane );
  test.equivalent( expected, negated );

  test.case = 'Negative coordinates'; /* */

  var plane = [ - 3, - 6 , 0, 8 ];
  var expected =  [ 3, 6, 0, - 8 ];

  var negated = _.plane.negate( plane );
  test.equivalent( expected, negated );

  test.case = 'More dimensions'; /* */

  var plane = [ 4, 0 , 0, 4, 0, 4, 8 ];
  var expected = [  - 4, 0 , 0, - 4, 0, - 4, - 8 ];

  var negated = _.plane.negate( plane );
  test.equivalent( expected, negated );

  test.case = 'NaN result'; /* */

  var plane = [ NaN, NaN, NaN, NaN ];
  var expected =  [ NaN, NaN, NaN, NaN ];

  var negated = _.plane.negate( plane );
  test.equivalent( expected, negated );

  test.case = 'Plane  [ 0 ]'; /* */

  var plane = [ 0 ];
  var expected =  [ 0 ];

  var negated = _.plane.negate( plane );
  test.equivalent( expected, negated );

  test.case = 'Null coordinate'; /* */

  var plane = [ 1, null, 0, 0 ];
  var expected =  [ - 1, 0, 0, 0 ];

  var negated = _.plane.negate( plane );
  test.equivalent( expected, negated );

  test.case = 'NaN coordinates'; /* */

  var plane = [ 1, NaN, 0, 0 ];
  var expected =  [ - 1, NaN, 0, 0 ];

  var negated = _.plane.negate( plane );
  test.equivalent( expected, negated );

  test.case = 'String coordinates'; /* */

  var plane = [ 1, 'string', 0, 0 ];
  var expected =  [ - 1, NaN, 0, 0 ];

  var negated = _.plane.negate( plane );
  test.equivalent( expected, negated );


  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.negate( ));
  test.shouldThrowErrorSync( () => _.plane.negate( [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.negate( [] ));
  test.shouldThrowErrorSync( () => _.plane.negate( null ));
  test.shouldThrowErrorSync( () => _.plane.negate( NaN ));
  test.shouldThrowErrorSync( () => _.plane.negate( 'plane' ));

}

//

function threeIntersectionPoint( test )
{

  test.case = 'Planes remain unchanged'; /* */

  var plane1 = [ 1, 0 , 0, 1 ];
  var oldPlane1 = plane1.slice();
  var plane2 = [ 1, 1 , 0, 1 ];
  var oldPlane2 = plane2.slice();
  var plane3 = [ 1, 0 , 1, 1 ];
  var oldPlane3 = plane3.slice();
  var expected = [ - 1, 0, 0 ];
  expected = _.vector.from( expected );

  var interPoint = _.plane.threeIntersectionPoint( plane1, plane2, plane3 );
  test.identical( expected, interPoint );
  test.identical( plane1, oldPlane1 );
  test.identical( plane2, oldPlane2 );
  test.identical( plane3, oldPlane3 );

  test.case = 'Parallel planes'; /* */

  var plane1 = [ 1, 0 , 0, 1 ];
  var plane2 = [ 2, 0 , 0, 4 ];
  var plane3 = [ 3, 0 , 0, 7 ];
  var expected = NaN;

  var interPoint = _.plane.threeIntersectionPoint( plane1, plane2, plane3 );
  test.identical( expected, interPoint );

  test.case = '2 Parallel planes'; /* */

  var plane1 = [ 1, 0 , 0, 1 ];
  var plane2 = [ 2, 0 , 0, 4 ];
  var plane3 = [ 3, 1 , 4, 7 ];
  var expected = NaN;

  var interPoint = _.plane.threeIntersectionPoint( plane1, plane2, plane3 );
  test.identical( expected, interPoint );

  test.case = 'Perpendicular planes in origin'; /* */

  var plane1 = [ 1, 0 , 0, 0 ];
  var plane2 = [ 0, 1 , 0, 0 ];
  var plane3 = [ 0, 0 , 1, 0 ];
  var expected = [ 0, 0, 0 ];
  expected = _.vector.from( expected );

  var interPoint = _.plane.threeIntersectionPoint( plane1, plane2, plane3 );
  test.equivalent( expected, interPoint );
  debugger;
  test.case = 'Planes in origin'; /* */

  var plane1 = [ - 1, 1, 0, 0 ];
  var plane2 = [ 0, 1 , 0, 0 ];
  var plane3 = [ 0, - 1, 6, 0 ];
  var expected = [ 0, 0, 0 ];
  expected = _.vector.from( expected );

  var interPoint = _.plane.threeIntersectionPoint( plane1, plane2, plane3 );
  test.equivalent( expected, interPoint );

  test.case = 'Perpendicular planes'; /* */

  var plane1 = [ 3, 0 , 0, 3 ];
  var plane2 = [ 0, - 4 , 0, 4 ];
  var plane3 = [ 0, 0 , 5, 5 ];
  var expected = [ - 1, 1, - 1 ];
  expected = _.vector.from( expected );

  var interPoint = _.plane.threeIntersectionPoint( plane1, plane2, plane3 );
  test.identical( expected, interPoint );

  test.case = 'Trivial'; /* */

  var plane1 = [ 2, 1, 2, 4 ];
  var plane2 = [ 1, 1 , 0, - 5 ];
  var plane3 = [ 1, - 1 , 6, 0 ];
  var expected = [ - 32, 37, 11.5 ];
  expected = _.vector.from( expected );

  var interPoint = _.plane.threeIntersectionPoint( plane1, plane2, plane3 );
  test.identical( expected, interPoint );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.threeIntersectionPoint( ));
  test.shouldThrowErrorSync( () => _.plane.threeIntersectionPoint( [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.threeIntersectionPoint( [ 0, 0, 1, 0 ], [ 0, 0, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.threeIntersectionPoint( [ 0, 0, 1, 0 ], [ 0, - 1, 0, 2 ], [ 0, 3, 1, 2 ], [ 0, 3, 1, 2 ]  ));
  test.shouldThrowErrorSync( () => _.plane.threeIntersectionPoint( [ 0, 0, 1, 0, 2 ], [ 0, - 1, 0, 2 ], [ 0, 3, 1, 2 ] ));
  test.shouldThrowErrorSync( () => _.plane.threeIntersectionPoint( [ 0, 0, 1, 0 ], [ 0, - 1, 0, 2, 3 ], [ 0, 3, 1, 2 ] ));
  test.shouldThrowErrorSync( () => _.plane.threeIntersectionPoint( [ 0, 0, 1, 0 ], [ 0, - 1, 0, 2 ], [ 0, 3, 1, 2, 4 ] ));
  test.shouldThrowErrorSync( () => _.plane.threeIntersectionPoint( null, [ 0, - 1, 0, 2 ], [ 0, 3, 1, 2 ]  ));
  test.shouldThrowErrorSync( () => _.plane.threeIntersectionPoint( [ 0, 0, 1, 0 ], NaN, [ 0, 3, 1, 2 ], ));
  test.shouldThrowErrorSync( () => _.plane.threeIntersectionPoint( [ ], [ ], [ ] ));

}

// --
// define class
// --

var Self =
{

  name : 'Tools/Math/Plane',
  silencing : 1,
  enabled : 1,
  // verbosity : 7,
  // debug : 1,
  // routine: 'boxIntersects',

  tests :
  {

    from : from,
    fromNormalAndPoint : fromNormalAndPoint,
    fromPoints : fromPoints,

    pointDistance : pointDistance,
    pointCoplanarGet : pointCoplanarGet,

    sphereDistance : sphereDistance,
    sphereIntersects : sphereIntersects,
    boxIntersects : boxIntersects,

    lineIntersects : lineIntersects,

    //matrixHomogenousApply : matrixHomogenousApply,
    translate : translate,

    normalize : normalize,
    negate : negate,

    threeIntersectionPoint : threeIntersectionPoint,

  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
