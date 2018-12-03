if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;


var polygon =  _.Space.make( [ 3, 4 ] ).copy
([
  2,   3,   3,   2,
  2,   3,   4,   3,
  2,   3,   3,   2
]);
var line = [ 3, 2, 3, 1, 0, 0 ];

var gotInt = _.convexPolygon.lineIntersects( polygon, line );
var gotDist = _.convexPolygon.lineDistance( polygon, line );
var gotCP = _.convexPolygon.lineClosestPoint( polygon, line );

logger.log('Intersection', gotInt)
logger.log('Dist', gotDist)
logger.log('CP', gotCP)
