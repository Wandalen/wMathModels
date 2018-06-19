if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var plane1 = [ 1, 0, 0, - 4 ];
var plane2 = [ 1, 0, 0, 1 ];
var plane3 = [ 1, 0, 0, 2 ];

var Intpoint = [ 0, 0, 0 ];

var IntPoint = _.plane.threePlanesIntersectionPoint( plane1, plane2, plane3, Intpoint );
console.log('Point: ', IntPoint );

debugger;
