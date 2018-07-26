
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var box = [ 3, 3, 3, 4, 4, 4 ];
var frustum =  _.Space.make( [ 4, 6 ] ).copy
([
  0,   0,   0,   0, - 1,   1,
  1, - 1,   0,   0,   0,   0,
  0,   0,   1, - 1,   0,   0,
  - 1,   0, - 1,   0,   0, - 1 ]
);

var gotBool = _.box.frustumDistance( box, frustum );
console.log( gotBool );
