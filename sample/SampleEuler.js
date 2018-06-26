if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;


var matrix =  _.Space.make( [ 3, 3 ] ).copy(
     [ 1, 0, 1,
       1, 1, 0,
       0, 1, 1 ] );

var dstXYZ = [ 0, 0, 0, 0, 1, 2 ];
var dstXZY = [ 0, 0, 0, 0, 2, 1 ];
var dstXYX = [ 0, 0, 0, 0, 1, 0 ];
var dstXZX = [ 0, 0, 0, 0, 2, 0 ];
var dstYXZ = [ 0, 0, 0, 1, 0, 2 ];
var dstYZX = [ 0, 0, 0, 1, 2, 0 ];
var dstYXY = [ 0, 0, 0, 1, 0, 1 ];
var dstYZY = [ 0, 0, 0, 1, 2, 1 ];
var dstZXY = [ 0, 0, 0, 2, 0, 1 ];
var dstZYX = [ 0, 0, 0, 2, 1, 0 ];
var dstZXZ = [ 0, 0, 0, 2, 0, 2 ];
var dstZYZ = [ 0, 0, 0, 2, 1, 2 ];
var euler2 = _.euler.fromMatrix2( matrix, dstXYZ );
console.log( 'Euler from mat xyz:', euler2 );
var euler2 = _.euler.fromMatrix2( matrix, dstXZY );
console.log( 'Euler from mat xzy:', euler2 );
var euler2 = _.euler.fromMatrix2( matrix, dstXYX );
console.log( 'Euler from mat xyx:', euler2 );
var euler2 = _.euler.fromMatrix2( matrix, dstXZX );
console.log( 'Euler from mat xzx:', euler2 );
var euler2 = _.euler.fromMatrix2( matrix, dstYXZ );
console.log( 'Euler from mat yxz:', euler2 );
var euler2 = _.euler.fromMatrix2( matrix, dstYZX );
console.log( 'Euler from mat yzx:', euler2 );
var euler2 = _.euler.fromMatrix2( matrix, dstYXY );
console.log( 'Euler from mat yxy:', euler2 );
var euler2 = _.euler.fromMatrix2( matrix, dstYZY );
console.log( 'Euler from mat yzy:', euler2 );
var euler2 = _.euler.fromMatrix2( matrix, dstZXY );
console.log( 'Euler from mat zxy:', euler2 );
var euler2 = _.euler.fromMatrix2( matrix, dstZYX );
console.log( 'Euler from mat zyx:', euler2 );
var euler2 = _.euler.fromMatrix2( matrix, dstZYZ );
var euler2 = _.euler.fromMatrix2( matrix, dstZXZ );
console.log( 'Euler from mat zxz:', euler2 );
console.log( 'Euler from mat zyz:', euler2 );


var matrix =  _.Space.make( [ 3, 3 ] ).copy(
     [ 0, 0, 1,
       0, 1, 0,
       -1, 0, 0 ] );

var dstZYX = [ 0, 0, 0, 2, 1, 0 ];
var euler2 = _.euler.fromMatrix2( matrix, dstZYX );
console.log( 'Euler from mat zyz (0, 1.5708, 0 ):', euler2 );

var matrix =  _.Space.make( [ 3, 3 ] ).copy(
     [ 0, 0, 1,
       0, - 1, 0,
       -1, 0, 0 ] );

var dstZYZ = [ 0, 0, 0, 2, 1, 2 ];
var euler2 = _.euler.fromMatrix2( matrix, dstZXZ );
console.log( 'Euler from mat zxz ( -3.14, - 1.5708, -3.14 ):', euler2 );
//var quat = [ 0, 0, 3, 3 ];
//var dstXYZ = [ 0, 0, 0, 0, 1, 2 ];
//var euler2 = _.euler.fromQuat2( quat, dstXYZ );
//console.log( 'Euler from quat :', euler2 );
