
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var ray =  [ 3, 7, 2, - 1, 0, 0 ];
var point =  [ 0, 0, 0 ];
result = _.ray.pointClosestPoint( ray, point );
logger.log('Final result: ', result );
