if( typeof module !== 'undefined' )
require( 'wmathmodels' );

var _ = wTools;

/* */

var srcBox = new F32x([ 0, 1, 2, 3 ]);
var box = _.box.from( srcBox );
console.log( `srcBox === box : ${ srcBox === box }` );
/* log : srcBox === box : true */
console.log( `Type : ${ _.strType( box ) }` );
/* log : Type : F32x */
console.log( box );
/* log : Float32Array(4) [ 0, 1, 2, 3 ] */
