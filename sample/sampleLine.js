
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var line = [ 1, 1, 1, 2, 2, 2 ];
var sphere = [ 2, 1, 0, 0.1 ];
result = _.line.sphereClosestPoint( line, sphere );
logger.log('Final result: ', result );
