
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var src = [ 0,1,2,3 ];
var got = _.box.make( src );

console.log( '2D Box created',got );
