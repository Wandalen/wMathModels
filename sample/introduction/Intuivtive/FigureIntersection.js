if( typeof module !== 'undefined' )
var _ = require( '../../..' );

var _ = wTools;

var plane = [ 1, 0, 0, 1 ];

var box = [ 0, 0, 0, 1, 1, 1 ];
var got = _.plane.boxIntersects( plane, box );
console.log( 'Plane intersects with box: ', got )
/* log : Plane intersects with box: false */

var capsule = [ - 1, 2, 3, -1, 2, 3, 0  ]
var got = _.plane.capsuleIntersects( plane, capsule );
console.log( 'Plane intersects with capsule: ', got )
/* log : Plane intersects with capsule: true */

var frustum = _.Matrix.make( [ 4, 6 ] ).copy
([
  0,   0,   0,   0,  -1,   1,
  1,  -1,   0,   0,   0,   0,
  0,   0,   1,  -1,   0,   0,
 -1,   0,  -1,   0,   0,  -1
]);
var got = _.plane.frustumIntersects( plane, frustum );
console.log( 'Plane intersects with frustum: ', got )
/* log : Plane intersects with frustum: false */

var got = _.plane.planeIntersects( plane, plane );
console.log( 'Plane intersects with plane: ', got )
/* log : Plane intersects with plane: true */

var line = [ 1, 0, 1, 1, 1, 1 ]
var got = _.plane.lineIntersects( plane, line );
console.log( 'Plane intersects with line: ', got )
/* log : Plane intersects with line: true */

var segment = [ -2, -2, -2, 2, 2, 2 ]
var got = _.plane.segmentIntersects( plane, segment );
console.log( 'Plane intersects with segment: ', got )
/* log : Plane intersects with segment: true */

var sphere = [ 2, 0, 0, 1 ]
var got = _.plane.sphereIntersects( plane, sphere );
console.log( 'Plane intersects with sphere: ', got )
/* log : Plane intersects with sphere: false */

var ray = [ 0, 0, 0, 1, 1, 1  ]
var got = _.plane.rayIntersects( plane, ray );
console.log( 'Plane intersects with ray: ', got )
/* log : Plane intersects with ray: false */