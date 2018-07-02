if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;


debugger;
var q = _.quat.makeZero();
console.log('Zero q: ', q);
var q = _.quat.makeUnit( );
console.log('Zero q: ', q);
var q = _.quat.zero( q );
console.log('Zero q: ', q);
debugger;

var euler = [ 0, 0, 0, 0, 1, 0 ];
q = _.quat.fromEuler( q, euler );
console.log('Zero q: ', q);
var v1 = [ 1, 0, 0 ];
var v2 = [ 0, 1, 0 ];
var q = _.quat.fromVectors( q, v1, v2 );
console.log('Vectors q: ', q);


//var q = _.quat._from( [ Math.sqrt(2)/2, Math.sqrt(2)/2, 0, 0 ]);
var qc = _.quat.conjugate( q );
var r = _.quat.mul( _.quat.makeUnit(), qc, q);
console.log('conjugated ', r );
