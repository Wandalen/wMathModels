if( typeof module !== 'undefined' )
require( 'wmathmodels' );

var _ = wTools;

/* Sample checks order of polygon vertexes */

/* */

var vertices =
[
  2,  6,  9,  5,
  1, -1,  2,  6,
]
var polygon = _.convexPolygon.make( vertices, 2 );
var point = [ 6, 4 ];
var contains = _.convexPolygon.pointContains( polygon, point );
console.log( `Should contains if has counterclock-wise order : ${ contains }` );
/* log : Should contains if has counterclock-wise order : true */

var vertices =
[
  2, 9,  6,  5,
  1, 2, -1,  6,
]
var polygon = _.convexPolygon.make( vertices, 2 );
var point = [ 6, 4 ];
var contains = _.convexPolygon.pointContains( polygon, point );
console.log( `Should not contains if has counterclock-wise order : ${ contains }` );
/* log : Should not contains if has counterclock-wise order : false */

