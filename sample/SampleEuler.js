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

var srcXYZ = [ 0.5, 0.5, 0, 0, 1, 2 ];
var srcXZY = [ 0.5, 0, 0.5, 0, 2, 1 ];
var srcZXZ = [ 0.5, 0.5, 0, 2, 0, 2 ];
var srcZYX = [ 0, 0.5, 0.5, 2, 1, 0 ];
var quat = _.euler.toQuat2( srcXYZ );
console.log( 'quat from euler XYZ (0.239, 0.239, 0.061, 0.938) :', quat );
var quat = _.euler.toQuat2( srcXZY );
console.log( 'quat from euler XZY(0.239, 0.239, 0.061, 0.938) :', quat );
var quat = _.euler.toQuat2( srcZXZ );
console.log( 'quat from euler :', quat );
var quat = _.euler.toQuat2( srcZYX );
console.log( 'quat from euler (0.239, 0.239, - 0.061, 0.938):', quat );
