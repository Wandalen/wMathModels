
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var ray = [  - 1,  - 1 , 1, 1 ];
var box = [ 0, 0, 1, 1 ];
result = _.ray.boxIntersects( ray, box );
logger.log('Final result: ', result );
