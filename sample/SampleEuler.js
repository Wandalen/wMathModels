if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var dstXYZ = [ 0, 0, 0, 0, 1, 2 ];
var dstXZY = [ 0, 0, 0, 0, 2, 1 ];
var dstYXZ = [ 0, 0, 0, 1, 0, 2 ];
var dstYZX = [ 0, 0, 0, 1, 2, 0 ];
var dstZXY = [ 0, 0, 0, 2, 0, 1 ];
var dstZYX = [ 0, 0, 0, 2, 1, 0 ];
var dstXYX = [ 0, 0, 0, 0, 1, 0 ];
var dstXZX = [ 0, 0, 0, 0, 2, 0 ];
var dstYXY = [ 0, 0, 0, 1, 0, 1 ];
var dstYZY = [ 0, 0, 0, 1, 2, 1 ];
var dstZXZ = [ 0, 0, 0, 2, 0, 2 ];
var dstZYZ = [ 0, 0, 0, 2, 1, 2 ];

var Matrix = _.Space.make( [ 3, 3 ] ).copy
([
  0.66757100, 0.09500198, 0.738460242,
  0.4207354, 0.77015113, - 0.479425549,
  - 0.61427241, 0.6307470, 0.474159896
]);

var euler = [ 0, 1, 0, 0, 1, 2 ];
var dst = [ 0, 0, 0, 0, 1, 2 ];

console.log( 'Euler:', euler);
var quat = _.euler.toQuat2( euler );
console.log( 'Quat:', quat);
var gotEuler = _.euler.fromQuat2( quat, dst );

console.log( 'Euler:', gotEuler);

var quat = _.euler.toQuat2( gotEuler );
console.log( 'Quat:', quat);
