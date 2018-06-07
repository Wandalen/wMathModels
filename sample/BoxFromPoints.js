if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var src = null;
var pointOne = _.avector.arrayMakeRandom( 3 );
var pointTwo = _.avector.arrayMakeRandom( 3 );
var pointThree = _.avector.arrayMakeRandom( 3 );
var pointFour = _.avector.arrayMakeRandom( 3 );
var pointFive = _.avector.arrayMakeRandom( 3 );


var got = _.box.fromPoints( src, pointOne);
console.log( 'box centered :', pointOne );
console.log( 'box centered :', pointTwo );
console.log( 'box centered :', pointThree );
console.log( 'box centered :', got );
