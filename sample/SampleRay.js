
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var src1Ray = [ 3, 7, 1, 1, 0, 0 ];
var src2Ray = [ 3, 7, 1, 0, 0, 1 ];

var isParallel = _.ray.rayParallel( src1Ray, src2Ray );

logger.log( isParallel );
