if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var plane = [ 4, 0, 0, 4, 0, 4, 8 ];
//point = _.vector.from( point );

console.log('Plane: ', plane );
var inter = _.plane.normalize( plane );

console.log('line intersection: ', plane);
