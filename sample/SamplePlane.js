if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

let plane1 = [ 1, 0, 0, 0 ];

let line = [ [ 2, 2, 2 ], [ 3, 0, 2 ] ];
debugger;
let j = _.plane.lineIntersects( plane1, line )
console.log( j );
debugger;
