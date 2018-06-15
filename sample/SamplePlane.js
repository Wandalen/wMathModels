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

console.log('Plane 3D: ',plane);
var normal = _.plane.normalGet( plane );
console.log('normal: ',normal);
var bias = _.plane.biasGet( plane );
console.log('bias: ',bias);

var plane = _.plane.fromNormalAndPoint( plane, normal, pointc );

console.log('Plane 3D fromNormalAndPoint: ',plane,' point: ', pointc );


var plane = _.plane.from( [ 0, 0, 0, 0 ], [ 0, 0, 1 ],  2 );

console.log('Plane 3D: ',plane);


// console.log('Array: ',sphere,' - Vector: ', vsphere );

debugger;
