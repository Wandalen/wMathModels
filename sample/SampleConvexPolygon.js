if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var srcPolygon = _.Space.make( [ 3, 4 ] ).copy
([
  0,   0,   0,   0,
  1, - 1,   -2,   0,
  1,   1,   -2,  0
]);

var resultIs = _.convexPolygon.is( srcPolygon );

var resultInt = _.convexPolygon.boxIntersects( srcPolygon, [ 1, 0, 0, 3, 2, 2 ] );

var resultDist = _.convexPolygon.boxDistance( srcPolygon, [ 1, 0, 0, 3, 2, 2 ] );

var resultCP = _.convexPolygon.boxClosestPoint( srcPolygon, [ 1, 0, 0, 3, 2, 2 ] );

logger.log( 'Result', resultIs )
logger.log( 'Result', resultInt )
logger.log( 'Result', resultDist )
logger.log( 'Result', resultCP )

var polygon =  _.Space.make( [ 3, 4 ] ).copy
([
  1,   0, - 1,   0,
  0,   1,   0, - 1,
  0,   0,   0,   0
]);
var box = [ 2, -2, -2, 4, 2, 2 ];
var gotDist = _.convexPolygon.boxDistance( polygon, box );
logger.log( gotDist );
