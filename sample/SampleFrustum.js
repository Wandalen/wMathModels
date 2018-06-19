if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var frustum = _.Space.make( [ 4, 6 ] ).copy(
   [ 1, 0, 0, - 1, 0, 0,
     0, 1, 0, 0, - 1, 0,
     0, 0, 1, 0, 0, - 1,
     1, 1, 1, 1, 1, 1 ] );

var box = [ 0, 0, 0, 1, 1, 1 ];
//box = _.vector.from( box );

debugger;

var expected = _.frustum.boxIntersects( frustum, box );

console.log('Intersection:',expected);


debugger;
