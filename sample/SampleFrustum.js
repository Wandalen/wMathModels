if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var srcFrustum= _.Space.make( [ 4, 6 ] ).copy
([
  0,   0,   0,   0, - 1,   1,
  1, - 1,   0,   0,   0,   0,
  0,   0,   1, - 1,   0,   0,
  - 3, 2, - 3,   2,   2, - 3
]);
var segment = [ - 2, 0.3, 0, 1, 0, 0 ];

var result = _.frustum.segmentIntersects( srcFrustum, segment )
console.log( 'Result: ', result );
var result = _.frustum.segmentDistance( srcFrustum, segment )
console.log( 'Result: ', result );
var result = _.frustum.segmentClosestPoint( srcFrustum, segment )
console.log( 'Result: ', result );
