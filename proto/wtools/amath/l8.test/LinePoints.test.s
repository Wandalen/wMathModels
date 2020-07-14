( function _LinePoints_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );
  _.include( 'wMathVector' );
  _.include( 'wMathMatrix' );

  require( '../l8/Concepts.s' );

}

//

var _ = _global_.wTools.withDefaultLong.Fx;
var Matrix = _.Matrix;
var vector = _.vectorAdapter;
var vec = _.vectorAdapter.fromArray;
var avector = _.avector;
var sqrt = _.math.sqrt;
var Parent = wTester;

_.assert( _.routineIs( sqrt ) );

// --
// test
// --


function make( test )
{

  test.case = 'pair 2D'; //

  var dim = 2;
  var gotPair = _.linePoints.make( dim );

  var expected = _.linePoints.tools.longMake( [ 0, 0, 0, 0 ] );
  test.identical( gotPair, expected );

  /* */

  if( !Config.debug )
  return;

  var vertices = 3;

  test.shouldThrowErrorSync( () => _.linePoints.make( dim, vertices, vertices ));
  test.shouldThrowErrorSync( () => _.linePoints.make( null, vertices ));
  test.shouldThrowErrorSync( () => _.linePoints.make( NaN, vertices ));
  test.shouldThrowErrorSync( () => _.linePoints.make( undefined, vertices ));
  test.shouldThrowErrorSync( () => _.linePoints.make( 'dim', vertices ));
  test.shouldThrowErrorSync( () => _.linePoints.make( [ 3 ], vertices ));
  test.shouldThrowErrorSync( () => _.linePoints.make( dim, null ));
  test.shouldThrowErrorSync( () => _.linePoints.make( dim, NaN ));
  test.shouldThrowErrorSync( () => _.linePoints.make( dim, undefined ));
  test.shouldThrowErrorSync( () => _.linePoints.make( dim, 'vertices' ));
  test.shouldThrowErrorSync( () => _.linePoints.make( dim, [ 3 ] ));
  test.shouldThrowErrorSync( () => _.linePoints.make( 1, 3 ));
  test.shouldThrowErrorSync( () => _.linePoints.make( 4, 3 ));
  test.shouldThrowErrorSync( () => _.linePoints.make( 2, 2 ));

}

//


