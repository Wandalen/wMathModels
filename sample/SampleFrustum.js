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
var segment = [ 1, 1, 1, 2, 2, 2 ];

var result = _.frustum.segmentIntersects( srcFrustum, segment )
console.log( 'Result: ', result );
var result = _.frustum.segmentDistance( srcFrustum, segment )
console.log( 'Result: ', result );
var result = _.frustum.segmentClosestPoint( srcFrustum, segment )
console.log( 'Result: ', result );
