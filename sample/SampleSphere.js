
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var sphere = [ 0, 0, 0, 1 ];
var ray = [ -2, -2, 0, 1, 0, 0 ];
var result = _.sphere.rayClosestPoint( sphere, ray );
console.log( result )
debugger;
