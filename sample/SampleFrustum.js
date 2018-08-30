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
var ray = [ 2, 2, 2, - 1, -1, 0 ];

var result = _.frustum.rayIntersects( srcFrustum, ray )
console.log( 'Result: ', result );
var result = _.frustum.rayDistance( srcFrustum, ray )
console.log( 'Result: ', result );
var result = _.frustum.rayClosestPoint( srcFrustum, ray )
console.log( 'Result: ', result );
