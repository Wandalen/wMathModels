
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

let srcBox = [ 1, 1, 1, 7, 7, 7 ];
let tstSegment = [ 0, 0, 0, 5, 5, 5 ];

let gotsegment = _.box.segmentIntersects( srcBox, tstSegment );
logger.log( gotsegment )
gotsegment = _.segment.boxIntersects( tstSegment, srcBox );
logger.log( gotsegment )
debugger;
