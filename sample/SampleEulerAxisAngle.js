if( typeof module !== 'undefined' )
require( 'wmathconcepts' );
var _ = wTools;

debugger;

var euler1 = _.euler.make();

euler1 =[ 7.85366, 7.85429, 1.04719, 0, 1, 2];
dst = [ 0, 0, 0, 1, 2, 0 ];
var axis = [ 1, 1, 0, Math.PI ] ;
var angle = Math.PI;

// Case 1: - _.euler Conversion methods
dstEuler = _.euler.fromAxisAndAngle2( dst, axis, angle );
//logger.log( dstEuler )
//logger.log( dst )

var axisAndAngle = [ 0, 0, 0, 0 ];

// Case 1: - _.euler Conversion methods
var dstAA = _.euler.toAxisAndAngle2( dstEuler, axisAndAngle );
logger.log( dstAA )
logger.log( axisAndAngle )
