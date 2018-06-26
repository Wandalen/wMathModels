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
var quat = _.euler.toQuat2( srcXYZ );
console.log( 'quat from euler XYZ :', quat );
var quat = _.euler.toQuat2( srcXZY );
console.log( 'quat from euler XZY :', quat );
var quat = _.euler.toQuat2( srcXYX );
console.log( 'quat from euler XYX:', quat );
var quat = _.euler.toQuat2( srcXZX );
console.log( 'quat from euler XZX:', quat );
var quat = _.euler.toQuat2( srcYXZ );
console.log( 'quat from euler YXZ:', quat );
var quat = _.euler.toQuat2( srcYZX );
console.log( 'quat from euler YZX:', quat );
var quat = _.euler.toQuat2( srcYXY );
console.log( 'quat from euler YXY:', quat );
var quat = _.euler.toQuat2( srcYZY );
console.log( 'quat from euler YZY:', quat );
var quat = _.euler.toQuat2( srcZYX );
console.log( 'quat from euler ZYX :', quat );
var quat = _.euler.toQuat2( srcZXY );
console.log( 'quat from euler ZXY :', quat );
var quat = _.euler.toQuat2( srcZXZ );
console.log( 'quat from euler ZXZ:', quat );
