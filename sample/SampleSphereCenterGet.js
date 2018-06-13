if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var sphere = [ 0, 0, 2, 2, 3 ];
var Oldsphere = [ 0, 0, 2, 2, 3 ];
var dst = [ 1, 2, 3, 4 ];
var vdst = _.vector.from( dst );
var vsphere = _.vector.from( sphere );
var radius = 3;


// console.log('Array: ',sphere,' - Vector: ', vsphere );
debugger;

console.log('***************************************** - array + point');
var asphered = _.sphere.centerGet( sphere, dst );
console.log('++++++++++++++ asphered ', asphered,' - dst: ', dst);
console.log('***************************************** - vector + point');
var vsphered = _.sphere.centerGet( vsphere, vdst );
console.log('++++++++++++++ vsphered ', vsphered,' - vdst: ', vdst);

// console.log('Array: ',sphere,' - Vector: ', vsphere,' - Array: ',dst,' - Vector: ', vdst );

console.log('***************************************** - array');
var asphere = _.sphere.centerGet( sphere );
console.log('++++++++++++++ asphere ', asphere );
console.log('***************************************** - vector');
var vsphere = _.sphere.centerGet( vsphere );
console.log('++++++++++++++ vsphere ', vsphere );

debugger;
