
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var ray = _.ray.make( );
console.log( '_.ray.make( ) = ', ray );

var ray = _.ray.fromPair( [ [ 0, 1, 2 ],[ 0, 1, 5 ] ] );
console.log( ray );

var rayPoint = _.ray.rayAt( ray, 1 );
console.log( rayPoint );

ray = [ 0, 1, 2, 0, 1, 5 ];
var rayPoint = _.ray.rayAt( ray, 1 );
console.log( rayPoint );
debugger;
