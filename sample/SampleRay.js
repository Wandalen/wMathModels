
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var ray =   [ 3, 7, 1, 1, 0, 0 ];
var ray2 =  [ 3, -2, 1, 0, 0, 1 ];
result = _.ray.rayIntersectionFactors( ray, ray2 );
logger.log('Final result: ', result );
