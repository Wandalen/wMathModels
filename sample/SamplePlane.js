if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var plane = [ 1, 0, 0, 0 ];
var offset = [ NaN, NaN, NaN ];
//var m = Math.matrix.fromArray( [ - 2, 0, 0, 1, 0, 2, 0, 1, 0, 0, 0, 1, 0, 0, 3, 1 ] );
//point = _.vector.from( point );

console.log('Plane: ', plane, ' - Offset: ', offset );
var inter = _.plane.translate( plane , offset );

console.log('line intersection: ', plane);
