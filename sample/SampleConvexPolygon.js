if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;


var polygon =  _.Space.make( [ 2, 4 ] ).copy
([
  1,   1,   2,   2,
  0,   1,   1,   0
]);
var segment = [ 0, 0.5, 1, -0.5 ];

var gotDist = _.convexPolygon.segmentDistance( polygon, segment );

var gotCP = _.convexPolygon.segmentClosestPoint( polygon, segment );
var gotCPS = _.segment.pointClosestPoint( segment, gotCP );
logger.log('Distance', gotDist)
logger.log('Distance', gotCP)
logger.log('Distance', gotCPS)
