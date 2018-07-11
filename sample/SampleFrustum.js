if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var srcfrustum =  _.Space.make( [ 4, 6 ] ).copy
([
 0,   0,   0,   0, - 1,   1,
 1, - 1,   0,   0,   0,   0,
 0,   2,   1, - 1,   0,   0,
- 3,   0, - 1,   0,   0, - 1
]);

debugger;

var box = [ -1, -1, 1, 0.5, 1.5, 2 ];
var point = _.frustum.boxClosestPoint( srcfrustum, box );
console.log( 'final point inter outside: ', point );

debugger;
