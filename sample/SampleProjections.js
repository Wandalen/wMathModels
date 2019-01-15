if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var capsule = [ 0, 0, 1, 1, 1 ];
var project = [ [ 1, 1 ], 2, 2 ];
var projCapsule =  _.capsule.project( capsule, project )
logger.log( 'Projected to', projCapsule );
