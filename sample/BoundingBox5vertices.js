if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var point1 = _.avector.arrayMakeRandom(3);
console.log( 'points :',point1 );
var src = null;
 var got = _.box.pointExpand( src , point1);
console.log( 'box centered :',got );

var point2 = _.avector.arrayMakeRandom(3);
console.log( 'points :',point2 );
 var got = _.box.pointExpand( got , point2);
console.log( 'box centered :',got );

var point3 = _.avector.arrayMakeRandom(3);
console.log( 'points :',point3 );
 var got = _.box.pointExpand( got , point3);
console.log( 'box centered :',got );

var point4 = _.avector.arrayMakeRandom(3);
console.log( 'points :',point4 );
 var got = _.box.pointExpand( got , point4);
console.log( 'box centered :',got );

var point5 = _.avector.arrayMakeRandom(3);
console.log( 'points :',point5 );
 var got = _.box.pointExpand( got , point5);
console.log( 'box centered :',got );
