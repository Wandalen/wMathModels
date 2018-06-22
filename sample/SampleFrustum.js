if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;


debugger;
var srcfrustum = _.Space.make( [ 4, 6 ] ).copy(
   [ 0,   0,   0,   0, - 1,   1,
     1, - 1,   0,   0,   0,   0,
     0,   2,   1, - 1,   0,   0,
   - 3,   0, - 1,   0,   0, - 1 ] );

var spinterins = [ 5, 5, 5, 6 ];
var bc1 = _.frustum.sphereIntersects( srcfrustum, spinterins );
console.log('final point inter inside: ', bc1);
var spinterout = [ 7, 7, 5, 2 ];
var bc2 = _.frustum.sphereClosestPoint( srcfrustum, spinterout );
console.log('final point inter outside: ', bc2);

var out = [ 0.5, 1, 1, 0.01 ];
var bc3 = _.frustum.sphereClosestPoint( srcfrustum, out );
console.log('final point inter outside: ', bc3);

debugger;
