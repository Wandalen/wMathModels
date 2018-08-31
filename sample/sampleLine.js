
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var sphere = [ 4, 4, 4, 1 ];
var line = [ 0, 0, 0, 1, 1, 1 ];
result = _.line.sphereIntersects( line, sphere );
logger.log('Final result: ', result );
