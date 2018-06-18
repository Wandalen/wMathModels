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

  test.description = 'Src plane, normal and bias stay unchanged, dst plane changes'; //

  var dstplane = [ 0, 0 , 1, 2 ];
  var srcplane = [ 0, 1, 2, 3 ];
  var normal = [ 0, 1, 2 ];
  var bias = 3;
  var oldsrcplane = [ 0, 1, 2, 3 ];
  var oldnormal = [ 0, 1, 2 ];
  var oldbias = 3;
  var expected = [ 0, 1, 2, 3 ];

  var plane = _.plane.from( dstplane, srcplane );
  test.identical( plane, dstplane );
  test.identical( expected, dstplane );
  test.identical( srcplane, oldsrcplane );
  test.identical( normal, oldnormal );
  test.identical( bias, oldbias );

  test.description = 'null plane'; //

  var dstplane = null;
  var srcplane = [ 0, 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0 ];

  var plane = _.plane.from( dstplane, srcplane );
  test.identical( plane, expected );

  test.description = 'null plane fron normal and bias'; //

  var dstplane = null;
  var normal = [ 0, 0, 0 ];
  var bias = 0;
  var expected = [ 0, 0, 0, 0 ];

  var plane = _.plane.from( dstplane, normal, bias );
  test.identical( plane, expected );

  test.description = 'NaN normal'; //

  var dstplane = [ 0, 0, 0, 0 ];
  var normal = [ NaN, NaN, NaN ];
  var bias = 2;
  var expected = [ NaN, NaN, NaN, 2 ];

  var plane = _.plane.from( dstplane, normal, bias );
  test.identical( plane, expected );

  test.description = 'NaN bias'; //

  var dstplane = [ 0, 0, 0, 0 ];
  var normal = [ 0, 1, 0 ];
  var bias = NaN;
  var expected = [ 0, 1, 0, NaN ];

  var plane = _.plane.from( dstplane, normal, bias );
  test.identical( plane, expected );

  test.description = 'Erase plane'; //

  var dstplane = [ 1, 1, 1, 1 ];
  var srcplane = [ 0, 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0 ];

  var plane = _.plane.from( dstplane, srcplane );
  test.identical( plane, expected );

  test.description = 'Erase plane form normal and bias'; //

  var dstplane = [ 1, 1, 1, 1 ];
  var normal = [ 0, 0, 0 ];
  var bias = 0;
  var expected = [ 0, 0, 0, 0 ];

  var plane = _.plane.from( dstplane, normal, bias );
  test.identical( plane, expected );

  test.description = 'Change plane'; //

  var dstplane = [ 1, 0, 1, 2 ];
  var srcplane = [ 0, 1, 0, 1 ];
  var expected = [ 0, 1, 0, 1 ];

  var plane = _.plane.from( dstplane, srcplane );
  test.identical( plane, expected );

  test.description = 'Change plane from normal and bias'; //

  var dstplane = [ 1, 0, 1, 2 ];
  var normal = [ 1, 2, 1 ];
  var bias = 1;
  var expected = [ 1, 2, 1, 1 ];

  var plane = _.plane.from( dstplane, normal, bias );
  test.identical( plane, expected );

  test.description = 'Change plane 2D'; //

  var dstplane = [ 0, 0, 0 ];
  var srcplane = [ 0, 1, 1 ];
  var expected = [ 0, 1, 1 ];

  var plane = _.plane.from( dstplane, srcplane );
  test.identical( plane, expected );

  test.description = 'Change plane 2D'; //

  var dstplane = [ 0, 0, 0 ];
  var normal = [ 0, 1 ];
  var bias = 1;
  var expected = [ 0, 1, 1 ];

  var plane = _.plane.from( dstplane, normal, bias );
  test.identical( plane, expected );

  test.description = 'Change plane 4D'; //

  var dstplane = [ 0, 0, 0, 0, 0 ];
  var srcplane = [ 0, 1, 1, 0, 1 ];
  var expected = [ 0, 1, 1, 0, 1 ];

  var plane = _.plane.from( dstplane, srcplane );
  test.identical( plane, expected );

  test.description = 'Change plane 4D'; //

  var dstplane = [ 0, 0, 0, 0, 0 ];
  var normal = [ 0, 1, 1, 0 ];
  var bias = 1;
  var expected = [ 0, 1, 1, 0, 1 ];

  var plane = _.plane.from( dstplane, normal, bias );
  test.identical( plane, expected );

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

  test.description = 'Normal and point stay unchanged, dst plane changes'; //

  var dstplane = [ 0, 0 , 1, 2 ];
  var normal = [ 0, 1, 0 ];
  var point = [ 0, 3, 4 ];
  var oldnormal = [ 0, 1, 0 ];
  var oldpoint = [ 0, 3, 4 ];
  var expected = [ 0, 1, 0, - 3 ];

  var plane = _.plane.fromNormalAndPoint( dstplane, normal, point );
  test.identical( plane, dstplane );
  test.identical( expected, dstplane );
  test.identical( normal, oldnormal );
  test.identical( point, oldpoint );

  test.description = 'NaN plane from normal and point'; //

  var dstplane = [ NaN, NaN, NaN, NaN ];
  var normal = [ 0, 0, 1 ];
  var point = [ 0, 0, 2 ];
  var expected = [ 0, 0, 1, - 2 ];

  var plane = _.plane.fromNormalAndPoint( dstplane, normal, point );
  test.identical( plane, expected );

  test.description = 'null plane from normal and point'; //

  var dstplane = null;
  var normal = [ 0, 0, 1 ];
  var point = [ 0, 0, 2 ];
  var expected = [ 0, 0, 1, - 2 ];

  var plane = _.plane.fromNormalAndPoint( dstplane, normal, point );
  test.identical( plane, expected );

  test.description = 'NaN normal array'; //

  var dstplane = [ 0, 0, 0, 0 ];
  var normal = [ NaN, NaN, NaN ];
  var point = [ 0, 0, 2 ];
  var expected = [ NaN, NaN, NaN, NaN ];

  var plane = _.plane.fromNormalAndPoint( dstplane, normal, point );
  test.identical( plane, expected );

  test.description = 'NaN normal'; //

  var dstplane = [ 0, 0, 0, 0 ];
  var normal = NaN ;
  var point = [ 0, 0, 2 ];
  var expected = [ NaN, NaN, NaN, NaN ];

  var plane = _.plane.fromNormalAndPoint( dstplane, normal, point );
  test.identical( plane, expected );

  test.description = 'NaN point'; //

  var dstplane = [ 0, 0, 0, 0 ];
  var normal = [ 0, 1, 0 ];
  var point = [ NaN, NaN, NaN ];
  var expected = [ 0, 1, 0, NaN ];

  var plane = _.plane.fromNormalAndPoint( dstplane, normal, point );
  test.identical( plane, expected );

  test.description = 'Erase plane'; //

  var dstplane = [ 1, 1, 1, 1 ];
  var normal = [ 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0 ];

  var plane = _.plane.fromNormalAndPoint( dstplane, normal, point );
  test.identical( plane, expected );

  test.description = 'Change plane'; //

  var dstplane = [ 1, 0, 1, 2 ];
  var normal = [ 1, 2, 1 ];
  var point = [ 0, 3, 0 ];
  var expected = [ 1, 2, 1, - 6 ];

  var plane = _.plane.fromNormalAndPoint( dstplane, normal, point );
  test.identical( plane, expected );

  test.description = 'Change plane 2D'; //

  var dstplane = [ 0, 0, 0 ];
  var normal = [ 0, 1 ];
  var point = [ 1, 0 ];
  var expected = [ 0, 1, 0 ];

  var plane = _.plane.fromNormalAndPoint( dstplane, normal, point );
  test.identical( plane, expected );

  test.description = 'Change plane 4D'; //

  var dstplane = [ 0, 0, 0, 0, 0 ];
  var normal = [ 0, 1, 1, 0 ];
  var point = [ 0, 0, 0, 4 ];
  var expected = [ 0, 1, 1, 0, 0 ];

  var plane = _.plane.fromNormalAndPoint( dstplane, normal, point );
  test.identical( plane, expected );

  test.description = 'Negative numbers'; //

  var dstplane = [ - 1, - 3, - 1 ];
  var normal = [ - 1, 0 ];
  var point = [ 4, - 4 ];
  var expected = [ - 1, 0, 4 ];

  var plane = _.plane.fromNormalAndPoint( dstplane, normal, point );
  test.identical( plane, expected );

  test.description = 'Decimal numbers'; //

  var dstplane = [ 0.2, 0.3, - 0.1 ];
  var normal = [ 0.57, 0.57 ];
  var point = [ 0, 0.500 ];
  var expected = [ 0.57, 0.57, - 0.285 ];

  var plane = _.plane.fromNormalAndPoint( dstplane, normal, point );
  test.equivalent( plane, expected );

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

  test.description = 'Points stay unchanged, dst plane changes'; //

  var dstplane = [ 0, 0 , 1, 2 ];
  var a = [ 0, 1, 0 ];
  var b = [ 0, 3, 4 ];
  var c = [ 0, 2, 0 ];
  var olda = [ 0, 1, 0 ];
  var oldb = [ 0, 3, 4 ];
  var oldc = [ 0, 2, 0 ];
  var expected = [ 1, 0, 0, 0 ];

  var plane = _.plane.fromPoints( dstplane, a, b, c );
  test.identical( plane, dstplane );
  test.identical( expected, dstplane );
  test.identical( a, olda );
  test.identical( b, oldb );
  test.identical( c, oldc );

  test.description = 'NaN plane'; //

  var dstplane = [ NaN, NaN, NaN, NaN ];
  var a = [ 2, 1, 0 ];
  var b = [ 2, 3, 4 ];
  var c = [ 2, 2, 0 ];
  var expected = [ 1, 0, 0, - 2 ];

  var plane = _.plane.fromPoints( dstplane, a, b, c  );
  test.identical( plane, expected );

  test.description = 'null plane from normal and point'; //

  var dstplane = null;
  var a = [ 0, 1, 0 ];
  var b = [ 0, 3, 4 ];
  var c = [ 0, 2, 0 ];
  var expected = [ 1, 0, 0, 0 ];

  var plane = _.plane.fromPoints( dstplane, a, b, c  );
  test.identical( plane, expected );

  test.description = 'NaN point'; //

  var dstplane = [ 0, 0, 0, 0 ];
  var a = [ NaN, NaN, NaN ];
  var b = [ 0, 3, 4 ];
  var c = [ 0, 2, 0 ];
  var expected = [ NaN, NaN, NaN, NaN ];

  var plane = _.plane.fromPoints( dstplane, a, b, c  );
  test.identical( plane, expected );

  test.description = 'Erase plane'; //

  var dstplane = [ 1, 1, 1, 1 ];
  var a = [ 0, 0, 0 ];
  var b = [ 0, 0, 0 ];
  var c = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0 ];

  var plane = _.plane.fromPoints( dstplane, a, b, c  );
  test.identical( plane, expected );

  test.description = 'Change plane'; //

  var dstplane = [ 1, 0, 1, 2 ];
  var a = [ 1, 3, 0 ];
  var b = [ 1, 3, 4 ];
  var c = [ 1, 2, 0 ];
  var expected = [ - 1, 0, 0, 1 ];

  var plane = _.plane.fromPoints( dstplane, a, b, c  );
  test.identical( plane, expected );

  test.description = 'Negative numbers'; //

  var dstplane = [ - 1, - 3, - 1, 3 ];
  var a = [ 2, 0, 2 ];
  var b = [ 2, - 2, - 2 ];
  var c = [ 2, 2, 0 ];
  var expected = [ - 1, 0, 0, 2 ];

  var plane = _.plane.fromPoints( dstplane, a, b, c  );
  test.identical( plane, expected );

  test.description = 'Decimal numbers'; //

  var dstplane = [ 0.2, 0.3, - 0.1, 0 ];
  var a = [ 0, 0.2, 0.6 ];
  var b = [ 0, 0, 4.2 ];
  var c = [ 0, 0.3, 0 ];
  var expected = [ 1, 0, 0, 0 ];

  var plane = _.plane.fromPoints( dstplane, a, b, c  );
  test.equivalent( plane, expected );

  test.description = 'Points in same direction - no plane'; //

  var dstplane = [ 0.2, 0.3, - 0.1, 0 ];
  var a = [ 0, 0, 1 ];
  var b = [ 0, 0, 2 ];
  var c = [ 0, 0, 3 ];
  var expected = [ 0, 0, 0, 0 ];

  var plane = _.plane.fromPoints( dstplane, a, b, c  );
  test.equivalent( plane, expected );

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

  test.description = 'Point and plane stay unchanged'; //

  var plane = [ 0, 0 , 1, 2 ];
  var point = [ 0, 1, 0 ];
  point = _.vector.from( point );
  var oldplane = [ 0, 0, 1, 2 ];
  var oldpoint = [ 0, 1, 0 ];
  oldpoint = _.vector.from( point );
  var expected = 2;

  var distance = _.plane.pointDistance( plane, point );
  test.identical( expected, distance );
  test.identical( plane, oldplane );
  test.identical( point, oldpoint );

  test.description = 'NaN plane'; //

  var plane = [ NaN, NaN, NaN, NaN ];
  var point = [ 2, 1, 0 ];
  point = _.vector.from( point );
  var expected = NaN;

  var plane = _.plane.pointDistance( plane, point );
  test.identical( plane, expected );

  test.description = 'NaN point'; //

  var plane = [ 0, 0, 0, 0 ];
  point = [ NaN, NaN, NaN ];
  point = _.vector.from( point );
  var expected = NaN;

  var plane = _.plane.pointDistance( plane, point );
  test.identical( plane, expected );

  test.description = 'Trivial'; //

  var plane = [ 0, 1, 0, 2 ];
  point = [ 1, 1, 1 ];
  point = _.vector.from( point );
  var expected = 3;

  var plane = _.plane.pointDistance( plane, point );
  test.identical( plane, expected );


  test.description = 'Point under plane'; //

  var plane = [ 0, 0, 1, 1 ];
  point = [ 0, 0, - 2 ];
  point = _.vector.from( point );
  var expected = - 1;

  var plane = _.plane.pointDistance( plane, point );
  test.identical( plane, expected );

  test.description = 'Point over plane'; //

  var plane = [ 0, 0, 1, 1 ];
  point = [ 0, 0, 2 ];
  point = _.vector.from( point );
  var expected = 3;

  var plane = _.plane.pointDistance( plane, point );
  test.identical( plane, expected );

  test.description = 'Decimal numbers'; //

  var plane = [ 0.2, 0.3, - 0.1, 0 ];
  point = [ 0, 0.2, 0.6 ];
  point = _.vector.from( point );
  var expected = 0;

  var plane = _.plane.pointDistance( plane, point );
  test.equivalent( plane, expected );

  test.description = 'Points in plane'; //

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

