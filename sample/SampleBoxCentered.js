
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var box = [ 0, 0, 0, 0.5, 1, 1 ];
var frustum =  _.Space.make( [ 4, 6 ] ).copy
([
  0,   0,   0,   0, - 1,   1,
  1, - 1,   0,   0,   0,   0,
  0,   0,   1, - 1,   0,   0,
  - 1,   0, - 1,   0,   0, - 1 ]
);

var gotBool = _.box.frustumContains( box, frustum );
console.log( gotBool );
