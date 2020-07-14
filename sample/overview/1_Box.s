if( typeof module !== 'undefined' )
require( 'wmathmodels' );

var _ = wTools;

/* */

var box = [ 2, 1, 9, 5 ];
var point = [ 6, 8 ];
var got = _.box.pointDistance( box, point );
console.log( `Distance from box to point : ${ _.toStr( got, { precision : 2 } ) }` );
/* log : Distance from box to point : 3.0 */
