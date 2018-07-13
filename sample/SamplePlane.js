if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var plane1 = [ 0, 0, -4, 2 ];


var box = [  0, 0, 0, 1, 1, 1 ];

var i = _.plane.boxIntersects( plane1, box );
console.log( i );
debugger;
