if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var point1 = [1,0,0]
console.log( 'points :',point1 );
var src = null;
// var got = _.box.fromPoints( src , points);
 var got = _.box.pointExpand( src , point1);
console.log( 'box centered :',got );

var point2 = [0,1,0]
console.log( 'points :',point2 );
// var got = _.box.fromPoints( src , points);
 var got = _.box.pointExpand( got , point2);
console.log( 'box centered :',got );

var point3 = [0,0,1]
console.log( 'points :',point3 );
// var got = _.box.fromPoints( src , points);
 var got = _.box.pointExpand( got , point3);
console.log( 'box centered :',got );

var point4 = [-1,-1,-1]
console.log( 'points :',point4 );
// var got = _.box.fromPoints( src , points);
 var got = _.box.pointExpand( got , point4);
console.log( 'box centered :',got );

var point5 = [2,-2,0]
console.log( 'points :',point5 );
// var got = _.box.fromPoints( src , points);
 var got = _.box.pointExpand( got , point5);
console.log( 'box centered :',got );
