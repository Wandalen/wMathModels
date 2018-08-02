if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var plane1 = [ 1, 0, 0, -2.5 ];


var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
([
  0,   0,   0,   0, - 1,   1,
  1, - 1,   0,   0,   0,   0,
  0,   0,   1, - 1,   0,   0,
  - 1,   0, - 1,   0,   0, - 1
]);

var j = _.plane.frustumClosestPoint( plane1, srcFrustum, _.vector.from( [ 0, 0, 0 ] ) )
console.log( j );
debugger;
