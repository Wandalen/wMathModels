if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var srcPolygon = _.Space.make( [ 3, 6 ] ).copy
([
  0,   0,   0,   0, - 1,   1,
  1, - 1,   0,   0,   0,   0,
  0,   0,   1, - 1,   0,   0,
]);

var result = _.convexPolygon.is( srcPolygon );
logger.log( result )

var result = _.convexPolygon.make( 2, 3 );

var result = _.convexPolygon.is( result );
logger.log( result )

logger.log( _.convexPolygon.angleThreePoints( [ 0, 0, 0 ], [ 0, 2, 0 ], [ 2, 0, 0 ], [ 0, 0, 1 ] ) );
logger.log( _.convexPolygon.angleThreePoints( [ 0, 0, 0 ], [ 2, 0, 0 ], [ 0, 2, 0 ], [ 0, 0, 1 ]  ) );
