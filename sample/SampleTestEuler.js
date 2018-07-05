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
  console.log('On Each');
  var expected = _.euler.toQuat2( euler );
  euler2 = _.euler.fromQuat2( expected, eulerEmpty  );
  if( euler2 === 0 ){ Z = Z + 1; console.log( 'zero' ); }
  else
  {
    var result = _.euler.toQuat2( euler2 );
    console.log(expected);
    console.log(result);
    var posDif0 = Math.abs( expected.eGet( 0 ) -  result.eGet( 0 ) );
    var posDif1 = Math.abs( expected.eGet( 1 ) -  result.eGet( 1 ) );
    var posDif2 = Math.abs( expected.eGet( 2 ) -  result.eGet( 2 ) );
    var posDif3 = Math.abs( expected.eGet( 3 ) -  result.eGet( 3 ) );
    var negDif0 = Math.abs( expected.eGet( 0 ) +  result.eGet( 0 ) );
    var negDif1 = Math.abs( expected.eGet( 1 ) +  result.eGet( 1 ) );
    var negDif2 = Math.abs( expected.eGet( 2 ) +  result.eGet( 2 ) );
    var negDif3 = Math.abs( expected.eGet( 3 ) +  result.eGet( 3 ) );

    if( Math.abs( positiveR0 ) < 0.01 && Math.abs( positiveR1 ) < 0.01 && Math.abs( positiveR2 ) < 0.01 && Math.abs( positiveR3 ) < 0.01 )
    { console.log( 'TRUE ****************************************' ); T = T+1; }
    else if( Math.abs( negativeR0 ) < 0.01 && Math.abs( negativeR1 ) < 0.01 && Math.abs( negativeR2 ) < 0.01 && Math.abs( negativeR3 ) < 0.01 )
    {
      result.eSet( 0, - result.eGet( 0 ) );
      result.eSet( 1, - result.eGet( 1 ) );
      result.eSet( 2, - result.eGet( 2 ) );
      result.eSet( 3, - result.eGet( 3 ) );
      console.log('******** Changed to negative', result );
      T = T+1;
    }
    else
    { //console.log( 'FALSE', result,'   ',expected );
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
        euler[ 1 ] = Angle[ ang ] + Quadrant[ quad ]*Math.PI/2 + Delta[ d ];
        euler[ 2 ] = Angle[ ang ] + Quadrant[ quad ]*Math.PI/2 + Delta[ d ];
        var eulerEmpty = _.euler.make2( null, seq );
        onEach( euler, eulerEmpty );
      }
    }
  }
}


console.log( 'Z = ', Z);
console.log( 'T = ', T);
console.log( 'F = ', F);
