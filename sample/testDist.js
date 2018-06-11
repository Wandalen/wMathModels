if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var box = [ 0, 0, 0, 2, 2, 2 ];
const pointnotclamped = [ 1, 1, 3 ];
var point = pointnotclamped;

console.log( pointnotclamped );

debugger;

var clamped = _.box.pointClamp(box, point);

console.log(clamped,' vs ', pointnotclamped, ' vs ',point);

dist2 = _.avector.distance(pointnotclamped, clamped);

debugger;

console.log(clamped,' vs ', pointnotclamped, ' vs ',point);

console.log( 'distance :',dist2 );
