if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var e = [ 0.5, 0.2, 0.3, 0, 1, 2 ];
var e2 = [ 0, 0, 0, 0, 1, 2 ];
var q = _.euler.toQuat2( e );
console.log( q );
var m = _.quat.toMatrix( q );
var e2 = _.euler.fromMatrix2( m, e2 );
var m2 = _.euler.toMatrix2( e2 );
var q2 = _.quat.from( [ 0, 0, 0, 0 ] )
q2 = _.quat.fromMatrixRotation( q2, m2 );

console.log( q2 );
