
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var srcBox = [ 0, 0, 0, 3, 3, 3 ];
var srcPlane = [ 1, 0, 0, - 6 ];

var gotBool = _.box.planeDistance( srcBox, srcPlane );
debugger;
console.log( gotBool );
