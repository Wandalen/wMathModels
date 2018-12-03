if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

/*
var polygon =  _.Space.make( [ 3, 4 ] ).copy
([
  0,   2,   1,   0,
  0,   0,   1,   2,
  0,   1,   1,   1
]);
var frustum = _.Space.make( [ 4, 6 ] ).copy
([
  0,   0,   0,   0, - 1,   1,
  1, - 1,   0,   0,   0,   0,
  0,   0,   1, - 1,   0,   0,
  - 2, 1.1, - 2, 1.1, 1.1, - 2
]);

var gotInt = _.convexPolygon.frustumClosestPoint( polygon, frustum );

logger.log('Intersection', gotInt)
*/

var polygon =  _.Space.make( [ 3, 4 ] ).copy
([
  -1,   0,   1,   0,
  -0.6,   0,   0.6,   0,
  0.7,   1,   0.7,   0
]);

logger.log('Is convex', _.convexPolygon.isPolygon( polygon ))
