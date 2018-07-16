(function _Quat_s_(){

'use strict'; /**/

var _ = _global_.wTools;
var avector = _.avector;
var vector = _.vector;
var pi = Math.PI;
var sin = Math.sin;
var cos = Math.cos;
var asin = Math.asin;
var acos = Math.acos;
var abs = Math.abs;
var sqr = _.sqr;
var sqrt = _.sqrt;

_.assert( !_.quat );
var Self = _.quat = _.quat || Object.create( _.avector );

// --
//
// --

function make( src )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( src === undefined || src === null || _.quat.is( src ) );
  var result = _.quat.makeUnit();
  if( _.quat.is( src ) )
  _.avector.assign( result,src );
  return result;
}

//

function makeZero()
{
  _.assert( arguments.length === 0 );
  var result = _.dup( 0,4 );
  return result;
}

//

function makeUnit()
{
  _.assert( arguments.length === 0 );
  var result = _.dup( 0,4 );
  result[ 3 ] = 1;
  return result;
}

//

function zero( quat )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( quat === undefined || quat === null || _.quat.is( quat ) );

  if( _.quat.is( quat ) )
  {
    var quatv = _.quat._from( quat );
    quatv.assign( 0 );
    return quat;
  }

  return _.quat.makeZero();
}

//

function unit( quat )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( quat === undefined || quat === null || _.quat.is( quat ) );

  if( _.quat.is( quat ) )
  {
    var quatv = _.quat._from( quat );
    quatv.assign( 0 );
    quatv.eSet( 3,1 );
    return quat;
  }

  return _.quat.makeUnit();
}

//

function from( quat )
{

  _.assert( quat === null || _.quat.is( quat ),'expects quaternion' );
  _.assert( arguments.length === 1, 'expects single argument' );

  if( quat === null )
  return _.quat.make();

  if( _.vectorIs( quat ) )
  {
    debugger;
    xxx
    quat.toArray();
    // throw _.err( 'not implemented' );
    // return quat.slice();
  }

  return quat;
}

//

function _from( quat )
{
  _.assert( /*quat === null ||*/ _.quat.is( quat ),'expects quaternion' );
  _.assert( arguments.length === 1, 'expects single argument' );

  // if( quat === null )
  // quat = _.quat.make();

  return _.vector.from( quat );
}

//

