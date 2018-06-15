if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var plane = [ 2, - 1, 3, 1 ];
var point = [ 4, 1, - 3 ];
point = _.vector.from( point );

var pointp = _.plane.pointCoplanarGet( plane , point );

console.log('point proyection on plane: ', point,' value: ', pointp);
