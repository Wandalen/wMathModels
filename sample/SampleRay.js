
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var ray = [ 0, 2 ];
var point = [ - 3 ];
let result = _.ray.pointClosestPoint( ray, point );
logger.log('Final result: ', result );
result = _.ray.pointDistance( ray, point );
logger.log('Final result: ', result );