function fromEuler( dst, euler, v )
{

  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  var dst = _.quat.from( dst );
  var dstv = _.vector.from( dst );
  var eulerv = _.euler._from( euler );

  var ox = eulerv.eGet( 3 );
  var oy = eulerv.eGet( 4 );
  var oz = eulerv.eGet( 5 );

  var e1 = eulerv.eGet( 0 );
  var e2 = eulerv.eGet( 1 );
  var e3 = eulerv.eGet( 2 );

  var c1 = cos( e1 / 2 );
  var c2 = cos( e2 / 2 );
  var c3 = cos( e3 / 2 );
  var s1 = sin( e1 / 2 );
  var s2 = sin( e2 / 2 );
  var s3 = sin( e3 / 2 );

  var cs1 = s1 * c2 * c3;
  var cs2 = c1 * s2 * c3;
  var cs3 = c1 * c2 * s3;
  var c = c1 * c2 * c3;

  var sc1 = c1 * s2 * s3;
  var sc2 = s1 * c2 * s3;
  var sc3 = s1 * s2 * c3;
  var s = s1 * s2 * s3;

  var vars = [ c,cs1,cs2,cs3,s,sc1,sc2,sc3 ];
  // logger.log( 'vars',vars.slice().sort() );

  // var xsign = ox === 0 ? oy === 1 : ox === 1;
  // var ysign = ox === 1 ? oy === 2 : ox === 2;
  // var zsign = ox === 2 ? oy === 0 : ox === 0;
  var wsign = ( ( ox !== 0 ) + ( oy !== 1 ) + ( oz !== 2 ) ) === 2;

  // xsign = xsign ? +1 : -1;
  // ysign = ysign ? +1 : -1;
  // zsign = zsign ? +1 : -1;
  wsign = wsign ? +1 : -1;

  var axisTwice = ox === oz;

  if( axisTwice )
  {
    wsign *= -1;
    if( ( ox === 0 && oy === 1 ) || ( ox === 1 && oy === 0 ) )
    oz = 2;
    else if( ( ox === 0 && oy === 2 ) || ( ox === 2 && oy === 0 ) )
    oz = 1;
    else if( ( ox === 1 && oy === 2 ) || ( ox === 2 && oy === 1 ) )
    oz = 0;
    else _.assert( 0 );
  }

  // console.log( 'xsign',xsign );
  // console.log( 'ysign',ysign );
  // console.log( 'zsign',zsign );
  // console.log( 'wsign',wsign );

  // if( 0 )
  // if( ox === 2 && oy === 1 && oz === 0 ) /* zyx */
  // {
  //
  //   dstv.eSet( 0, c1*c2*s3 - s1*s2*c3 );
  //   dstv.eSet( 1, c1*s2*c3 + s1*c2*s3 );
  //   dstv.eSet( 2, s1*c2*c3 - c1*s2*s3 );
  //   dstv.eSet( 3, c1*c2*c3 + s1*s2*s3 );
  //
  //   // dstv.eSet( 0, 3 - 7 );
  //   // dstv.eSet( 1, 2 + 6 );
  //   // dstv.eSet( 2, 1 - 5 );
  //   // dstv.eSet( 3, 0 + 4 );
  //
  //   // var vars = [ c,cs1,cs2,cs3,s,sc1,sc2,sc3 ];
  //   // var vars = [ 0,  1,  2,  3,4,  5,  6,  7 ];
  //
  //   // var vars = [ c1*c2*c3,s1*c2*c3,c1*s2*c3,c1*c2*s3, s1*s2*s3,c1*s2*s3,s1*c2*s3,s1*s2*c3 ];
  //   // var vars = [ 0,       1,       2,       3,        4,       5,       6,       7 ];
  //
  // }

  if( !axisTwice )
  {
    dstv.eSet( ox, cs1 - sc1*wsign );
    dstv.eSet( oy, cs2 + sc2*wsign );
    dstv.eSet( oz, cs3 - sc3*wsign );
    dstv.eSet( 3,  c   +   s*wsign );
  }
  else if( ox === 0 && oy === 1 ) /* xyx */
  {

    dstv.eSet( 0, s1*c2*c3 + c1*c2*s3 );
    dstv.eSet( 1, c1*s2*c3 + s1*s2*s3 );
    dstv.eSet( 2, s1*s2*c3 - c1*s2*s3 );
    dstv.eSet( 3, c1*c2*c3 - s1*c2*s3 );

    // dstv.eSet( 0, 1 + 3 );
    // dstv.eSet( 1, 2 + 4 );
    // dstv.eSet( 2, 7 - 5 );
    // dstv.eSet( 3, 0 - 6 );

    // var vars = [ c1*c2*c3,s1*c2*c3,c1*s2*c3,c1*c2*s3, s1*s2*s3,c1*s2*s3,s1*c2*s3,s1*s2*c3 ];
    // var vars = [ 0,       1,       2,       3,        4,       5,       6,       7 ];

    // dstv.eSet( ox, cs1 + cs3*wsign );
    // dstv.eSet( oy, cs2 + s*wsign );
    // dstv.eSet( oz, sc3 - sc1*wsign );
    // dstv.eSet( 3,  c   - sc2*wsign );

  }
  else if( ox === 0 && oy === 2 ) /* xzx */
  {

    dstv.eSet( 0, s1*c2*c3 + c1*c2*s3 );
    dstv.eSet( 1, c1*s2*s3 - s1*s2*c3 );
    dstv.eSet( 2, c1*s2*c3 + s1*s2*s3 );
    dstv.eSet( 3, c1*c2*c3 - s1*c2*s3 );

    // dstv.eSet( 0, 1 + 3 );
    // dstv.eSet( 1, 5 - 7 );
    // dstv.eSet( 2, 2 + 4 );
    // dstv.eSet( 3, 0 - 6 );

    // var vars = [ c1*c2*c3,s1*c2*c3,c1*s2*c3,c1*c2*s3, s1*s2*s3,c1*s2*s3,s1*c2*s3,s1*s2*c3 ];
    // var vars = [ 0,       1,       2,       3,        4,       5,       6,       7 ];

  }
  else if( ox === 1 && oy === 0 ) /* yxy */
  {

    dstv.eSet( 0, c1*s2*c3 + s1*s2*s3 );
    dstv.eSet( 1, s1*c2*c3 + c1*c2*s3 );
    dstv.eSet( 2, c1*s2*s3 - s1*s2*c3 );
    dstv.eSet( 3, c1*c2*c3 - s1*c2*s3 );

    // dstv.eSet( 0, 2 + 4 );
    // dstv.eSet( 1, 1 + 3 );
    // dstv.eSet( 2, 5 - 7 );
    // dstv.eSet( 3, 0 - 6 );

    // var vars = [ c1*c2*c3,s1*c2*c3,c1*s2*c3,c1*c2*s3, s1*s2*s3,c1*s2*s3,s1*c2*s3,s1*s2*c3 ];
    // var vars = [ 0,       1,       2,       3,        4,       5,       6,       7 ];

  }
  else if( ox === 1 && oy === 2 ) /* yzy */
  {

    dstv.eSet( 0, s1*s2*c3 - c1*s2*s3 );
    dstv.eSet( 1, s1*c2*c3 + c1*c2*s3 );
    dstv.eSet( 2, c1*s2*c3 + s1*s2*s3 );
    dstv.eSet( 3, c1*c2*c3 - s1*c2*s3 );

    // dstv.eSet( 0, 7 - 5 );
    // dstv.eSet( 1, 1 + 3 );
    // dstv.eSet( 2, 2 + 4 );
    // dstv.eSet( 3, 0 - 6 );

    // var vars = [ c1*c2*c3,s1*c2*c3,c1*s2*c3,c1*c2*s3, s1*s2*s3,c1*s2*s3,s1*c2*s3,s1*s2*c3 ];
    // var vars = [ 0,       1,       2,       3,        4,       5,       6,       7 ];

  }
  else if( ox === 2 && oy === 0 ) /* zxz */
  {

    dstv.eSet( 0, c1*s2*c3 + s1*s2*s3 );
    dstv.eSet( 1, s1*s2*c3 - c1*s2*s3 );
    dstv.eSet( 2, s1*c2*c3 + c1*c2*s3 );
    dstv.eSet( 3, c1*c2*c3 - s1*c2*s3 );

    // dstv.eSet( 0, 2 + 4 );
    // dstv.eSet( 1, 7 - 5 );
    // dstv.eSet( 2, 1 + 3 );
    // dstv.eSet( 3, 0 - 6 );

    // var vars = [ c,cs1,cs2,cs3,s,sc1,sc2,sc3 ];
    // var vars = [ 0,  1,  2,  3,4,  5,  6,  7 ];

    // var vars = [ c1*c2*c3,s1*c2*c3,c1*s2*c3,c1*c2*s3, s1*s2*s3,c1*s2*s3,s1*c2*s3,s1*s2*c3 ];
    // var vars = [ 0,       1,       2,       3,        4,       5,       6,       7 ];

  }
  else if( ox === 2 && oy === 1 ) /* zyz */
  {

    // dstv.eSet( 0, sc1 - sc3 );
    // dstv.eSet( 1, cs2 + s );
    // dstv.eSet( 2, cs1 + cs3 );
    // dstv.eSet( 3, c - sc2 );

    dstv.eSet( 0, c1*s2*s3 - s1*s2*c3 );
    dstv.eSet( 1, c1*s2*c3 + s1*s2*s3 );
    dstv.eSet( 2, s1*c2*c3 + c1*c2*s3 );
    dstv.eSet( 3, c1*c2*c3 - s1*c2*s3 );

    // dstv.eSet( 0, 5 - 7 );
    // dstv.eSet( 1, 2 + 4 );
    // dstv.eSet( 2, 1 + 3 );
    // dstv.eSet( 3, 0 - 6 );

    // var vars = [ c,cs1,cs2,cs3,s,sc1,sc2,sc3 ];
    // var vars = [ 0,  1,  2,  3,4,  5,  6,  7 ];

  }
  // else _.assert( 0 );

  /* */

  // if( v )
  // {
  //
  //   dstv.assign( -10 );
  //
  //   /* xyx : - */
  //   /* xzx : 1,2,0 */
  //   /* yxy : 2,0,1 */
  //   /* yzy : 1,2,0 */
  //   /* zxz : 2,0,1 */
  //   /* zyz : - */
  //
  //   dstv.eSet( 0, vars[ v.ox0 ] + vars[ v.ox1 ]*v.xs );
  //   dstv.eSet( 1, vars[ v.oy0 ] + vars[ v.oy1 ]*v.ys );
  //   dstv.eSet( 2, vars[ v.oz0 ] + vars[ v.oz1 ]*v.zs );
  //   dstv.eSet( 3, vars[ v.ow0 ] + vars[ v.ow1 ]*v.ws );
  //
  // }

  return dst;
}

