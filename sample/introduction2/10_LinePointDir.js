if( typeof module !== 'undefined' )
require( 'wmathmodels' );

var _ = wTools;

/* */

var line = _.linePointDir.make([ 1, 2, 3, 4 ]);
console.log( `Line : ${ line }` );
/* log : Line : [ 1, 2, 3, 4 ] */
