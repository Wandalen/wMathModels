if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;


var matrix =  _.Space.make( [ 3, 3 ] ).copy(
     [ 1, 0, 1,
       1, 1, 0,
       0, 1, 1 ] );

var dstXYZ = [ 0, 0, 0, 0, 1, 2 ];
var euler2 = _.euler.fromMatrix2( matrix, dstXYZ );
console.log( 'Euler from mat xyz:', euler2 );

var quat = [ 0, 0, 3, 3 ];
var dstXYZ = [ 0, 0, 0, 0, 1, 2 ];
var euler2 = _.euler.fromQuat2( quat, dstXYZ );
console.log( 'Euler from quat :', euler2 );