// fromEuler.variates =
// {
//
//   // ox : [ 0,1,2,3 ],
//   // oy : [ 0,1,2,3 ],
//   // oz : [ 0,1,2,3 ],
//   // ow : [ 0,1,2,3 ],
//   // ow : [ 3 ],
//
//   // check : function()
//   // {
//   //   if( sample.ox0+sample.oy0+sample.oz0+sample.ow0 !== 6 )
//   //   return false;
//   // },
//
//   ox0 : [ 0,1,2,3, 4,5,6,7 ],
//   oy0 : [ 0,1,2,3, 4,5,6,7 ],
//   oz0 : [ 0,1,2,3, 4,5,6,7 ],
//   ow0 : [ 0,1,2,3, 4,5,6,7 ],
//
//   ox1 : [ 0,1,2,3, 4,5,6,7 ],
//   oy1 : [ 0,1,2,3, 4,5,6,7 ],
//   oz1 : [ 0,1,2,3, 4,5,6,7 ],
//   ow1 : [ 0,1,2,3, 4,5,6,7 ],
//
//   xs : [ +1,-1 ],
//   ys : [ +1,-1 ],
//   zs : [ +1,-1 ],
//   ws : [ +1,-1 ],
//
//   // x1 : [ +1,-1 ],
//   // y1 : [ +1,-1 ],
//   // z1 : [ +1,-1 ],
//   // w1 : [ +1,-1 ],
//
//   // ox2 : [ 0,1,2,3 ],
//   // oy2 : [ 0,1,2,3 ],
//   // oz2 : [ 0,1,2,3 ],
//   //
//   // x02 : [ +1,-1 ],
//   // y02 : [ +1,-1 ],
//   // z02 : [ +1,-1 ],
//   // w02 : [ +1,-1 ],
//   //
//   // x12 : [ +1,-1 ],
//   // y12 : [ +1,-1 ],
//   // z12 : [ +1,-1 ],
//   // w12 : [ +1,-1 ],
//
// }

