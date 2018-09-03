
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var ray =   [ 0, 0, 0, 1, 1, 1 ];
var line =  [ 3, 7, 1, 0, 0, 0 ];
result = _.ray.lineClosestPoint( ray, line );
logger.log('Final result: ', result );
