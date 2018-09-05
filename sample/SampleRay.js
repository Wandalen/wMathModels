
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var ray =  [ 0, 0, 2, 1 ];
var ray2 =  [ 1, 0, - 1, - 2 ];
result = _.ray.rayClosestPoint( ray, ray2 );
logger.log('Final result: ', result );
result = _.ray.rayClosestPoint( ray2, ray );
logger.log('Final result: ', result );
