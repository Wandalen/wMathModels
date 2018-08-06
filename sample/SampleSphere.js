
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var box = [ 0, 0, 0, 1, 1, 1 ];
var srcSphere = _.vector.from( [ 3, 3, 3, 1 ] );
var result = _.sphere.boxDistance( srcSphere, box );
logger.log( result )
var result = _.box.sphereDistance( box, srcSphere );
logger.log( result )
