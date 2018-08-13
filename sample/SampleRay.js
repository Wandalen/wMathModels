
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var srcRay = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
var srcPoint = [ 5, 5, 5.000000001, 5 ];

let result = _.ray.pointContains( srcRay, srcPoint );

logger.log('Final result: ', result );
