
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

/*
var capsule = [ -3, 0, 0, -1, 0, 0, 1 ];
var segment = [ 1, 0, 0, 3, 0, 0 ];

var intersection = _.segment.capsuleIntersects( segment, capsule );
var distance = _.segment.capsuleDistance( segment, capsule );
var closestPoint = _.segment.capsuleClosestPoint( segment, capsule );
logger.log('Final result: ', intersection );
logger.log('Final result: ', distance );
logger.log('Final result: ', closestPoint );
*/


var segment = [ 0, 0, 0, 1, 0, 0 ];

let result = _.segment.boundingSphereGet( null, segment )
logger.log( 'Result :', result );
result = _.segment.boundingBoxGet( null, segment )
logger.log( 'Result :', result );
