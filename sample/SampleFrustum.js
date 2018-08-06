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
var box = [ 3, 3, 3, 4, 4, 4 ];

var result = _.frustum.boxDistance( srcFrustum, box )
console.log( 'Result: ', result );

var result = _.box.frustumDistance( box, srcFrustum )
console.log( 'Result: ', result );
debugger;
