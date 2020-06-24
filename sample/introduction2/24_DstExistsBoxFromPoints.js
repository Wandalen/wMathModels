if( typeof module !== 'undefined' )
require( 'wmathmodels' );

var _ = wTools;

/* */

var point1 = [ 3, 1 ];
var point2 = [ 0, 8 ];
var dstBox = _.vectorAdapter.make( 4 );
_.box.fromPoints( dstBox, [ point1, point2 ] );
console.log( `Box : ${ dstBox }` );
/* log : Box : VectorAdapter.x4.F32x :: 0.000 0.000 3.000 8.000 */
