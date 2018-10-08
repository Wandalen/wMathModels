
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var box = [ - 1, - 1, - 1, -0.5, 0, 0 ];
var capsule = [ 0, 0, 0, 0, 0, 2, 0.2 ];
var result = _.capsule.boxClosestPoint( capsule, box );
logger.log('Final result: ', result );
