if( typeof module !== 'undefined' )
require( 'wmathmodels' );

var _ = wTools;

/* */

var dim = 2;
var box = _.box.make( dim );
console.log( `Type : ${ _.strType( box ) }` );
/* log : Type : Array */
console.log( box );
/* log : [ 0, 0, 0, 0 ] */
