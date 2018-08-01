if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var plane1 = [ 1, 2, 0, -1 ];

var plane2 = [  2, 2, 0, 2 ];

var i = _.plane.planeIntersects( plane1, plane2 );
console.log( i );
debugger;
