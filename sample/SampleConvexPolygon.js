if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;


var polygon =  _.Space.make( [ 2, 4 ] ).copy
([
  1,   1,   2,   2,
  0,   1,   1,   0
]);
var capsule = [ 0, 0.5, 1, -0.5, 0.05 ];

var gotInt = _.convexPolygon.capsuleIntersects( polygon, capsule );

var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );

var gotCP = _.convexPolygon.capsuleClosestPoint( polygon, capsule );

logger.log('Intersection', gotInt)
logger.log('Distance', gotDist)
logger.log('ClosestPoint', gotCP)
