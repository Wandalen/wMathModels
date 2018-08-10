
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

let ray1 = [ 0, 0, 1, 1 ];
let ray2 = [2, 0, - 1, 1 ];


let point = _.ray.rayIntersectionPointAccurate( ray1, ray2 );

logger.log( point );
