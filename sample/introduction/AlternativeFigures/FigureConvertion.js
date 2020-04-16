if( typeof module !== 'undefined' )
var _ = require( '../../..' );

var _ = wTools;

var linePoints1 = _.linePoints.from( [ 1, 1, 3, 3 ] );
var linePoints2 = _.linePoints.from( [ 2, 2, 3, 3 ] );
var point = _.linePoints.pairIntersectionPoint( linePoints1, linePoints2 );
console.log( 'Intersection point:', point.toString() );
/* log : Intersection point: 2,2 */

var linePointsDir1 = _.linePointDir.fromPoints2( linePoints1 );
var linePointsDir2 = _.linePointDir.fromPoints2( linePoints2 );
var point = _.linePointDir.lineIntersectionPoint( linePointsDir1, linePointsDir2 );
console.log( 'Intersection point:', point.toString() );
/* log : Intersection point: 2,2 */