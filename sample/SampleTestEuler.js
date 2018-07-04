if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var EulerSeqs = [ 'xyz', 'xzy', 'yxz', 'yzx', 'zxy', 'zyx', 'xyx', 'xzx', 'yxy', 'yzy', 'zxz', 'zyz' ];
var Angle = [ 0, Math.PI / 6, Math.PI / 4, Math.PI / 3 ];
var Accuracy =  1e-7;
var Delta = [ -0.1, -Math.sqrt( Accuracy ), -( Accuracy*Accuracy ), 0, +( Accuracy*Accuracy ), +Math.sqrt( Accuracy ), +0.1 ];

var a0 = Angle[ 0 ];
var a1 = Angle[ 1 ];
var a2 = Angle[ 2 ];
var a3 = Angle[ 3 ];
var d0 = Delta[ 1 ];
var d1 = Delta[ 3 ];
var d2 = Delta[ 5 ];
var n0 = 0;
var n1 = 1;
var n2 = 2;
var n3 = 3;
var seq0 = EulerSeqs[1];
var seq1 = EulerSeqs[3];
console.log(seq0,'   ',seq1);


var e0 = _.euler.createEulerAngle( a0, n0, d0, a1, n1, d1, a2, n2, d2, seq0 );
var e1 = _.euler.createEulerAngle( a3, n3, d2, a2, n2, d1, a1, n1, d0, seq1 );
console.log( 'Euler from mat xyz:', e0);
console.log( 'Euler from mat xyz:', e1);
