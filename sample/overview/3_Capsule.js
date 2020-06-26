if( typeof module !== 'undefined' )
require( 'wmathmodels' );

var _ = wTools;

/* */

var capsule = [ 9, 1, 2, 4, 0.5 ];
var point = [ 3, 5 ];
var distance = _.capsule.pointDistance( capsule, point );
console.log( `Distance from capsule to point : ${ _.toStr( distance, { precision : 2 } ) }` );
/* log : Distance from capsule to point : 0.81 */
