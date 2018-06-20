if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;


debugger;
var srcfrustum = _.Space.make( [ 4, 6 ] ).copy(
   [ 0,   0,   0,   0, - 1,   1,
     1, - 1,   0,   0,   0,   0,
     0,   0,   1, - 1,   0,   0,
   - 1,   0, - 1,   0,   0, - 1 ] );

var pointsFru = _.frustum.frustumCorners( srcfrustum );


console.log('Corners of frustum: ');
for( var i = 0 ; i < 8 ; i++ )
{
  col = _.vector.toArray(pointsFru.colVectorGet( i ));
console.log(col);
}


debugger;


debugger;
