if( typeof module !== 'undefined' )
require( 'wmathmodels' );

var _ = wTools;

/* */

var box = _.box.make( null );
console.log( `Type : ${ _.strType( box ) }` );
/* log : Type : Array */
console.log( box );
/* log : [ 0, 1, 2, 3 ] */
