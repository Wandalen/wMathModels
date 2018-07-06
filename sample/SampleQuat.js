if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;


var q = _.quat.from( [ 0.7, - 0.5, 0.5, 0.2 ] )
var q2 = _.quat.from( [ 0, 0, 0, 0 ] )

var matrix = _.quat.toMatrix( q );

console.log( matrix );

var q2 = _.quat.fromMatrixRotation( q2, matrix );

console.log( q2 );
