
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var src = undefined;
var got = _.box.centeredOfSize( src );
console.log( 'box centered :',got );

// var expected = [ -0.5,-0.5,-0.5,+0.5,+0.5,+0.5 ];
