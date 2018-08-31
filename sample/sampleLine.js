
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var line = [ 0, 0, 0, 0, 0, 2 ];
var point = [ 0, 0, 1 ];
result = _.line.pointContains( line, point );
logger.log('Final result: ', result );
