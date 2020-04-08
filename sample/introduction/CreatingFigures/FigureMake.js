
if( typeof module !== 'undefined' )
var _ = require( '../../..' );

var _ = wTools;

//Make sphere using default dimensions

var sphere = _.sphere.make();
console.log( 'Sphere : ', sphere );
/* log : Sphere : [ 0, 0, 0, 0 ] */

//Make 2D sphere

var sphere = _.sphere.make( 2 );
console.log( 'Sphere : ', sphere );
/* log : Sphere : [ 0, 0, 0 ] */
