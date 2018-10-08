
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var point = [  1, 1, 1 ];
var capsule = [ 0, 0, 0, 2, 2, 2, 0 ];
var result = _.capsule.pointClosestPoint( capsule, point );
logger.log('Final result: ', result );