//

function fromAxisAndAngle( dst, axisAndAngle, angle )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );

  dst = _.quat.from( dst );
  var dstv = _.vector.from( dst );
  var axisAndAnglev = _.axisAndAngle._from( axisAndAngle,angle );

  var halfAngle = axisAndAnglev.eGet( 3 ) / 2;
  var s = sin( halfAngle );

  dstv.eSet( 0, axisAndAnglev.eGet( 0 ) * s );
  dstv.eSet( 1, axisAndAnglev.eGet( 1 ) * s );
  dstv.eSet( 2, axisAndAnglev.eGet( 2 ) * s );
  dstv.eSet( 3, cos( halfAngle ) );

  return dst;
}

//

function toAxisAndAngle( quat, axisAndAngle )
{

  _.assert( _.accuracySqr > 0 );
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  var quat = _.quat.from( quat );
  var quatv = _.vector.from( quat );
  var axisAndAngle = _.axisAndAngle.from( axisAndAngle );
  var axisAndAnglev = _.vector.from( axisAndAngle );

  var w = quatv.eGet( 3 );

  if( abs( w-1 ) < _.accuracySqr )
  {
    axisAndAnglev.assign( 0 );
    axisAndAnglev.eSet( 3,0 );
    return axisAndAngle;
  }

  var halfAngle = acos( w );
  var s = sin( halfAngle );

  axisAndAnglev.eSet( 0, quatv.eGet( 0 ) / s );
  axisAndAnglev.eSet( 1, quatv.eGet( 1 ) / s );
  axisAndAnglev.eSet( 2, quatv.eGet( 2 ) / s );
  axisAndAnglev.eSet( 3, halfAngle * 2 );

  return axisAndAngle;
}

//

function fromVectors( dst, src1, src2 )
{

  _.assert( arguments.length === 3, 'expects exactly three argument' );

  var dst = _.quat.from( dst );
  var dstv = _.vector.from( dst );
  var dst3 = dstv.subarray( 0,3 );
  var dot = _.avector.dot( src1, src2 );

  dot += Math.sqrt( _.avector.magSqr( src1 ) * _.avector.magSqr( src2 ) );

  if( _.numbersAreEquivalent( dot, 0 ) )
  {

    dot = 0;
    dst3.assign([ - src1[ 2 ], src1[ 1 ], src1[ 0 ] ]);

  }
  else
  {

    _.avector.cross3( dst3,src1,src2 );

  }

  dstv.eSet( 3, dot );

  this.normalize( dstv );

  return dst;
}

