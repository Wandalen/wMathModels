if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var src = null;
var pointOne = _.avector.arrayMakeRandom( 3 );
var pointTwo = _.avector.arrayMakeRandom( 3 );
var pointThree = _.avector.arrayMakeRandom( 3 );
var pointFour = _.avector.arrayMakeRandom( 3 );
var pointFive = _.avector.arrayMakeRandom( 3 );
var points = [ pointOne, pointTwo, pointThree, pointFour, pointFive ]

var got = _.box.fromPoints( src, points );

console.log( 'P1 :', pointOne );
console.log( 'P2 :', pointTwo );
console.log( 'P3 :', pointThree );
console.log( 'P4 :', pointFour );
console.log( 'P5 :', pointFive );
console.log( 'box centered :', got );
