if( typeof module !== 'undefined' )
var _ = require( '../../..' );

var _ = wTools;

var point = [ 0, 1 ];

var plane = [ 0, 1, 1 ];
var contains = _.plane.pointContains( plane, point );
console.log( 'Plane contains point: ', contains );
/* log : Plane contains point: false */

var line = [ 0, 0, 0, 2 ];
var contains = _.linePointDir.pointContains( line, point );
console.log( 'Line contains point: ', contains );
/* log : Line contains point: true */

var vertices =
[
  1, 0, 0,
  0, 0, 1
];
var polygon = _.convexPolygon.make( vertices, 2 );
var contains = _.convexPolygon.pointContains( polygon, point );
console.log( 'Polygon contains point: ', contains );
/* log : Polygon contains point: true */
