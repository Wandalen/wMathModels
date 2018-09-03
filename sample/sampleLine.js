
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var line = [ 3, 0, 1, 2.5 ];
var ray = [ 6, 6, 1, 1 ];

result = _.line.rayIntersects( line, ray );
logger.log('Final result: ', result );
