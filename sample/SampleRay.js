
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

console.log( isNaN( -0  ) );
var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
var src2Ray = [ 3, 3, 3, 0, 1, 4 ];

var isParallel = _.ray.rayIntersectionFactors( src1Ray, src2Ray );

logger.log( isParallel );
