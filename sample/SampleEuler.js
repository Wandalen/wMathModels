if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

debugger;

var euler1 = _.euler.make();
var euler2 = _.euler.make();
var matrix1 = _.Space.makeZero( [ 3, 3 ] );
var matrix2 = _.Space.makeZero( [ 3, 3 ] );
var quat1 = _.quat.make();
var quat2 = _.quat.make();

euler1 =[ 7.85366, 7.85429, 1.04719, 0, 2, 1 ]
euler2[ 3 ] = euler1[ 3 ]; euler2[ 4 ] = euler1[ 4 ]; euler2[ 5 ] = euler1[ 5 ];

quat1 = _.euler.toQuat2( euler1, quat1 );
console.log( 'quat1:',quat1[ 0 ], quat1[ 1 ], quat1[ 2 ], quat1[ 3 ] );
matrix1 = _.quat.toMatrix( quat1, matrix1 );
//console.log(matrix1);
euler2 = _.euler.fromMatrix2( euler2, matrix1 );
//console.log( 'euler2:', euler2[ 0 ], euler2[ 1 ], euler2[ 2 ], euler2[ 3 ], euler2[ 4 ], euler2[ 5 ] );
matrix2 = _.euler.toMatrix2( matrix2, euler2 );
//console.log(matrix2);
quat2 = _.quat.fromMatrixRotation( quat2, matrix2 );
console.log( 'quat2:',quat2[ 0 ], quat2[ 1 ], quat2[ 2 ], quat2[ 3 ] );
