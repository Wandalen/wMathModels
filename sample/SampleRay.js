
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

let ray1 = [ 0, 1, 2, 4, 6, 4 ];
let ray2 = [ 0, 1, 5, 2, 3, 2 ];

let point = _.ray.rayParallel( ray1, ray2 );

logger.log( point );
