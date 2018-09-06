
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var segment = [ 0, 0, 2, 0 ];
var ray = [  - 3, - 4, 1, 0 ];
result = _.segment.rayDistance( segment, ray );
logger.log('Final result: ', result );