//

function fromVectors2( src1,src2,axis )
{
  throw _.err( 'not tested' );

  src1 = _.vector.slice( src1 );
  src2 = _.vector.slice( src2 );

  var accuracy = 0.01;
  var v1 = src1.slice().normalize();
  var v2 = src2.slice().normalize();
  var d = v1.dot( v2 );
  var result = [ 0,0,0,1 ];

  if( d >= 1 - accuracy )
  {
    return result;
  }

  if( d <= accuracy - 1 )
  {
    if( axis )
    result.setFromAxisAngle( axis,Math.PI )
  }
  else
  {
    var w = _sqrt( (1+d)*2 );
    var invw = 1 / w;
    var v = [ 0,0,0 ];
    v.crossVectors( v1,v2 );
    result.set( v[ 0 ]*invw , v[ 1 ]*invw , v[ 2 ]*invw , w * 0.5 );
    result.normalize();
  }

  return result;
}

//

function fromNormalizedVectors( dst, src1, src2 )
{

  _.assert( arguments.length === 3, 'expects exactly three argument' );

  var dst = _.quat.from( dst );
  var dstv = _.vector.from( dst );
  var dst3 = dstv.subarray( 0,3 );
  var dot = _.avector.dot( src1, src2 ) + 1;

  if( _.numbersAreEquivalent( dot, 0 ) )
  {

    dot = 0;
    dst3.assign([ - src1[ 2 ], src1[ 1 ], src1[ 0 ] ]);

  }
  else
  {

    _.avector.cross3( dst3,src1,src2 );

  }

  dstv.eSet( 3, dot );

  this.normalize( dstv );

  return dst;
}

//

function fromMatrixRotation( dst, mat )
{

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.Space.is( mat ) );
  _.assert( mat.dims[ 0 ] >= 3 );
  _.assert( mat.dims[ 1 ] >= 3 );

  var dst = _.quat.from( dst );
  var dstv = _.vector.from( dst );
  var m00 = mat.atomGet([ 0,0 ]), m01 = mat.atomGet([ 0,1 ]), m02 = mat.atomGet([ 0,2 ]);
  var m10 = mat.atomGet([ 1,0 ]), m11 = mat.atomGet([ 1,1 ]), m12 = mat.atomGet([ 1,2 ]);
  var m20 = mat.atomGet([ 2,0 ]), m21 = mat.atomGet([ 2,1 ]), m22 = mat.atomGet([ 2,2 ]);
  var trace = m00 + m11 + m22;

  if( trace > 0 )
  {

    var s = 0.5 / Math.sqrt( trace + 1.0 );

    dstv.eSet( 0, ( m21 - m12 ) * s );
    dstv.eSet( 1, ( m02 - m20 ) * s );
    dstv.eSet( 2, ( m10 - m01 ) * s );
    dstv.eSet( 3, 0.25 / s );

  }
  else if( m00 > m11 && m00 > m22 )
  {

    var s = 2.0 * Math.sqrt( 1.0 + m00 - m11 - m22 );

    dstv.eSet( 0, 0.25 * s );
    dstv.eSet( 1, ( m01 + m10 ) / s );
    dstv.eSet( 2, ( m02 + m20 ) / s );
    dstv.eSet( 3, ( m21 - m12 ) / s );

  }
  else if ( m11 > m22 )
  {

    var s = 2.0 * Math.sqrt( 1.0 + m11 - m00 - m22 );

    dstv.eSet( 0, ( m01 + m10 ) / s );
    dstv.eSet( 1, 0.25 * s );
    dstv.eSet( 2, ( m12 + m21 ) / s );
    dstv.eSet( 3, ( m02 - m20 ) / s );

  }
  else
  {

    var s = 2.0 * Math.sqrt( 1.0 + m22 - m00 - m11 );

    dstv.eSet( 0, ( m02 + m20 ) / s );
    dstv.eSet( 1, ( m12 + m21 ) / s );
    dstv.eSet( 2, 0.25 * s );
    dstv.eSet( 3, ( m10 - m01 ) / s );

  }

  return dst;
}

//

