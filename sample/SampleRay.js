
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var srcRay = [ 0, 0, 0, 0, 2, 3 ];
var srcPoint = [  0, 12, 18 ];
let result = _.ray.getFactor( srcRay, srcPoint );

logger.log('Final result: ', result );
