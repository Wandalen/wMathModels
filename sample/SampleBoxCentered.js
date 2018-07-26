
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var srcBox = [ 0, 0, 0, 3, 3, 3 ];
var srcPlane = [ 1, 0, 0, 2 ];

var gotBool = _.box.planeExpand( srcBox, srcPlane );
debugger;
console.log( gotBool );
