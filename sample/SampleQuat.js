if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;


debugger;
var q = _.quat.makeZero();
console.log('Zero q: ', q);
var q = _.quat.makeUnit( );
console.log('Zero q: ', q);
var q = _.quat.zero( q );
console.log('Zero q: ', q);
debugger;

var euler = [ 1, 0, 0, 0, 0, 1 ];
q = _.quat.fromEuler( q, euler );
console.log('Zero q: ', q);
