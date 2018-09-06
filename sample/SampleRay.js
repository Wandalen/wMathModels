
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var segment =  [ 0, 0, - 2, 0, 0, - 1 ];
var ray =  [ 0, 0, 0, 0, 0, 1 ];
result = _.ray.segmentDistance( ray, segment );
logger.log('Final result: ', result );
