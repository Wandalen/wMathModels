if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var EulerSeqs = [ 'xyz', 'xzy', 'yxz', 'yzx', 'zxy', 'zyx', 'xyx', 'xzx', 'yxy', 'yzy', 'zxz', 'zyz' ];
var Angle = [ 0, Math.PI / 6, Math.PI / 4, Math.PI / 3 ];
var Quadrant = [ 0, 1, 2, 3 ];
var Accuracy =  1e-7;
var Delta = [ -0.1, -Math.sqrt( Accuracy ), -( Accuracy*Accuracy ), 0, +( Accuracy*Accuracy ), +Math.sqrt( Accuracy ), +0.1 ];

var T = 0;
var F = 0;
var Z = 0;

function onEach( euler, eulerEmpty )
{
  var dstEuler = euler.slice();
  dstEuler[ 0 ] = 0;
  dstEuler[ 1 ] = 0;
  dstEuler[ 2 ] = 0;
  var expected = _.euler.toQuat2( euler );
  euler2 = _.euler.fromQuat2( expected, dstEuler );
  if( euler2 === 0 ){ Z = Z + 1; console.log( 'zero' ); console.log('expected :',expected); console.log(' euler : ',euler); }
  else
  {
    var result = _.euler.toQuat2( euler2 );
    var posDif0 = Math.abs( expected.eGet( 0 ) -  result.eGet( 0 ) );
    var posDif1 = Math.abs( expected.eGet( 1 ) -  result.eGet( 1 ) );
    var posDif2 = Math.abs( expected.eGet( 2 ) -  result.eGet( 2 ) );
    var posDif3 = Math.abs( expected.eGet( 3 ) -  result.eGet( 3 ) );
    var negDif0 = Math.abs( expected.eGet( 0 ) +  result.eGet( 0 ) );
    var negDif1 = Math.abs( expected.eGet( 1 ) +  result.eGet( 1 ) );
    var negDif2 = Math.abs( expected.eGet( 2 ) +  result.eGet( 2 ) );
    var negDif3 = Math.abs( expected.eGet( 3 ) +  result.eGet( 3 ) );

    if( posDif0 < 0.01 && posDif1 < 0.01 && posDif2 < 0.01 && posDif3 < 0.01 )
    { T = T+1; }
    else if( negDif0 < 0.01 && negDif1 < 0.01 && negDif2 < 0.01 && negDif3 < 0.01 )
    {
      result.eSet( 0, - result.eGet( 0 ) );
      result.eSet( 1, - result.eGet( 1 ) );
      result.eSet( 2, - result.eGet( 2 ) );
      result.eSet( 3, - result.eGet( 3 ) );
      T = T+1;
    }
    else
    {
      console.log( 'FALSE' );
      console.log(expected);
      console.log(euler);
      console.log(result);

      F = F +1; }
    }
}

for( var i = 0; i < EulerSeqs.length; i++ )
{
  var seq = EulerSeqs[ i ];
  var euler = _.euler.make2( euler, seq );
  for( var ang = 0; ang < Angle.length; ang++ )
  {
    for( var quad = 0; quad < Quadrant.length; quad++ )
    {
      for( var d = 0; d < Delta.length; d++ )
      {
        euler[ 0 ] = Angle[ ang ] + Quadrant[ quad ]*Math.PI/2 + Delta[ d ];
        for( var ang2 = 0; ang2 < Angle.length; ang2++ )
        {
          for( var quad2 = 0; quad2 < Quadrant.length; quad2++ )
          {
            for( var d2 = 0; d2 < Delta.length; d2++ )
            {
              euler[ 1 ] = Angle[ ang2 ] + Quadrant[ quad2 ]*Math.PI/2 + Delta[ d2 ];
              euler[ 2 ] = Angle[ ang2 ] + Quadrant[ quad2 ]*Math.PI/2 + Delta[ d2 ];
              var eulerEmpty = _.euler.make2( null, seq );
              onEach( euler );
            }
          }
        }
      }
    }
  }
}


console.log( 'Z = ', Z);
console.log( 'T = ', T);
console.log( 'F = ', F);
