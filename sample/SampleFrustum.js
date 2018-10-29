if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
([
  0,   0,   0,   0, - 1,   1,
  1, - 1,   0,   0,   0,   0,
  0,   0,   1, - 1,   0,   0,
  1,   3,   1,   3,   3,   1
]);

var result = _.frustum.boundingSphereGet( null, srcFrustum )
console.log( 'Result: ', result );

var result = _.frustum.boundingBoxGet( null, srcFrustum )
console.log( 'Result: ', result );
