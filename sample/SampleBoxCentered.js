
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var b = [ 4, 4, 4, 5,  5, 5 ];
var off = 3;
var box = _.box.translate( b, off );
console.log( box )
