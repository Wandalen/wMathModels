if( typeof module !== 'undefined' )
require( 'wmathmodels' );

var _ = wTools;

/* */

var box = _.box.from( null );
console.log( `Type : ${ _.strType( box ) }` );
/* log : Type : Array */
console.log( box );
/* log : [ 0, 0, 0, 0, 0, 0 ] */
