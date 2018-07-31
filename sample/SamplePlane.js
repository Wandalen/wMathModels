if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var plane1 = [ 1, 0, 0, -4 ];

var box = [  0, 0, 0, 2, 2, 2 ];

var i = _.plane.boxClosestPoint( plane1, box, _.vector.from( [ 0, 0, 0 ] ) );
console.log( i );
debugger;
