
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var line = [ 0, 0, -3, 0, 0, 1 ];
var ray = [ 3, 0, 0, - 1, - 1, 0 ];

result = _.line.rayIntersects( line, ray );
logger.log('Final result: ', result );

result = _.line.rayClosestPoint( line, ray );
logger.log('Final result: ', result );

result = _.line.rayDistance( line, ray );
logger.log('Final result: ', result );
