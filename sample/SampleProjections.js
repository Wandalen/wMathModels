if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

//var srcBox = [ 3, 0, -1, 4, 0, 0 ];
//var project =  [ [ 1, 0, 0 ], 0, 0, 2 ];

var srcBox = [ 0, 0, 1, 1 ];
var oldSrcBox = srcBox.slice();
var project = [ [ 0.5, 0.5 ], 2, 2 ];
var projBox =  _.box.project( srcBox, project )
logger.log( 'Projected to', projBox );
logger.log( 'Projected to', _.box.getProjectionFactors( oldSrcBox, projBox ) );

logger.log( _.vector.from( [ [ 1, 2 ], 1, 2 ] ) )
logger.log( _.vector.from( [ _.vector.from( [ 1, 2 ] ), 1, 2 ] ) )