if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

let plane1 = [ -1, 0, 0, 0 ];

let segment = [ 2, 2, 2, 3, 3, 3 ];
debugger;

j = _.plane.segmentClosestPoint( plane1, segment )
console.log( j );
debugger;
