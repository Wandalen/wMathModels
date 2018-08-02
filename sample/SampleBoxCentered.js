
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

let frustum =  _.Space.make( [ 4, 6 ] ).copy
([
 0,   0,   0,   0, - 1,   1,
 1, - 1,   0,   0,   0,   0,
 0,   0,   1, - 1,   0,   0,
 - 1,   0, - 1,   0,   0, - 1 ]
);
let box = [ 3, 3, 3, 4, 4, 4 ];


let gotBool = _.box.frustumIntersects( box, frustum );
console.log( gotBool );
gotBool = _.frustum.boxIntersects( frustum, box );
console.log( gotBool );
