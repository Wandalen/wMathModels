
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var dst = [ Infinity, Infinity, Infinity, -Infinity, -Infinity, -Infinity ];
// var point = new Float32Array([ 454.8794860839844, 7893.02783203125, -7698.6318359375 ]);
var point = _.vector.from( [ 454.8794860839844, 7893.02783203125, -7698.6318359375 ] );
var box = _.box.pointExpand( dst, point );
console.log( box )
debugger;
