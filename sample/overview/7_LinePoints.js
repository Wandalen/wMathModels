if( typeof module !== 'undefined' )
require( 'wmathmodels' );

var _ = wTools;

/* */

var ray = [ 2, 1, 4, 2 ];
var factor = 0.25;
var pair = _.linePoints.pairAt( ray,factor );
console.log( `Pair at factor 0.25 : ${ pair }` );
/* log : Pair at factor 0.25 : 2.500 1.250 */
