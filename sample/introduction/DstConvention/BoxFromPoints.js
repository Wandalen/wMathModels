if( typeof module !== 'undefined' )
var _ = require( '../../..' );

var _ = wTools;

var pointA = [ 3, 1, 3 ];
var pointB = [ 3, 8, 3 ];
var box = _.box.fromPoints( null, [ pointA, pointB ] );
console.log( 'Box: ', box );
/* log : Box: [ 3, 1, 3, 3, 8, 3 ] */