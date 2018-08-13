
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var src1Ray = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
var src2Ray = [ 3, 0, 1, 4, 2, 2, 2, -1 ];

let result = _.ray.rayIntersectionFactors( src1Ray, src2Ray );

logger.log('Final result: ', result );
