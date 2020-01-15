
if( typeof module !== 'undefined' )
require( '../' );

let _ = wTools;

let srcBox = [ 0, 0, 1, 1 ];
let tstCapsule = [ 0, 3, -1, 3, 1 ];

result = _.box.capsuleIntersects( srcBox, tstCapsule );
logger.log( result );
result = _.box.capsuleDistance( srcBox, tstCapsule );
logger.log( result );
result = _.box.capsuleClosestPoint( srcBox, tstCapsule );
logger.log( result );
debugger;
