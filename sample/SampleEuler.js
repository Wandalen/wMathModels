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

var quat = [ 3, 0, 3, 3 ];
var dstZXZ = [ 0, 0, 0, 2, 0, 2 ];
var dstZYX = [ 0, 0, 0, 2, 1, 0 ];
var euler2 = _.euler.fromQuat2( quat, dstZXZ );
console.log( 'Euler from quat :', euler2 );
var quat = _.euler.toQuat2( euler2 );
console.log( 'quat from euler :', quat );
var euler2 = _.euler.fromQuat2( quat, dstZYX );
console.log( 'Euler from quat :', euler2 );
var quat = _.euler.toQuat2( euler2 );
console.log( 'quat from euler :', quat );
