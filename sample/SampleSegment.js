
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
([
  0,   0,   0,   0, - 1,   1,
  1, - 1,   0,   0,   0,   0,
  0,   0,   1, - 1,   0,   0,
  - 3, 2, - 3,   2,   2, - 3
]);
var segment = [ -2, 0.3, 0, 1, 0, 0.1 ];
result = _.segment.frustumClosestPoint( segment, srcFrustum );
logger.log('Final result: ', result );
