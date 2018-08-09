
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

let p1 = [ 0, 1, 2 ];
let p2 = [ 0, 1, 2 ];

let ray = _.ray.fromPair( [ p1, p2 ] );

logger.log( ray );
