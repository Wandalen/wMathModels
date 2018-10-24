
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var line =  [ 0, 3, 3, 1, 0, - 1 ];
result = _.line.boundingSphereGet( null, line );
logger.log('Final result: ', result );
result = _.line.boundingBoxGet( null, line );
logger.log('Final result: ', result );
