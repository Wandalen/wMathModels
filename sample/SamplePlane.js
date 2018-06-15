if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;



var normal= [ 1, 1, 1 ];
normal = _.vector.from(normal);
var mod = _.vector.dot(normal, normal);
console.log('mdulo  ',mod);
var modu = Math.sqrt(mod);
console.log('mdulo normal ',modu);


normal = _.vector.mulScalar( normal, 1/modu);

console.log('mdulo normal ',normal);

console.log('sphereDistance **************************');

var plane = [ 0, 2, 0, 2 ];
var sphere = [ 1, 1, 1, 1 ];


var dist = _.plane.pointDistance( plane, _.vector.from([1,1,1]) );

console.log('PointDistance: ',dist);
var dist = _.plane.sphereDistance( plane, sphere );

console.log('SphereDistance: ',dist);

// console.log('Array: ',sphere,' - Vector: ', vsphere );

debugger;
