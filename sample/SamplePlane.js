if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

let plane1 = [ 0, 0, 1, 2 ];

let line = [ 3, 3, 0, 0, -1, 0 ];
debugger;
let j = _.plane.lineIntersects2( plane1, line )
console.log( j );

j = _.plane.lineDistance( plane1, line )
console.log( j );

j = _.plane.lineClosestPoint( plane1, line )
console.log( j );
debugger;
