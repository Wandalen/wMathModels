
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var srcBox = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.80 ];
var tstBox = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.90 ];
var expected = true;

var gotBool = _.box.boxIntersects2( srcBox, tstBox );

console.log( gotBool );
