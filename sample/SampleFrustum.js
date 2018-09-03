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
var line = [ 2, 2, 2, - 1, -1, -1 ];

var result = _.frustum.lineIntersects( srcFrustum, line )
console.log( 'Result: ', result );
var result = _.frustum.lineDistance( srcFrustum, line )
console.log( 'Result: ', result );
var result = _.frustum.lineClosestPoint( srcFrustum, line )
console.log( 'Result: ', result );
