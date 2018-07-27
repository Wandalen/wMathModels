
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var sphere = _.vector.from([ 0, 0, 0, 1 ]);
var plane = [ 1, 0, 0, 2 ];

var result = _.sphere.planeExpand( sphere, plane );

console.log( 'sphere: ', result)
