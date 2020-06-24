if( typeof module !== 'undefined' )
require( 'wmathmodels' );

var _ = wTools;

/* */

var line = [ 1, 2, 3, 4 ];

//How to get origin point
var origin = _.linePointDir.originGet( line );
console.log( `Origin : ${ origin }` );
/* log : Origin : VectorAdapter.x2.Array :: 1.000 2.000 */

//How to get direction vector
var direction = _.linePointDir.directionGet( line );
console.log( `Direction : ${ direction }` );
/* log : Direction : VectorAdapter.x2.Array :: 3.000 4.000 */
