if( typeof module !== 'undefined' )
require( 'wmathmodels' );

var _ = wTools;

/* */

var srcBox = [ 0, 1, 2, 3 ];
var box = _.box.make( srcBox );
console.log( `srcBox === box : ${ srcBox === box }` );
/* log : srcBox === box : false */
console.log( `Type : ${ _.strType( box ) }` );
/* log : Type : Array */
console.log( box );
/* log : [ 0, 1, 2, 3 ] */
