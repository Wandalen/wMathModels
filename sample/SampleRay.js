
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var ray = [ 0, 0, 0, 1 / Math.sqrt( 3 ), 1 / Math.sqrt( 3 ), 1 / Math.sqrt( 3 ) ];
var sphere = [ 3, 0, 3, 1 ];
result = _.ray.sphereIntersects( ray, sphere );
logger.log('Final result: ', result );
result = _.ray.sphereDistance( ray, sphere );
logger.log('Final result: ', result );
result = _.ray.sphereClosestPoint( ray, sphere );
logger.log('Final result: ', result );
