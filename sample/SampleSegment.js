
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var segment = [ 0, 0, 2, 1 ];
var s2 =  [ 1, 0 ];
result = _.segment.pointClosestPoint( segment, s2 );
logger.log('Final result: ', result );
result = _.ray.pointClosestPoint( segment, s2 );
logger.log('Final result: ', result );
