
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var sphere = [ 0, 0, 0, 1 ];
var sphere2 = [ 0, 0, 5, 2 ];

var result = _.sphere.sphereClosestPoint( sphere, sphere2 );

console.log( 'result: ', result );
