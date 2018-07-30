
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
([
  0,   0,   0,   0, - 1,   1,
  1, - 1,   0,   0,   0,   0,
  0,   0,   1, - 1,   0,   0,
  - 1,   0, - 1,   0,   0, - 1
]);
var box = [ 0.5, 0.5, 0.5, 1.5, 1.5, 1.5 ];

var gotBool = _.box.frustumExpand( box, srcFrustum );
console.log( gotBool );
