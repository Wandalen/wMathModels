if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;



var q = _.euler.toQuat2( [ 0, 0, 0, 2, 0, 2 ] );
console.log( 'q:  ', q );

var q2 = _.quat.from( [ 0, 0, 0, 0 ] )
var matrix = _.quat.toMatrix( q );

console.log( matrix );

var q2 = _.quat.fromMatrixRotation( q2, matrix );

console.log( 'qf: ',q2 );
