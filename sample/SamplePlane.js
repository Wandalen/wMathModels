if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var plane1 = [ 0, 2, 0, -2 ];


var sphere = [  1, 1, 1, 1];

var d = _.plane.sphereDistance( plane1, sphere );
console.log( d );
var i = _.plane.sphereIntersects( plane1, sphere );
console.log( i );
debugger;
