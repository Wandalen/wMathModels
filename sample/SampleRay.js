
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

let ray1 = [ 0, 0, 0, 1, 0, 0 ];
let ray2 = [ 1, 1, 0, 0, 1, 0 ];
let result = _.ray.rayClosestPoint( ray2, ray1 );
logger.log('Final result: ', result );
result = _.ray.rayDistance( ray2, ray1 );
logger.log('Final result: ', result );
//result = _.ray.rayDistance( ray1, ray2 );
//logger.log('Final result: ', result );
// result = _.ray.frustumDistance( ray, frustum );
// logger.log('Final result: ', result );
// result = _.ray.frustumClosestPoint( ray, frustum );
// logger.log('Final result: ', result );
