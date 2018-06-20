if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var srcfrustum = _.Space.make( [ 4, 6 ] ).copy(
   [ - 1, 1, 0, 0, 0, 0,
     0, 0, 0, 0, - 1, 1,
     0, 0, 1, - 1, 0, 0,
     0, - 1, - 1, 0, 0, - 1 ] );

var far1 = srcfrustum.colVectorGet( 0 );
var near1 = srcfrustum.colVectorGet( 1 );
var top1 = srcfrustum.colVectorGet( 2 );
var bottom1 = srcfrustum.colVectorGet( 3 );
var left1 = srcfrustum.colVectorGet( 4 );
var right1 = srcfrustum.colVectorGet( 5 );

var p001 = _.plane.threeIntersectionPoint( far1, top1, left1 );
var p011 = _.plane.threeIntersectionPoint( far1, top1, right1 );
var p000 = _.plane.threeIntersectionPoint( far1, bottom1, left1 );
var p010 = _.plane.threeIntersectionPoint( far1, bottom1, right1 );
var p101 = _.plane.threeIntersectionPoint( near1, top1, left1 );
var p111 = _.plane.threeIntersectionPoint( near1, top1, right1 );
var p100 = _.plane.threeIntersectionPoint( near1, bottom1, left1 );
var p110 = _.plane.threeIntersectionPoint( near1, bottom1, right1 );

for( var d = 0 ; d < 8 ; d++ )
if( min.eGet( d ) > max.eGet( d ) )
return true;

console.log('000: ',p000 ,'  001; ',p001,'  010: ',p010 ,'  100; ',p100);
console.log('011: ',p011 ,'  101; ',p101,'  110: ',p110 ,'  111; ',p111);


var testfrustum = _.Space.make( [ 4, 6 ] ).copy(
    [ 1, 0, 0, - 1, 0, 0,
      0, 1, 0, 0, - 1, 0,
      0, 0, 1, 0, 0, - 1,
      1, 1, 1, 1, 1, 1 ] );



debugger;





//var expected = _.frustum.frustumIntersect( srcfrustum, testfrustum );

//console.log('Intersection:', expected);


debugger;
