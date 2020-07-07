if( typeof module !== 'undefined' )
require( 'wmathmodels' );

var _ = wTools;

/* */

var box = _.box.make( null );
console.log( box );
/* log : [ 0, 0, 0, 0 ] */
console.log( `Type : ${ _.strType( box ) }` );
/* log : Type : Array */
console.log( `_.box.is( box ) : ${ _.box.is( box ) }` );
/* log : _.box.is( box ) : true */
