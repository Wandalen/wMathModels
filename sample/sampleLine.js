
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var line = null;
var ray = [ 3, 7, 2, - 1, 0, 0 ];
logger.log( 'line',_.line.make( ray.length / 2 ));

result = _.line.rayIntersects( line, ray );
logger.log('Final result: ', result );

result = _.line.rayClosestPoint( line, ray );
logger.log('Final result: ', result );

result = _.line.rayDistance( line, ray );
logger.log('Final result: ', result );
