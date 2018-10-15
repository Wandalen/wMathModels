
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var sphere = [ 5, 0, 0, 1 ];
var capsule = [ 1, 0, 0, 3, 0, 0, 0.9 ];
var result = _.sphere.capsuleIntersects( sphere, capsule );
console.log( result )
var result = _.sphere.capsuleDistance( sphere, capsule );
console.log( result )
var result = _.sphere.capsuleClosestPoint( sphere, capsule );
console.log( result )
