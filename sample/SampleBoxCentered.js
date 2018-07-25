
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var srcBox = [ 0, 0, 0, 4, 4, 4 ];
var tstBox = [ 5, 5, 5, 6, 6, 6 ];

var gotBool = _.box.boxClosestPoint( srcBox, tstBox, _.vector.fromArray([ 0, 0, 0 ]) );
debugger;
console.log( gotBool );
