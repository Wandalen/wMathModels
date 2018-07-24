if( typeof module !== 'undefined' )
require( 'wmathconcepts' );
var _ = wTools;

debugger;

//var representations = [ 'xyz', 'xzy', 'yxz', 'yzx', 'zxy', 'zyx' ];
var representations = [ 'yxz' ];
var deltas = [ -_.accuracySqrt ];
var angles = [ 0 ];
var quadrants = [ 1 ];
anglesLocked = [ Math.PI / 3 ];
quadrantsLocked = [ 0 ];
deltasLocked = [ 0 ];

var euler = _.euler.make();
var euler2 = _.euler.make();
var euler2bis = _.euler.make();
var matrix1 = _.Space.makeZero( [ 3, 3 ] );
var matrix2 = _.Space.makeZero( [ 3, 3 ] );
var quat = _.quat.make();
var quat2 = _.quat.make();

_.euler.representationSet( euler, representations[ 0 ] );
euler[ 0 ] = angles[ 0 ] + quadrants[ 0 ]*Math.PI/2 + deltas[ 0 ];
euler[ 1 ] = angles[ 0 ] + quadrants[ 0 ]*Math.PI/2 + deltas[ 0 ];
euler[ 2 ] = anglesLocked[ 0 ] + quadrantsLocked[ 0 ]*Math.PI/2 + deltasLocked[ 0 ];
euler2[ 3 ] = euler[ 3 ]; euler2[ 4 ] = euler[ 4 ]; euler2[ 5 ] = euler[ 5 ];
euler2bis[ 3 ] = euler[ 3 ]; euler2bis[ 4 ] = euler[ 4 ]; euler2bis[ 5 ] = euler[ 5 ];

quat= _.euler.toQuat2( euler, quat );
euler2bis = _.euler.fromQuat2( euler2bis, quat );
quat2= _.euler.toQuat2( euler2bis, quat2 );
logger.log( 'dstQuat - srcQuat :',quat[ 0 ] - quat2[ 0 ], quat[ 1 ] - quat2[ 1 ], quat[ 2 ] - quat2[ 2 ], quat[ 3 ] - quat2[ 3 ]  );

matrix1 = _.quat.toMatrix( quat, matrix1 );
quat2 = _.quat.fromMatrixRotation( quat2, matrix1 );

//euler2 = _.euler.fromQuat2( euler2, quat2bis );
//var euler2bis = _.euler.fromQuat2( euler2bis, quat );
//quat2= _.euler.toQuat2( euler2, quat2 );
//logger.log( 'dstQuat - srcQuat :',dstQuat[ 0 ] + srcQuat[ 0 ], dstQuat[ 1 ] + srcQuat[ 1 ], dstQuat[ 2 ] + srcQuat[ 2 ], dstQuat[ 3 ] + srcQuat[ 3 ]  );
logger.log( 'dstQuat - srcQuat :',quat[ 0 ] - quat2[ 0 ], quat[ 1 ] - quat2[ 1 ], quat[ 2 ] - quat2[ 2 ], quat[ 3 ] - quat2[ 3 ]  );
