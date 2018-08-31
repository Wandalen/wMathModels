
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var line = [ 2, 0, 2, 2 ];
var box = [ 0, 0, 1, 1 ];
result = _.line.boxClosestPoint( line, box );
logger.log('Final result: ', result );
