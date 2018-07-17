if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var numXYZ = [ 0, 1, 2 ];
var numXZY = [ 0, 2, 1 ];
var txtXYZ = 'xyz';
var txtYZY = 'yzy';
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

debugger;

var euler =[ 0.25, 1, 0.5, 2, 1, 0 ];
//var resN = _.euler.represent( dstEulerN, txtYZY );
var res = _.euler.toQuat2( euler, null );
console.log( 'Old Euler:', res);

var Matrix = _.Space.make([ 3, 3 ]).copy
([
  0.77015113, -0.42073547, 0.47942554,
  0.62244683, 0.65995573, - 0.42073547,
  - 0.13938129, 0.62244683, 0.77015113
]);

var gotEuler = _.euler.fromMatrix2( Matrix, dstXYZ );
gotEuler = _.vector.toArray( gotEuler );

console.log( 'Old Euler:', gotEuler);