function fromMatrixRotation2( dst, mat )
{

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.Space.is( mat ) );
  _.assert( mat.dims[ 0 ] >= 3 );
  _.assert( mat.dims[ 1 ] >= 3 );

  var dst = _.quat.from( dst );
  var dstv = _.vector.from( dst );

  var m00 = mat.atomGet([ 0,0 ]), m01 = mat.atomGet([ 0,1 ]), m02 = mat.atomGet([ 0,2 ]);
  var m10 = mat.atomGet([ 1,0 ]), m11 = mat.atomGet([ 1,1 ]), m12 = mat.atomGet([ 1,2 ]);
  var m20 = mat.atomGet([ 2,0 ]), m21 = mat.atomGet([ 2,1 ]), m22 = mat.atomGet([ 2,2 ]);

  var x = Math.sqrt( Math.max( 0, 1 + m00 - m11 - m22 ) ) / 2;
  var y = Math.sqrt( Math.max( 0, 1 - m00 + m11 - m22 ) ) / 2;
  var z = Math.sqrt( Math.max( 0, 1 - m00 - m11 + m22 ) ) / 2;
  var w = Math.sqrt( Math.max( 0, 1 + m00 + m11 + m22 ) ) / 2;

  if( _.sign( x ) !== _.sign( m21 - m12 ) )
  x *= -1;
  if( _.sign( y ) !== _.sign( m02 - m20 ) )
  y *= -1;
  if( _.sign( z ) !== _.sign( m10 - m01 ) )
  z *= -1;

  dstv.eSet( 0 , x );
  dstv.eSet( 1 , y );
  dstv.eSet( 2 , z );
  dstv.eSet( 3 , w );

  dstv.normalize();

  return dst;
}

//

function fromMatrixWithScale( dst, mat )
{

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.Space.is( mat ) );
  _.assert( mat.dims[ 0 ] >= 3 );
  _.assert( mat.dims[ 1 ] >= 3 );

  var dst = _.quat.from( dst );
  var dstv = _.vector.from( dst );
  var m = mat.scaleGet().clone().abs().reduceToMean();
  var m00 = mat.atomGet([ 0,0 ]) / m, m01 = mat.atomGet([ 0,1 ]) / m, m02 = mat.atomGet([ 0,2 ]) / m;
  var m10 = mat.atomGet([ 1,0 ]) / m, m11 = mat.atomGet([ 1,1 ]) / m, m12 = mat.atomGet([ 1,2 ]) / m;
  var m20 = mat.atomGet([ 2,0 ]) / m, m21 = mat.atomGet([ 2,1 ]) / m, m22 = mat.atomGet([ 2,2 ]) / m;
  var trace = m00 + m11 + m22;

  if( trace > 0 )
  {

    var s = 0.5 / Math.sqrt( trace + 1.0 );
    var sm = s*m;

    dstv.eSet( 0, ( m21 - m12 ) * sm );
    dstv.eSet( 1, ( m02 - m20 ) * sm );
    dstv.eSet( 2, ( m10 - m01 ) * sm );
    dstv.eSet( 3, 0.25*m / s );

  }
  else if( m00 > m11 && m00 > m22 )
  {

    var s = 2.0 * Math.sqrt( 1.0 + m00 - m11 - m22 );
    var sm = s/m;

    dstv.eSet( 0, 0.25 * s * m );
    dstv.eSet( 1, ( m01 + m10 ) / sm );
    dstv.eSet( 2, ( m02 + m20 ) / sm );
    dstv.eSet( 3, ( m21 - m12 ) / sm );

  }
  else if ( m11 > m22 )
  {

    var s = 2.0 * Math.sqrt( 1.0 + m11 - m00 - m22 );
    var sm = s/m;

    dstv.eSet( 0, ( m01 + m10 ) / sm );
    dstv.eSet( 1, 0.25 * s * m );
    dstv.eSet( 2, ( m12 + m21 ) / sm );
    dstv.eSet( 3, ( m02 - m20 ) / sm );

  }
  else
  {

    var s = 2.0 * Math.sqrt( 1.0 + m22 - m00 - m11 );
    var sm = s/m;

    dstv.eSet( 0, ( m02 + m20 ) / sm );
    dstv.eSet( 1, ( m12 + m21 ) / sm );
    dstv.eSet( 2, 0.25 * s * m );
    dstv.eSet( 3, ( m10 - m01 ) / sm );

  }

  return dst;
}

//

