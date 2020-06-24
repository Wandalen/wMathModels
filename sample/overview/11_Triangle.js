if( typeof module !== 'undefined' )
require( 'wmathmodels' );

var _ = wTools;

/* */

var triangle = [ 2, 1, 9, 2, 5, 6 ];
var point = [ 2, 5 ]
var distance = _.triangle.pointDistance( triangle, point );
console.log( `Distance from triangle to point : ${ _.toStr( distance, { precision : 2 } ) } )` );
/* log : Distance from triangle to point : 1.1 */
