if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var capsule = [ 3, 4, 3, 5, 1 ];
var oldCapsule = [ 3, 4, 3, 5, 1 ];
var project = [ [ -1, 3 ], 4, 2 ];

var projCapsule =  _.capsule.project( capsule, project )
logger.log( 'Projected to', projCapsule );
logger.log('*******************')
var factors = _.capsule.getProjectionFactors( oldCapsule, projCapsule );
logger.log( factors );