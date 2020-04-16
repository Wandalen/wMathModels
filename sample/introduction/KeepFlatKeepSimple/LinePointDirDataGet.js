
if( typeof module !== 'undefined' )
var _ = require( '../../..' );

var _ = wTools;

//How to get origin point
let line = _.linePointDir.from( [ 1, 2, 3, 4 ] );
let origin = _.linePointDir.originGet( line );
console.log( 'Origin: ', origin.toStr() );
/* log : Origin : "1.000 2.000" */

//How to get direction vector
let line = _.linePointDir.from( [ 1, 2, 3, 4 ] );
let direction = _.linePointDir.directionGet( line );
console.log( 'Direction: ', direction.toStr() );
/* log : Origin : "3.000 4.000" */
