
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var capsule = [ -1, -1, -1, -2, -2, -2, 1 ];
var result = _.capsule.boundingSphereGet( null, capsule );
logger.log('Final result: ', result );
