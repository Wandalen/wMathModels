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
  0.568439841270, - 0.78996562957, 0.22984884679,
  0.789965629577, 0.44602236151, - 0.4207354784,
  0.229848867931, 0.4207354784, 0.877582550048
]);

var dst = [ 0, 0, 0, 2, 0, 2 ];

console.log( 'Matrix:', Matrix );
var euler = _.euler.fromMatrix2( Matrix, dst );
console.log( 'Euler:', euler );
euler = [ 0.5, 0.5, 0.5, 2, 0, 2 ];
var gotEuler = _.euler.toMatrix2( euler );
console.log( 'Matrix:', gotEuler);
