if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var f = _.Space.make( [ 4, 6 ] ).copy(
   [ 1, 0, 0, - 1, 0, 0,
     0, 1, 0, 0, - 1, 0,
     0, 0, 1, 0, 0, - 1,
     1, 1, 1, 1, 1, 1 ] );

var b = _.Space.make( [ 3, 6 ] ).copy(
        [ 0, 0, 0, 1, 1, 1,
        0, 0, 0, 1, 1, 1,
        0, 0, 0, 1, 1,  1,] );
//console.log('space: 4 - 4:  ',Spa);

//var f = _.frustum.fromMatrixHomogenous( null , Spa);

debugger;

console.log('frustum:',f);

//console.log('++++++++++++++++++++++++++++++++',Math.min(box[ 0 ]));
//console.log('++++++++++++++++++++++++++++++++',box.min[ 0 ]);
var expected = _.frustum.boxIntersects( f, b );
console.log('Intersection:',expected);


debugger;
