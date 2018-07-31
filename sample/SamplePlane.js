if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var plane1 = [ 1, 0, 0, -1 ];

var sphere = [  0, 0, 0, 2 ];

var i = _.plane.sphereClosestPoint( plane1, sphere, _.vector.from( [ 0, 0, 0 ] ) );
console.log( i );
debugger;
