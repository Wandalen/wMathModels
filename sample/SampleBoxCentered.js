
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

let srcBox = [ 0, 0, 0, 4, 4, 4 ];
let tstline = [ 5, 5, 5, 0, 0, 1 ];

let gotline = _.box.lineDistance( srcBox, tstline );
logger.log( gotline )
gotline = _.line.boxDistance( tstline, srcBox );
logger.log( gotline )
debugger;
