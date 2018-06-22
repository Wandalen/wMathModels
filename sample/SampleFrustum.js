if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;


debugger;
var srcfrustum = _.Space.make( [ 4, 6 ] ).copy(
   [ 0,   0,   0,   0, - 1,   1,
     1, - 1,   0,   0,   0,   0,
     0,   2,   1, - 1,   0,   0,
   - 3,   0, - 1,   0,   0, - 1 ] );

var box = [ - 0.5, -1, - 0.5, 0.5, -0.1, 2 ];

var bc2 = _.frustum.boxClosestPoint( srcfrustum, box );
console.log('final point inter outside: ', bc2);


debugger;