function from( test )
{
  /* */

  test.case = 'Same instance returned - array';

  var srcPair = [ 0, 0, 1 , 1, 2, 0 ];
  var expected = _.linePoints.tools.longMake( [ 0, 0, 1, 1, 2, 0 ] );

  var gotPair = _.linePoints.from( srcPair );
  test.identical( gotPair, expected );
  test.is( srcPair === gotPair );

  var srcPair = null;
  var expected = _.linePoints.tools.longMake( [ 0, 0, 0, 0 ] );

  var gotPair = _.linePoints.from( srcPair );
  test.identical( gotPair, expected );
  test.is( srcPair !== gotPair );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.linePoints.from( ));
  test.shouldThrowErrorSync( () => _.linePoints.from( [] ));
  test.shouldThrowErrorSync( () => _.linePoints.from( [ 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.linePoints.from( [ 0, 0, 0, 0 ], [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.linePoints.from( 'pair' ));
  test.shouldThrowErrorSync( () => _.linePoints.from( NaN ));
  test.shouldThrowErrorSync( () => _.linePoints.from( undefined ));
}

//

function is( test )
{

  test.is( _.linePoints.is( [ 0, 0, 0, 0 ] ) );
  test.is( _.linePoints.is( [ 0, 0, 1, 1, 2, 0 ] ) );

  //

  test.is( !_.linePoints.is( [ 0, 0, 1, 1, 2, 0, 0 ] ) );
  test.is( !_.linePoints.is( null ) );
  test.is( !_.linePoints.is( NaN ) );
  test.is( !_.linePoints.is( undefined ) );
  test.is( !_.linePoints.is( 'polygon' ) );
  test.is( !_.linePoints.is( [ 3 ] ) );
  test.is( !_.linePoints.is( 3 ) );

}

//

function fromRay( test )
{
  var src = [ 0, 0, 1, 1 ]
  var got = _.linePoints.fromRay( src );
  var expected = _.linePoints.tools.longMake( [ 0,0, 1,1 ] );
  test.identical( got, expected );
  test.is( got !== src );

  var src = [ 1, 1, 1, 1 ]
  var got = _.linePoints.fromRay( src );
  var expected = _.linePoints.tools.longMake([ 1, 1, 2, 2 ] );
  test.identical( got, expected );
  test.is( got !== src );
}

//

function pairAt( test )
{
  var src = [ 1, 1, 5, 5 ]
  var got = _.linePoints.pairAt( src, 0.25 );
  var expected = _.linePoints.tools.vectorAdapter.fromLong( [ 2, 2 ] );
  test.identical( got, expected );
  test.is( got !== src );

  var src = [ 1, 1, 5, 5 ]
  var got = _.linePoints.pairAt( src, 0.5 );
  var expected = _.linePoints.tools.vectorAdapter.fromLong( [ 3, 3 ] );
  test.identical( got, expected );
  test.is( got !== src );

  var src = [ 1, 1, 5, 5 ]
  var got = _.linePoints.pairAt( src, 0 );
  var expected = _.linePoints.tools.vectorAdapter.fromLong( [ 1, 1 ] );
  test.identical( got, expected );
  test.is( got !== src );

  var src = [ 1, 1, 5, 5 ]
  var got = _.linePoints.pairAt( src, 1 );
  var expected = _.linePoints.tools.vectorAdapter.fromLong( [ 5, 5 ] );
  test.identical( got, expected );
  test.is( got !== src );

}

//

function pairPairParallel( test )
{
  test.case = '2d parallel'
  var pair1 = _.linePoints.fromRay( [ 0, 0, 1, 1 ] );
  var pair2 = _.linePoints.fromRay( [ 3, 7, - 2, - 2 ] );
  var expected = true;

  var got = _.linePoints.pairPairParallel( pair1, pair2 );
  test.identical( got, expected )

  test.case = '2d not parallel'

  var pair1 = _.linePoints.fromRay( [ 3, 7, 1, - 1 ] );
  var pair2 = _.linePoints.fromRay( [ 3, 7, 7, 7 ]);
  var expected = false;

  var got = _.linePoints.pairPairParallel( pair1, pair2 );
  test.identical( got, expected )

}

//

function pairIntersectionFactors( test )
{
  /* */

  test.case = 'Rays don´t intersect';

  var pair1 = _.linePoints.fromRay( [ 0, 0, 1, 1 ] );
  var pair2 = _.linePoints.fromRay( [ 3, 0, 2, -1 ] );
  var expected = 0;

  var got = _.linePoints.pairIntersectionFactors( pair1, pair2 );
  test.identical( got, expected )

  /* */

  test.case = 'Rays intersect in their origin';

  var pair1 = _.linePoints.fromRay( [ 3, 7, 1, 0 ] );
  var pair2 = _.linePoints.fromRay( [ 3, 7, 0, 1  ] );
  var expected = _.linePoints.tools.vectorAdapter.from( [ 0, 0 ] );

  var got = _.linePoints.pairIntersectionFactors( pair1, pair2 );
  test.identical( got, expected )

  /* */

  test.case = 'Rays intersect ';

  var pair1 = _.linePoints.fromRay( [ 0, 0, 1, 0 ] );
  var pair2 = _.linePoints.fromRay( [ -2, -6, 1, 2 ] );
  var expected = _.linePoints.tools.vectorAdapter.from( [ 1, 3 ] );

  var got = _.linePoints.pairIntersectionFactors( pair1, pair2 );
  test.identical( got, expected )

  /* */

  test.case = 'Rays are perpendicular ';

  var pair1 = _.linePoints.fromRay( [ -3, 0, 1, 0 ] );
  var pair2 = _.linePoints.fromRay( [ 0, -2, 0, 1 ] );
  var expected = _.linePoints.tools.vectorAdapter.from( [ 3, 2 ] );

  var got = _.linePoints.pairIntersectionFactors( pair1, pair2 );
  test.identical( got, expected )
}

//

function pairIntersectionPoint( test )
{
  /* */

  test.case = 'Parellel';

  var pair1 = _.linePoints.fromRay( [ 0, 0, 1, 1 ] );
  var pair2 = _.linePoints.fromRay( [ 3, 7, 1, 1 ] );
  var expected = 0

  var got = _.linePoints.pairIntersectionPoint( pair1, pair2 );
  test.identical( got, expected )

  /* */

  test.case = 'Same';

  var pair1 = _.linePoints.fromRay( [ 0, 0, 1, 1 ] );
  var pair2 = _.linePoints.fromRay( [ 0, 0, 1, 1 ] );
  var expected = _.linePoints.tools.longMake( [ 0, 0 ] );

  var got = _.linePoints.pairIntersectionPoint( pair1, pair2 );
  test.identical( got, expected )

  /* */

  test.case = 'Rays intersect in their origin';

  var pair1 = _.linePoints.fromRay( [ 3, 7, 1, 0 ] );
  var pair2 = _.linePoints.fromRay( [ 3, 7, 0, 1 ] );
  var expected = _.linePoints.tools.longMake( [ 3, 7 ] );

  var got = _.linePoints.pairIntersectionPoint( pair1, pair2 );
  test.identical( got, expected )

  /* */

  test.case = 'Rays intersect';

  var pair1 = _.linePoints.fromRay( [ 0, 0, 1, 0 ] );
  var pair2 = _.linePoints.fromRay( [ -2, -6, 1, 2 ] );
  var expected = _.linePoints.tools.longMake( [ 1, 0 ] );

  var got = _.linePoints.pairIntersectionPoint( pair1, pair2 );
  test.identical( got, expected )

}

//

function pairIntersectionPointAccurate( test )
{
  /* */

  test.case = 'Parellel';

  var pair1 = _.linePoints.fromRay( [ 0, 0, 1, 1 ] );
  var pair2 = _.linePoints.fromRay( [ 3, 7, 1, 1 ] );
  var expected = 0

  var got = _.linePoints.pairIntersectionPointAccurate( pair1, pair2 );
  test.identical( got, expected )

  /* */

  test.case = 'Same';

  var pair1 = _.linePoints.fromRay( [ 0, 0, 1, 1 ] );
  var pair2 = _.linePoints.fromRay( [ 0, 0, 1, 1 ] );
  var expected = _.linePoints.tools.longMake( [ 0, 0 ] );

  var got = _.linePoints.pairIntersectionPointAccurate( pair1, pair2 );
  test.identical( got, expected )

  /* */

  test.case = 'Rays intersect in their origin';

  var pair1 = _.linePoints.fromRay( [ 3, 7, 1, 0 ] );
  var pair2 = _.linePoints.fromRay( [ 3, 7, 0, 1 ] );
  var expected = _.linePoints.tools.longMake( [ 3, 7 ] );

  var got = _.linePoints.pairIntersectionPointAccurate( pair1, pair2 );
  test.identical( got, expected )

  /* */

  test.case = 'Rays intersect';

  var pair1 = _.linePoints.fromRay( [ 0, 0, 1, 0 ] );
  var pair2 = _.linePoints.fromRay( [ -2, -6, 1, 2 ] );
  var expected = _.linePoints.tools.longMake( [ 1, 0 ] );

  var got = _.linePoints.pairIntersectionPointAccurate( pair1, pair2 );
  test.identical( got, expected )

}

//

// --
// declare
// --

var Self =
{

  name : 'Tools/Math/LinePoints',
  silencing : 1,
  enabled : 1,
  // verbosity : 7,
  // debug : 1,

  tests :
  {
    make,
    is,
    from,

    fromRay,

    pairAt,

    pairPairParallel,
    pairIntersectionFactors,
    pairIntersectionPoint,
    pairIntersectionPointAccurate
  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
