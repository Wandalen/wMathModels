
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var sphere = [ -1, 0, 0, 2 ];
var point = [ 1, 0, 0 ];

var result = _.sphere.pointContains( sphere, point );

console.log( 'result: ', result );
