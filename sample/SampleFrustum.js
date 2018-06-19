if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var frustum = _.Space.make( [ 4, 6 ] ).copy(
   [ 1, 0, 0, - 1, 0, 0,
     0, 1, 0, 0, - 1, 0,
     0, 0, 1, 0, 0, - 1,
     1, 1, 1, 1, 1, 1 ] );

var point = [ 2, 2, 2 ];
point = _.vector.from( point );

debugger;

var expected = _.frustum.pointContains( frustum, point );

console.log('Intersection:', expected);


debugger;
