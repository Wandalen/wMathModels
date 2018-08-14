
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var ray = [ 0, 0, 0, 1 / Math.sqrt( 3 ), 1 / Math.sqrt( 3 ), 1 / Math.sqrt( 3 ) ];
var sphere = [ 3, 0, 3, 1 ];
//result = _.ray.sphereIntersects( ray, sphere );
//logger.log('Final result: ', result );
//result = _.ray.sphereDistance( ray, sphere );
//logger.log('Final result: ', result );
//result = _.ray.sphereClosestPoint( ray, sphere, _.vector.from( [ 0, 0, 0 ]) );
//logger.log('Final result: ', result );

var p = [ 3, 0, 0 ]

logger.log(_.ray.pointClosestPoint( ray, p ))
logger.log(_.ray.pointDistance( ray, p ))
