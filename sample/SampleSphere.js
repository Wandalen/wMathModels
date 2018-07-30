
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
var srcSphere = _.vector.from( [ 3, 0, 0, 1 ] );
var result = _.sphere.frustumExpand( srcSphere, tstFrustum );

logger.log( result )
