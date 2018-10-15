if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var capsule =  [ 0, 1, - 2, 0, 1, - 1, 0.5 ];
var plane =  [ 1, 0, 0, 0.4 ];
result = _.plane.capsuleIntersects( plane, capsule );
logger.log('Final result: ', result );
result = _.plane.capsuleDistance( plane, capsule );
logger.log('Final result: ', result );
result = _.plane.capsuleClosestPoint( plane, capsule );
logger.log('Final result: ', result );
