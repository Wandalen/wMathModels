if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var srcSphere = [ 4, 4, Math.sqrt( 2 ) ];
var polygon =  _.Space.make( [ 2, 4 ] ).copy
([
  3,   5,   5,   3,
  3,   3,   5,   5
]);

result = _.sphere.convexPolygonIntersects( srcSphere, polygon );
logger.log( result );
result = _.sphere.convexPolygonDistance( srcSphere, polygon );
logger.log( result );
result = _.sphere.convexPolygonClosestPoint( srcSphere, polygon );
logger.log( result );
result = _.sphere.convexPolygonContains( srcSphere, polygon );
logger.log( result );
debugger;
