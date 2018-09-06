
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var segment =  [ 0, 0, -2, 0, 0, - 1 ];
var ray =  [ 0, 0, 0, 0, 0, 1 ];
result = _.segment.rayDistance( segment, ray );
logger.log('Final result: ', result );
