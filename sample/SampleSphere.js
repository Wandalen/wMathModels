
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var sphere = [ 0, 0, 0, 1 ];
var box = [ -3,0,5,-1,1,9 ];
var s2 = _.sphere.fromBox( sphere, box );
console.log( s2 )
debugger;
