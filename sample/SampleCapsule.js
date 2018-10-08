
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var capsule = [ 1, 2, 4, 3, 4, 0, 0.5 ];
var tstCapsule = [ 1, 2, 3, 1, 2, 3, 0 ];
var result = _.capsule.capsuleIntersects( capsule, tstCapsule );
logger.log('Final result: ', result );
var result = _.capsule.capsuleDistance( capsule, tstCapsule );
logger.log('Final result: ', result );
var result = _.capsule.capsuleClosestPoint( capsule, tstCapsule );
logger.log('Final result: ', result );
