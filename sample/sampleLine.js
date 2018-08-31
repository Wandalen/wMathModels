
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var line =   [ -3, 0, 1, 0 ];
var line2 =  [ 0, -2, 0, 1 ];
result = _.line.lineIntersectionFactors( line, line2 );
logger.log('Final result: ', result );
