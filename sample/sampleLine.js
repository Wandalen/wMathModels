
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var srcLine = [ -5, 2, -5, 1, 0, 1 ];
var polygon =  _.Space.make( [ 3, 4 ] ).copy
([
  0,   0,   0,   0,
  1,   0, - 1,   0,
  0,   1,   0, - 1
]);

result = _.line.convexPolygonIntersects( srcLine, polygon );
logger.log( result );
result = _.line.convexPolygonDistance( srcLine, polygon );
logger.log( result );
result = _.line.convexPolygonClosestPoint( srcLine, polygon );
logger.log( result );
