
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var line =   [ 5, 5, 7, 0, 0, 1 ];
var line2 =  [ 0, 0, 0, 4, 4, 4 ];
result = _.line.lineIntersectionFactors( line, line2 );
logger.log('Final result: ', result );
