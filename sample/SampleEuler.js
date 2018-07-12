if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var numXYZ = [ 0, 1, 2 ];
var numXZY = [ 0, 2, 1 ];
var txtXYZ = 'xyz';
var txtXZY = 'xzy';
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

var dstEuler = [  1, 0.25, 0.5, 0, 1, 2  ];

var gotEuler = _.euler.represent( dstEuler, numXYZ );
console.log( 'Euler:', gotEuler);
var gotEuler = _.euler.represent( dstEuler, numXZY );
console.log( 'Euler:', gotEuler);
var gotEuler = _.euler.represent( dstEuler, txtXYZ );
console.log( 'Euler:', gotEuler);
var gotEuler = _.euler.represent( dstEuler, txtXZY );
console.log( 'Euler:', gotEuler);
