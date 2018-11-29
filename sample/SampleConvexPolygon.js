if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;


var polygon =  _.Space.make( [ 3, 3 ] ).copy
([
  0,   0,   0,
  0,   3,   4,
  3,   0,   4
]);
var box = [ 0, 0, 0, 1, 1, 1 ];

var gotDist = _.convexPolygon.boxDistance( polygon, box );
logger.log('Distance', gotDist)
