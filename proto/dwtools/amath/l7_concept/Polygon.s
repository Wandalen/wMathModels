(function _Polygon_s_(){

'use strict';

let _ = _global_.wTools;
// let this.tools.avector = this.tools.avector;
// let vector = this.tools.vectorAdapter;
let Self = _.polygon = _.polygon || Object.create( _.avector );

// --
// routines
// --

function pointContains( polygon, point )
{
  let self = this;
  //let c = [ point[ 0 ], point[ 1 ], 1 ];
  let line21 = [];
  let line20 = [];
  let p = 0;
  let pl = polygon.length / 2;
  let inside = 0;

  _.assert( pl === 2, 'not implemented' );

  //

  function pointsPointSide( points, point )
  {

    let point1 = [];
    point1[ 0 ] = points[ 0 ][ 0 ] - point[ 0 ];
    point1[ 1 ] = points[ 0 ][ 1 ] - point[ 1 ];

    let point2 = [];
    point2[ 0 ] = points[ 1 ][ 0 ] - point[ 0 ];
    point2[ 1 ] = points[ 1 ][ 1 ] - point[ 1 ];

    if( point1[ 0 ] < 0 && point2[ 0 ] < 0 )
    return false;

    if( point1[ 0 ] > 0 && point2[ 0 ] > 0 )
    return false;

    if( point1[ 0 ] === point2[ 0 ] )
    {
      if( point1[ 1 ] < 0 && point2[ 1 ] < 0 )
      return false;

      if( point1[ 1 ] > 0 && point2[ 1 ] > 0 )
      return false;

      return 2;
    }

    let upper = point2[ 1 ] - point2[ 0 ] * ( point1[ 1 ]-point2[ 1 ] ) / ( point1[ 0 ]-point2[ 0 ] );

    if( upper === 0 )
    return 2;

    return upper >= 0;
  }

  //

  let p1 = [ polygon[ (pl-1)*2+0 ], polygon[ (pl-1)*2+1 ] ];
  let p2 = [ polygon[ (p+0)*2+0 ], polygon[ (p+0)*2+1 ] ];
  let side = pointsPointSide( [ p1, p2 ], point );
  if( side === 2 ) return 1;
  inside = inside + side;

  //

  for( p = 1 ; p < pl ; p++ )
  {

    let p1 = [ polygon[ (p-1)*2+0 ], polygon[ (p-1)*2+1 ] ];
    let p2 = [ polygon[ (p+0)*2+0 ], polygon[ (p+0)*2+1 ] ];
    let side = pointsPointSide( [ p1, p2 ], point );
    if( side === 2 ) return p+1;
    inside = inside + side;

  }

  return inside % 2 ? pl+1 : 0;
}

// --
// declare
// --


let Extension = /* qqq xxx : normalize order */
{

  pointContains,

  // ref

  tools : _,
}

_.mapExtend( Self, Extension );

})();
