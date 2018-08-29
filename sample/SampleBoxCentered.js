
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

let box = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
// var point = new Float32Array([ 454.8794860839844, 7893.02783203125, -7698.6318359375 ]);
let corners = _.box.cornersGet( box );
logger.log( corners )
debugger;
