
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

var segment = [ 0, 0, 0, 1, 0, 0 ];

let result = _.segment.boundingSphereGet( null, segment )
logger.log( 'Result :', result );
result = _.segment.boundingBoxGet( null, segment )
logger.log( 'Result :', result );


s1 = [ 2, -2, -2, 4, -2, 2 ];
s2 = [ 2, -2, 0, 4, -2, 0 ];
let f = _.segment.segmentIntersectionFactors( s1, s2)
console.log('factors', f)
