if( typeof module !== 'undefined' )
require( 'wmathmodels' );

var _ = wTools;

/* */

var point = [ 0, 1, 2 ];
var plane = [ 1, 2, -1, 0 ];
var contains = _.plane.pointContains( plane, point );
console.log( `Plane contains point : ${ contains }` );
/* log : Plane contains point: true */
