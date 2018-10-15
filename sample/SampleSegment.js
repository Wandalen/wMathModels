
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;


var ray = [ - 3, - 3, 2, 1, 1, 0 ];
var segment = [ 0, 0, 0, 0, 0, 3 ];
var expected = 3;

var result = _.segment.rayIntersects( segment, ray );
logger.log('Final result: ', result );
