if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var plane1 = [ 3, 0, 0, - 2 ];

var box = [  0, 0, 0, 2, 2, 2 ];

var i = _.plane.boxIntersects( plane1, box );
console.log( i );
debugger;
