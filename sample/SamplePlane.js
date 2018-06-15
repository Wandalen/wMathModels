if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var dim = 3;
var plane = _.plane.make( dim );
console.log('Plane 3D: ',plane);

var pointa = [ 0, 0, 1];
//pointa = _.vector.from(pointa);
var pointb = [ 0, 1, 1];
//pointb = _.vector.from(pointb);
var pointc = [ 1, 0, 1];
//pointc = _.vector.from(pointc);
var plane = _.plane.fromPoints( plane, pointa, pointb, pointc );
console.log('Plane 3D fromPoints: a: ',pointa,' b: ', pointb, ' c: ', pointc,' plane: ', plane );

var normal = _.plane.normalGet( plane );
console.log('normal: ',normal);
var bias = _.plane.biasGet( plane );
console.log('bias: ',bias);

var plane = _.plane.fromNormalAndPoint( plane, normal, pointc );

console.log('Plane 3D fromNormalAndPoint:',plane,' point: ', pointc );

var plane = [ - 1, - 1, - 1, - 1 ];
//plane = _.vector.from(plane);
pointa = _.vector.from(pointa);
var dist = _.plane.pointDistance(plane, pointa);

console.log('Distance fro point: ',dist);

console.log('**************************');

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

console.log('**************************');

var sphere = [ 2, 0, 0, 1 ];
var plane = [ 1, 0, 0, 1 ];

var dist = _.plane.sphereDistance( plane, sphere );

console.log('SphereDistance: ',dist);

// console.log('Array: ',sphere,' - Vector: ', vsphere );

debugger;
