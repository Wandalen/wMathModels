if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var vertices =
[
  2,  6,  9,  5,
  1, -1,  2,  6
]
var polygon = _.convexPolygon.make( vertices, 2 );
var point = [ 3, 6 ];
var distance = _.convexPolygon.pointDistance( polygon, point );
console.log( `Distance from convex polygon to point : ${ _.toStr( distance, { precision : 2 } ) }` );
/* log : Distance from convex polygon to point : 1.7 */
console.log( `Type : ${ _.strType( polygon ) }` );
/* log : Type : wMatrix */
