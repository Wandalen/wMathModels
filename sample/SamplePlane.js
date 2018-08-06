if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var plane1 = [ 1, 0, 0, -0.5 ];


var box = [ 0, 0, 0, 1, 1, 1 ];

var j = _.plane.boxDistance( plane1, box )
console.log( j );
debugger;
var j = _.box.planeDistance( box, plane1 )
console.log( j );
debugger;
