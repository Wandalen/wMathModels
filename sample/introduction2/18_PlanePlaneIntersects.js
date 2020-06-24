if( typeof module !== 'undefined' )
require( 'wmathmodels' );

var _ = wTools;

/* */

var plane = [ 1, 0, 0, 1 ];
var intersected = _.plane.planeIntersects( plane, plane );
console.log( `Plane intersects with plane : ${ intersected }` );
/* log : Plane intersects with plane : true */
