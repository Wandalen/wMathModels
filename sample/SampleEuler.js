if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;


var matrix =  _.Space.make( [ 3, 3 ] ).copy(
     [ 1, 0, 1,
       1, 1, 0,
       0, 1, 1 ] );

var dstXYZ = [ 0, 0, 0, 1, 2, 0 ];
//var euler2 = _.euler.fromMatrix2( matrix, dstXYZ );
//console.log( 'Euler from mat xyz:', euler2 );

var a = (Math.PI/2);
console.log(a);
var srcXYZ = [ 0.1, a, 0, 1, 2, 0 ];
var srcZYX2 = [ 0.1, -a, 0, 1, 2, 0 ];
var quat = _.euler.toQuat2( srcXYZ );
console.log( 'Quat XYZ :', quat );
var euler = _.euler.fromQuat2( quat, dstXYZ );
console.log( 'euler from quat XYZ :', euler );
var quat = _.euler.toQuat2( srcZYX2 );
var euler = _.euler.fromQuat2( quat, dstXYZ );
console.log( 'euler from quat XYZ :', euler );
