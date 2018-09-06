
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var segment =  [ 0, 0, - 2, 0, 0, - 1 ];
var line =  [ 0, 2, 0, 0, 0, 1 ];
result = _.line.segmentIntersects( line, segment );
logger.log('Final result: ', result );
result = _.line.segmentDistance( line, segment );
logger.log('Final result: ', result );
