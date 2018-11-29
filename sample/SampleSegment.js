
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

s1 = [ -3, 0, 2, 0 ];
s2 = [ 0, -2, 0, 1 ];
let f = _.segment.segmentIntersectionFactors( s1, s2)
console.log('factors', f)
