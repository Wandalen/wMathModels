( function _Plane_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  //

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
  var bias = 1
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
//   fromNormalAndPoint : fromNormalAndPoint,
//   fromPoints : fromPoints,
//   pointDistance : pointDistance,
//   pointCoplanarGet : pointCoplanarGet,

//   sphereDistance : sphereDistance,

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
