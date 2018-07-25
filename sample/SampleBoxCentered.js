
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var srcBox = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.80 ];
var point = [ -1, 3, 0 ];

var gotBool = _.box.pointClosestPoint( srcBox, point );

console.log( gotBool );
