if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var numXYZ = [ 0, 1, 2 ];
var numXZY = [ 0, 2, 1 ];
var txtXYZ = 'xyz';
var txtYZY = 'yzy';
var dstXYZ = [ 0, 0, 0, 0, 1, 2 ];
var dstXZY = [ 0, 0, 0, 0, 2, 1 ];
var dstYXZ = [ 0, 0, 0, 1, 0, 2 ];
var dstYZX = [ 0, 0, 0, 1, 2, 0 ];
var dstZXY = [ 0, 0, 0, 2, 0, 1 ];
var dstZYX = [ 0, 0, 0, 2, 1, 0 ];
var dstXYX = [ 0, 0, 0, 0, 1, 0 ];
var dstXZX = [ 0, 0, 0, 0, 2, 0 ];
var dstYXY = [ 0, 0, 0, 1, 0, 1 ];
var dstYZY = [ 0, 0, 0, 1, 2, 1 ];
var dstZXZ = [ 0, 0, 0, 2, 0, 2 ];
var dstZYZ = [ 0, 0, 0, 2, 1, 2 ];

debugger;

var euler1 = _.euler.make();
var euler2 = _.euler.make();
var matrix1 = _.Space.makeZero( [ 3, 3 ] );
var matrix2 = _.Space.makeZero( [ 3, 3 ] );
var quat1 = _.quat.make();
var quat2 = _.quat.make();
var quat2b = _.quat.make();

euler1 =[ 0.0003, - 0.0003, 1.04719755, 2, 1, 2 ];
euler2[ 3 ] = euler1[ 3 ]; euler2[ 4 ] = euler1[ 4 ]; euler2[ 5 ] = euler1[ 5 ];

quat1 = _.euler.toQuat2( euler1, quat1 );
console.log( 'quat1:',quat1[ 0 ], quat1[ 1 ], quat1[ 2 ], quat1[ 3 ] );
matrix1 = _.quat.toMatrix( quat1, matrix1 );
euler2 = _.euler.fromMatrix2( euler2, matrix1 );
matrix2 = _.euler.toMatrix2( matrix2, euler2 );
quat2 = _.quat.fromMatrixRotation( quat2, matrix2 );


console.log( 'quat2:',quat2[ 0 ], quat2[ 1 ], quat2[ 2 ], quat2[ 3 ] );
