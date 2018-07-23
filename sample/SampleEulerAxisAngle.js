if( typeof module !== 'undefined' )
require( 'wmathconcepts' );
var _ = wTools;

debugger;

var euler1 = _.euler.make();

euler1 =[ 7.85366, 7.85429, 1.04719, 0, 1, 2];
dst = [ 0, 0, 0, 1, 2, 0 ];
var axis = _.vector.from( [ 1, 1, 0, Math.PI ] );
var angle = Math.PI;

// Case 1: - _.euler Conversion methods
dstEuler = _.euler.fromAxisAndAngle2( dst, axis );
logger.log( dstEuler )
