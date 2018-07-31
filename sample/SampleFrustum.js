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
var srcPlane = [ 1, 0, 0, 2 ];

var result = _.frustum.planeClosestPoint( srcFrustum, srcPlane, [ 0, 0, 0 ] )
console.log( 'Result: ', result );

debugger;
