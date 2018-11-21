if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var srcPolygon = _.Space.make( [ 3, 6 ] ).copy
([
  0,   0,   0,   0, - 1,   1,
  1, - 1,   0,   0,   0,   0,
  0,   0,   1, - 1,   0,   0,
]);

var result = _.convexPolygon.isPolygon( srcPolygon );
logger.log( result )

var result = _.convexPolygon.make( 2, 3 );

var result = _.convexPolygon.isPolygon( result );
logger.log( result )

logger.log( _.convexPolygon.angleThreePoints( [ 1, 1, 1 ], [ 2, 2, 2 ], [ -1, -1, -1 ] ) );
