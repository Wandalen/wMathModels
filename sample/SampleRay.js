
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var ray =   [ 0, 1, 0, 0, 4, 1, 0, 0, 0, 0 ];
var ray2 =  [ 3, 1, 0, 0, 0, 0, 0, 0, 0, 1 ];

result = _.ray.rayParallel( ray, ray2 );
logger.log('Final result: ', result );
result = _.ray.rayClosestPoint( ray, ray2 );
logger.log('Final result: ', result );
