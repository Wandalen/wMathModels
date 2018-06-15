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
