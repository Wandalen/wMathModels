
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var dim = 3;
result = _.capsule.make( dim );
logger.log('Final result: ', result );
