if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var srcFrustum= _.Space.make( [ 4, 6 ] ).copy
([
  0,   0,   0,   0, - 1,   1,
  1, - 1,   0,   0,   0,   0,
  0,   0,   1, - 1,   0,   0,
  - 1,   0, - 1,   0,   0, - 1
]);
var srcSphere = [ 0.5, 0.5, 0.5, 0.4 ];

var result = _.frustum.sphereContains( srcFrustum, srcSphere )
console.log( 'Result: ', result );

debugger;
