if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
([
  0,   0,   0,   0,   -1,  1,
  1,  -1,   0,   0,   0,   0,
  0,   0,  -1,   1,   0,   0,
  -3,  0,   0,  -3,   0,  -3
]);
var polygon =  _.Space.make( [ 3, 4 ] ).copy
([
  2,   1, 0.5,   1,
  1,   2,   1, 0.5,
  4,   4,   4,   4
]);

result = _.frustum.convexPolygonIntersects( srcFrustum, polygon );
logger.log( result );
result = _.frustum.convexPolygonDistance( srcFrustum, polygon );
logger.log( result );
result = _.frustum.convexPolygonClosestPoint( srcFrustum, polygon );
logger.log( result );
debugger;