function fromPlane( plane,origin )
{
  var originVector;

  return function quatWithPlane( plane,origin )
  {
    if( !originVector ) originVector = [ 0,0,1 ];
    throw _.err( 'not tested' );
    origin = origin !== undefined ? origin : originVector;
    var pos0 = [ 0,0,0 ];
    var pos1 = [ 0,0,0 ];
    var pos2 = [ 0,0,0 ];
    pos0.copy( plane[ 0 ] );
    pos1.copy( plane[ 1 ] ).sub( pos0 );
    pos2.copy( plane[ 2 ] ).sub( pos0 );
    pos0.crossVectors( pos1,pos2 ).normalize();

    return Self.quatWithVectors( origin,pos0 );
  }

}

//

function toMatrix( quat, mat )
{

  if( mat === null || mat === undefined )
  mat = _.Space.make([ 3,3 ]);

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.quat.is( quat ) );
  _.assert( _.Space.is( mat ) );
  _.assert( mat.dims[ 0 ] >= 3 );
  _.assert( mat.dims[ 1 ] >= 3 );

  mat.fromQuat( quat );

  return mat
}

//

function is( quat )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  return ( _.arrayLike( quat ) || _.vectorIs( quat ) ) && ( quat.length === 4 );
}

//

function isUnit( quat )
{

  _.assert( arguments.length === 1, 'expects single argument' );

  var quatv = _.quat._from( quat );

  if( quatv.eGet( 3 ) !== 1 )
  return false;

  for( var d = 0 ; d < 3 ; d++ )
  if( quatv.eGet( d ) !== 0 )
  return false;

  return true;
}

//

function isZero( quat )
{

  _.assert( arguments.length === 1, 'expects single argument' );

  var quatv = _.quat._from( quat );

  if( quatv.eGet( 3 ) !== 0 )
  return false;

  for( var d = 0 ; d < 3 ; d++ )
  if( quatv.eGet( d ) !== 0 )
  return false;

  return true;
}

//

function dimGet( quat )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( _.quat.is( quat ) );
  return quat.length;
}

//

function conjugate( dst )
{
  var dstv = _.quat._from( dst );

  _.assert( arguments.length === 1, 'expects single argument' );

  dstv.eSet( 0,-dstv.eGet( 0 ) );
  dstv.eSet( 1,-dstv.eGet( 1 ) );
  dstv.eSet( 2,-dstv.eGet( 2 ) );

  return dst;
}

//

function inv( dst )
{
  var dstv = _.quat._from( dst );

  _.assert( arguments.length === 1, 'expects single argument' );

  this.normalize( this.conjugate( dst ) );

  return dst;
}

//

function _mul3( dst, src1, src2 )
{

  var src10 = src1.eGet( 0 ), src11 = src1.eGet( 1 ), src12 = src1.eGet( 2 ), src13 = src1.eGet( 3 );
  var src20 = src2.eGet( 0 ), src21 = src2.eGet( 1 ), src22 = src2.eGet( 2 ), src23 = src2.eGet( 3 );

  dst.eSet( 0, src10 * src23 + src13 * src20 + src11 * src22 - src12 * src21 );
  dst.eSet( 1, src11 * src23 + src13 * src21 + src12 * src20 - src10 * src22 );
  dst.eSet( 2, src12 * src23 + src13 * src22 + src10 * src21 - src11 * src20 );
  dst.eSet( 3, src13 * src23 - src10 * src20 - src11 * src21 - src12 * src22 );

  return dst;
}

//

function mul( dst )
{
  var first = 1;

  _.assert( arguments.length >= 2, 'expects at least two arguments' );

  if( dst === null )
  {
    dst = this.make( arguments[ 1 ] );
    first = 2;
    _.assert( arguments.length >= 3, 'expects at least three arguments' );
  }

  var dstv = _.quat._from( dst );

  for( var a = first ; a < arguments.length ; a++ )
  {
    var srcv = _.quat._from( arguments[ a ] );
    this._mul3( dstv,dstv,srcv );
  }

  return dst;
}

//

