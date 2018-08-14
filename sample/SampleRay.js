
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var ray = [ 0, 0, 0, 1 / Math.sqrt( 3 ), 1 / Math.sqrt( 3 ), 1 / Math.sqrt( 3 ) ];
var plane = [ 1, 0, 0, 1 ];
result = _.ray.planeIntersects( ray, plane );
logger.log('Final result: ', result );
//result = _.ray.planeDistance( ray, plane );
//logger.log('Final result: ', result );
//result = _.ray.planeClosestPoint( ray, plane );
//logger.log('Final result: ', result );
