if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var EulerSeqs = [ 'xyz', 'xzy', 'yxz', 'yzx', 'zxy', 'zyx', 'xyx', 'xzx', 'yxy', 'yzy', 'zxz', 'zyz' ];
var Angle = [ 0, Math.PI / 6, Math.PI / 4, Math.PI / 3 ];
var Quadrant = [ 0, 1, 2, 3 ];
var Accuracy =  1e-7;
var Delta = [ -0.1, -Math.sqrt( Accuracy ), -( Accuracy*Accuracy ), 0, +( Accuracy*Accuracy ), +Math.sqrt( Accuracy ), +0.1 ];

var expected = true;

for( var i = 0; i < EulerSeqs.length; i++ )
{
  var seq = EulerSeqs[ i ];
  for( var ang = 0; ang < Angle.length; ang++ )
  {
    for( var quad = 0; quad < Quadrant.length; quad++ )
    {
      for( var d = 0; d < Delta.length; d++ )
      {
        var angle0 = [ Angle[ ang ], Quadrant[ quad ], Delta[ d ] ];
        var angle1 = [ Angle[ ang ], Quadrant[ quad ], Delta[ d ] ];
        var angle2 = [ Angle[ ang ], Quadrant[ quad ], Delta[ d ] ];

        var result = _.euler.checkQuatRoutines( angle0, angle1, angle2, seq );
        if( result == false )
        {
          console.log(angle0, angle1, angle2, seq );

        }
      }
    }
  }
}
