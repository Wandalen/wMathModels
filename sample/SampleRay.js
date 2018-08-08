
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var ray = _.ray.make( );
console.log( '_.ray.make( ) = ', ray );

ray = _.ray.from( [ 1, 2, 3, 4, 5, 6] );
console.log( '_.ray.:_from( ray ) = ', ray );

let or = _.ray.originGet( ray );
let dir = _.ray.directionGet( ray );

console.log( or.slice(), dir.slice() );