function mix( dst, src, val )
{

  var dstv = _.quat._from( dst );
  var srcv = _.quat._from( src );

  _.assert( arguments.length === 3, 'expects exactly three argument' );

  if( val === 0 )
  return dst;

  if( val === 1 )
  debugger;
  if( val === 1 )
  return this.copy( dst,src );

  var src0 = srcv.eGet( 0 ), src1 = srcv.eGet( 1 ), src2 = srcv.eGet( 2 ), src3 = srcv.eGet( 3 );
  var dst0 = dstv.eGet( 0 ), dst1 = dstv.eGet( 1 ), dst2 = dstv.eGet( 2 ), dst3 = dstv.eGet( 3 );

  var cosHalfTheta = src0 * src.eGet( 0 ) + src1 * src.eGet( 1 ) + src2 * src.eGet( 2 ) + src3 * src.eGet( 3 );

  var invertCosHalfTheta = 0;
  if( cosHalfTheta < 0 )
  {
    debugger;
    cosHalfTheta = - cosHalfTheta;
    invertCosHalfTheta = 1;
  }

  if( cosHalfTheta >= 1.0 )
  {

    debugger;
    dstv.eSet( 0, src0 );
    dstv.eSet( 1, src1 );
    dstv.eSet( 2, src2 );
    dstv.eSet( 3, src3 );

    return dst;
  }

  var halfTheta = Math.acos( cosHalfTheta );
  var sinHalfTheta = Math.sqrt( 1.0 - cosHalfTheta * cosHalfTheta );

  if( invertCosHalfTheta )
  {

    debugger;
    src0 = -src0;
    src1 = -src1;
    src2 = -src2;
    src3 = -src3;

  }
  // else
  // {
  //
  //   debugger;
  //   dstv.copy( srcv );
  //
  // }

  if( Math.abs( sinHalfTheta ) < 0.0001 )
  {

    debugger;
    dstv.eSet( 0, 0.5 * ( src0 + dst0 ) );
    dstv.eSet( 1, 0.5 * ( src1 + dst1 ) );
    dstv.eSet( 2, 0.5 * ( src2 + dst2 ) );
    dstv.eSet( 3, 0.5 * ( src3 + dst3 ) );

    return dst;
  }

  debugger;
  var r1 = Math.sin( ( 1 - val ) * halfTheta ) / sinHalfTheta;
  var r2 = Math.sin( t * halfTheta ) / sinHalfTheta;

  dstv.eSet( 0, ( dst0 * r1 + src0 * r2 ) );
  dstv.eSet( 1, ( dst1 * r1 + src1 * r2 ) );
  dstv.eSet( 2, ( dst2 * r1 + src2 * r2 ) );
  dstv.eSet( 3, ( dst3 * r1 + src3 * r2 ) );

  return dst;
}

//

function applyTo( quat,vector )
{

  var quatv = _.quat._from( quat );
  var vectorv = _.vector.from( vector );

  var x = vectorv.eGet( 0 );
  var y = vectorv.eGet( 1 );
  var z = vectorv.eGet( 2 );

  var qx = quatv.eGet( 0 );
  var qy = quatv.eGet( 1 );
  var qz = quatv.eGet( 2 );
  var qw = quatv.eGet( 3 );

  var ix = + qw * x + qy * z - qz * y;
  var iy = + qw * y + qz * x - qx * z;
  var iz = + qw * z + qx * y - qy * x;
  var iw = - qx * x - qy * y - qz * z;

  vectorv.eSet( 0 , ix * qw + iw * - qx + iy * - qz - iz * - qy );
  vectorv.eSet( 1 , iy * qw + iw * - qy + iz * - qx - ix * - qz );
  vectorv.eSet( 2 , iz * qw + iw * - qz + ix * - qy - iy * - qx );

  return vector;
}

// --
// define class
// --

var Proto =
{

  make : make,
  makeZero : makeZero,
  makeUnit : makeUnit,

  zero : zero,
  unit : unit,

  from : from,
  _from : _from,

  fromEuler : fromEuler,

  fromAxisAndAngle : fromAxisAndAngle,
  toAxisAndAngle : toAxisAndAngle,

  fromVectors : fromVectors,
  fromVectors2 : fromVectors2,
  fromNormalizedVectors : fromNormalizedVectors,

  fromMatrixRotation : fromMatrixRotation,
  fromMatrixRotation2 : fromMatrixRotation2,
  fromMatrixWithScale : fromMatrixWithScale,

  fromPlane : fromPlane,

  toMatrix : toMatrix,

  is : is,
  isUnit : isUnit,
  isZero : isZero,

  dimGet : dimGet,

  conjugate : conjugate,
  inv : inv,

  _mul3 : _mul3,
  mul : mul,
  mix : mix,

  applyTo : applyTo,

}

_.mapExtend( Self,Proto );

})();
