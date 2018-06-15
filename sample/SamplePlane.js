if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

console.log('sphereDistance **************************');

var sphere = [ 2, 0, 0, 1 ];
var plane = [ 1, 0, 0, 1 ];

var dist = _.plane.sphereDistance( plane, sphere );

console.log('SphereDistance: ',dist);

// console.log('Array: ',sphere,' - Vector: ', vsphere );

debugger;


console.log('Coplanar **************************');

var plane = [ 1, 0, 0, 0 ];
var vplane = _.vector.from(plane);
pointa = [ 5, 4, 4 ];
var vpointa = _.vector.from(pointa);
console.log('Point: ',pointa);
//var coplanar = _.plane.pointCoplanarGet( plane, pointa );
var coplanar = _.plane.pointCoplanarGet( vplane, vpointa );
//console.log('pointCoplanarGet: ',coplanar);
console.log('Plane: ',plane);
console.log('Point: ',pointa);
console.log('pointCoplanarGet: ',coplanar);
