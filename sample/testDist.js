if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var box = [ 0, 0, 0, 2, 2, 2 ];
var point = [ 1, 1, 3 ];
const pointnotclamped = point;
console.log( pointnotclamped );
var clamped = _.box.pointClamp(box, point);

// console.log(clamped,' vs ', pointnotclamped, ' vs ',point);

dist2 = _.avector.distance(pointnotclamped, clamped);
// console.log( 'distance :',dist2 );
