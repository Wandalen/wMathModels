if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var EulerSeqs = [ 'xyz', 'xzy', 'yxz', 'yzx', 'zxy', 'zyx', 'xyx', 'xzx', 'yxy', 'yzy', 'zxz', 'zyz' ];
var Angle = [ 0, Math.PI / 6, Math.PI / 4, Math.PI / 3 ];
var Accuracy =  1e-7;
var Delta = [ -0.1, -Math.sqrt( Accuracy ), -( Accuracy*Accuracy ), 0, +( Accuracy*Accuracy ), +Math.sqrt( Accuracy ), +0.1 ];

var angle0 = [ Angle[ 0 ], 0, Delta[ 0 ] ];
var angle1 = [ Angle[ 1 ], 1, Delta[ 2 ] ];
var angle2 = [ Angle[ 2 ], 2, Delta[ 2 ] ];

var seq0 = EulerSeqs[0];
var seq1 = EulerSeqs[1];


var e0 = _.euler.createEulerAngle( angle0, angle1, angle2, seq0 );
var e1 = _.euler.createEulerAngle( angle0, angle1, angle2, seq1 );
console.log( 'Euler from mat xyz:', e0);
console.log( 'Euler from mat xyz:', e1);
