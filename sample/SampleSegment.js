
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var segment = [ 0, 0, 0, 1, 1, 0 ];
var s2 =  [ 3, 3, 0, -1, -1, 0 ];
result = _.segment.segmentIntersectionFactors( segment, s2 );
logger.log('Final result: ', result );
