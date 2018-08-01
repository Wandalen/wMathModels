if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var plane1 = [ 2, 4, -4, -6 ];

var plane2 = [  1, 2, -2, -3 ];

var j = _.plane.planeIntersects( plane1, plane2 )
console.log( j );
var i = _.plane.planeDistance( plane1, plane2 );
console.log( i );
debugger;
