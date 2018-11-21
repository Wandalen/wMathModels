if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var srcPolygon = _.Space.make( [ 3, 4 ] ).copy
([
  0,   0,   0,   2,
  1, - 1,   -2,   0,
  1, - 1,   -2,   0
]);

var result = _.convexPolygon.is( srcPolygon );
logger.log( 'Result', result )
