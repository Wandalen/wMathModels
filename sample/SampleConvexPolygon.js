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

var result = _.convexPolygon.pointContains( srcPolygon, [ 1, 0, 0 ] );
logger.log( 'Result', result )

var polygon = _.convexPolygon.make( 3, 4 ).copy
([
  1, 0, 0, 1,
  0, 0, 1, 1,
  0, 0, 0, 0
]);
var point = [ 0.5, 0.5, 2 ]
var result = _.convexPolygon.pointDistance( polygon, point );
logger.log( 'Result', result )
