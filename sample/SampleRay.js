
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

let ray1 = [ 0, 0, 1, 1 ];
let ray2 = [ 3, 7, 1, 1 ];


let point = _.ray.rayIntersectionPoint( ray1, ray2 );

logger.log( point );
