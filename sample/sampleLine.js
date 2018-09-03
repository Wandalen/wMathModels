
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var ray = [ 0, 0, - 1, 1, 1, 1 ];
var line = [ 0, 0, 0, 1, 1, 1 ];
logger.log( _.line.pointContains( line, [ 0, 0, 1 ] ) )
//result = _.line.rayIntersects( line, ray );
//logger.log('Final result: ', result );
