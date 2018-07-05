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
        console.log( 'Euler : ', euler );
        var expected = _.euler.toQuat2( euler );
        var euler2 = _.euler.make2( null, seq );
        euler2 = _.euler.fromQuat2( expected, euler2  );
        console.log( 'Euler2 : ', euler2 );
        if( euler2 === 0 ){ Z = Z + 1; console.log( 'zero' ); }
        else
        {
          var result = _.euler.toQuat2( euler2 );
          var positiveR0 = expected[ 0 ] - result[ 0 ];
          var positiveR1 = expected[ 1 ] - result[ 1 ];
          var positiveR2 = expected[ 2 ] - result[ 2 ];
          var positiveR3 = expected[ 3 ] - result[ 3 ];
          var negativeR0 = expected[ 0 ] + result[ 0 ];
          var negativeR1 = expected[ 1 ] + result[ 1 ];
          var negativeR2 = expected[ 2 ] + result[ 2 ];
          var negativeR3 = expected[ 3 ] + result[ 3 ];

          if( Math.abs( positiveR0 ) < 0.01 &&
              Math.abs( positiveR1 ) < 0.01 &&
              Math.abs( positiveR2 ) < 0.01 &&
              Math.abs( positiveR3 ) < 0.01 )
          { console.log( 'TRUE ****************************************' ); T = T+1; }
          else if( expected[ 0 ] + result[ 0 ] <= 0.01 &&
                   expected[ 0 ] + result[ 0 ] <= 0.01 &&
                   expected[ 0 ] + result[ 0 ] <= 0.01 &&
                   expected[ 0 ] + result[ 0 ] <= 0.01 )
          {
            console.log('***************** Positive   ', result );
            result[ 0 ] = - result[ 0 ];
            result[ 1 ] = - result[ 1 ];
            result[ 2 ] = - result[ 2 ];
            result[ 3 ] = - result[ 3 ];
            console.log('******** Changed to negative', result );
          }
          else
          { //console.log( 'FALSE', result,'   ',expected );
          F = F +1; }
        }
      }
    }
  }
}

console.log( 'Z = ', Z);
console.log( 'T = ', T);
console.log( 'F = ', F);
