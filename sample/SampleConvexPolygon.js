if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;


var polygon =  _.Space.make( [ 3, 3 ] ).copy
([
  0,   0,   0,
  0,   3,   4,
  3,   0,   4
]);
var ray = [ 0, 0, -1, 0, 3, 0 ];

var gotInt = _.convexPolygon.rayIntersects( polygon, ray );
var gotDist = _.convexPolygon.rayDistance( polygon, ray );
var gotCP = _.convexPolygon.rayClosestPoint( polygon, ray );

logger.log('Intersection', gotInt)
logger.log('Dist', gotDist)
logger.log('CP', gotCP)
