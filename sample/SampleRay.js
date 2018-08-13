
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

let _ = wTools;

let o =
{
  x : null,
  m : _.Space.makeSquare
  ([
    +2,+2,
    -2,-3
  ]),
  y : _.Space.makeCol([ 0,3 ]),
  kernel : null,
  pivoting : 1,
}

let x = _.Space.solveGeneral( o );
logger.log( x )
