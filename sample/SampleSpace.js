if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

let  m = _.Space.makeSquare([
    1, 2, 3,
    2, 1, 2,
    0, 1, 2
  ]);
let  i = m.clone();
console.log( m.triangulateLuNormal().toStr() )

i.invert( );
// console.log('m', m);
m = _.Space.from( m );
i = _.Space.from( i );

let r = _.Space.mul( null,[ m, i ] );
// console.log( r )
