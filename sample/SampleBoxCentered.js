
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var b = [ 4, 4, 5, 5 ];
var mat = _.Space.make( [ 3, 3 ] ).copy
  ([
    0.5, 0, 0,
    0, 0.5, 0,
    0, 0, 1
  ]);
var box = _.box.matrixHomogenousApply( b, mat );
console.log( box )
debugger;
