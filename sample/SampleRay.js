
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

let ray = [ 0, 1, 2, 2 ];
let factor = 1;

let point = _.ray.rayAt( ray, factor );

logger.log( point );
