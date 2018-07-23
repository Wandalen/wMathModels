if( typeof module !== 'undefined' )
require( 'wmathconcepts' );
var _ = wTools;

debugger;

var euler1 = _.euler.make();

dst = [ 0, 0, 0, 1, 2, 0 ];
var axis = [ 1, 1, 0, Math.PI ] ;
var angle = Math.PI;

dstEuler = _.euler.fromAxisAndAngle2( dst, axis, angle );

var axisAndAngle = [ 0, 0, 0, 0 ];

var dstAA = _.euler.toAxisAndAngle2( dstEuler, axisAndAngle );
logger.log( dstAA );
logger.log( axisAndAngle );
