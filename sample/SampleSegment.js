
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var segment = [ 0, -6, 24, 1, 1, 1 ];
var plane = [ 1, 0, 1, 3 ];
result = _.segment.planeClosestPoint( segment, plane );
logger.log('Final result: ', result );
