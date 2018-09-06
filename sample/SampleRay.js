
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var ray =  [ 0, 0, -2, 0, 0, 1 ];
var ray2 =  [ 0, 0, 2, 0, 0, 1 ];
result = _.ray.rayIntersectionFactors( ray, ray2 );
logger.log('Final result: ', result );
