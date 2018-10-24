
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var capsule = [ 0, 0, 0, 2, 0, 0, 1 ];
var result = _.capsule.boundingSphereGet( null, capsule );
logger.log('Final result: ', result );
var result = _.capsule.boundingBoxGet( null, capsule );
logger.log('Final result: ', result );
