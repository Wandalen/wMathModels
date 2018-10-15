
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

/*
var capsule =  [ 0, 0, - 2, 0, 0, - 1, 0.5 ];
var ray =  [ 0, 0, 0, 0, 1, 0 ];
result = _.ray.capsuleIntersects( ray, capsule );
logger.log('Final result: ', result );
result = _.ray.capsuleDistance( ray, capsule );
logger.log('Final result: ', result );
result = _.ray.capsuleClosestPoint( ray, capsule );
logger.log('Final result: ', result );
*/

var ray = [ - 3, - 3, 2, 1, 1, 0 ];
var segment = [ 0, 0, 0, 0, 0, 3 ];
var expected = 3;

var result = _.ray.rayIntersectionFactors( segment, ray );
logger.log('Final result: ', result );
