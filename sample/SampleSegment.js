if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

let srcSegment = [ 3, 0, -1, 4, 0, 0 ];
var polygon =  _.Space.make( [ 3, 4 ] ).copy
([
  0,   0,   0,   0,
  1,   0, - 1,   0,
  0,   1,   0, - 1
]);

result = _.segment.convexPolygonIntersects( srcSegment, polygon );
logger.log( result );
result = _.segment.convexPolygonDistance( srcSegment, polygon );
logger.log( result );
result = _.segment.convexPolygonClosestPoint( srcSegment, polygon );
logger.log( result );
debugger;
