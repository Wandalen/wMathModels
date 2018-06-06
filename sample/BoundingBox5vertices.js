if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;
var maxdim = 10000; //maximum dimension of the box

var point1 = _.avector.arrayMakeRandom(3);
point1[0] = Math.ceil(point1[0]*maxdim);
point1[1] = Math.ceil(point1[1]*maxdim);
point1[2] = Math.ceil(point1[2]*maxdim);
console.log( 'points :',point1 );
var src = null;
 var got = _.box.pointExpand( src , point1);
console.log( 'box centered :',got );

var point2 = _.avector.arrayMakeRandom(3);
point2[0] = Math.ceil(point2[0]*maxdim);
point2[1] = Math.ceil(point2[1]*maxdim);
point2[2] = Math.ceil(point2[2]*maxdim);
console.log( 'points :',point2 );
 var got = _.box.pointExpand( got , point2);
console.log( 'box centered :',got );

var point3 = _.avector.arrayMakeRandom(3);
point3[0] = Math.ceil(point3[0]*maxdim);
point3[1] = Math.ceil(point3[1]*maxdim);
point3[2] = Math.ceil(point3[2]*maxdim);

console.log( 'points :',point3 );
 var got = _.box.pointExpand( got , point3);
console.log( 'box centered :',got );

var point4 = _.avector.arrayMakeRandom(3);
point4[0] = Math.ceil(point4[0]*maxdim);
point4[1] = Math.ceil(point4[1]*maxdim);
point4[2] = Math.ceil(point4[2]*maxdim);
console.log( 'points :',point4 );
 var got = _.box.pointExpand( got , point4);
console.log( 'box centered :',got );

var point5 = _.avector.arrayMakeRandom(3);
point5[0] = Math.ceil(point5[0]*maxdim);
point5[1] = Math.ceil(point5[1]*maxdim);
point5[2] = Math.ceil(point5[2]*maxdim);
console.log( 'points :',point5 );
 var got = _.box.pointExpand( got , point5);
console.log( 'box centered :',got );
