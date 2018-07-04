if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var EulerSeqs = [ 'xyz', 'xzy', 'yxz', 'yzx', 'zxy', 'zyx', 'xyx', 'xzx', 'yxy', 'yzy', 'zxz', 'zyz' ];
var Angle = [ 0, Math.PI / 6, Math.PI / 4, Math.PI / 3 ];
var Accuracy =  1e-7;
var Delta = [ -0.1, -Math.sqrt( Accuracy ), -( Accuracy*Accuracy ), 0, +( Accuracy*Accuracy ), +Math.sqrt( Accuracy ), +0.1 ];

var angle0 = [ Angle[ 0 ], 2, Delta[ 0 ] ];
var angle1 = [ Angle[ 1 ], 2, Delta[ 0 ] ];
var angle2 = [ Angle[ 1 ], 2, Delta[ 0 ] ];

var seq0 = EulerSeqs[0];
var seq1 = EulerSeqs[1];
var seq2 = EulerSeqs[2];
var seq3 = EulerSeqs[3];
var seq4 = EulerSeqs[4];
var seq5 = EulerSeqs[5];
var seq6 = EulerSeqs[6];
var seq7 = EulerSeqs[7];
var seq8 = EulerSeqs[8];
var seq9 = EulerSeqs[9];
var seq10 = EulerSeqs[10];
var seq11 = EulerSeqs[11];

var e0 = _.euler.checkQuatRoutines( angle0, angle1, angle2, seq0 );
console.log('******************************   0:  ', e0);
var e0 = _.euler.checkQuatRoutines( angle0, angle1, angle2, seq1 );
console.log('******************************   0:  ', e0);
var e0 = _.euler.checkQuatRoutines( angle0, angle1, angle2, seq2 );
console.log('******************************   0:  ', e0);
var e0 = _.euler.checkQuatRoutines( angle0, angle1, angle2, seq3 );
console.log('******************************   0:  ', e0);
var e0 = _.euler.checkQuatRoutines( angle0, angle1, angle2, seq4 );
console.log('******************************   0:  ', e0);
var e0 = _.euler.checkQuatRoutines( angle0, angle1, angle2, seq5 );
console.log('******************************   0:  ', e0);
