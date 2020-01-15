if( typeof module !== 'undefined' )
require( '../' );

let _ = wTools;

var plane = [ 1, 0, 0, - 1 ];
var sphere = [ 0, 1, 0, 1 ];

result = _.plane.boundingSphereGet( sphere, plane );
logger.log('Final result: ', result );

result = _.plane.boundingBoxGet( null, plane );
logger.log('Final result: ', result );
