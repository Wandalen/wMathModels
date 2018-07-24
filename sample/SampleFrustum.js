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
var srcPoint = [ -1, -1, -1 ];
var expected = [ 0, 0, 0 ];

dstPoint = [ 0, 2, 0 ];
var result = _.frustum.pointClosestPoint( srcFrustum, srcPoint, dstPoint )
console.log( 'final point result: ', result );
console.log( 'final point dstPoint: ', dstPoint );

debugger;

var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
([
  0,   0,   0,   0, - 1,   1,
  1, - 1,   0,   0,   0,   0,
  0,   2,   1, - 1,   0,   0,
  - 1,   0, - 1,   0,   0, - 1
]);
var srcPoint = [ 0, 0, 2 ];
var expected = [ 0, 0.4, 0.2 ];

dstPoint = _.vector.from( [ 0, 0, 0 ] );
var result = _.frustum.pointClosestPoint( srcFrustum, srcPoint, dstPoint )
console.log( 'final point: ', result );
console.log( 'final point: ', dstPoint );

debugger;
