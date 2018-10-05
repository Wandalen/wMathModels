
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var sphere = [ 4, 4, 4, 1 ];
var segment = [ 4, 0, 4, 4, 10, 4 ];
var result = _.sphere.lineIntersects( sphere, segment );
console.log( result )
var result = _.sphere.lineDistance( sphere, segment );
console.log( result )
var result = _.sphere.segmentIntersects( sphere, segment );
console.log( result )
var result = _.sphere.segmentDistance( sphere, segment );
console.log( result )
debugger;
console.log(_.sphere.makeNil( 3 ))
