if( typeof module !== 'undefined' )
require( 'wmathmodels' );

var _ = wTools;


var polygon =  _.Space.make( [ 3, 4 ] ).copy
([
  0,   0,   0,   0,
  1,   0, - 1,   0,
  0,   1,   0, - 1
]);
var sphere = [ 1, 1, 5, 1 ];

var gotInt = _.convexPolygon.sphereIntersects( polygon, sphere );
var gotDist = _.convexPolygon.sphereDistance( polygon, sphere );
var gotCP = _.convexPolygon.sphereClosestPoint( polygon, sphere );

logger.log('Intersection', gotInt)
logger.log('Dist', gotDist)
logger.log('CP', gotCP)
logger.log('CP', _.sphere.pointClosestPoint( sphere, gotCP ) )
