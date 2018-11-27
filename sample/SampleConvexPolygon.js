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
var point = _.vector.from( [ - 0.5, 0.75, 2 ] );
var result = _.convexPolygon.pointClosestPoint( polygon, point, _.vector.from( [ 0, 0, 0 ]) );
logger.log( 'Result', result )


logger.log('MYYYY')
var polygon = _.convexPolygon.make( 2, 4 ).copy
([
  1,   0,  -1, -2,
  0.25, 0, 0.25,  1
]);
var point = [ -1, 0 ];

var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
var expected = [ -1, 0.1 ];
logger.log( 'Result', gotClosestPoint )
