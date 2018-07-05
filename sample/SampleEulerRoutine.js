if( typeof module !== 'undefined' )
require( 'wmathconcepts' );
require( 'wTesting' );

var _ = wTools;

var EulerSeqs = [ 'xyz', 'xzy', 'yxz', 'yzx', 'zxy', 'zyx', 'xyx', 'xzx', 'yxy', 'yzy', 'zxz', 'zyz' ];
var Angle = [ 0, Math.PI / 6, Math.PI / 4, Math.PI / 3 ];
var Quadrant = [ 0, 1, 2 ];
var accuracy =  1e-7;
var Delta = [ -0.1, -Math.sqrt( accuracy ), -( accuracy*accuracy ), 0, +( accuracy*accuracy ), +Math.sqrt( accuracy ), +0.1 ];
var euler = [ 0, 0, 0, 0, 0, 0 ];

function onEach( euler)
{
  var dstEuler = euler.slice();
  dstEuler[ 0 ] = 0;
  dstEuler[ 1 ] = 0;
  dstEuler[ 2 ] = 0;
  var expected = _.euler.toQuat2( euler );
  var euler2 = _.euler.fromQuat2( expected, dstEuler );
  var result = _.euler.toQuat2( euler2 );

  var expected = _.vector.toArray( expected );
  var positiveResult = _.vector.toArray( result );
  var negativeResult = _.avector.mul( _.vector.toArray( result ), -1 );
  var eq1 = _.entityEquivalent( positiveResult, expected);
  var eq2 = _.entityEquivalent( negativeResult, expected );
  if ( eq1 === 'true' || eq2 === 'true')
  {
    console.log(eq1,eq2);
  }
  else
  {
    console.log('FALSE');
  }
  //test.is( eq1 || eq2 );
}

function onEach1( euler )
{
  var dstEuler = euler.slice();
  dstEuler[ 0 ] = 0;
  dstEuler[ 1 ] = 0;
  dstEuler[ 2 ] = 0;
  var expected = _.euler.toQuat2( euler );
  euler2 = _.euler.fromQuat2( expected, dstEuler );
  var result = _.euler.toQuat2( euler2 );
  var posDif0 = Math.abs( expected.eGet( 0 ) -  result.eGet( 0 ) );
  var posDif1 = Math.abs( expected.eGet( 1 ) -  result.eGet( 1 ) );
  var posDif2 = Math.abs( expected.eGet( 2 ) -  result.eGet( 2 ) );
  var posDif3 = Math.abs( expected.eGet( 3 ) -  result.eGet( 3 ) );
  var negDif0 = Math.abs( expected.eGet( 0 ) +  result.eGet( 0 ) );
  var negDif1 = Math.abs( expected.eGet( 1 ) +  result.eGet( 1 ) );
  var negDif2 = Math.abs( expected.eGet( 2 ) +  result.eGet( 2 ) );
  var negDif3 = Math.abs( expected.eGet( 3 ) +  result.eGet( 3 ) );

  if( posDif0 < accuracy && posDif1 < accuracy && posDif2 < accuracy && posDif3 < accuracy )
  { console.log('TRUE'); }
  else if( negDif0 < accuracy && negDif1 < accuracy && negDif2 < accuracy && negDif3 < accuracy )
  { console.log('TRUE'); }
  else
  { console.log('FALSE'); }
}

euler[ 0 ] = Angle[ 1 ] + Quadrant[ 0 ]*Math.PI/2 + Delta[ 1 ];
euler[ 1 ] = Angle[ 3 ] + Quadrant[ 1 ]*Math.PI/2 + Delta[ 3 ];
euler[ 2 ] = Angle[ 3 ] + Quadrant[ 1 ]*Math.PI/2 + Delta[ 3 ];
euler[ 3 ] = 0;
euler[ 4 ] = 1;
euler[ 5 ] = 2;

onEach( euler );

onEach1( euler );
