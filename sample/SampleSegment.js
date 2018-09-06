
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var segment = [ 0, 0, 0, 1, 0, 0 ];
var line = [ 2, 0, 0, 1, 0, 0 ];
result = _.segment.lineIntersects( segment, line );
logger.log('Final result: ', result );
result = _.segment.rayIntersects( segment, line );
logger.log('Final result: ', result );
