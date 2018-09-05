
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var ray =  [ 0, 0, -2, 0, 0, 1 ];
var ray2 =  [ 0, 0, 2 ];
result = _.ray.pointContains( ray, ray2 );
logger.log('Final result: ', result );
