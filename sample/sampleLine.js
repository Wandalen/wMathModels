
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var capsule =  [ 0, 1, - 2, 0, 1, - 1, 0.5 ];
var line =  [ 0, 0, 3, 0, 0, 1 ];
result = _.line.capsuleIntersects( line, capsule );
logger.log('Final result: ', result );
result = _.line.capsuleDistance( line, capsule );
logger.log('Final result: ', result );
result = _.line.capsuleClosestPoint( line, capsule );
logger.log('Final result: ', result );
