if( typeof module !== 'undefined' )
require( 'wmathmodels' );

var _ = wTools;

/* */

var segment = [ 2, 1, 9, 4 ];
var point = [ 3, 5 ];
var distance = _.segment.pointDistance( segment, point );
console.log( `Distance from segment to point : ${ _.toStr( distance, { precision : 2 } ) }` );
/* log : Distance from segment to point : 3.3 */
