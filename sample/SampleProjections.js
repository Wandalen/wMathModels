if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

//var srcBox = [ 3, 0, -1, 4, 0, 0 ];
//var project =  [ [ 1, 0, 0 ], 0, 0, 2 ];

var srcBox = null;
var project = [ [ 0, 0, 0 ], 1, 2, 3 ];

logger.log( 'Projected to', _.box.project( srcBox, project ) );
