
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var ray =  [ -3, 0, 0, 3, 0, 0 ];
var ray2 =  [ 0, -2, 4, 0, 4, 0 ];
result = _.ray.rayClosestPoint( ray, ray2 );
logger.log('Final result: ', result );
result = _.ray.rayClosestPoint( ray2, ray );
logger.log('Final result: ', result );
