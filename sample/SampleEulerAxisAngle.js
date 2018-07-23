if( typeof module !== 'undefined' )
require( 'wmathconcepts' );
var _ = wTools;

debugger;

var euler1 = _.euler.make();

dst = [ 0, 0, 0, 1, 2, 0 ];
var axis = [ 1, 1, 0 ] ;
var angle = Math.PI;
var aa = [ 1, 1, 0, Math.PI ];

dstEuler = _.euler.fromAxisAndAngle2( dst, axis, angle );
logger.log( dstEuler );

var axisAndAngle = [ 0, 0, 0, 0 ];

var dstAA = _.euler.toAxisAndAngle2( dstEuler, axisAndAngle );
logger.log( dstAA );
logger.log( axisAndAngle );
