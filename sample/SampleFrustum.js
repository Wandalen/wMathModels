if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;


debugger;
var srcfrustum = _.Space.make( [ 4, 6 ] ).copy(
   [ 0,   0,   0,   0, - 1,   1,
     1, - 1,   0,   0,   0,   0,
     0,   2,   1, - 1,   0,   0,
   - 3,   0, - 1,   0,   0, - 1 ] );

var boxinter = [ -1, -2, -3, 0.1, 0.1, 0.1 ];
var boxfructumc = [ 2, 3, 4, 5, 6, 7 ];
var boxc = [ -2, -2, 1, 0, 0, 4 ];


var bc1 = _.frustum.boxClosestPoint( srcfrustum, boxinter );
console.log('final point inter: ', bc1);
var bc2 = _.frustum.boxClosestPoint( srcfrustum, boxfructumc );
console.log('final point crner: ', bc2);
var bc3 = _.frustum.boxClosestPoint( srcfrustum, boxc );
console.log('final point: ', bc3);

//console.log('Frustums intersect: ', interno);

debugger;
