if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;


var polygon =  _.Space.make( [ 3, 4 ] ).copy
([
  0,   0,   0,   0,
  1,   0, - 1,   0,
  0,   1,   0, - 1
]);
var plane = [ 0, 1, 0, -2 ];

var gotInt = _.convexPolygon.planeIntersects( polygon, plane );
var gotDist = _.convexPolygon.planeDistance( polygon, plane );
var gotCP = _.convexPolygon.planeClosestPoint( polygon, plane );

logger.log('Intersection', gotInt)
logger.log('Dist', gotDist)
logger.log('CP', gotCP)
