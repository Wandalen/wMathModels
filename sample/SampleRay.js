
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var ray =  [ -2, 0, 0, 1, 0, 0 ];
var line =  [ 0, - 2, 3, 0, 2, 0 ];
result = _.ray.lineIntersects( ray, line );
logger.log('Final result: ', result );
result = _.ray.lineDistance( ray, line );
logger.log('Final result: ', result );
result = _.ray.lineClosestPoint( ray, line );
logger.log('Final result: ', result );
result = _.line.rayClosestPoint( line, ray );
logger.log('Final result: ', result );
