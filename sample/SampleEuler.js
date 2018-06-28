if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;


var matrix =  _.Space.make( [ 3, 3 ] ).copy(
     [ 1, 0, 1,
       1, 1, 0,
       0, 1, 1 ] );

var dstXYZ = [ 0, 0, 0, 0, 1, 2 ];
//var euler2 = _.euler.fromMatrix2( matrix, dstXYZ );
//console.log( 'Euler from mat xyz:', euler2 );

var srcXYZ = [ 0, 1.570796327, 0, 0, 1, 2 ];
var srcXZY = [ 0, 1.570796327, 0, 0, 2, 1 ];
var srcXYX = [ 1, 0.5, 0.5, 0, 1, 0 ];
var srcXZX = [ 1, 0.5, 0.5, 0, 2, 0 ];
var srcYXZ = [ 1, 0.5, 0.5, 1, 0, 2 ];
var srcYZX = [ 1, 0.5, 0.5, 1, 2, 0 ];
var srcYXY = [ 1, 0.5, 0.5, 1, 0, 1 ];
var srcYZY = [ 1, 0.5, 0.5, 1, 2, 1 ];
var srcZYX = [ 1, 0.5, 0.5, 2, 1, 0 ];
var srcZXY = [ 1, 0.5, 0.5, 2, 0, 1 ];
var srcZXZ = [ 1, 0.5, 0.5, 2, 0, 2 ];
var srcZYZ = [ 1, 0.5, 0.5, 2, 1, 2 ];
var quat = _.euler.toQuat2( srcXYZ );
var euler = _.euler.fromQuat2( quat, srcXYZ );
console.log( 'euler from quat XYZ :',  euler  );
var quat = _.euler.toQuat2( srcXZY );
var euler = _.euler.fromQuat2( quat, srcXZY );
console.log( 'euler from quat XZY :', _.vector.toArray( euler.slice() ) );
var quat = _.euler.toQuat2( srcYXZ );
var euler = _.euler.fromQuat2( quat, srcYXZ );
console.log( 'euler from quat YXZ :', _.vector.toArray( euler.slice() ) );
var quat = _.euler.toQuat2( srcYZX );
var euler = _.euler.fromQuat2( quat, srcYZX );
console.log( 'euler from quat YZX :', _.vector.toArray( euler.slice() ) );
var quat = _.euler.toQuat2( srcZXY );
var euler = _.euler.fromQuat2( quat, srcZXY );
console.log( 'euler from quat ZXY :', _.vector.toArray( euler.slice() ) );
var quat = _.euler.toQuat2( srcZYX );
console.log( 'QUAT ZYX :', _.vector.toArray( quat ) );
var euler = _.euler.fromQuat2( quat, srcZYX );
console.log( 'euler from quat ZYX :', _.vector.toArray( euler.slice() ) );
var quat = _.euler.toQuat2( srcXYX );
var euler = _.euler.fromQuat2( quat, srcXYX );
console.log( 'euler from quat XYX :', _.vector.toArray( euler.slice() ) );
var quat = _.euler.toQuat2( srcXZX );
var euler = _.euler.fromQuat2( quat, srcXZX );
console.log( 'euler from quat XZX :', _.vector.toArray( euler.slice() ) );
var quat = _.euler.toQuat2( srcYXY );
var euler = _.euler.fromQuat2( quat, srcYXY );
console.log( 'euler from quat YXY :', _.vector.toArray( euler.slice() ) );
var quat = _.euler.toQuat2( srcYZY );
var euler = _.euler.fromQuat2( quat, srcYZY );
console.log( 'euler from quat YZY :', _.vector.toArray( euler.slice() ) );
var quat = _.euler.toQuat2( srcZXZ );
var euler = _.euler.fromQuat2( quat, srcZXZ );
console.log( 'euler from quat ZXZ :', _.vector.toArray( euler.slice() ) );
var quat = _.euler.toQuat2( srcZYZ );
var euler = _.euler.fromQuat2( quat, srcZYZ );
console.log( 'euler from quat ZYZ :', _.vector.toArray( euler.slice() ) );
