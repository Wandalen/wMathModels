if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var srcFrustum= _.Space.make( [ 4, 6 ] ).copy
([
  0,   0,   0,   0,   1, - 1,
  1, - 1,   0,   0,   0,   0,
  0,   0,   1, - 1,   0,   0,
  - 1, 0, - 1,   0, - 1,   0,
]);

logger.log(  srcFrustum )
var capsule = [ - 2, - 2, - 2, - 3, - 3, - 3, 1 ];

var result = _.frustum.capsuleIntersects( srcFrustum, capsule )
console.log( 'Result: ', result );
var result = _.frustum.capsuleDistance( srcFrustum, capsule )
console.log( 'Result: ', result );
var result = _.frustum.capsuleClosestPoint( srcFrustum, capsule )
console.log( 'Result: ', result );
