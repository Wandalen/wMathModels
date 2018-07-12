
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var sphere = [ 0, 0, 0, 3 ];
var box = [ 2, 0, 0, 3, 3, 3 ];

var result = _.sphere.boxIntersects( sphere, box );

console.log( '3D Box created',result );
