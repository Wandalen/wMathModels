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

euler[ 0 ] = Angle[ 1 ] + Quadrant[ 0 ]*Math.PI/2 + Delta[ 1 ];
euler[ 1 ] = Angle[ 3 ] + Quadrant[ 1 ]*Math.PI/2 + Delta[ 3 ];
euler[ 2 ] = Angle[ 3 ] + Quadrant[ 1 ]*Math.PI/2 + Delta[ 3 ];
euler[ 3 ] = 0; euler[ 4 ] = 1; euler[ 5 ] = 2;

var dstEuler = euler.slice();
dstEuler[ 0 ] = 0; dstEuler[ 1 ] = 0; dstEuler[ 2 ] = 0;

var expected = _.euler.toQuat2( euler );
var euler2 = _.euler.fromQuat2( expected, dstEuler );
var result = _.euler.toQuat2( euler2 );

var positiveResult = result.slice();
var negativeResult = _.avector.mul( result , -1 );
console.log( 'Expected : ', expected );
console.log( 'Positive Result : ', positiveResult );
var expected = _.vector.toArray( expected );
var eq1 = _.entityEquivalent( positiveResult, expected, { accuracy : 1e-3 }  );
console.log( 'Expected : ', expected );
console.log( 'Negative Result : ', negativeResult );
var eq2 = _.entityEquivalent( negativeResult, expected, { accuracy : 1e-3 }  );

console.log( eq1, eq2 );


var eq1 = _.entityEquivalent( [ 0.001, 0.00000003], [ 0.001, 0.00000002], { accuracy : 1e-3 }  );
console.log( eq1 );
