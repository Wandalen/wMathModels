
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

let srcBox = [ -1, 3, 2, 3, 3, 4 ];
var polygon =  _.Space.make( [ 3, 4 ] ).copy
([
  0,   0,   0,   0,
  1,   0, - 1,   0,
  0,   1,   0, - 1
]);

result = _.box.convexPolygonIntersects( srcBox, polygon );
logger.log( result );
result = _.box.convexPolygonDistance( srcBox, polygon );
logger.log( result );
result = _.box.convexPolygonClosestPoint( srcBox, polygon );
logger.log( result );
debugger;
