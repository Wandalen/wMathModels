if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;


//var space = [ [ 1, 1, 1, 1 ], [ - 1, 1, 1, 1 ], [ 1, - 1, 1, 1 ], [ 1, 1, - 1, 1 ] ];
//var vspa = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 ];
var v = [ 9, 9, 8, 8 ];
v = _.vector.fromArray( v );
var Spa = _.Space.make([ 4,4 ]);
Spa.atomSet( [ 0, 0 ], 1 ); Spa.atomSet( [ 1, 0 ], 0 ); Spa.atomSet( [ 2, 0 ], 0 ); Spa.atomSet( [ 3, 0 ], - 1 );
Spa.atomSet( [ 0, 1 ], 0 ); Spa.atomSet( [ 1, 1 ], 1 ); Spa.atomSet( [ 2, 1 ], 0 ); Spa.atomSet( [ 3, 1 ], 0 );
Spa.atomSet( [ 0, 2 ], 0 ); Spa.atomSet( [ 1, 2 ], 0 ); Spa.atomSet( [ 2, 2 ], 1 ); Spa.atomSet( [ 3, 2 ], 0 );
Spa.atomSet( [ 0, 3 ], - 1 ); Spa.atomSet( [ 1, 3 ], - 1 ); Spa.atomSet( [ 2, 3 ], - 1 ); Spa.atomSet( [ 3, 3 ], 1 );
console.log('space: 4 - 4:  ',Spa);
//space = _.vector.fromArray( space );
//space = _.Space.from( space );

//console.log('space:',space);

var f = _.frustum.fromMatrixHomogenous( null , Spa);

debugger;

console.log('frustum:',f);
var sphere = [ 4, 4, 4, 1 ];
var expected = _.frustum.sphereIntersects( f, sphere );
console.log('Intersection:',expected);


debugger;
