if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var srcPolygon = _.Space.make( [ 3, 4 ] ).copy
([
  0,   0,   0,   2,
  1, - 1,   -2,   0,
  1, - 1,   -2,  0
]);

var result = _.convexPolygon.is( srcPolygon );
logger.log( 'Result', result )

var result = _.convexPolygon.boxIntersects( srcPolygon, [ 1, 0, 0, 3, 2, 2 ] );
logger.log( 'Result', result )


var polygon =  _.Space.make( [ 3, 4 ] ).copy
([
  0,   0,   0,   0,
  1,   0, - 1,   0,
  0,   1,   0, - 1
]);

var result = _.convexPolygon.is( polygon );
logger.log( 'Result', result )
