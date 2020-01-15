
if( typeof module !== 'undefined' )
require( '../' );

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

var ray = [ - 3, - 3, 2, - 1E-12, 0, 1E-12 ];

var result = _.ray.boundingSphereGet( null, ray );
logger.log('Final result: ', result );

var result = _.ray.boundingBoxGet( null, ray );
logger.log('Final result: ', result );
