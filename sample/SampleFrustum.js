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
var boxfructumc = [ -1, -2, -3, -0.1, -0.1, -0.1 ];
var boxc = [ -1, -1, 0.8, 0, 1.6, 2 ];
//var boxcclamped = [ -0.5, -0.5, , -0.1, -0.1, -0.1 ];


var bc1 = _.frustum.boxClosestPoint( srcfrustum, boxinter );
console.log('final point: ', bc1);
var bc2 = _.frustum.boxClosestPoint( srcfrustum, boxfructumc );
console.log('final point: ', bc2);
var bc3 = _.frustum.boxClosestPoint( srcfrustum, boxc );
console.log('final point: ', bc3);

//console.log('Frustums intersect: ', interno);

debugger;