function sphereDistance( test )
{

  test.description = 'Sphere and plane stay unchanged'; //

  var plane = [ 1, 0 , 0, 1 ];
  var sphere = [ 2, 0, 0, 1 ];
  var oldplane = [ 1, 0, 0, 1 ];
  var oldsphere = [ 2, 0, 0, 1];
  var expected = 2;

  var distance = _.plane.sphereDistance( plane, sphere );
  test.identical( expected, distance );
  test.identical( plane, oldplane );
  test.identical( sphere, oldsphere );

  test.description = 'Trivial'; //

  var sphere = [ 2, 0, 0, 1 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = 2;

  var plane = _.plane.sphereDistance( plane, sphere );
  test.identical( plane, expected );

  test.description = 'Trivial 2'; //

  var plane = [ 0, 2, 0, 2 ];
  var sphere = [ 1, 1, 1, 1 ];
  var expected = 1;

  var plane = _.plane.sphereDistance( plane, sphere );
  test.identical( plane, expected );

  test.description = 'Center in plane'; //

  var plane = [ 0, 2, 0, 2 ];
  var sphere = [ 0, - 1, 0, 1 ];
  var expected = - 1;

  var plane = _.plane.sphereDistance( plane, sphere );
  test.identical( plane, expected );

  test.description = 'Sphere cuts plane'; //

  var plane = [ 0, 2, 0, 2 ];
  var sphere = [ 0, 0, 0, 1.5 ];
  var expected = - 0.5;

  var plane = _.plane.sphereDistance( plane, sphere );
  test.identical( plane, expected );

  test.description = 'Sphere touches plane'; //

  var plane = [ 0, 2, 0, 2 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var plane = _.plane.sphereDistance( plane, sphere );
  test.identical( plane, expected );

  test.description = 'Sphere under plane'; //

  var plane = [ 0, - 2, 0, 2 ];
  var sphere = [ - 1, - 1, - 1, 1 ];
  var expected = 1;

  var plane = _.plane.sphereDistance( plane, sphere );
  test.identical( plane, expected );

  test.description = 'Sphere over plane'; //

  var plane = [ 0, - 2, 0, 2 ];
  var sphere = [ 0, 3, 0, 1 ];
  var expected = - 3;

  var plane = _.plane.sphereDistance( plane, sphere );
  test.identical( plane, expected );

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


function pointCoplanarGet( test )
{

  test.description = 'Plane remains unchanged, point changes'; //

  var plane = [ 1, 0 , 0, 1 ];
  var point = [ 2, 0, 2 ];
  var oldplane = [ 1, 0, 0, 1 ];
  var expected = [ - 1, 0, 2 ];

  point = _.plane.pointCoplanarGet( plane, point );
  test.identical( expected, point );
  test.identical( plane, oldplane );

  test.description = 'No point'; //

  var plane = [ 1, 0 , 0, 1 ];
  var expected = [ - 1, 0, 0 ];

  point = _.plane.pointCoplanarGet( plane );
  test.identical( expected, point );

  test.description = 'Null point'; //

  var plane = [ 1, 0 , 0, 1 ];
  var point = null;
  var expected = [ - 1, 0, 0 ];

  point = _.plane.pointCoplanarGet( plane, point );
  test.identical( expected, point );

  test.description = 'NaN point'; //

  var plane = [ 1, 0 , 0, 1 ];
  var point = NaN;
  var expected = [ - 1, 0, 0 ];

  point = _.plane.pointCoplanarGet( plane, point );
  test.identical( expected, point );

  test.description = 'NaN array point'; //

  var plane = [ 1, 0 , 0, 1 ];
  var point = [ NaN, NaN, NaN ];
  var expected = [ NaN, NaN, NaN ];

  point = _.plane.pointCoplanarGet( plane, point );
  test.identical( expected, point );

  test.description = 'Trivial'; //

  var plane = [ 1, 0 , 0, 1 ];
  var point = [ 1, 3, 2 ];
  var expected = [ - 1, 3, 2 ];

  point = _.plane.pointCoplanarGet( plane, point );
  test.identical( expected, point );

  test.description = 'Trivial 2'; //

  var plane = [ 1, 0 , - 1, 0 ];
  var point = [ 2, 3, 2 ];
  var expected = [ 2, 3, 2 ];

  point = _.plane.pointCoplanarGet( plane, point );
  test.identical( expected, point );

  test.description = 'Proyection 3D'; //

  var plane = [ 2, - 1 , 3, 1 ];
  var point = [ 4, 1, -3 ];
  var expected = [ 29/7, 13/14, -39/14  ];

  point = _.plane.pointCoplanarGet( plane, point );
  test.equivalent( expected, point );

  test.description = 'Point in plane'; //

  var plane = [ 1, 0 , 0, 1 ];
  var point = [ - 1, 2, 3 ];
  var expected = [ - 1, 2, 3 ];

  point = _.plane.pointCoplanarGet( plane, point );
  test.identical( expected, point );

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

function lineIntersects( test )
{

  test.description = 'Plane and line remain unchanged'; //

  var plane = [ 1, 0 , 0, 1 ];
  var line = [ [ 1, 0, 1 ], [ 2, 1, 2 ] ];
  var oldplane = [ 1, 0, 0, 1 ];
  var oldline = [ [ 1, 0, 1 ], [ 2, 1, 2 ] ];
  var expected = false;

  var inters = _.plane.lineIntersects( plane, line );
  test.identical( expected, inters );
  test.identical( plane, oldplane );
  test.identical( line, oldline );

  test.description = 'Line and plane intersect'; //

  var plane = [ 1, 0 , 0, 1 ];
  var line = [ [ - 2, - 2, - 2 ], [ 2, 2, 2 ] ];
  var expected = true;

  line = _.plane.lineIntersects( plane, line );
  test.identical( expected, line );

  test.description = 'Line and Plane intersect'; //

  var plane = [ 1, 0 , - 1, 0 ];
  var line = [ [ 2, 2, 2 ], [ 3, 3, 3 ] ];
  var expected = true;

  line = _.plane.lineIntersects( plane, line );
  test.identical( expected, line );

  test.description = 'Line and Plane don´t intersect'; //

  var plane = [ 1, 0 , - 1, 0 ];
  var line = [ [ 2, 2, 3 ], [ 3, 3, 4 ] ];
  var expected = false;

  line = _.plane.lineIntersects( plane, line );
  test.identical( expected, line );

  test.description = 'Line in Plane'; //

  var plane = [ 1, 0 , 0, 0 ];
  var line = [ [ 0, 2, 3 ], [ 0, 5, 7 ] ];
  var expected = true;

  line = _.plane.lineIntersects( plane, line );
  test.equivalent( expected, line );

  test.description = 'Perpendicular line intersects'; //

  var plane = [ 1, 0 , 0, 0 ];
  var line = [ [ - 2, 2, 2 ], [ 2, 2, 2 ] ];
  var expected = true;

  line = _.plane.lineIntersects( plane, line );
  test.identical( expected, line );

  test.description = 'Perpendicular line touches plane'; //

  var plane = [ 1, 0 , 0, 0 ];
  var line = [ [ - 2, 2, 2 ], [ 0, 2, 2 ] ];
  var expected = true;

  line = _.plane.lineIntersects( plane, line );
  test.identical( expected, line );

  test.description = 'Perpendicular doesn´t intersect'; //

  var plane = [ 1, 0 , 0, 0 ];
  var line = [ [ - 2, 2, 2 ], [ - 1, 2, 2 ] ];
  var expected = false;

  line = _.plane.lineIntersects( plane, line );
  test.identical( expected, line );

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

function translate( test )
{

  test.description = 'Offset remains unchanged, plane changes'; //

  var plane = [ 1, 0 , 0, 1 ];
  var offset = [ 1, 0, 1 ];
  var oldOffset = [ 1, 0, 1 ];
  var expected = [ 1, 0, 0, 0 ];

  var newplane = _.plane.translate( plane, offset );
  test.identical( expected, newplane );
  test.identical( plane, newplane );
  test.identical( offset, oldOffset );

  test.description = 'No change (normal and offset are perpendicular)'; //

  var plane = [ 1, 0 , 0, 1 ];
  var offset = [ 0, 2, 3 ];
  var expected = [ 1, 0 , 0, 1 ];

  offset = _.plane.translate( plane, offset );
  test.identical( expected, offset );

  test.description = 'No change'; //

  var plane = [ 1, 0 , - 1, 0 ];
  var offset = [ 2, 2, 2 ];
  var expected = [ 1, 0 , - 1, 0 ];

  offset = _.plane.translate( plane, offset );
  test.identical( expected, offset );

  test.description = 'Trivial translation'; //

  var plane = [ 1, 0 , 0, 0 ];
  var offset = [ 3, 2, 3 ];
  var expected =  [ 1, 0 , 0, - 3 ];

  offset = _.plane.translate( plane, offset );
  test.equivalent( expected, offset );

  test.description = 'Negative offset'; //

  var plane = [ 1, 0 , 0, 0 ];
  var offset = [ - 3, - 2, - 3 ];
  var expected =  [ 1, 0 , 0, 3 ];

  offset = _.plane.translate( plane, offset );
  test.equivalent( expected, offset );

  test.description = 'More dimensions'; //

  var plane = [ 1, 0 , 0, 2, 3, 4, 0 ];
  var offset = [ - 2, - 2, - 2, 2, 2, 2 ];
  var expected = [ 1, 0 , 0, 2, 3, 4, -16 ];

  offset = _.plane.translate( plane, offset );
  test.identical( expected, offset );

  test.description = 'NaN offset'; //

  var plane = [ 1, 0 , 0, 0 ];
  var offset = [ NaN, NaN, NaN ];
  var expected =  [ 1, 0 , 0, NaN ];

  offset = _.plane.translate( plane, offset );
  test.equivalent( expected, offset );

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


function normalize( test )
{

  test.description = 'Plane changes'; //

  var plane = [ 2, 0 , 0, 1 ];
  var expected = [ 1, 0, 0, 0.5 ];

  var newplane = _.plane.normalize( plane );
  test.identical( expected, newplane );
  test.identical( plane, newplane );

  test.description = 'Trivial '; //

  var plane = [ 2, 0 , 0, 4 ];
  var expected =  [ 1, 0 , 0, 2 ];

  var result = _.plane.normalize( plane );
  test.equivalent( expected, result );

  test.description = 'Trivial'; //

  var plane = [ 2, 2 , 2, 4 ];
  var expected = [ 2/Math.sqrt( 12 ), 2/Math.sqrt( 12 ), 2/Math.sqrt( 12 ), 4/Math.sqrt( 12 ) ];

  result = _.plane.normalize( plane );
  test.equivalent( expected, result );

  test.description = 'Already normalized 1D'; //

  var plane = [ 1, 0 , 0, 3 ];
  var expected = [ 1, 0 , 0, 3 ];

  result = _.plane.normalize( plane );
  test.identical( expected, result );

  test.description = 'Already normalized'; //

  var plane = [ 1/Math.sqrt( 2 ), 1/Math.sqrt( 2 ), 0, 2/Math.sqrt( 2 ) ];
  var expected = [1/Math.sqrt( 2 ), 1/Math.sqrt( 2 ), 0, 2/Math.sqrt( 2 ) ];

  result = _.plane.normalize( plane );
  test.equivalent( expected, result );

  test.description = 'Negative coordinates'; //

  var plane = [ - 3, - 6 , 0, 8 ];
  var expected =  [ - 3/Math.sqrt( 45 ), - 6/Math.sqrt( 45 ) , 0, 8/Math.sqrt( 45 ) ];

  result = _.plane.normalize( plane );
  test.equivalent( expected, result );

  test.description = 'More dimensions'; //

  var plane = [ 4, 0 , 0, 4, 0, 4, 8 ];
  var expected = [ 4/Math.sqrt( 48 ), 0 , 0, 4/Math.sqrt( 48 ), 0, 4/Math.sqrt( 48 ), 8/Math.sqrt( 48 ) ];

  result = _.plane.normalize( plane );
  test.identical( expected, result );

  test.description = 'NaN result'; //

  var plane = [ NaN, NaN, NaN, NaN ];
  var expected =  [ NaN, NaN, NaN, NaN ];

  result = _.plane.normalize( plane );
  test.equivalent( expected, result );

  test.description = 'Plane  [ 0 ]'; //

  var plane = [ 0 ];
  var expected =  [ NaN ];

  result = _.plane.normalize( plane );
  test.equivalent( expected, result );

  test.description = 'Null coordinate'; //

  var plane = [ 1, null, 0, 0 ];
  var expected =  [ 1, 0, 0, 0 ];

  result = _.plane.normalize( plane );
  test.equivalent( expected, result );

  test.description = 'NaN coordinates'; //

  var plane = [ 1, NaN, 0, 0 ];
  var expected =  [ NaN, NaN, NaN, NaN ];

  result = _.plane.normalize( plane );
  test.equivalent( expected, result );

  test.description = 'String coordinates'; //

  var plane = [ 1, 'string', 0, 0 ];
  var expected =  [ NaN, NaN, NaN, NaN ];

  result = _.plane.normalize( plane );
  test.equivalent( expected, result );


  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.normalize( ));
  test.shouldThrowErrorSync( () => _.plane.normalize( [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.normalize( null ));
  test.shouldThrowErrorSync( () => _.plane.normalize( NaN ));
  test.shouldThrowErrorSync( () => _.plane.normalize( 'plane' ));

}


function negate( test )
{

  test.description = 'Zero'; //

  var plane = [ 0, 0 , 0, 0 ];
  var expected = [ 0, 0, 0, 0 ];

  var newplane = _.plane.negate( plane );
  test.identical( expected, newplane );
  test.identical( plane, newplane );

  test.description = 'Plane changes'; //

  var plane = [ 2, 0 , 0, 1 ];
  var expected = [ - 2, 0, 0, - 1 ];

  var newplane = _.plane.negate( plane );
  test.identical( expected, newplane );
  test.identical( plane, newplane );

  test.description = 'Trivial '; //

  var plane = [ 2, 0 , 0, 4 ];
  var expected =  [ - 2, 0 , 0, - 4 ];

  var result = _.plane.negate( plane );
  test.equivalent( expected, result );

  test.description = 'Trivial'; //

  var plane = [ 2, 2 , 2, 4 ];
  var expected = [ - 2, - 2, - 2, - 4 ];

  result = _.plane.negate( plane );
  test.equivalent( expected, result );

  test.description = 'Negate 1D'; //

  var plane = [ 1, 0 , 0, 3 ];
  var expected = [ - 1, 0 , 0, - 3 ];

  result = _.plane.negate( plane );
  test.identical( expected, result );

  test.description = 'Negate'; //

  var plane = [ 1/Math.sqrt( 2 ), 1/Math.sqrt( 2 ), 0, 2/Math.sqrt( 2 ) ];
  var expected = [ - 1/Math.sqrt( 2 ), - 1/Math.sqrt( 2 ), 0, - 2/Math.sqrt( 2 ) ];

  result = _.plane.negate( plane );
  test.equivalent( expected, result );

  test.description = 'Negative coordinates'; //

  var plane = [ - 3, - 6 , 0, 8 ];
  var expected =  [ 3, 6, 0, - 8 ];

  result = _.plane.negate( plane );
  test.equivalent( expected, result );

  test.description = 'More dimensions'; //

  var plane = [ 4, 0 , 0, 4, 0, 4, 8 ];
  var expected = [  - 4, 0 , 0, - 4, 0, - 4, - 8 ];

  result = _.plane.negate( plane );
  test.identical( expected, result );

  test.description = 'NaN result'; //

  var plane = [ NaN, NaN, NaN, NaN ];
  var expected =  [ NaN, NaN, NaN, NaN ];

  result = _.plane.negate( plane );
  test.equivalent( expected, result );

  test.description = 'Plane  [ 0 ]'; //

  var plane = [ 0 ];
  var expected =  [ 0 ];

  result = _.plane.negate( plane );
  test.equivalent( expected, result );

  test.description = 'Null coordinate'; //

  var plane = [ 1, null, 0, 0 ];
  var expected =  [ - 1, 0, 0, 0 ];

  result = _.plane.negate( plane );
  test.equivalent( expected, result );

  test.description = 'NaN coordinates'; //

  var plane = [ 1, NaN, 0, 0 ];
  var expected =  [ - 1, NaN, 0, 0 ];

  result = _.plane.negate( plane );
  test.equivalent( expected, result );

  test.description = 'String coordinates'; //

  var plane = [ 1, 'string', 0, 0 ];
  var expected =  [ - 1, NaN, 0, 0 ];

  result = _.plane.negate( plane );
  test.equivalent( expected, result );


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

// --
// define class
// --

var Self =
{

  name : 'Math.Plane',
  silencing : 1,
  // verbosity : 7,
  // debug : 1,
  routine: 'negate',

  tests :
  {

    from : from,
    fromNormalAndPoint : fromNormalAndPoint,
    fromPoints : fromPoints,
    pointDistance : pointDistance,
    pointCoplanarGet : pointCoplanarGet,

    sphereDistance : sphereDistance,

    lineIntersects : lineIntersects,

    //matrixHomogenousApply : matrixHomogenousApply,
    translate : translate,

    normalize : normalize,
    negate : negate,

  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
