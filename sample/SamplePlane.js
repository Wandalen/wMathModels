if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var plane1 = [ 1, 0, 0, -1 ];
var plane2 = [ - 1, 0, 0, 0 ];
var plane3 = [ 1, 0, 0, 2 ];

var Intpoint = _.vector.from( [ 2, 2, 2 ] );


IntPoint = _.plane.pointDistance( plane1, Intpoint);
console.log('Point: ', IntPoint );

IntPoint = _.plane.pointDistance( plane2, Intpoint);
console.log('Point: ', IntPoint );
debugger;
