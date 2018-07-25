
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var srcBox = [ 0, 0, 0, 4, 4, 4 ];
var tstSphere = [ 2, 2, 3, 2 ];

var gotBool = _.box.sphereContains( srcBox, tstSphere );
debugger;
console.log( gotBool );
