if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;


debugger;
var srcfrustum = _.Space.make( [ 4, 6 ] ).copy(
   [ 0,   0,   0,   0, - 1,   1,
     1, - 1,   0,   0,   0,   0,
     0,   2,   1, - 1,   0,   0,
   - 1,   0, - 1,   0,   0, - 1 ] );

var srcpoint = [ 0, 0,  2 ];


var inter = _.frustum.pointClosestPoint( srcfrustum, srcpoint );
//var interno = _.frustum.frustumIntersects( srcfrustum, frustum2 );

console.log('final point: ', inter);
//console.log('Frustums intersect: ', interno);

debugger;
