
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var sphere = _.vector.from([ 0, 0, 0, 1 ]);
var plane = [ 1, 0, 0, 2 ];

var result = _.sphere.planeClosestPoint( sphere, plane, _.vector.from( [ 0, 0, 0 ]) );

console.log( 'sphere: ', result)
console.log( 'sphere: ', sphere)
