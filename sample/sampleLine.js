
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var line =  [ 0, 0, 3, 0, 0, - 1 ];
result = _.line.boundingSphereGet( null, line );
logger.log('Final result: ', result );
