
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var ray =   [ 0, 1, 0, 0, 4, 1, 0, 0, 0, 0 ];
var ray2 =  [ 3, 1, 0, 0, 0, 0, 0, 0, 0, 1 ];
var frustum =  _.Space.make( [ 4, 6 ] ).copy
([
  0,   0,   0,   0, - 1,   1,
  1, - 1,   0,   0,   0,   0,
  0,   0,   1, - 1,   0,   0,
  - 1,   0.5, - 1,   0.5,   0.5, - 1
]);
result = _.ray.rayParallel( ray, ray2 );
logger.log('Final result: ', result );
result = _.ray.rayClosestPoint( ray, ray2 );
logger.log('Final result: ', result );
