
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

/*

var ray = [ - 3, - 3, 2, - 1E-12, 0, 1E-12 ];

var result = _.ray.boundingSphereGet( null, ray );
logger.log('Final result: ', result );

var result = _.ray.boundingBoxGet( null, ray );
logger.log('Final result: ', result );
*/
var ray = [ 1.1, 0, 0, 2 ];

let segment = [ 0, -1, 1, 1 ];

logger.log( _.ray.rayIntersectionFactors( segment, ray ))
