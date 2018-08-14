
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var ray = [ 0, 0, 0, 0, 0, 0 ];
var point = [ 0, 0, 0 ];
let result = _.ray.pointContains( ray, point );
logger.log('Final result: ', result );
result = _.ray.pointClosestPoint( ray, point );
logger.log('Final result: ', result );
result = _.ray.pointDistance( ray, point );
logger.log('Final result: ', result );
