if( typeof module !== 'undefined' )
require( 'wmathmodels' );

var _ = wTools;

/* */

var srcBox = new F32x([ 2, 1, 9, 5 ]);
var box = _.box.from( srcBox );
console.log( box );
/* log : Float32Array(4) [ 2, 1, 9, 5 ] */
console.log( `Type : ${ _.strType( box ) }` );
/* log : Type : F32x */
console.log( `srcBox === box : ${ srcBox === box }` );
/* log : srcBox === box : true */
