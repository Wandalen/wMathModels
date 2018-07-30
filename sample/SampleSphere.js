
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var tstFrustum =  _.Space.make( [ 4, 6 ] ).copy
([
  0,   0,   0,   0, - 1,   1,
  1, - 1,   0,   0,   0,   0,
  0,   0,   1, - 1,   0,   0,
  - 1,   0, - 1,   0,   0, - 1 ]
);
var srcSphere = [ 0, 0, 0, Math.sqrt( 3 ) ];
var result = _.sphere.frustumContains( srcSphere, tstFrustum );

logger.log( result )
