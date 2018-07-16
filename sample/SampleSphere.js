
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var sphere = [ -1, 0, 0, 2 ];
var box = [ 3, 0, 0, 3, 0, 0 ];

var result = _.sphere.boxExpand( sphere, box );

console.log( '3D Box created',result );
console.log( '3D Box created',sphere );
console.log( '3D Box created',box );
var s = _.box.makeNil();
console.log(s);
