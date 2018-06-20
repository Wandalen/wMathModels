if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;


debugger;
var srcfrustum = _.Space.make( [ 4, 6 ] ).copy(
   [ - 1, 1, 0, 0, 0, 0,
     0, 0, 0, 0, - 1, 1,
     0, 0, 1, - 1, 0, 0,
     0, - 1, - 1, 0, 0, - 1 ] );

 var dims = _.Space.dimsOf( srcfrustum ) ;
 var rows = dims[ 0 ];
 var cols = dims[ 1 ];

var pointsFru = _.Space.makeZero( [ rows - 1, cols + 2 ] );

var l = 0;
debugger;
for( var i = 0 ; i < cols - 2 ; i++ )
{
  debugger;
  for( var j = i + 1 ; j < cols - 1 ; j++ )
  {
    debugger;
    for( var k = j + 1 ; k < cols ; k++ )
    {
      var plane1 = srcfrustum.colVectorGet( i );
      var plane2 = srcfrustum.colVectorGet( j );
      var plane3 = srcfrustum.colVectorGet( k );
      var point = _.plane.threeIntersectionPoint( plane1, plane2, plane3 );
      debugger;
      if ( !_.vectorIs( point ) ){}
      else{
        for( var m = 0 ; m < rows - 1; m++ )
        {
          debugger;
          point = _.vector.toArray( point );
          pointsFru.atomSet( [ m, l ], point[ m ] );
        }
        l = l + 1;
      }
    }
   }
}

console.log('Corners of frustum: ');
for( var i = 0 ; i < 8 ; i++ )
{
  col = _.vector.toArray(pointsFru.colVectorGet( i ));
console.log(col);
}


debugger;





//var expected = _.frustum.frustumIntersect( srcfrustum, testfrustum );

//console.log('Intersection:', expected);


debugger;
