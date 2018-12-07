if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var srcSphere = [ 0, 1, 0, 2 ];
var polygon =  _.Space.make( [ 3, 4 ] ).copy
([
  -2,  -2,  -2,  -2,
  1,   0, - 1,   0,
  0,   1,   0, - 1
]);

result = _.sphere.convexPolygonIntersects( srcSphere, polygon );
logger.log( result );
result = _.sphere.convexPolygonDistance( srcSphere, polygon );
logger.log( result );
result = _.sphere.convexPolygonClosestPoint( srcSphere, polygon );
logger.log( result );
debugger;
