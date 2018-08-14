
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var ray = [  0, 0, 3, 1, 1, 7 ];
var sphere = [ 5, 5, 37, 3 ];
result = _.ray.sphereIntersects( ray, sphere );
logger.log('Final result: ', result );
//result = _.ray.sphereDistance( ray, sphere );
//logger.log('Final result: ', result );
//result = _.ray.sphereClosestPoint( ray, sphere, _.vector.from( [ 0, 0, 0 ]) );
//logger.log('Final result: ', result );
