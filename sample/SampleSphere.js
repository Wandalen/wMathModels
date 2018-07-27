
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var sphere = [ 0, 0, 0, 0 ];
var point = [ 0, 0, 0, 0 ];

var result = _.sphere.sphereContains( sphere, point );

console.log( 'result: ', result );
