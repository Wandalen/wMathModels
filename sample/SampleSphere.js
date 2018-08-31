
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var sphere = [ 4, 4, 4, 1 ];
var line = [ 0, 0, 0, 1, 1, 0 ];
var result = _.sphere.lineDistance( sphere, line );
console.log( result )
debugger;
