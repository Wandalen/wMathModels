if( typeof module !== 'undefined' )
require( 'wmathconcepts' );
require( 'wTesting' );

var _ = wTools;

var EulerSeqs = [ 'xyz', 'xzy', 'yxz', 'yzx', 'zxy', 'zyx', 'xyx', 'xzx', 'yxy', 'yzy', 'zxz', 'zyz' ];
var Angle = [ 0, Math.PI / 6, Math.PI / 4, Math.PI / 3 ];
var Quadrant = [ 0, 1, 2, 3 ];
var Delta = [ -0.1, -Math.sqrt( _.EPS ), -( _.EPS2 ), 0, +( _.EPS2 ), +Math.sqrt( _.EPS ), +0.1 ];
var euler = [ 0, 0, 0, 0, 0, 0 ];
euler[ 0 ] = Angle[ 3 ] + Quadrant[ 1 ]*Math.PI/2 + Delta[ 6 ];
euler[ 1 ] = Angle[ 0 ] + Quadrant[ 2 ]*Math.PI/2 + Delta[ 2 ];
euler[ 2 ] = Angle[ 0 ] + Quadrant[ 1 ]*Math.PI/2 + Delta[ 2 ];
euler[ 3 ] = 2; euler[ 4 ] = 1; euler[ 5 ] = 0;
console.log( 'Euler : ' );
console.log( euler[ 0 ],euler[ 1 ],euler[ 2 ], euler[ 3 ],euler[ 4 ],euler[ 5 ] );

var dstEuler = euler.slice();
dstEuler[ 0 ] = 0; dstEuler[ 1 ] = 0; dstEuler[ 2 ] = 0;


var expected = _.euler.toQuat2( euler );
var euler2 = _.euler.fromQuat2( expected, dstEuler );
console.log( 'Euler2:', euler2[ 0 ],euler2[ 1 ],euler2[ 2 ], euler2[ 3 ],euler2[ 4 ],euler2[ 5 ] );
var result = _.euler.toQuat2( euler2 );

var positiveResult = result.slice();
var negativeResult = _.avector.mul( result , -1 );
var expected = _.vector.toArray( expected );
console.log( 'Quat1:', expected[ 0 ],' ',expected[ 1 ],' ',expected[ 2 ], expected[ 3 ] );
//console.log( 'Quat2:', positiveResult[ 0 ],' ',positiveResult[ 1 ],' ',positiveResult[ 2 ], positiveResult[ 3 ]);
console.log( 'Quat2:', negativeResult[ 0 ],' ',negativeResult[ 1 ],' ',negativeResult[ 2 ], negativeResult[ 3 ]);
var eq1 = _.entityEquivalent( positiveResult, expected, { accuracy : _.EPS }  );
var eq2 = _.entityEquivalent( negativeResult, expected, { accuracy : _.EPS }  );

console.log( eq1, eq2 );
