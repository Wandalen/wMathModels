
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var ray = [  0, 0, 3, 1, 1, 7 ];
var box = [ 0, 0, 0, 1, 1, 1 ];
result = _.ray.boxIntersects( ray, box );
logger.log('Final result: ', result );
result = _.ray.boxDistance( ray, box );
logger.log('Final result: ', result );
result = _.ray.boxClosestPoint( ray, box, _.vector.from( [ 0, 0, 0 ]) );
logger.log('Final result: ', result );
