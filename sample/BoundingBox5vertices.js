//
// Sample file for pointExpand(): Cretion of a box according to 5 random vertices
//

if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;
var src = null;
var got = null;

var pointOne = _.avector.arrayMakeRandom( 3 );
var pointTwo = _.avector.arrayMakeRandom( 3 );
var pointThree = _.avector.arrayMakeRandom( 3 );
var pointFour = _.avector.arrayMakeRandom( 3 );
var pointFive = _.avector.arrayMakeRandom( 3 );

console.log( 'point 1 :', pointOne );
console.log( 'point 2 :', pointTwo );
console.log( 'point 3 :', pointThree );
console.log( 'point 4 :', pointFour );
console.log( 'point 5 :', pointFive );

got = _.box.pointExpand( src, pointOne );
got = _.box.pointExpand( got, pointTwo );
got = _.box.pointExpand( got, pointThree );
got = _.box.pointExpand( got, pointFour );
got = _.box.pointExpand( got, pointFive );

console.log( 'box centered :', got );
