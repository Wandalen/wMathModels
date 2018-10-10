
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var capsule = [ -1, -1, -1, -2, -2, -2, 1 ];
var frustum= _.Space.make( [ 4, 6 ] ).copy
([
  0,   0,   0,   0, - 1,   1,
  1, - 1,   0,   0,   0,   0,
  0,   0,   1, - 1,   0,   0,
  - 1,   0, - 1,   0,   0, - 1
]);
var result = _.capsule.frustumIntersects( capsule, frustum );
logger.log('Final result: ', result );
var result = _.capsule.frustumDistance( capsule, frustum );
logger.log('Final result: ', result );
var result = _.capsule.frustumClosestPoint( capsule, frustum );
logger.log('Final result: ', result );
