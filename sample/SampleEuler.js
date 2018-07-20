if( typeof module !== 'undefined' )
require( 'wmathconcepts' );
var _ = wTools;

debugger;

var euler1 = _.euler.make();
var euler2 = _.euler.make();
var matrix1 = _.Space.makeZero( [ 3, 3 ] );
var srcQuat = _.quat.make();
var dstQuat = _.quat.make();

euler1 =[ 7.85366, 7.85429, 1.04719, 0, 1, 2];
euler2[ 3 ] = euler1[ 3 ]; euler2[ 4 ] = euler1[ 4 ]; euler2[ 5 ] = euler1[ 5 ];

// Case 1: - _.euler Conversion methods
srcQuat = _.euler.toQuat2( euler1, srcQuat );
matrix1 = _.euler.toMatrix2( matrix1, euler1 );
euler2 = _.euler.fromMatrix2( euler2, matrix1 );
dstQuat = _.euler.toQuat2( euler2, dstQuat );
logger.log( 'First case: Conversion methods _.euler.toMatrix2 and _.euler.fromMatrix2 ')
logger.log( 'dstQuat - srcQuat :',dstQuat[ 0 ] + srcQuat[ 0 ], dstQuat[ 1 ] + srcQuat[ 1 ], dstQuat[ 2 ] + srcQuat[ 2 ], dstQuat[ 3 ] + srcQuat[ 3 ]  );
logger.log( 'Low accuracy, so there is an accuracy problem in _.euler.ToMatrix2 or _.euler.fromMatrix2 ')
logger.log( );

// Case 2: - _.quat Conversion methods
srcQuat = _.euler.toQuat2( euler1, srcQuat );
matrix1 = _.quat.toMatrix( srcQuat, matrix1 );
dstQuat = _.quat.fromMatrixRotation( dstQuat, matrix1 );
logger.log( 'Second case: Conversion methods _.quat.toMatrix and _.euler.fromMatrix2 ')
logger.log( 'dstQuat - srcQuat :',dstQuat[ 0 ] - srcQuat[ 0 ], dstQuat[ 1 ] - srcQuat[ 1 ], dstQuat[ 2 ] - srcQuat[ 2 ], dstQuat[ 3 ] - srcQuat[ 3 ]  );
logger.log( 'High accuracy, _.quat conversion methods work fine ')
logger.log( );

// Case 3: - _.quat.toMatrix + _.euler.fromMatrix2
srcQuat = _.euler.toQuat2( euler1, srcQuat );
matrix1 = _.quat.toMatrix( srcQuat, matrix1 );
euler2 = _.euler.fromMatrix2( euler2, matrix1 );
dstQuat = _.euler.toQuat2( euler2, dstQuat );
logger.log( 'Third case: _.quat.toMatrix (working) and _.euler.fromMatrix2 (under test) ')
logger.log( 'dstQuat - srcQuat :',dstQuat[ 0 ] + srcQuat[ 0 ], dstQuat[ 1 ] + srcQuat[ 1 ], dstQuat[ 2 ] + srcQuat[ 2 ], dstQuat[ 3 ] + srcQuat[ 3 ]  );
logger.log( 'Low accuracy, _.euler.fromMatrix2 method has an accuracy problem ')
logger.log( );

// Case 4: - _.quat.fromMatrixRotation + _.euler.toMatrix2
srcQuat = _.euler.toQuat2( euler1, srcQuat );
matrix1 = _.euler.toMatrix2( matrix1, euler1 );
dstQuat = _.quat.fromMatrixRotation( dstQuat, matrix1 );
logger.log( 'Fourth case: Conversion methods _.euler.toMatrix2 (under test) and _.quat.fromMatrixRotation (working) ')
logger.log( 'dstQuat - srcQuat :',dstQuat[ 0 ] - srcQuat[ 0 ], dstQuat[ 1 ] - srcQuat[ 1 ], dstQuat[ 2 ] - srcQuat[ 2 ], dstQuat[ 3 ] - srcQuat[ 3 ]  );
logger.log( 'High accuracy, _.euler.toMatrix2 conversion methods work fine ')
logger.log( );
