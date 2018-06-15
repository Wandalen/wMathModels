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
  var expected = 1;

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
  var expected = 1;

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

// --
// define class
// --

var Self =
{

  name : 'Math.Plane',
  silencing : 1,
  // verbosity : 7,
  // debug : 1,

  tests :
  {

   from : from,
   fromNormalAndPoint : fromNormalAndPoint,
   fromPoints : fromPoints,
   pointDistance : pointDistance,
   pointCoplanarGet : pointCoplanarGet,

   sphereDistance : sphereDistance,

//   lineIntersects : lineIntersects,

//   matrixHomogenousApply : matrixHomogenousApply,
//   translate : translate,

//   normalize : normalize,
//   negate : negate,

  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
