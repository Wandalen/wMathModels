if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;


debugger;
var srcfrustum = _.Space.make( [ 4, 6 ] ).copy(
   [ 0,   0,   0,   0, - 1,   1,
     1, - 1,   0,   0,   0,   0,
     0,   0,   1, - 1,   0,   0,
   - 1,   0, - 1,   0,   0, - 1 ] );

var testfrustum = _.Space.make( [ 4, 6 ] ).copy(
  [ 0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  - 2,   0, - 2,   0,   0, - 2 ] );

var frustum2 = _.Space.make( [ 4, 6 ] ).copy(
  [ 0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  - 2,   3, - 2,   3,   3, - 2 ] );

var inter = _.frustum.frustumIntersect( srcfrustum, testfrustum );
var interno = _.frustum.frustumIntersect( srcfrustum, frustum2 );


console.log('Frustums intersect: ', inter);
console.log('Frustums intersect: ', interno);

debugger;
