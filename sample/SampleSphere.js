
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var sphere = [ -1, 0, 0, 2 ];
var point = [ 3, 3, 3, 4, 4, 4 ];

var result = _.sphere.boxClosestPoint( sphere, point );

console.log( 'result: ', result );
