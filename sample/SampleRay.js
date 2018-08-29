
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var ray =   [ 5, 5, 2, 0, 1, 0 ];
var ray2 =  [ 0, 0, 0, 4, 4, 4 ];
result = _.ray.boxClosestPoint( ray, ray2 );
logger.log('Final result: ', result );
