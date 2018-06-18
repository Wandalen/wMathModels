if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var plane = [ 1, 0, 0, 0 ];
var line = [ [ - 2, 0, 0 ], [ 0, 0, 0 ] ];
//point = _.vector.from( point );

console.log('Plane: ', plane, ' - Line: ', line[0], ' - ', line[1] );
var inter = _.plane.lineIntersects( plane , line );

console.log('line intersection: ', inter);
