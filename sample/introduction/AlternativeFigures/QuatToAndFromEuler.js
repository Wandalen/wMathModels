if( typeof module !== 'undefined' )
var _ = require( '../../..' );

var _ = wTools;

var euler =  [ 1, 0, 0.5, 0, 1, 2 ] ;
console.log( 'Euler:', _.toStr( euler, { precision : 2 } ) )
/* log : Euler: [ 1.0, 0.0, 0.50, 0.0, 1.0, 2.0 ] */

var quat = _.euler.toQuat( euler, null );
console.log( 'Quat from Euler:', _.toStr( quat, { precision : 2 } ) )
/* log : Quat from Euler: [ 0.46, -0.12, 0.22, 0.85 ] */

var euler2 = _.quat.toEuler( quat, null );
console.log( 'Euler from Quat:', _.toStr( euler2, { precision : 2 } ) )
/* log : Euler from Quat: [ 1.0, 0.0, 0.50, 0.0, 1.0, 2.0 ] */