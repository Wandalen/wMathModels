
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var srcBox = [ - 1, - 1, -1, 2, 2, 2 ];
var polygon =  _.Space.make( [ 3, 4 ] ).copy
([
  0,   0,   0,   0,
  1,   0, - 1,   0,
  0,   1,   0, - 1
]);

  var gotBool = _.box.convexPolygonContains( srcBox, polygon );
logger.log( gotBool )
debugger;
