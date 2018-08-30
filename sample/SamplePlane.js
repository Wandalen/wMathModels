if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

let plane1 = [ 1, 0, 0, -0.5 ];

let ray = [ 2, 2, 2, 1, 1, 1 ];

let j = _.plane.rayClosestPoint( plane1, ray )
console.log( j );
debugger;
