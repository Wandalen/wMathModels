if( typeof module !== 'undefined' )
require( 'wmathmodels' );

var _ = wTools;

/* */

var srcBox = _.vectorAdapter.fromLong([ 0, 1, 2, 3 ]);
var box = _.box.from( srcBox );
console.log( `srcBox === box : ${ srcBox === box }` );
/* log : srcBox === box : true */
console.log( `Type : ${ _.strType( box ) }` );
/* log : Type : VectorAdapterFromLong */
console.log( box );
/* log : VectorAdapter.x4.Array :: 0.000 1.000 2.000 3.000 */
