
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var ray =  [ - 2, 0.3, 0, 1, 0, 0 ];;
var frustum =  _.Space.make( [ 4, 6 ] ).copy
([
  0,   0,   0,   0, - 1,   1,
  1, - 1,   0,   0,   0,   0,
  0,   0,   1, - 1,   0,   0,
  - 1,   0.5, - 1,   0.5,   0.5, - 1
]);
result = _.ray.frustumClosestPoint( ray, frustum );
logger.log('Final result: ', result );
result = _.ray.frustumDistance( ray, frustum );
logger.log('Final result: ', result );
//result = _.ray.rayDistance( ray1, ray2 );
//logger.log('Final result: ', result );
// result = _.ray.frustumDistance( ray, frustum );
// logger.log('Final result: ', result );
// result = _.ray.frustumClosestPoint( ray, frustum );
// logger.log('Final result: ', result );
