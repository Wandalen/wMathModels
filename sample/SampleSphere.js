
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
var srcSphere = [ 5, 5, 5, 1 ];
var result = _.sphere.frustumDistance( srcSphere, tstFrustum );

logger.log( result )
