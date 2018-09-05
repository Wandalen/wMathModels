
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var segment = [ 0, 0, -2, 0, 0, 2 ];
var s2 =  [ 0, 0, 2 ];
result = _.segment.pointContains( segment, s2 );
logger.log('Final result: ', result );
result = _.ray.pointContains( segment, s2 );
logger.log('Final result: ', result );
result = _.line.pointContains( segment, s2 );
logger.log('Final result: ', result );
