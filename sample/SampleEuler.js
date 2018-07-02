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

var srcXYZ = [ 0.5, 0.5, 0.5, 0, 1, 2 ];
var srcXZY = [ 0.5, 0.5, 0.5, 0, 2, 1 ];
var srcXYX = [ 0.5, 0.5, 0.5, 0, 1, 0 ];
var srcXZX = [ 0.5, 0.5, 0.5, 0, 2, 0 ];
var srcYXZ = [ 0.5, 0.5, 0.5, 1, 0, 2 ];
var srcYZX = [ 0.5, 0.5, 0.5, 1, 2, 0 ];
var srcYXY = [ 0.5, 0.5, 0.5, 1, 0, 1 ];
var srcYZY = [ 0.5, 0.5, 0.5, 1, 2, 1 ];
var srcZYX = [ 0.5, 0.5, 0.5, 2, 1, 0 ];
var srcZXY = [ 0.5, 0.5, 0.5, 2, 0, 1 ];
var srcZXZ = [ 0.5, 0.5, 0.5, 2, 0, 2 ];
var srcZYZ = [ 0.5, 0.5, 0.5, 2, 1, 2 ];
var quat = _.euler.toQuat2( srcZYX );
console.log( 'quat from euler ZYX :', _.vector.toArray( quat.slice() ) );
var euler = _.euler.fromQuat2( quat, srcZYX );
console.log( 'euler from quat ZYX :', _.vector.toArray( euler.slice() ) );
var quat = _.euler.toQuat2( srcZXZ );
console.log( 'quat from euler ZXZ :', _.vector.toArray( quat.slice() ) );
var euler = _.euler.fromQuat2( quat, srcZXZ );
console.log( 'euler from quat ZXZ :', _.vector.toArray( euler.slice() ) );
