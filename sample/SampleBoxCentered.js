
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var dstBox = _.vector.from( [ 0, 0, 0, 4, 4, 4 ] );
var srcSphere = [ 0, 7, 7, 5 ];

var gotBool = _.box.sphereExpand( dstBox, srcSphere );
debugger;
console.log( gotBool );
