if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;


var matrix =  _.Space.make( [ 3, 3 ] ).copy(
     [ 1, 0, 1,
       1, 1, 0,
       0, 1, 1 ] );

var dstZYX = [ 0, 0, 0, 2, 1, 0 ];
//var euler2 = _.euler.fromMatrix2( matrix, dstXYZ );
//console.log( 'Euler from mat xyz:', euler2 );


var srcZYX = [ 0.1, -1.570796327, 0, 2, 1, 0 ];
var srcZYX2 = [ -0.3, 1.570796327, 0, 2, 1, 0 ];
var quat = _.euler.toQuat2( srcZYX );
var euler = _.euler.fromQuat2( quat, dstZYX );
console.log( 'euler from quat XYZ :', euler );
var quat = _.euler.toQuat2( srcZYX2 );
var euler = _.euler.fromQuat2( quat, dstZYX );
console.log( 'euler from quat XYZ :', euler );
