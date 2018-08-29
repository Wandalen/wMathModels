
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

let srcBox = [ 0, 0, 0, 4, 4, 4 ];
let tstRay = [ 5, 5, 2, 0, 1, 0 ];

let gotRay = _.box.rayClosestPoint( srcBox, tstRay );
logger.log( gotRay )
debugger;
