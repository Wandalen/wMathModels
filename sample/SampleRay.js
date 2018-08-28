
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var frustum =  _.Space.make( [ 4, 6 ] ).copy
([
  0,   0,   0,   0, - 1,   1,
  1, - 1,   0,   0,   0,   0,
  0,   0,   1, - 1,   0,   0,
  - 1, 0.5, - 1, 0.5, 0.5, - 1
]);
var ray = null;
result = _.ray.frustumIntersects( ray, frustum );
logger.log('Final result: ', result );
// result = _.ray.frustumDistance( ray, frustum );
// logger.log('Final result: ', result );
// result = _.ray.frustumClosestPoint( ray, frustum );
// logger.log('Final result: ', result );
