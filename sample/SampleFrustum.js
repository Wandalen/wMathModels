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
var srcBox = [ 0.5, 0.5, 0.5, 0.9, 0.9, 0.9 ];

var result = _.frustum.boxContains( srcFrustum, srcBox )
console.log( 'Result: ', result );

debugger;
