if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var plane = [ 1, 0, 1, 2, 3, 4 ];
var sphere = [ 0, 1, 0, 1, 2, 1 ];

result = _.plane.boundingSphereGet( sphere, plane );
logger.log('Final result: ', result );
