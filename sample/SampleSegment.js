
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var segment = [ 1, 2, 3, 0, 0, 0 ];
var s2 =  [ 3, 4, 5 ];
result = _.segment.pointClosestPoint( segment, s2 );
logger.log('Final result: ', result );
