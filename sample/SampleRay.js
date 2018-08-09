
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

let ray1 = [ -3, 0, 1, 0 ];
let ray2 = [ 0, -2, 0, 1 ];


let point = _.ray.rayIntersectionPoints( ray1, ray2 );

logger.log( point );
