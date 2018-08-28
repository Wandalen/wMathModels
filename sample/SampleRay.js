
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var  ray1 = [ 0, 0, 0, 1, 1, 1 ];
var  ray2 = [ 3, 7, 1, 0, 0, 0 ];
let result = _.ray.rayClosestPoint( ray1, ray2 );
logger.log('Final result: ', result );
logger.log( _.ray.pointDistance( ray2, result ))
result = _.ray.rayClosestPoint( ray2, ray1 );
logger.log('Final result: ', result );
result = _.ray.rayDistance( ray2, ray1 );
logger.log('Final result: ', result );
//result = _.ray.rayDistance( ray1, ray2 );
//logger.log('Final result: ', result );
// result = _.ray.frustumDistance( ray, frustum );
// logger.log('Final result: ', result );
// result = _.ray.frustumClosestPoint( ray, frustum );
// logger.log('Final result: ', result );
