
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var srcBox = [ 0, 0, 0, 4, 4, 4 ];
var tstSphere = [ 0, 7, 7, 5 ];

var gotBool = _.box.sphereClosestPoint( srcBox, tstSphere );
debugger;
console.log( gotBool );
