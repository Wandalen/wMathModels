if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;


debugger;
var srcfrustum = _.Space.make( [ 4, 6 ] ).copy(
   [ 0,   0,   0,   0, - 1,   1,
     1, - 1,   0,   0,   0,   0,
     0,   0,   1, - 1,   0,   0,
   - 1,   0, - 1,   0,   0, - 1 ] );

var srcpoint = [ 5, 0.5, - 3 ];


var inter = _.frustum.pointClosestPoint( srcfrustum, srcpoint );
//var interno = _.frustum.frustumIntersects( srcfrustum, frustum2 );

console.log('src point: ', srcpoint);
console.log('final: ', inter);
//console.log('Frustums intersect: ', interno);

debugger;
