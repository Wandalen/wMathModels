(function _Euler_s_(){

'use strict';

var _ = _global_.wTools;
var avector = _.avector;
var vector = _.vector;
var pi = Math.PI;
var sin = Math.sin;
var cos = Math.cos;
var atan2 = Math.atan2;
var asin = Math.asin;
var acos = Math.acos;
var abs = Math.abs;
var sqr = _.sqr;
var sqrt = _.sqrt;
var clamp = _.clamp;

_.assert( clamp )
_.assert( !_.euler );

var Self = _.euler = _.euler || Object.create( _.avector );

// --
//
// --

function is( euler )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  return ( _.arrayLike( euler ) || _.vectorIs( euler ) ) && ( euler.length === 6 );
}

//

function isZero( euler )
{

  _.assert( arguments.length === 1, 'expects single argument' );

  var eulerv = _.euler._from( euler );

  for( var d = 0 ; d < 3 ; d++ )
  if( eulerv.eGet( d ) !== 0 )
  return false;

  return true;
}

//

function make( src )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( src === undefined || src === null || _.euler.is( src ) );
  var result = _.euler.makeZero();
  if( _.euler.is( src ) )
  _.avector.assign( result,src );
  return result;
}

//

function make2( src, seq )
{
  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 );
  _.assert( src === undefined || src === null || _.euler.is( src ) );
  _.assert( typeof( seq ) === "string" );

  var result = _.euler.makeZero();

  if( _.euler.is( src ) )
    _.avector.assign( result, src );

   // Sequence
   if ( seq === 'xyz' )
   {
     result[ 3 ] = 0;
     result[ 4 ] = 1;
     result[ 5 ] = 2;
   }
   else if ( seq === 'xzy' )
   {
     result[ 3 ] = 0;
     result[ 4 ] = 2;
     result[ 5 ] = 1;
   }
   else if ( seq === 'yxz' )
   {
     result[ 3 ] = 1;
     result[ 4 ] = 0;
     result[ 5 ] = 2;
   }
   else if ( seq === 'yzx' )
   {
     result[ 3 ] = 1;
     result[ 4 ] = 2;
     result[ 5 ] = 0;
   }
   else if ( seq === 'zxy' )
   {
     result[ 3 ] = 2;
     result[ 4 ] = 0;
     result[ 5 ] = 1;
   }
   else if ( seq === 'zyx' )
   {
     result[ 3 ] = 2;
     result[ 4 ] = 1;
     result[ 5 ] = 0;
   }
   else if ( seq === 'xyx' )
   {
     result[ 3 ] = 0;
     result[ 4 ] = 1;
     result[ 5 ] = 0;
   }
   else if ( seq === 'xzx' )
   {
     result[ 3 ] = 0;
     result[ 4 ] = 2;
     result[ 5 ] = 0;
   }
   else if ( seq === 'yxy' )
   {
     result[ 3 ] = 1;
     result[ 4 ] = 0;
     result[ 5 ] = 1;
   }
   else if ( seq === 'yzy' )
   {
     result[ 3 ] = 1;
     result[ 4 ] = 2;
     result[ 5 ] = 1;
   }
   else if ( seq === 'zxz' )
   {
     result[ 3 ] = 2;
     result[ 4 ] = 0;
     result[ 5 ] = 2;
   }
   else if ( seq === 'zyz' )
   {
     result[ 3 ] = 2;
     result[ 4 ] = 1;
     result[ 5 ] = 2;
   }
   else
   {}

   return result;
}

//

function makeZero()
{
  _.assert( arguments.length === 0 );
  var result = _.dup( 0,6 );
  result[ 3 ] = 0;
  result[ 4 ] = 1;
  result[ 5 ] = 2;
  return result;
}

//

function zero( euler )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( euler === undefined || euler === null || _.euler.is( euler ) );

  if( _.euler.is( euler ) )
  {
    var eulerv = _.euler._from( euler );
    for( var i = 0 ; i < 3 ; i++ )
    eulerv.eSet( i,0 );
    return euler;
  }

  return _.euler.makeZero();
}

//

function from( euler )
{

  _.assert( euler === null || _.euler.is( euler ) );
  _.assert( arguments.length === 1, 'expects single argument' );

  if( euler === null )
  return _.euler.make();

  if( _.vectorIs( euler ) )
  {
    debugger;
    //throw _.err( 'not implemented' );
    return euler.slice();
  }

  return euler;
}

//

function _from( euler )
{
  _.assert( euler === null || _.euler.is( euler ) );
  _.assert( arguments.length === 1, 'expects single argument' );

  if( euler === null )
  euler = _.euler.make();

  return _.vector.from( euler );
}

//

/*

  double s=Math.sin(angle);
  double c=Math.cos(angle);
  double t=1-c;

  //  if axis is not already normalised then uncomment this
  // double magnitude = Math.sqrt(x*x + y*y + z*z);
  // if (magnitude==0) throw error;
  // x /= magnitude;
  // y /= magnitude;
  // z /= magnitude;

  if ((x*y*t + z*s) > 0.998) { // north pole singularity detected
    heading = 2*atan2(x*Math.sin(angle/2),Math.cos(angle/2));
    attitude = Math.PI/2;
    bank = 0;
    return;
  }

  if ((x*y*t + z*s) < -0.998) { // south pole singularity detected
    heading = -2*atan2(x*Math.sin(angle/2),Math.cos(angle/2));
    attitude = -Math.PI/2;
    bank = 0;
    return;
  }

  heading = Math.atan2(y * s- x * z * t , 1 - (y*y+ z*z ) * t);
  attitude = Math.asin(x * y * t + z * s) ;
  bank = Math.atan2(x * s - y * z * t , 1 - (x*x + z*z) * t);

*/

function fromAxisAndAngle( dst, axis, angle )
{

  dst = _.euler.from( dst );
  var dstv = _.vector.from( dst );
  var axisv = _.vector.from( axis );

  if( angle === undefined )
  angle = axis[ 3 ];

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( axis.length === 3 || axis.length === 4 );
  _.assert( _.numberIs( angle ) );
  _.assert( this.EPS > 0 );

  var s = sin( angle );
  var c = cos( angle );
  var t = 1-c;

  var x = axisv.eGet( 0 );
  var y = axisv.eGet( 1 );
  var z = axisv.eGet( 2 );

  if ( ( x*y*t + z*s ) > 1-this.EPS )
  {
    xxx
    dstv.eSet( 0, 2*atan2( x*sin( angle/2 ),cos( angle/2 ) ) );
    dstv.eSet( 1, Math.PI/2 );
    dstv.eSet( 2, bank = 0 );
    return dst;
  }
  else if ( ( x*y*t + z*s ) < -1+this.EPS )
  {
    yyy
    dstv.eSet( 0, -2*atan2( x*sin( angle/2 ),cos( angle/2 ) ) );
    dstv.eSet( 1, -Math.PI/2 );
    dstv.eSet( 2, bank = 0 );
    return dst;
  }

  var x2 = x*x;
  var y2 = y*y;
  var z2 = z*z;

  // xyz

  dstv.eSet( 0, atan2( y*s - x*z*t , 1 - ( y2 + z2 ) * t ) );
  dstv.eSet( 1, asin( x*y*t + z*s ) );
  dstv.eSet( 2, atan2( x*s - y*z*t , 1 - ( x2 + z2 ) * t ) );

  // xzy

  dstv.eSet( 0, atan2( z*s - x*y*t , 1 - ( z2 + y2 ) * t ) );
  dstv.eSet( 1, atan2( x*s - z*y*t , 1 - ( x2 + y2 ) * t ) );
  dstv.eSet( 2, asin( x*z*t + y*s ) );

  return dst;
}

//

function fromQuat( dst,quat,v )
{
  var /*eps*/accuracy = 1e-9;
  var half = 0.5-/*eps*/accuracy;

  var dst = _.euler.from( dst );
  var dstv = _.vector.from( dst );
  var quatv = _.quat._from( quat );

  // _.assert( arguments.length === 2, 'expects exactly two arguments' );

  var ox = dstv.eGet( 3 );
  var oy = dstv.eGet( 4 );
  var oz = dstv.eGet( 5 );
  var same = ox === oz;

  var sign;

  // if( same )
  // {
  //   if( 0 !== ox && 0 !== oy )
  //   oz = 0;
  //   else if( 1 !== ox && 1 !== oy )
  //   oz = 1;
  //   else if( 2 !== ox && 2 !== oy )
  //   oz = 2;
  //   sign = ( ( ox !== 0 ) + ( oy !== 1 ) + ( oz !== 2 ) ) === 2;
  // }
  // else
  // {
    sign = ( ( ox !== 0 ) + ( oy !== 1 ) + ( oz !== 2 ) ) === 2;
  // }

  sign = sign ? -1 : + 1;
  // console.log( 'sign',sign );

  var ex,ey,ez;

  // var x = quatv.eGet( ox );
  // var y = quatv.eGet( oy );
  // var z = quatv.eGet( oz );
  // var w = quatv.eGet( 3 );

  var x = quatv.eGet( 0 );
  var y = quatv.eGet( 1 );
  var z = quatv.eGet( 2 );
  var w = quatv.eGet( 3 );

  var sqx = x*x;
  var sqy = y*y;
  var sqz = z*z;
  var sqw = w*w;

  //

  // xyx
  // psi = atan2((q[1] * q[2] + q[3] * q[0]), (q[2] * q[0] - q[1] * q[3]));
  // theta = acos(q[0] * q[0] + q[1] * q[1] - q[2] * q[2] - q[3] * q[3]);
  // phi = atan2((q[1] * q[2] - q[3] * q[0]), (q[1] * q[3] + q[2] * q[0]));

  // xzx
  // psi = atan2((q[1] * q[3] - q[2] * q[0]), (q[1] * q[2] + q[3] * q[0]));
  // theta = acos(q[0] * q[0] + q[1] * q[1] - q[2] * q[2] - q[3] * q[3]);
  // phi = atan2((q[1] * q[3] + q[2] * q[0]), (q[3] * q[0] - q[1] * q[2]));

  // yxy
  // psi = atan2((q[1] * q[2] - q[3] * q[0]), (q[1] * q[0] + q[2] * q[3]));
  // theta = acos(q[0] * q[0] - q[1] * q[1] + q[2] * q[2] - q[3] * q[3]);
  // phi = atan2((q[1] * q[2] + q[3] * q[0]), (q[1] * q[0] - q[2] * q[3]));

//   if( same )
//   {
//
//     // sign = 1;
//     dstv.eSet( 0, atan2( ( x * y + sign * z * w ) , ( y * w - sign * x * z ) ) );
//     dstv.eSet( 1, acos( sqw + sqx - sqy - sqz ) );
//     dstv.eSet( 2, atan2( ( x * y - sign * z * w ) , ( y * w + sign * x * z ) ) );
//
//   }
//   else
//   {
//
//     // var test = ( v.xz1*x*z + v.yw1*y*w );
//     var test = ( x*z - y*w );
//
//     if( test > +half )
//     {
//       xxx
//       dstv.eSet( ox, +2 * Math.atan2( z,w ) );
//       dstv.eSet( oy, +Math.PI / 2 );
//       dstv.eSet( oz, 0 );
//     }
//     else if( test < -half )
//     {
//       yyy
//       dstv.eSet( ox, -2 * Math.atan2( z,w ) );
//       dstv.eSet( oy, -Math.PI / 2 );
//       dstv.eSet( oz, 0 );
//     }
//     else
//     {
//       // dstv.eSet( ox, sign * atan2( 2 * ( x * w - y * z ) , ( sqw - sqx - sqy + sqz ) ) );
//       // dstv.eSet( oy, sign * asin( clamp( 2 * test, - 1, 1 ) ) );
//       // dstv.eSet( oz, sign * atan2( 2 * ( z * w - x * y ) , ( sqw + sqx - sqy - sqz ) ) );
//
//       dstv.eSet( 0, sign * atan2( 2 * ( x * w - y * z ) , ( sqw - sqx - sqy + sqz ) ) );
//       dstv.eSet( 1, asin( clamp( 2 * test, - 1, 1 ) ) );
//       dstv.eSet( 2, sign * atan2( 2 * ( z * w - x * y ) , ( sqw + sqx - sqy - sqz ) ) );
//
//       // dstv.eSet( 0, atan2( 2 * ( v.xw0 * x * w + v.yz0 * y * z ) , ( v.sqw0*sqw + v.sqx0*sqx + v.sqy0*sqy + v.sqz0*sqz ) ) );
//       // dstv.eSet( 1, asin( clamp( 2 * test, - 1, 1 ) ) );
//       // dstv.eSet( 2, atan2( 2 * ( v.zw2 * z * w + v.xy2 * x * y ) , ( v.sqw2*sqw + v.sqx2*sqx + v.sqy2*sqy + v.sqz2*sqz ) ) );
//
//       // dstv.eSet( 0, atan2( 2 * ( x * w + v.yz0 * y * z ) , ( v.sqw0*sqw + v.sqx0*sqx + v.sqy0*sqy + v.sqz0*sqz ) ) );
//       // dstv.eSet( 1, asin( clamp( 2 * test, - 1, 1 ) ) );
//       // dstv.eSet( 2, atan2( 2 * ( v.zw2 * z * w + v.xy2 * x * y ) , ( v.sqw2*sqw + v.sqx2*sqx + v.sqy2*sqy + v.sqz2*sqz ) ) );
//
// // trivial xyz sample :
// // {
// //   xw0 : 1,
// //   yz0 : -1,
// //   xz1 : 1,
// //   yw1 : 1,
// //   zw2 : 1,
// //   xy2 : -1,
// //   sqw0 : 1,
// //   sqx0 : -1,
// //   sqy0 : -1,
// //   sqz0 : 1,
// //   sqw2 : 1,
// //   sqx2 : 1,
// //   sqy2 : -1,
// //   sqz2 : -1
// // }
// //
// // trivial xzy sample :
// // {
// //   xw0 : 1,
// //   yz0 : 1,
// //   xz1 : -1,
// //   yw1 : 1,
// //   zw2 : 1,
// //   xy2 : 1,
// //   sqw0 : 1,
// //   sqx0 : -1,
// //   sqy0 : -1,
// //   sqz0 : 1,
// //   sqw2 : 1,
// //   sqx2 : 1,
// //   sqy2 : -1,
// //   sqz2 : -1
// // }
// //
// // trivial zyx sample :
// // {
// //   xw0 : 1,
// //   yz0 : 1,
// //   xz1 : -1,
// //   yw1 : 1,
// //   zw2 : 1,
// //   xy2 : 1,
// //   sqw0 : 1,
// //   sqx0 : -1,
// //   sqy0 : -1,
// //   sqz0 : 1,
// //   sqw2 : 1,
// //   sqx2 : 1,
// //   sqy2 : -1,
// //   sqz2 : -1
// // }
// //
// // trivial zyx sample :
// // {
// //   xw0 : 1,
// //   yz0 : 1,
// //   xz1 : 1,
// //   yw1 : -1,
// //   zw2 : 1,
// //   xy2 : 1,
// //   sqw0 : 1,
// //   sqx0 : -1,
// //   sqy0 : -1,
// //   sqz0 : 1,
// //   sqw2 : 1,
// //   sqx2 : 1,
// //   sqy2 : -1,
// //   sqz2 : -1
// // }
//
//       // var x = quatv.eGet( 0 );
//       // var y = quatv.eGet( 1 );
//       // var z = quatv.eGet( 2 );
//       // var w = quatv.eGet( 3 );
//
//       // dstv.eSet( ox, -sign * atan2( 2 * ( x * w + y * z ) , ( sqw - sqx - sqy + sqz ) ) );
//       // dstv.eSet( oy, -asin( clamp( 2 * test, - 1, 1 ) ) );
//       // dstv.eSet( oz, sign * atan2( 2 * ( z * w - x * y ) , ( sqw - sqx - sqy + sqz ) ) );
//
//       // dstv.eSet( ox, atan2( 2 * ( x * w - y * z ) , ( sqw - sqx - sqy + sqz ) ) );
//       // dstv.eSet( oy, asin( clamp( 2 * ( x*z + y*w ), - 1, 1 ) ) );
//       // dstv.eSet( oz, atan2( 2 * ( z * w - x * y ) , ( sqw + sqx - sqy - sqz ) ) );
//
//       // dstv.eSet( ox, atan2( 2 * ( z*w - x*y ) , ( sqw + sqx - sqy - sqz ) ) );
//       // dstv.eSet( oy, asin( clamp( 2 * ( x*w - y*z ), - 1, 1 ) ) );
//       // dstv.eSet( oz, atan2( ( sqw - sqx - sqy + sqz ) , 2 * ( x*z + w*y ) ) );
//
//       // /* xzy */
//       //
//       // var sign = 1;
//       // dstv.eSet( ox, atan2( 2 * ( x * w + y * z ) , ( sqw - sqx - sqy + sqz ) ) );
//       // dstv.eSet( oy, asin( clamp( 2 * ( w*y - x*z ), - 1, 1 ) ) );
//       // dstv.eSet( oz, atan2( 2 * ( z * w + x * y ) , ( sqw + sqx - sqy - sqz ) ) );
//
//     }
//
//   }

  // debugger;

  // ex = atan2( ( x * y + z * w ), ( y * w - x * z ) );
  // ey = acos( w * w + x * x - y * y - z * z );
  // ez = atan2( ( x * y - z * w ), ( x * z + y * w ) );

  if( ox === 0 && oy === 1 && oz === 2 ) // xyz
  {
    ex = atan2( 2 * ( x * w - y * z ), ( w * w - x * x - y * y + z * z ) );
    ey = asin( 2 * ( x * z + y * w ) );
    ez = atan2( 2 * ( z * w - x * y ), ( w * w + x * x - y * y - z * z ) );
  }
  else if( ox === 0 && oy === 2 && oz === 1 ) // xzy
  {
    ex = atan2( 2 * ( x * w + y * z ), ( w * w - x * x + y * y - z * z ) );
    ey = asin( 2 * ( z * w - x * y ) );
    ez = atan2( 2 * ( x * z + y * w ), ( w * w + x * x - y * y - z * z ) );
  }
  else if( ox === 1 && oy === 0 && oz === 2 ) // yxz
  {
    ex = atan2( 2 * ( x * z + y * w ), ( w * w - x * x - y * y + z * z ) );
    ey = asin( 2 * ( x * w - y * z ) );
    ez = atan2( 2 * ( x * y + z * w ), ( w * w - x * x + y * y - z * z ) );
  }
  else if( ox === 1 && oy === 2 && oz === 0 ) // yzx
  {
    ex = atan2( 2 * ( y * w - x * z ), ( w * w + x * x - y * y - z * z ) );
    ey = asin( 2 * ( x * y + z * w ) );
    ez = atan2( 2 * ( x * w - z * y ), ( w * w - x * x + y * y - z * z ) );
  }
  else if( ox === 2 && oy === 0 && oz === 1 ) // zxy
  {
    ex = atan2( 2 * ( z * w - x * y ), ( w * w - x * x + y * y - z * z ) );
    ey = asin( 2 * ( x * w + y * z ) );
    ez = atan2( 2 * ( y * w - z * x ), ( w * w - x * x - y * y + z * z ) );
  }
  else if( ox === 2 && oy === 1 && oz === 0 ) // zyx
  {
    ex = atan2( 2 * ( x * y + z * w ), ( w * w + x * x - y * y - z * z ) );
    ey = asin( 2 * ( y * w - x * z ) );
    ez = atan2( 2 * ( x * w + z * y ), ( w * w - x * x - y * y + z * z ) );
  }
  else if( ox === 0 && oy === 1 && oz === 0 ) // xyx
  {
    ex = atan2( ( x * y + z * w ), ( y * w - x * z ) );
    ey = acos( w * w + x * x - y * y - z * z );
    ez = atan2( ( x * y - z * w ), ( x * z + y * w ) );
  }
  else if( ox === 0 && oy === 2 && oz === 0 ) // xzx
  {
    ex = atan2( ( x * z - y * w ), ( x * y + z * w ) );
    ey = acos( w * w + x * x - y * y - z * z );
    ez = atan2( ( x * z + y * w ), ( z * w - x * y ) );
  }
  else if( ox === 1 && oy === 0 && oz === 1 ) // yxy
  {
    ex = atan2( ( x * y - z * w ), ( x * w + y * z ) );
    ey = acos( w * w - x * x + y * y - z * z );
    ez = atan2( ( x * y + z * w ), ( x * w - y * z ) );
  }
  else if( ox === 1 && oy === 2 && oz === 1 ) // yzy
  {
    ex = atan2( ( x * w + y * z ), ( z * w - x * y ) );
    ey = acos( w * w - x * x + y * y - z * z );
    ez = atan2( ( y * z - x * w ), ( x * y + z * w ) );
  }
  else if( ox === 2 && oy === 0 && oz === 2 ) // zxz
  {
    ex = atan2( ( x * z + y * w ), ( x * w - y * z ) );
    ey = acos( w * w - x * x - y * y + z * z );
    ez = atan2( ( x * z - y * w ), ( x * w + y * z ) );
  }
  else if( ox === 2 && oy === 1 && oz === 2 ) // zyz
  {
    ex = atan2( ( y * z - x * w ), ( x * z + y * w ) );
    ey = acos( w * w - x * x - y * y + z * z );
    ez = atan2( ( x * w + y * z ), ( y * w - x * z ) );
  }
  else _.assert( 0,'unexpected euler order',dst );

  dstv.eSet( 0, ex );
  dstv.eSet( 1, ey );
  dstv.eSet( 2, ez );

  // xyz
  //
  //  atan2
  //  (
  //    2 * (q[1] * q[0] - q[2] * q[3]),
  //    (q[0] * q[0] - q[1] * q[1] - q[2] * q[2] + q[3] * q[3])
  //  );
  // theta = asin(2 * ( q[2] * q[0]) + q[1] * q[3] );
  // phi = atan2
  // (
  //    2 * (q[3] * q[0] - q[1] * q[2]),
  //    (q[0] * q[0] + q[1] * q[1] - q[2] * q[2] - q[3] * q[3])
  // );

  // xzy
  // psi =
  //   atan2
  //   (
  //    2 * (q[1] * q[0] + q[2] * q[3]),
  //    (q[0] * q[0] - q[1] * q[1] + q[2] * q[2] - q[3] * q[3])
  //   );
  // theta = asin(2 * (q[3] * q[0] - q[1] * q[2]));
  // phi = atan2
  // (
  //   2 * (q[1] * q[3] + q[2] * q[0]),
  //   (q[0] * q[0] + q[1] * q[1] - q[2] * q[2] - q[3] * q[3])
  // );

  // // case zyx:

  // (
  //  2*(q.y*q.z + q.w*q.x),
  //  q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z,
  //  -2*(q.x*q.z - q.w*q.y),
  //  2*(q.x*q.y + q.w*q.z),
  //  q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
  // )

  // // case xyz:

  // (
  //   2*( - q.x*q.y + q.w*q.z),
  //   q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
  //   2*( - q.y*q.z + q.w*q.x),
  //   q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z,
  //   +2*(q.x*q.z + q.w*q.y),
  // )
  //

  // // case xzy:

  // (
  //   +2*(q.x*q.z + q.w*q.y),
  //   q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
  //   +2*(q.y*q.z + q.w*q.x),
  //   +q.w*q.w - q.x*q.x + q.y*q.y - q.z*q.z,
  //   -2*(q.x*q.y - q.w*q.z),
  // )

  // void threeaxisrot(double r11, double r12, double r21, double r31, double r32, double res[])
  // {
  //   res[0] = atan2( r31, r32 );
  //   res[1] = asin ( r21 );
  //   res[2] = atan2( r11, r12 );
  // }

  // void threeaxisrot(double r11, double r12, double r21, double r31, double r32, double res[])
  // {
  //   res[0] = atan2( r11, r12 );
  //   res[1] = asin ( r21 );
  //   res[2] = atan2( r31, r32 );
  // }

  // {
  //
  //   var test = ( x * z + y * w );
  //   if( test > +half )
  //   {
  //     xxx
  //     dstv.eSet( 0, +2 * Math.atan2( z,w ) );
  //     dstv.eSet( 1, +Math.PI / 2 );
  //     dstv.eSet( 2, 0 );
  //   }
  //   else if( test < -half )
  //   {
  //     yyy
  //     dstv.eSet( 0, -2 * Math.atan2( z,w ) );
  //     dstv.eSet( 1, -Math.PI / 2 );
  //     dstv.eSet( 2, 0 );
  //   }
  //   else
  //   {
  //     dstv.eSet( 0, atan2( 2 * ( x * w - y * z ) , ( sqw - sqx - sqy + sqz ) ) );
  //     dstv.eSet( 1, asin( clamp( 2 * test, - 1, 1 ) ) );
  //     dstv.eSet( 2, atan2( 2 * ( z * w - x * y ) , ( sqw + sqx - sqy - sqz ) ) );
  //   }
  //
  // }

  return dst;
}

// fromQuat.variates =
// {
//
//   xw0 : [ +1,-1 ],
//   yz0 : [ +1,-1 ],
//   xz1 : [ +1,-1 ],
//   yw1 : [ +1,-1 ],
//   zw2 : [ +1,-1 ],
//   xy2 : [ +1,-1 ],
//
//   sqw0 : [ +1,-1 ],
//   sqx0 : [ +1,-1 ],
//   sqy0 : [ +1,-1 ],
//   sqz0 : [ +1,-1 ],
//
//   sqw2 : [ +1,-1 ],
//   sqx2 : [ +1,-1 ],
//   sqy2 : [ +1,-1 ],
//   sqz2 : [ +1,-1 ],
//
// }

// void quaternion2Euler(const Quaternion& q, double res[], RotSeq rotSeq)
// {
//     switch(rotSeq){
//     case zyx:
//       threeaxisrot( 2*(q.x*q.y + q.w*q.z),
//                      q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
//                     -2*(q.x*q.z - q.w*q.y),
//                      2*(q.y*q.z + q.w*q.x),
//                      q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z,
//                      res);
//       break;
//
//     case zyz:
//       twoaxisrot( 2*(q.y*q.z - q.w*q.x),
//                    2*(q.x*q.z + q.w*q.y),
//                    q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z,
//                    2*(q.y*q.z + q.w*q.x),
//                   -2*(q.x*q.z - q.w*q.y),
//                   res);
//       break;
//
//     case zxy:
//       threeaxisrot( -2*(q.x*q.y - q.w*q.z),
//                       q.w*q.w - q.x*q.x + q.y*q.y - q.z*q.z,
//                       2*(q.y*q.z + q.w*q.x),
//                      -2*(q.x*q.z - q.w*q.y),
//                       q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z,
//                       res);
//       break;
//
//     case zxz:
//       twoaxisrot( 2*(q.x*q.z + q.w*q.y),
//                   -2*(q.y*q.z - q.w*q.x),
//                    q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z,
//                    2*(q.x*q.z - q.w*q.y),
//                    2*(q.y*q.z + q.w*q.x),
//                    res);
//       break;
//
//     case yxz:
//       threeaxisrot( 2*(q.x*q.z + q.w*q.y),
//                      q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z,
//                     -2*(q.y*q.z - q.w*q.x),
//                      2*(q.x*q.y + q.w*q.z),
//                      q.w*q.w - q.x*q.x + q.y*q.y - q.z*q.z,
//                      res);
//       break;
//
//     case yxy:
//       twoaxisrot( 2*(q.x*q.y - q.w*q.z),
//                    2*(q.y*q.z + q.w*q.x),
//                    q.w*q.w - q.x*q.x + q.y*q.y - q.z*q.z,
//                    2*(q.x*q.y + q.w*q.z),
//                   -2*(q.y*q.z - q.w*q.x),
//                   res);
//       break;
//
//     case yzx:
//       threeaxisrot( -2*(q.x*q.z - q.w*q.y),
//                       q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
//                       2*(q.x*q.y + q.w*q.z),
//                      -2*(q.y*q.z - q.w*q.x),
//                       q.w*q.w - q.x*q.x + q.y*q.y - q.z*q.z,
//                       res);
//       break;
//
//     case yzy:
//       twoaxisrot( 2*(q.y*q.z + q.w*q.x),
//                   -2*(q.x*q.y - q.w*q.z),
//                    q.w*q.w - q.x*q.x + q.y*q.y - q.z*q.z,
//                    2*(q.y*q.z - q.w*q.x),
//                    2*(q.x*q.y + q.w*q.z),
//                    res);
//       break;
//
//     case xyz:
//       threeaxisrot( -2*(q.y*q.z - q.w*q.x),
//                     q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z,
//                     2*(q.x*q.z + q.w*q.y),
//                    -2*(q.x*q.y - q.w*q.z),
//                     q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
//                     res);
//       break;
//
//     case xyx:
//       twoaxisrot( 2*(q.x*q.y + q.w*q.z),
//                   -2*(q.x*q.z - q.w*q.y),
//                    q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
//                    2*(q.x*q.y - q.w*q.z),
//                    2*(q.x*q.z + q.w*q.y),
//                    res);
//       break;
//
//     case xzy:
//       threeaxisrot( 2*(q.y*q.z + q.w*q.x),
//                      q.w*q.w - q.x*q.x + q.y*q.y - q.z*q.z,
//                     -2*(q.x*q.y - q.w*q.z),
//                      2*(q.x*q.z + q.w*q.y),
//                      q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
//                      res);
//       break;
//
//     case xzx:
//       twoaxisrot( 2*(q.x*q.z - q.w*q.y),
//                    2*(q.x*q.y + q.w*q.z),
//                    q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
//                    2*(q.x*q.z + q.w*q.y),
//                   -2*(q.x*q.y - q.w*q.z),
//                   res);
//       break;
//     default:
//       std::cout << "Unknown rotation sequence" << std::endl;
//       break;
//    }
// }

//

function fromMatrix( euler,mat )
{
  var /*eps*/accuracy = 1e-7;
  var one = 1-/*eps*/accuracy;

  var euler = _.euler.from( euler );
  var eulerv = _.vector.from( euler );

  var s00 = mat.atomGet([ 0,0 ]), s10 = mat.atomGet([ 1,0 ]), s20 = mat.atomGet([ 2,0 ]);
  var s01 = mat.atomGet([ 0,1 ]), s11 = mat.atomGet([ 1,1 ]), s21 = mat.atomGet([ 2,1 ]);
  var s02 = mat.atomGet([ 0,2 ]), s12 = mat.atomGet([ 1,2 ]), s22 = mat.atomGet([ 2,2 ]);

  _.assert( _.Space.is( mat ) );
  _.assert( mat.dims[ 0 ] >= 3 );
  _.assert( mat.dims[ 1 ] >= 3 );
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

// m1
// -0.875, 0.250, 0.415,
// 0.250, -0.500, 0.829,
// 0.415, 0.829, 0.375,
// m2
// -0.875, -0.476, 0.086,
// 0.250, -0.292, 0.923,
// -0.415, 0.829, 0.375,

  // debugger; xxx

  eulerv.eSet( 1,asin( clamp( s02, - 1, + 1 ) ) );

  if( abs( /*eps*/accuracy ) < one )
  {
    eulerv.eSet( 0,atan2( - s12, s22 ) );
    eulerv.eSet( 2,atan2( - s01, s00 ) );
    // eulerv.eSet( 0,atan2( s12, s22 ) );
    // eulerv.eSet( 2,atan2( s01, s00 ) );
  }
  else
  {
    bbb
    eulerv.eSet( 0,atan2( s21, s11 ) );
    eulerv.eSet( 2,0 );
  }

// rz*ry*rx
//
// [ cy*cz, cz*sx*sy - cx*sz, sx*sz + cx*cz*sy]
// [ cy*sz, cx*cz + sx*sy*sz, cx*sy*sz - cz*sx]
// [ -sy,   cy*sx,      cx*cy]
//
// ry*rz*rx
//
// [  cy*cz, sx*sy - cx*cy*sz, cx*sy + cy*sx*sz]
// [         sz,      cx*cz,     -cz*sx]
// [ -cz*sy, cy*sx + cx*sy*sz, cx*cy - sx*sy*sz]
//
// rz*rx*ry
//
// [ cy*cz - sx*sy*sz, -cx*sz, cz*sy + cy*sx*sz]
// [ cy*sz + cz*sx*sy,  cx*cz, sy*sz - cy*cz*sx]
// [     -cx*sy,         sx,      cx*cy]
//
// rx*rz*ry
//
// [      cy*cz,       -sz,      cz*sy]
// [ sx*sy + cx*cy*sz, cx*cz, cx*sy*sz - cy*sx]
// [ cy*sx*sz - cx*sy, cz*sx, cx*cy + sx*sy*sz]
//
// ry*rx*rz
//
// [ cy*cz + sx*sy*sz, cz*sx*sy - cy*sz, cx*sy]
// [      cx*sz,      cx*cz,       -sx]
// [ cy*sx*sz - cz*sy, sy*sz + cy*cz*sx, cx*cy]
//
// rx*ry*rz
//
// [      cy*cz,     -cy*sz,         sy]
// [ cx*sz + cz*sx*sy, cx*cz - sx*sy*sz, -cy*sx]
// [ sx*sz - cx*cz*sy, cz*sx + cx*sy*sz,  cx*cy]
//
// rxz*ry*rx
//
// [  cy,        sx*sy,          cx*sy]
// [  sy*sz, cx*cz - cy*sx*sz, - cz*sx - cx*cy*sz]
// [ -cz*sy, cx*sz + cy*cz*sx,   cx*cy*cz - sx*sz]

  // var sx = sin( x );
  // var sy = sin( y );
  // var sz = sin( z );
  //
  // var cx = cos( x );
  // var cy = cos( y );
  // var cz = cos( z );

  return euler;
}

//

function toMatrix( euler,mat,premutating )
{
  // var /*eps*/accuracy = 1e-9;
  // var half = 0.5-/*eps*/accuracy;

  if( mat === null || mat === undefined )
  mat = _.Space.make([ 3,3 ]);

  var euler = _.euler.from( euler );
  var eulerv = _.vector.from( euler );

  if( premutating === undefined )
  premutating = true;

  _.assert( _.euler.is( euler ) );
  _.assert( _.Space.is( mat ) );
  _.assert( mat.dims[ 0 ] >= 3 );
  _.assert( mat.dims[ 1 ] >= 3 );
  _.assert( arguments.length === 1 || arguments.length === 2 || arguments.length === 3 );

  // debugger;

  var ox = eulerv.eGet( 3 );
  var oy = eulerv.eGet( 4 );
  var oz = eulerv.eGet( 5 );

  // var ox = 0;
  // var oy = 1;
  // var oz = 2;

  var x = eulerv.eGet( ox );
  var y = eulerv.eGet( oy );
  var z = eulerv.eGet( oz );

  var sign = ( ( ox !== 0 ) + ( oy !== 1 ) + ( oz !== 2 ) ) === 2;
  sign = sign ? -1 : + 1;
  // console.log( 'sign',sign );

  // var sx = ( ox === 0 && sign === 1 ) ? sin( x ) : cos( x );
  var sx = sin( x );
  var sy = sin( y );
  var sz = sin( z );

  // var cx = ( ox === 0 && sign === 1 ) ? cos( x ) : sin( x );
  var cx = cos( x );
  var cy = cos( y );
  var cz = cos( z );

  var cx_sy = cx*sy;
  var sx_sy = sx*sy;
  var cx_sz = cx*sz;
  var sx_sz = sx*sz;
  var cx_cy = cx*cy;
  var sx_cy = sx*cy;
  var cx_cz = cx*cz;
  var sx_cz = sx*cz;
  var cy_sz = cy*sz;
  var sy_sz = sy*sz;
  var cy_cz = cy*cz;
  var sy_cz = sy*cz;

  var m00,m01,m02;
  var m10,m11,m12;
  var m20,m21,m22;

  if( premutating )
  {

    mat.atomSet( [ 0,0 ],+cy_cz );
    mat.atomSet( [ 1,0 ],+cy_sz*sign );
    mat.atomSet( [ 2,0 ],-sy*sign );

    mat.atomSet( [ 0,1 ],+( +sx_sy*cz - cx_sz*sign ) );
    mat.atomSet( [ 1,1 ],+cx_cz + sx_sy*sz*sign );
    mat.atomSet( [ 2,1 ],+sx_cy*sign );

    mat.atomSet( [ 0,2 ],+sx_sz + cx_sy*cz*sign );
    mat.atomSet( [ 1,2 ],+( +cx_sy*sz - sx_cz*sign ) );
    mat.atomSet( [ 2,2 ],+cx_cy );

    // xxx

  }
  else
  {

    mat.atomSet( [ ox,ox ],+cy_cz );
    mat.atomSet( [ oy,ox ],-cy_sz*sign );
    mat.atomSet( [ oz,ox ],sy*sign );

    mat.atomSet( [ ox,oy ],+( +sx_sy*cz + cx_sz*sign ) );
    mat.atomSet( [ oy,oy ],+cx_cz - sx_sy*sz*sign );
    mat.atomSet( [ oz,oy ],-sx_cy*sign );

    mat.atomSet( [ ox,oz ],+sx_sz - cx_sy*cz*sign );
    mat.atomSet( [ oy,oz ],+( +cx_sy*sz + sx_cz*sign ) );
    mat.atomSet( [ oz,oz ],+cx_cy );

    // /* */
    //
    // mat.atomSet( [ 0,0 ],+cy_cz );
    // mat.atomSet( [ 1,0 ],-cy_sz*sign );
    // mat.atomSet( [ 2,0 ],sy*sign );
    //
    // mat.atomSet( [ 0,1 ],+( +sx_sy*cz + cx_sz*sign ) );
    // mat.atomSet( [ 1,1 ],+cx_cz - sx_sy*sz*sign );
    // mat.atomSet( [ 2,1 ],-sx_cy*sign );
    //
    // mat.atomSet( [ 0,2 ],+sx_sz - cx_sy*cz*sign );
    // mat.atomSet( [ 1,2 ],+( +cx_sy*sz + sx_cz*sign ) );
    // mat.atomSet( [ 2,2 ],+cx_cy );

  }

  mat.atomSet( [ 0,0 ],+cy_cz );
  mat.atomSet( [ 1,0 ],-cy_sz*sign );
  mat.atomSet( [ 2,0 ],sy*sign );

  mat.atomSet( [ 0,1 ],+( +sx_sy*cz + cx_sz*sign ) );
  mat.atomSet( [ 1,1 ],+cx_cz - sx_sy*sz*sign );
  mat.atomSet( [ 2,1 ],-sx_cy*sign );

  mat.atomSet( [ 0,2 ],+sx_sz - cx_sy*cz*sign );
  mat.atomSet( [ 1,2 ],+( +cx_sy*sz + sx_cz*sign ) );
  mat.atomSet( [ 2,2 ],+cx_cy );

  // debugger;

// rx*ry*rz
//
// | cx*cy    cx*sy*sz - sx*cz    cx*sy*cz + sx*sz |
// | sx*cy    sx*sy*sz + cx*cz    sx*sy*cz - cx*sz |
// | -sy                 cy*sz               cy*cz |
//

  // if( ox === 0 && oy === 1 && oz === 2 ) /* xyz */
  // {
  //
  //   var m00 = +cy_cz;
  //   var m10 = +cy_sz;
  //   var m20 = -sy;
  //
  //   var m01 = +sx_sy*cz - cx_sz;
  //   var m11 = +cx_cz + sx_sy*sz;
  //   var m21 = +sx_cy;
  //
  //   var m02 = +sx_sz + cx_sy*cz;
  //   var m12 = +cx_sy*sz - sx_cz;
  //   var m22 = +cx_cy;
  //
  // }
  // else if( ox === 0 && oy === 2 && oz === 1 ) /* xzy */
  // {
  //
    // var m00 = +cy_cz;
    // var m10 = +sz;
    // var m20 = -sy_cz;
    //
    // var m01 = +sx_sy - cx_cy*sz;
    // var m11 = +cx_cz;
    // var m21 = +sx_cy + cx_sy*sz;
    //
    // var m02 = +cx_sy + sx_cy*sz;
    // var m12 = -sx_cz;
    // var m22 = +cx_cy - sx_sy*sz;
  //
  // }
  // else _.assert( 0 );
  //
  // /* */
  //
  // mat.atomSet( [ 0,0 ],m00 );
  // mat.atomSet( [ 1,0 ],m10 );
  // mat.atomSet( [ 2,0 ],m20 );
  //
  // mat.atomSet( [ 0,1 ],m01 );
  // mat.atomSet( [ 1,1 ],m11 );
  // mat.atomSet( [ 2,1 ],m21 );
  //
  // mat.atomSet( [ 0,2 ],m02 );
  // mat.atomSet( [ 1,2 ],m12 );
  // mat.atomSet( [ 2,2 ],m22 );

// rz*ry*rx
//
// [ cy*cz, cz*sx*sy - cx*sz, sx*sz + cx*cz*sy]
// [ cy*sz, cx*cz + sx*sy*sz, cx*sy*sz - cz*sx]
// [ -sy,   cy*sx,      cx*cy]
//
// ry*rz*rx
//
// [  cy*cz, sx*sy - cx*cy*sz, cx*sy + cy*sx*sz]
// [         sz,      cx*cz,     -cz*sx]
// [ -cz*sy, cy*sx + cx*sy*sz, cx*cy - sx*sy*sz]
//
// rz*rx*ry
//
// [ cy*cz - sx*sy*sz, -cx*sz, cz*sy + cy*sx*sz]
// [ cy*sz + cz*sx*sy,  cx*cz, sy*sz - cy*cz*sx]
// [     -cx*sy,         sx,      cx*cy]
//
// rx*rz*ry
//
// [      cy*cz,       -sz,      cz*sy]
// [ sx*sy + cx*cy*sz, cx*cz, cx*sy*sz - cy*sx]
// [ cy*sx*sz - cx*sy, cz*sx, cx*cy + sx*sy*sz]
//
// ry*rx*rz
//
// [ cy*cz + sx*sy*sz, cz*sx*sy - cy*sz, cx*sy]
// [      cx*sz,      cx*cz,       -sx]
// [ cy*sx*sz - cz*sy, sy*sz + cy*cz*sx, cx*cy]
//
// rx*ry*rz
//
// [      cy*cz,     -cy*sz,         sy]
// [ cx*sz + cz*sx*sy, cx*cz - sx*sy*sz, -cy*sx]
// [ sx*sz - cx*cz*sy, cz*sx + cx*sy*sz,  cx*cy]
//
// | cx*cy    cx*sy*sz - sx*cz    cx*sy*cz + sx*sz |
// | sx*cy    sx*sy*sz + cx*cz    sx*sy*cz - cx*sz |
// | -sy                  cy*sz              cy*cz |
//
// [ cy*cx, cx*sz*sy - cz*sx, sz*sx + cz*cx*sy ]
// [ cy*sx, cz*cx + sz*sy*sx, cz*sy*sx - cx*sz ]
// [ -sy,   cy*sz,            cz*cy ]

// rxz*ry*rx
//
// [  cy,        sx*sy,          cx*sy]
// [  sy*sz, cx*cz - cy*sx*sz, - cz*sx - cx*cy*sz]
// [ -cz*sy, cx*sz + cy*cz*sx,   cx*cy*cz - sx*sz]

  return mat;
}

// --
// var
// --

var Order =
{

  'xyz' : [ 0,1,2 ],
  'xzy' : [ 0,2,1 ],
  'yxz' : [ 1,0,2 ],
  'yzx' : [ 1,2,0 ],
  'zxy' : [ 2,0,1 ],
  'zyx' : [ 2,1,0 ],

}


/**
  * Create a set of euler angles from a quaternion. Returns the created euler angles.
  * Quaternion stay untouched, dst contains the euler angle sequence.
  *
  * @param { Array } quat - Source quaternion.
  * @param { Array } dst - Destination sequence of Euler angles with source euler angles code.
  *
  * @example
  * // returns [ 1, 0, 0, 0, 1, 2 ];
  * _.fromQuat2( [ 0.49794255, 0, 0, 0.8775826 ], [ 0, 0, 0, 0, 1, 2 ] );
  *
  * @example
  * // returns [ 0, 1, 0, 2, 1, 0 ];
  * _.fromQuat2( [ 0, 0.4794255, 0, 0.8775826 ], [ 0, 0, 0, 2, 1, 0 ] );
  *
  * @returns { Quat } Returns the corresponding quaternion.
  * @function fromQuat2
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( quat ) is not quat.
  * @throws { Error } An Error if ( dst ) is not euler.
  * @memberof wTools.euler
  */

function fromQuat2( quat, dst )
{

  var dst = _.euler.from( dst );
  var dstv = _.vector.from( dst );
  var quatv = _.quat._from( quat );
  var accuracy =  1e-7;

  var ex,ey,ez;

  var x = quatv.eGet( 0 );
  var y = quatv.eGet( 1 );
  var z = quatv.eGet( 2 );
  var w = quatv.eGet( 3 );

  // Normalize

  var norm = sqrt( x*x + y*y + z*z + w*w );

  if( norm !== 1 )
  {
    x = x/norm;
    y = y/norm;
    z = z/norm;
    w = w/norm;
    norm = sqrt( x*x + y*y + z*z + w*w );
  }

  var ox = dstv.eGet( 3 );
  var oy = dstv.eGet( 4 );
  var oz = dstv.eGet( 5 );

  if( ox === 0 && oy === 1 && oz === 2 )
  {
    if( - 1 + accuracy*accuracy < 2*( x*z + w*y ) && 2*( x*z + w*y ) < 1 - accuracy*accuracy )
    {
      dstv.eSet( 2, atan2( -( 2*x*y - 2*w*z ) , w*w  + x*x - z*z - y*y ) );
      dstv.eSet( 1, asin( 2*x*z + 2*w*y ) );
      dstv.eSet( 0, atan2( - ( 2*y*z - 2*w*x ) , z*z - y*y - x*x + w*w ) );
    }
    else if( 2*( x*z + w*y ) <= - 1 + accuracy*accuracy )
    {
      // console.log('Indeterminate; We set angle z = 0. ');
      dstv.eSet( 0, - atan2( ( x*y + w*z ), ( x*z - w*y ) ) );
      dstv.eSet( 1, - pi/2 );
      dstv.eSet( 2, 0 );
    }
    else if( 2*( x*z + w*y ) >= 1 - accuracy*accuracy )
    {
      // console.log('Indeterminate; We set angle z = 0. ');
      dstv.eSet( 0, - atan2( -2*( x*y + w*z ), -2*( x*z - w*y ) ) );
      dstv.eSet( 1, pi/2 );
      dstv.eSet( 2, 0 );
    }
  }

  if( ox === 0 && oy === 2 && oz === 1 )
  {
    if( - 1 + accuracy*accuracy < 2*x*y - 2*w*z && 2*x*y - 2*w*z < 1 - accuracy*accuracy )
    {
      dstv.eSet( 2, atan2( 2*x*z + 2*w*y , x*x + w*w - z*z - y*y ) );
      dstv.eSet( 1, - asin( 2*x*y - 2*w*z ) );
      dstv.eSet( 0, atan2( 2*y*z + 2*w*x , y*y - z*z + w*w - x*x ) );
    }
    else if( 2*( x*y - w*z ) <= - 1 + accuracy*accuracy )
    {
      // console.log('Indeterminate; We set angle y = 0. ');
      dstv.eSet( 0, atan2( (x*z - w*y ), ( x*y + w*z ) ) );
      dstv.eSet( 1, pi/2 );
      dstv.eSet( 2, 0 );
    }
    else if( 2*( x*y - w*z ) >= 1 - accuracy*accuracy )
    {
      // console.log('Indeterminate; We set angle y = 0. ');
      dstv.eSet( 0, atan2( -2*( y*z - w*x ), 1-2*( x*x + y*y ) ) );
      dstv.eSet( 1, - pi/2 );
      dstv.eSet( 2, 0 );
    }
  }

  if( ox === 1 && oy === 0 && oz === 2 )
  {
    if( - 1 + accuracy*accuracy < ( 2*y*z - 2*w*x ) && ( 2*y*z - 2*w*x ) < 1 - accuracy*accuracy )
    {
      dstv.eSet( 2, atan2( 2*x*y + 2*w*z , y*y - z*z + w*w - x*x ) );
      dstv.eSet( 1, - asin( 2*y*z - 2*w*x ) );
      dstv.eSet( 0, atan2( 2*x*z + 2*w*y , z*z - y*y - x*x + w*w ) );
    }
    else if( ( 2*y*z - 2*w*x ) <= -1 + accuracy*accuracy )
    {
      // console.log('Indeterminate; We set angle z = 0. ');
      dstv.eSet( 0, atan2( ( x*y - w*z ), ( y*z + w*x ) ) );
      dstv.eSet( 1, pi/2 );
      dstv.eSet( 2, 0 );
    }
    else if( ( 2*y*z - 2*w*x ) >= 1 - accuracy*accuracy )
    {
      // console.log('Indeterminate; We set angle z = 0. ');
      dstv.eSet( 0, atan2( -2*( x*z - w*y ), 1-2*( y*y + z*z ) ) );
      dstv.eSet( 1, - pi/2 );
      dstv.eSet( 2, 0 );
    }
  }

  if( ox === 1 && oy === 2 && oz === 0 )
  {
    if( - 1 + accuracy*accuracy < ( 2*x*y + 2*w*z ) && ( 2*x*y + 2*w*z ) < 1 - accuracy*accuracy )
    {
      dstv.eSet( 2, atan2( - 2*y*z + 2*w*x , y*y - z*z + w*w - x*x ) );
      dstv.eSet( 1, asin( 2*x*y + 2*w*z ) );
      dstv.eSet( 0, atan2( - 2*x*z + 2*w*y , x*x + w*w - z*z - y*y  ) );
    }
    else if( ( 2*x*y + 2*w*z ) <= - 1 + accuracy*accuracy )
    {
      // console.log('Indeterminate; We set angle x = 0. ');
      dstv.eSet( 0, atan2( (x*z + w*y ), ( x*y - w*z ) ) );
      dstv.eSet( 1, - pi/2 );
      dstv.eSet( 2, 0 );
    }
    else if( ( 2*x*y + 2*w*z ) >= 1 - accuracy*accuracy )
    {
      // console.log('Indeterminate; We set angle x = 0. ');
      dstv.eSet( 0, atan2( 2*( x*z + w*y ), 1-2*( x*x + y*y ) ) );
      dstv.eSet( 1, + pi/2 );
      dstv.eSet( 2, 0 );
    }
  }

  if( ox === 2 && oy === 0 && oz === 1 )
  {
    if( - 1 + accuracy*accuracy < ( 2*y*z + 2*w*x ) && ( 2*y*z + 2*w*x ) < 1 - accuracy*accuracy )
    {
      dstv.eSet( 2, atan2( - 2*x*z + 2*w*y , z*z - y*y - x*x + w*w  ) );
      dstv.eSet( 1, asin( 2*y*z + 2*w*x ) );
      dstv.eSet( 0, atan2( - 2*x*y + 2*w*z , y*y - z*z + w*w - x*x  ) );
    }
    else if( ( 2*y*z + 2*w*x ) <= - 1 + accuracy*accuracy )
    {
      // console.log('Indeterminate; We set angle y = 0. ');
      dstv.eSet( 0, atan2( ( x*y + w*z ), ( y*z - w*x ) ) );
      dstv.eSet( 1, - pi/2 );
      dstv.eSet( 2, 0 );
    }
    else if( ( 2*y*z + 2*w*x ) >= 1 - accuracy*accuracy )
    {
      // console.log('Indeterminate; We set angle y = 0. ');
      dstv.eSet( 0, atan2( 2*( x*y + w*z ), 1-2*( y*y + z*z ) ) );
      dstv.eSet( 1, pi/2 );
      dstv.eSet( 2, 0 );
    }
  }

  if( ox === 2 && oy === 1 && oz === 0 )
  {
    if( - 1 + accuracy*accuracy < 2*( x*z - w*y ) && 2*( x*z - w*y ) < 1 - accuracy*accuracy )
    {
      dstv.eSet( 2, atan2( 2*y*z + 2*w*x , z*z - y*y - x*x + w*w ) );
      dstv.eSet( 1, asin( 2*w*y - 2*x*z ) );
      dstv.eSet( 0, atan2( 2*x*y + 2*w*z , x*x + w*w - y*y - z*z ) );
    }
    else if( 2*( x*z - w*y ) <= - 1 + accuracy*accuracy )
    {
      // console.log('Indeterminate; We set angle x = 0. ');
      dstv.eSet( 0, - atan2( ( x*y - w*z ), ( x*z + w*y ) ) );
      dstv.eSet( 1, pi/2 );
      dstv.eSet( 2, 0 );
    }
    else if( 2*( x*z - w*y ) >= 1 - accuracy*accuracy)
    {
      // console.log('Indeterminate; We set angle x = 0. ');
      dstv.eSet( 0, atan2( -2*( x*y - w*z ), -2*( x*z + w*y ) ) );
      dstv.eSet( 1, - pi/2 );
      dstv.eSet( 2, 0 );
    }
  }

  if( ox === 0 && oy === 1 && oz === 0 )
  {

    if( - 1 < (  x*x + w*w - z*z - y*y ) && (  x*x + w*w - z*z - y*y ) < 1 )
    {
      dstv.eSet( 2, atan2( 2*x*y - 2*w*z , 2*x*z + 2*w*y ) );
      dstv.eSet( 1, acos(  x*x + w*w - z*z - y*y ) );
      dstv.eSet( 0, atan2( 2*x*y + 2*w*z , -2*x*z + 2*w*y ) );
    }
    else if( (  x*x + w*w - z*z - y*y ) <= - 1 )
    {
      // console.log('Indeterminate; We set angle x2 = 0. ');
      dstv.eSet( 0, atan2( ( z*y - w*x ), 0.5 - ( x*x + z*z ) ) );
      dstv.eSet( 1, pi );
      dstv.eSet( 2, 0 );
    }
    else if( (  x*x + w*w - z*z - y*y ) >= 1 )
    {
      // console.log('Indeterminate; We set angle x2 = 0. ');
      dstv.eSet( 0, atan2( ( z*y + w*x ), 0.5 - ( x*x + z*z ) ) );
      dstv.eSet( 1, 0 );
      dstv.eSet( 2, 0 );
    }
  }

  if( ox === 0 && oy === 2 && oz === 0 )
  {

    if( - 1 < (  x*x + w*w - z*z - y*y ) && (  x*x + w*w - z*z - y*y ) < 1 )
    {
      dstv.eSet( 2, atan2( 2*x*z + 2*w*y , -2*x*y + 2*w*z ) );
      dstv.eSet( 1, acos( x*x + w*w -z*z - y*y ) );
      dstv.eSet( 0, atan2( 2*x*z - 2*w*y , 2*x*y + 2*w*z ) );
    }
    else if( (  x*x + w*w - z*z - y*y ) <= - 1 )
    {
      // console.log('Indeterminate; We set angle x2 = 0. ');
      dstv.eSet( 0, - atan2( ( z*y + w*x ), 0.5 - ( x*x + y*y ) ) );
      dstv.eSet( 1, pi );
      dstv.eSet( 2, 0 );
    }
    else if( (  x*x + w*w - z*z - y*y ) >= 1 )
    {
      // console.log('Indeterminate; We set angle x2 = 0. ');
      dstv.eSet( 0, atan2( ( z*y + w*x ), 0.5 - ( x*x + y*y ) ) );
      dstv.eSet( 1, 0 );
      dstv.eSet( 2, 0 );
    }
  }

  if( ox === 1 && oy === 0 && oz === 1 )
  {

    if( - 1 < ( y*y - z*z + w*w - x*x ) && ( y*y - z*z + w*w - x*x ) < 1 )
    {
      dstv.eSet( 2, atan2( 2*x*y + 2*w*z , -2*y*z + 2*w*x ) );
      dstv.eSet( 1, acos( y*y - z*z + w*w - x*x ) );
      dstv.eSet( 0, atan2( 2*x*y - 2*w*z , 2*y*z + 2*w*x ) );
    }
    else if( ( y*y - z*z + w*w - x*x ) <= - 1 )
    {
      // console.log('Indeterminate; We set angle y2 = 0. ');
      dstv.eSet( 0, - atan2( ( z*x - w*y ), 0.5 - ( z*z + y*y ) ) );
      dstv.eSet( 1, pi );
      dstv.eSet( 2, 0 );
    }
    else if( ( y*y - z*z + w*w - x*x ) >= 1 )
    {
      // console.log('Indeterminate; We set angle y2 = 0. ');
      dstv.eSet( 0, atan2( ( z*x + w*y ), 0.5 - ( z*z + y*y ) ) );
      dstv.eSet( 1, 0 );
      dstv.eSet( 2, 0 );
    }
  }

  if( ox === 1 && oy === 2 && oz === 1 )
  {
      if( - 1 < ( y*y - z*z + w*w - x*x ) && ( y*y - z*z + w*w - x*x ) < 1 )
      {
        dstv.eSet( 2, atan2( 2*y*z - 2*w*x , 2*x*y + 2*w*z ) );
        dstv.eSet( 1, acos( y*y - z*z + w*w - x*x ) );
        dstv.eSet( 0, atan2( 2*y*z + 2*w*x , -2*x*y + 2*w*z ) );
      }
      else if( ( y*y - z*z + w*w - x*x ) <= - 1 )
      {
        // console.log('Indeterminate; We set angle y2 = 0. ');
        dstv.eSet( 0, atan2( ( z*x - w*y ), 0.5 - ( y*y + x*x ) ) );
        dstv.eSet( 1, pi );
        dstv.eSet( 2, 0 );
      }
      else if( ( y*y - z*z + w*w - x*x ) >= 1 )
      {
        // console.log('Indeterminate; We set angle y2 = 0. ');
        dstv.eSet( 0, atan2( ( z*x + w*y ), 0.5 - ( y*y + x*x ) ) );
        dstv.eSet( 1, 0 );
        dstv.eSet( 2, 0 );
      }
  }

  if( ox === 2 && oy === 0 && oz === 2 )
  {
    if( -1 < ( z*z - x*x - y*y + w*w ) && ( z*z - x*x - y*y + w*w ) < 1 )
    {
        dstv.eSet( 2, atan2( ( 2*x*z - 2*w*y ), ( 2*y*z + 2*w*x ) ) );
        dstv.eSet( 1, acos( ( z*z - x*x - y*y + w*w ) ) );
        dstv.eSet( 0, atan2( ( 2*x*z + 2*w*y ), - ( 2*y*z - 2*w*x ) ) );
    }
    else if( ( z*z - x*x - y*y + w*w ) <= - 1 )
    {
      // console.log('Indeterminate; We set angle z2 = 0. ');
      dstv.eSet( 0, atan2( ( x*y - w*z ), 0.5 - ( y*y + z*z ) ) );
      dstv.eSet( 1, pi );
      dstv.eSet( 2, 0 );
    }
    else if( ( z*z - x*x - y*y + w*w ) >= 1 )
    {
      // console.log('Indeterminate; We set angle z2 = 0. ');
      dstv.eSet( 0, - atan2( ( x*y - w*z ), 0.5 - ( y*y + z*z ) ) );
      dstv.eSet( 1, 0 );
      dstv.eSet( 2, 0 );
    }
  }

  if( ox === 2 && oy === 1 && oz === 2 )
  {
    if( -1 < ( z*z - x*x - y*y + w*w ) && ( z*z - x*x - y*y + w*w ) < 1 )
    {
      dstv.eSet( 2, atan2( ( 2*y*z + 2*w*x ), ( - 2*x*z + 2*w*y ) ) );
      dstv.eSet( 1, acos( ( z*z - x*x - y*y + w*w ) ) );
      dstv.eSet( 0, atan2( ( 2*y*z - 2*w*x ), ( 2*x*z + 2*w*y ) ) );
    }
    else if( ( z*z - x*x - y*y + w*w ) <= -1 )
    {
      // console.log('Indeterminate; We set angle z2 = 0. ');
      dstv.eSet( 0, atan2( -( x*y - w*z ), 0.5 - ( x*x + z*z ) ) );
      dstv.eSet( 1, pi );
      dstv.eSet( 2, 0 );
    }
    else if( ( z*z - x*x - y*y + w*w ) >= 1 )
    {
      // console.log('Indeterminate; We set angle z2 = 0. ');
      dstv.eSet( 0, atan2( ( x*y + w*z ), 0.5 - ( x*x + z*z ) ) );
      dstv.eSet( 1, 0 );
      dstv.eSet( 2, 0 );
    }
  }
  return dst;

}


/**
  * Create the quaternion from a set of euler angles. Returns the created quaternion.
  * Euler angles stay untouched.
  *
  * @param { Array } euler - Source sequence of Euler angles.
  *
  * @example
  * // returns [ 0.49794255, 0, 0, 0.8775826 ];
  * _.toQuat2( [ 1, 0, 0, 0, 1, 2 ] );
  *
  * @example
  * // returns [ 0, 0.4794255, 0, 0.8775826 ];
  * _.toQuat2( [ 0, 1, 0, 2, 1, 0 ] );
  *
  * @returns { Quat } Returns the corresponding quaternion.
  * @function toQuat2
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( euler ) is not euler.
  * @memberof wTools.euler
  */

function toQuat2( euler )
{

  var euler = _.euler.from( euler );
  var eulerv = _.vector.from( euler );
  var quatv = _.quat._from( _.quat.makeUnit() );

  _.assert( arguments.length === 1 );

  var e0 = eulerv.eGet( 0 );
  var e1 = eulerv.eGet( 1 );
  var e2 = eulerv.eGet( 2 );
  var ox = eulerv.eGet( 3 );
  var oy = eulerv.eGet( 4 );
  var oz = eulerv.eGet( 5 );

  if( ox === 0 && oy === 1 && oz === 2 )
  {
    quatv.eSet( 0, sin( e0/2 )*cos( e1/2 )*cos( e2/2 ) + cos( e0/2 )*sin( e1/2 )*sin( e2/2) );
    quatv.eSet( 1, cos( e0/2 )*sin( e1/2 )*cos( e2/2 ) - sin( e0/2 )*cos( e1/2 )*sin( e2/2) );
    quatv.eSet( 2, cos( e0/2 )*cos( e1/2 )*sin( e2/2 ) + sin( e0/2 )*sin( e1/2 )*cos( e2/2) );
    quatv.eSet( 3, cos( e0/2 )*cos( e1/2 )*cos( e2/2 ) - sin( e0/2 )*sin( e1/2 )*sin( e2/2) );
  }

  else if( ox === 0 && oy === 2 && oz === 1 )
  {
    quatv.eSet( 0, sin( e0/2 )*cos( e1/2 )*cos( e2/2 ) - cos( e0/2 )*sin( e1/2 )*sin( e2/2) );
    quatv.eSet( 1, cos( e0/2 )*cos( e1/2 )*sin( e2/2 ) - sin( e0/2 )*sin( e1/2 )*cos( e2/2) );
    quatv.eSet( 2, cos( e0/2 )*sin( e1/2 )*cos( e2/2 ) + sin( e0/2 )*cos( e1/2 )*sin( e2/2) );
    quatv.eSet( 3, cos( e0/2 )*cos( e1/2 )*cos( e2/2 ) + sin( e0/2 )*sin( e1/2 )*sin( e2/2) );
  }

  else if( ox === 0 && oy === 1 && oz === 0 )
  {
    quatv.eSet( 0, sin( ( e0 + e2 )/2 )*cos( e1/2 ) );
    quatv.eSet( 1, cos( ( e0 - e2 )/2 )*sin( e1/2 ) );
    quatv.eSet( 2, sin( ( e0 - e2 )/2 )*sin( e1/2 ) );
    quatv.eSet( 3, cos( ( e0 + e2 )/2 )*cos( e1/2 ) );
  }

  else if( ox === 0 && oy === 2 && oz === 0 )
  {
    quatv.eSet( 0, sin( ( e0 + e2 )/2 )*cos( e1/2 ) );
    quatv.eSet( 1, - sin( ( e0 - e2 )/2 )*sin( e1/2 ) );
    quatv.eSet( 2, cos( ( e0 - e2 )/2 )*sin( e1/2 ) );
    quatv.eSet( 3, cos( ( e0 + e2 )/2 )*cos( e1/2 ) );
  }

  else if( ox === 1 && oy === 0 && oz === 2 )
  {
    quatv.eSet( 0, cos( e0/2 )*sin( e1/2 )*cos( e2/2 ) + sin( e0/2 )*cos( e1/2 )*sin( e2/2) );
    quatv.eSet( 1, sin( e0/2 )*cos( e1/2 )*cos( e2/2 ) - cos( e0/2 )*sin( e1/2 )*sin( e2/2) );
    quatv.eSet( 2, cos( e0/2 )*cos( e1/2 )*sin( e2/2 ) - sin( e0/2 )*sin( e1/2 )*cos( e2/2) );
    quatv.eSet( 3, cos( e0/2 )*cos( e1/2 )*cos( e2/2 ) + sin( e0/2 )*sin( e1/2 )*sin( e2/2) );
  }

  else if( ox === 1 && oy === 2 && oz === 0 )
  {
    quatv.eSet( 0, cos( e0/2 )*cos( e1/2 )*sin( e2/2 ) + sin( e0/2 )*sin( e1/2 )*cos( e2/2) );
    quatv.eSet( 1, sin( e0/2 )*cos( e1/2 )*cos( e2/2 ) + cos( e0/2 )*sin( e1/2 )*sin( e2/2) );
    quatv.eSet( 2, cos( e0/2 )*sin( e1/2 )*cos( e2/2 ) - sin( e0/2 )*cos( e1/2 )*sin( e2/2) );
    quatv.eSet( 3, cos( e0/2 )*cos( e1/2 )*cos( e2/2 ) - sin( e0/2 )*sin( e1/2 )*sin( e2/2) );
  }

  else if( ox === 1 && oy === 0 && oz === 1 )
  {
    quatv.eSet( 0, cos( ( e0 - e2 )/2 )*sin( e1/2 ) );
    quatv.eSet( 1, sin( ( e0 + e2 )/2 )*cos( e1/2 ) );
    quatv.eSet( 2, - sin( ( e0 - e2 )/2 )*sin( e1/2 ) );
    quatv.eSet( 3, cos( ( e0 + e2 )/2 )*cos( e1/2 ) );
  }

  else if( ox === 1 && oy === 2 && oz === 1 )
  {
    quatv.eSet( 0, sin( ( e0 - e2 )/2 )*sin( e1/2 ) );
    quatv.eSet( 1, sin( ( e0 + e2 )/2 )*cos( e1/2 ) );
    quatv.eSet( 2, cos( ( e0 - e2 )/2 )*sin( e1/2 ) );
    quatv.eSet( 3, cos( ( e0 + e2 )/2 )*cos( e1/2 ) );
  }

  else if( ox === 2 && oy === 1 && oz === 0 )
  {
    quatv.eSet( 0, cos( e0/2 )*cos( e1/2 )*sin( e2/2 ) - sin( e0/2 )*sin( e1/2 )*cos( e2/2) );
    quatv.eSet( 1, cos( e0/2 )*sin( e1/2 )*cos( e2/2 ) + sin( e0/2 )*cos( e1/2 )*sin( e2/2) );
    quatv.eSet( 2, sin( e0/2 )*cos( e1/2 )*cos( e2/2 ) - cos( e0/2 )*sin( e1/2 )*sin( e2/2) );
    quatv.eSet( 3, cos( e0/2 )*cos( e1/2 )*cos( e2/2 ) + sin( e0/2 )*sin( e1/2 )*sin( e2/2) );
  }

  else if( ox === 2 && oy === 0 && oz === 1 )
  {
    quatv.eSet( 0, cos( e0/2 )*sin( e1/2 )*cos( e2/2 ) - sin( e0/2 )*cos( e1/2 )*sin( e2/2) );
    quatv.eSet( 1, cos( e0/2 )*cos( e1/2 )*sin( e2/2 ) + sin( e0/2 )*sin( e1/2 )*cos( e2/2) );
    quatv.eSet( 2, sin( e0/2 )*cos( e1/2 )*cos( e2/2 ) + cos( e0/2 )*sin( e1/2 )*sin( e2/2) );
    quatv.eSet( 3, cos( e0/2 )*cos( e1/2 )*cos( e2/2 ) - sin( e0/2 )*sin( e1/2 )*sin( e2/2) );
  }

  else if( ox === 2 && oy === 0 && oz === 2 )
  {
    quatv.eSet( 0, cos( ( e0 - e2 )/2 )*sin( e1/2 ) );
    quatv.eSet( 1, sin( ( e0 - e2 )/2 )*sin( e1/2 ) );
    quatv.eSet( 2, sin( ( e0 + e2 )/2 )*cos( e1/2 ) );
    quatv.eSet( 3, cos( ( e0 + e2 )/2 )*cos( e1/2 ) );
  }

  else if( ox === 2 && oy === 1 && oz === 2 )
  {
    quatv.eSet( 0, - sin( ( e0 - e2 )/2 )*sin( e1/2 ) );
    quatv.eSet( 1, cos( ( e0 - e2 )/2 )*sin( e1/2 ) );
    quatv.eSet( 2, sin( ( e0 + e2 )/2 )*cos( e1/2 ) );
    quatv.eSet( 3, cos( ( e0 + e2 )/2 )*cos( e1/2 ) );
  }

  else
  {
     return 0;
  }

  return quatv;
}

//


/**
  * Create the euler angle from a rotation matrix. Returns the created euler angle.
  * Rotation matrix stays untouched.
  *
  * @param { Space } mat - Source rotation matrix.
  * @param { Array } dst - Destination array with euler angle source code.
  *
  * @example
  * // returns [ 0.5, 0.5, 0.5, 0, 1, 2 ]
  *  mat  = _.Space.make( [ 3, 3 ] ).copy(
  *            [ 0.7701, -0.4207, 0.4794,
  *             0.6224, 0.6599, - 0.4207,
  *           - 0.1393, 0.6224, 0.7701 ] );
  * _.fromMatrix2( mat, [ 0, 0, 0, 0, 1, 2 ] );
  *
  * @returns { Array } Returns the corresponding euler angles.
  * @function fromMatrix2
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dst ) is not euler.
  * @throws { Error } An Error if ( mat ) is not matrix.
  * @memberof wTools.euler
  */

function fromMatrix2( mat, dst )
{

  var euler = _.euler.from( dst );
  var eulerv = _.vector.from( euler );

  _.assert( _.Space.is( mat ) );
  _.assert( mat.dims[ 0 ] >= 3 );
  _.assert( mat.dims[ 1 ] >= 3 );
  _.assert( arguments.length === 2 );

  var m00 = mat.atomGet([ 0,0 ]); var m01 = mat.atomGet([ 0,1 ]); var m02 = mat.atomGet([ 0,2 ]);
  var m10 = mat.atomGet([ 1,0 ]); var m11 = mat.atomGet([ 1,1 ]); var m12 = mat.atomGet([ 1,2 ]);
  var m20 = mat.atomGet([ 2,0 ]); var m21 = mat.atomGet([ 2,1 ]); var m22 = mat.atomGet([ 2,2 ]);

  var ox = eulerv.eGet( 3 );
  var oy = eulerv.eGet( 4 );
  var oz = eulerv.eGet( 5 );

  if( ox === 0 && oy === 1 && oz === 2 )
  {
    if( - 1 < m02 && m02 < 1 )
    {
      eulerv.eSet( 0, atan2( - m12, m22 ) );
      eulerv.eSet( 1, atan2( m02, sqrt( 1 - m02*m02 ) ) );
      eulerv.eSet( 2, atan2( - m01, m00 ) );
    }
    else if( m02 <= - 1 )
    {
      eulerv.eSet( 0, - atan2( m10, m11 ) );
      eulerv.eSet( 1, - pi/2 );
      eulerv.eSet( 2, 0 );
    }
    else if( m02 >= 1 )
    {
      eulerv.eSet( 0, atan2( m10, m11 ) );
      eulerv.eSet( 1, pi/2 );
      eulerv.eSet( 2, 0 );
    }
  }

  if( ox === 0 && oy === 2 && oz === 1 )
  {
    if( - 1 < m01 && m01 < 1 )
    {
      eulerv.eSet( 0, atan2( m21, m11 ) );
      eulerv.eSet( 2, atan2( m02, m00 ) );
      eulerv.eSet( 1, asin( - m01) );
    }
    else if( m01 >= 1 )
    {
      eulerv.eSet( 0, atan2( - m20, m22 ) );
      eulerv.eSet( 2, 0 );
      eulerv.eSet( 1, - pi/2 );
    }
    else if( m01 <= - 1 )
    {
      eulerv.eSet( 0, - atan2( - m20, m22 ) );
      eulerv.eSet( 2, 0 );
      eulerv.eSet( 1, pi/2 );
    }
  }

  if( ox === 1 && oy === 0 && oz === 2 )
  {
    if( - 1 < m12 && m12 < 1 )
    {
      eulerv.eSet( 1, asin( -m12 ) );
      eulerv.eSet( 0, atan2( m02, m22 ) );
      eulerv.eSet( 2, atan2( m10, m11 ) );
    }
    else if( m12 >= 1 )
    {
      eulerv.eSet( 1, - pi/2 );
      eulerv.eSet( 0, atan2( - m01, m00 ) );
      eulerv.eSet( 2, 0 );
    }
    else if( m12 <= - 1 )
    {
      eulerv.eSet( 1, pi/2);
      eulerv.eSet( 0, - atan2( - m01, m00 )  );
      eulerv.eSet( 2, 0 );
    }
  }

  if( ox === 1 && oy === 2 && oz === 0 )
  {
    if( - 1 < m10 && m10 < 1 )
    {
      eulerv.eSet( 2, atan2( - m12, m11 ) );
      eulerv.eSet( 0, atan2( - m20, m00 ) );
      eulerv.eSet( 1, asin( m10 ) );
    }
    else if( m10 <= - 1 )
    {
      eulerv.eSet( 2, 0 );
      eulerv.eSet( 0, - atan2( m21, m22 ) );
      eulerv.eSet( 1, - pi/2 );
    }
    else if( m10 >= 1 )
    {
      eulerv.eSet( 2, 0 );
      eulerv.eSet( 0, atan2( m21, m22 )  );
      eulerv.eSet( 1, pi/2 );
    }
  }

  if( ox === 2 && oy === 0 && oz === 1 )
  {
    if( - 1 < m21 && m21 < 1 )
    {
      eulerv.eSet( 1, asin( m21 ) );
      eulerv.eSet( 2, atan2( - m20, m22 ) );
      eulerv.eSet( 0, atan2( - m01, m11 ) );
    }
    else if( m21 <= - 1 )
    {
      eulerv.eSet( 1, - pi/2 );
      eulerv.eSet( 2, 0 );
      eulerv.eSet( 0, - atan2( m02, m00 ) );
    }
    else if( m21 >= 1 )
    {
      eulerv.eSet( 1, pi/2 );
      eulerv.eSet( 2, 0 );
      eulerv.eSet( 0, atan2( m02, m00 ) );
    }
  }

  if( ox === 2 && oy === 1 && oz === 0 )
  {
    if( - 1 < m20 && m20 < 1 )
    {
      eulerv.eSet( 2, atan2( m21, m22 ) );
      eulerv.eSet( 1, asin( - m20 ) );
      eulerv.eSet( 0, atan2( m10, m00 ) );
    }
    else if( m20 <= - 1 )
    {
      eulerv.eSet( 2, 0 );
      eulerv.eSet( 1, pi/2 );
      eulerv.eSet( 0, - atan2( - m12, m11 ) );
    }
    else if( m20 >= 1 )
    {
      eulerv.eSet( 2, 0 );
      eulerv.eSet( 1, - pi/2 );
      eulerv.eSet( 0, atan2( - m12, m11 ) );
    }
  }

  if( ox === 0 && oy === 1 && oz === 0 )
  {
    if( - 1 < m00 && m00 < 1 )
    {
      eulerv.eSet( 0, atan2( m10, - m20 ) );
      eulerv.eSet( 1, acos( m00 ) );
      eulerv.eSet( 2, atan2( m01, m02 ) );
    }
    else if( m00 <= - 1 )
    {
      eulerv.eSet( 0, - atan2( - m12, m11 ) );
      eulerv.eSet( 1, pi );
      eulerv.eSet( 2, 0 );
    }
    else if( m00 >= 1 )
    {
      eulerv.eSet( 0, atan2( - m12, m11 ) );
      eulerv.eSet( 1, 0 );
      eulerv.eSet( 2, 0 );
    }
  }

  if( ox === 0 && oy === 2 && oz === 0 )
  {
    if( - 1 < m00 && m00 < 1 )
    {
      eulerv.eSet( 0, atan2( m20, m10 ) );
      eulerv.eSet( 1, acos( m00 ) );
      eulerv.eSet( 2, atan2( m02, - m01 ) );
    }
    else if( m00 <= - 1 )
    {
      eulerv.eSet( 0, - atan2( m21, m22 ) );
      eulerv.eSet( 1, pi );
      eulerv.eSet( 2, 0 );
    }
    else if( m00 >= 1 )
    {
      eulerv.eSet( 0, atan2( m21, m22 ) );
      eulerv.eSet( 1, 0 );
      eulerv.eSet( 2, 0 );
    }
  }

  if( ox === 1 && oy === 0 && oz === 1 )
  {
    if( - 1 < m11 && m11 < 1 )
    {
      eulerv.eSet( 0, atan2( m01, m21 ) );
      eulerv.eSet( 1, acos( m11 ) );
      eulerv.eSet( 2, atan2( m10, - m12 ) );
    }
    else if( m11 <= - 1 )
    {
      eulerv.eSet( 0, - atan2( m02, m00 ) );
      eulerv.eSet( 1, pi );
      eulerv.eSet( 2, 0 );
    }
    else if( m11 >= 1 )
    {
      eulerv.eSet( 0, atan2( m02, m00 ) );
      eulerv.eSet( 1, 0 );
      eulerv.eSet( 2, 0 );
    }
  }

  if( ox === 1 && oy === 2 && oz === 1 )
  {
    if( - 1 < m11 && m11 < 1 )
    {
      eulerv.eSet( 0, atan2( m21, - m01 ) );
      eulerv.eSet( 1, acos( m11 ) );
      eulerv.eSet( 2, atan2( m12, m10 ) );
    }
    else if( m11 <= - 1 )
    {
      eulerv.eSet( 0, atan2( m20, m22 ) );
      eulerv.eSet( 1, pi );
      eulerv.eSet( 2, 0 );
    }
    else if( m11 >= 1 )
    {
      eulerv.eSet( 0, atan2( - m20, m22 ) );
      eulerv.eSet( 1, 0 );
      eulerv.eSet( 2, 0 );
    }
  }

  if( ox === 2 && oy === 0 && oz === 2 )
  {
    if( - 1 < m22 && m22 < 1 )
    {
      eulerv.eSet( 0, atan2( m02, - m12 ) );
      eulerv.eSet( 1, acos( m22 ) );
      eulerv.eSet( 2, atan2( m20, m21 ) );
    }
    else if( m22 <= - 1 )
    {
      eulerv.eSet( 0, atan2( m10, m00 ) );
      eulerv.eSet( 1, pi );
      eulerv.eSet( 2, 0 );
    }
    else if( m22 >= 1 )
    {
      eulerv.eSet( 0, atan2( m10, m00 ) );
      eulerv.eSet( 1, 0 );
      eulerv.eSet( 2, 0 );
    }
  }

  if( ox === 2 && oy === 1 && oz === 2 )
  {
    if( - 1 < m22 && m22 < 1 )
    {
      eulerv.eSet( 0, atan2( m12, m02 ) );
      eulerv.eSet( 1, acos( m22 ) );
      eulerv.eSet( 2, atan2( m21, - m20 ) );
    }
    else if( m22 <= - 1 )
    {
      eulerv.eSet( 0, - atan2( m10, m11 ) );
      eulerv.eSet( 1, pi );
      eulerv.eSet( 2, 0 );
    }
    else if( m22 >= 1 )
    {
      eulerv.eSet( 0, atan2( m10, m11 ) );
      eulerv.eSet( 1, 0 );
      eulerv.eSet( 2, 0 );
    }
  }

  return eulerv;
}

//

/**
  * Create the rotation matrix from a set of euler angles. Returns the created matrix.
  * Euler angles stay untouched.
  *
  * @param { Array } euler - Source sequence of Euler angles.
  *
  * @example
  * // returns [ 0.7701, -0.4207, 0.4794,
                 0.6224, 0.6599, - 0.4207,
                 - 0.1393, 0.6224, 0.7701 ];
  * _.toMatrix2( [ 0.5, 0.5, 0.5, 0, 1, 2 ] );
  *
  * @example
  * // returns [ 0.4741, - 0.6142, 0.6307,
  * //           0.7384, 0.6675, 0.0950,
  * //           - 0.4794, 0.4207, 0.7701 ]
  * _.toMatrix2( [ 1, 0.5, 0.5, 2, 1, 0 ] );
  *
  * @returns { Space } Returns the corresponding rotation matrix.
  * @function toMatrix2
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( euler ) is not euler.
  * @memberof wTools.euler
  */
/* qqq : adjust indentation of documentations */

function toMatrix2( euler )
{

  var euler = _.euler.from( euler );
  var eulerv = _.vector.from( euler );
  var mat =  _.Space.makeZero( [ 3, 3 ] );

  _.assert( _.Space.is( mat ) );
  _.assert( arguments.length === 1 );

  var e1 = eulerv.eGet( 0 );
  var e2 = eulerv.eGet( 1 );
  var e3 = eulerv.eGet( 2 );
  var ox = eulerv.eGet( 3 );
  var oy = eulerv.eGet( 4 );
  var oz = eulerv.eGet( 5 );

  var ce1 = cos( e1 );
  var ce2 = cos( e2 );
  var ce3 = cos( e3 );
  var se1 = sin( e1 );
  var se2 = sin( e2 );
  var se3 = sin( e3 );

  /* qqq : should be if else if else */
  /* qqq : not optimal */

  if( ox === 0 && oy === 1 && oz === 2 )
  {
    mat.atomSet( [ 0, 0 ], ce2*ce3 );
    mat.atomSet( [ 0, 1 ], - ce2*se3 );
    mat.atomSet( [ 0, 2 ], se2 );
    mat.atomSet( [ 1, 0 ], se1*se2*ce3 + ce1*se3 );
    mat.atomSet( [ 1, 1 ], -se1*se2*se3 + ce1*ce3 );
    mat.atomSet( [ 1, 2 ], -se1*ce2 );
    mat.atomSet( [ 2, 0 ], -ce1*se2*ce3 + se1*se3 );
    mat.atomSet( [ 2, 1 ], ce1*se2*se3+ se1*ce3 );
    mat.atomSet( [ 2, 2 ], ce1*ce2 );
  }

  else if( ox === 0 && oy === 2 && oz === 1 )
  {
    mat.atomSet( [ 0, 0 ], ce2*ce3 );
    mat.atomSet( [ 0, 1 ], - se2 );
    mat.atomSet( [ 0, 2 ], ce2*se3 );
    mat.atomSet( [ 1, 0 ], ce1*se2*ce3 + se1*se3 );
    mat.atomSet( [ 1, 1 ], ce1*ce2 );
    mat.atomSet( [ 1, 2 ], ce1*se2*se3 - se1*ce3 );
    mat.atomSet( [ 2, 0 ], se1*se2*ce3 - ce1*se3 );
    mat.atomSet( [ 2, 1 ], se1*ce2 );
    mat.atomSet( [ 2, 2 ], se1*se2*se3 + ce1*ce3 );
  }

  else if( ox === 1 && oy === 0 && oz === 2 )
  {
    mat.atomSet( [ 0, 0 ], se1*se2*se3 + ce1*ce3 );
    mat.atomSet( [ 0, 1 ], se1*se2*ce3 - ce1*se3 );
    mat.atomSet( [ 0, 2 ], se1*ce2 );
    mat.atomSet( [ 1, 0 ], ce2*se3 );
    mat.atomSet( [ 1, 1 ], ce2*ce3 );
    mat.atomSet( [ 1, 2 ], -se2 );
    mat.atomSet( [ 2, 0 ], ce1*se2*se3 - se1*ce3 );
    mat.atomSet( [ 2, 1 ], ce1*se2*ce3+ se1*se3 );
    mat.atomSet( [ 2, 2 ], ce1*ce2 );
  }

  else if( ox === 1 && oy === 2 && oz === 0 )
  {
    mat.atomSet( [ 0, 0 ], ce1*ce2 );
    mat.atomSet( [ 0, 1 ], - ce1*se2*ce3 + se1*se3 );
    mat.atomSet( [ 0, 2 ], ce1*se2*se3 + se1*ce3 );
    mat.atomSet( [ 1, 0 ], se2 );
    mat.atomSet( [ 1, 1 ], ce2*ce3 );
    mat.atomSet( [ 1, 2 ], - ce2*se3 );
    mat.atomSet( [ 2, 0 ], - se1*ce2 );
    mat.atomSet( [ 2, 1 ], se1*se2*ce3+ ce1*se3 );
    mat.atomSet( [ 2, 2 ], - se1*se2*se3 + ce1*ce3 );
  }

  else if( ox === 2 && oy === 0 && oz === 1 )
  {
    mat.atomSet( [ 0, 0 ], - se1*se2*se3 + ce1*ce3 );
    mat.atomSet( [ 0, 1 ], - se1*ce2 );
    mat.atomSet( [ 0, 2 ], se1*se2*ce3 + ce1*se3 );
    mat.atomSet( [ 1, 0 ], ce1*se2*se3 + se1*ce3 );
    mat.atomSet( [ 1, 1 ], ce1*ce2 );
    mat.atomSet( [ 1, 2 ], - ce1*se2*ce3 + se1*se3 );
    mat.atomSet( [ 2, 0 ], - ce2*se3 );
    mat.atomSet( [ 2, 1 ], se2 );
    mat.atomSet( [ 2, 2 ], ce2*ce3 );
  }

  else if( ox === 2 && oy === 1 && oz === 0 )
  {
    mat.atomSet( [ 0, 0 ], ce1*ce2 );
    mat.atomSet( [ 0, 1 ], ce1*se2*se3 - se1*ce3 );
    mat.atomSet( [ 0, 2 ], ce1*se2*ce3 + se1*se3 );
    mat.atomSet( [ 1, 0 ], se1*ce2 );
    mat.atomSet( [ 1, 1 ], se1*se2*se3 + ce1*ce3 );
    mat.atomSet( [ 1, 2 ], se1*se2*ce3 - ce1*se3 );
    mat.atomSet( [ 2, 0 ], - se2 );
    mat.atomSet( [ 2, 1 ], ce2*se3 );
    mat.atomSet( [ 2, 2 ], ce2*ce3 );
  }

  else if( ox === 0 && oy === 1 && oz === 0 )
  {
    mat.atomSet( [ 0, 0 ], ce2 );
    mat.atomSet( [ 0, 1 ], se2*se3 );
    mat.atomSet( [ 0, 2 ], se2*ce3 );
    mat.atomSet( [ 1, 0 ], se1*se2 );
    mat.atomSet( [ 1, 1 ], ce1*ce3 - se1*ce2*se3 );
    mat.atomSet( [ 1, 2 ], - ce1*se3 - se1*ce2*ce3 );
    mat.atomSet( [ 2, 0 ], - ce1*se2 );
    mat.atomSet( [ 2, 1 ], se1*ce3 + ce1*ce2*se3  );
    mat.atomSet( [ 2, 2 ], - se1*se3 + ce1*ce2*ce3 );
  }

  else if( ox === 0 && oy === 2 && oz === 0 )
  {
    mat.atomSet( [ 0, 0 ], ce2 );
    mat.atomSet( [ 0, 1 ], - se2*ce3 );
    mat.atomSet( [ 0, 2 ], se2*se3 );
    mat.atomSet( [ 1, 0 ], ce1*se2 );
    mat.atomSet( [ 1, 1 ], ce1*ce2*ce3 - se1*se3 );
    mat.atomSet( [ 1, 2 ], - ce1*ce2*se3 - se1*ce3 );
    mat.atomSet( [ 2, 0 ], se1*se2 );
    mat.atomSet( [ 2, 1 ], se1*ce2*ce3 + ce1*se3 );
    mat.atomSet( [ 2, 2 ], - se1*ce2*se3 + ce1*ce3 );
  }

  else if( ox === 1 && oy === 0 && oz === 1 )
  {
    mat.atomSet( [ 0, 0 ], - se1*ce2*se3 + ce1*ce3 );
    mat.atomSet( [ 0, 1 ], se1*se2 );
    mat.atomSet( [ 0, 2 ], se1*ce2*ce3 + ce1*se3 );
    mat.atomSet( [ 1, 0 ], se2*se3 );
    mat.atomSet( [ 1, 1 ], ce2 );
    mat.atomSet( [ 1, 2 ], - se2*ce3 );
    mat.atomSet( [ 2, 0 ], - ce1*ce2*se3 - se1*ce3 );
    mat.atomSet( [ 2, 1 ], ce1*se2 );
    mat.atomSet( [ 2, 2 ], ce1*ce2*ce3 - se1*se3 );
  }

  else if( ox === 1 && oy === 2 && oz === 1 )
  {
    mat.atomSet( [ 0, 0 ], ce1*ce2*ce3 - se1*se3 );
    mat.atomSet( [ 0, 1 ], - ce1*se2 );
    mat.atomSet( [ 0, 2 ], ce1*ce2*se3 + se1*ce3 );
    mat.atomSet( [ 1, 0 ], se2*ce3 );
    mat.atomSet( [ 1, 1 ], ce2 );
    mat.atomSet( [ 1, 2 ], se2*se3 );
    mat.atomSet( [ 2, 0 ], - se1*ce2*ce3 - ce1*se3 );
    mat.atomSet( [ 2, 1 ], se1*se2 );
    mat.atomSet( [ 2, 2 ], - se1*ce2*se3 + ce1*ce3 );
  }

  else if( ox === 2 && oy === 0 && oz === 2 )
  {
    mat.atomSet( [ 0, 0 ], - se1*ce2*se3 + ce1*ce3 );
    mat.atomSet( [ 0, 1 ], - se1*ce2*ce3 - ce1*ce3  );
    mat.atomSet( [ 0, 2 ], se1*se2 );
    mat.atomSet( [ 1, 0 ], ce1*ce2*se3 + se1*ce3 );
    mat.atomSet( [ 1, 1 ], ce1*ce2*ce3 - se1*se3 );
    mat.atomSet( [ 1, 2 ], - ce1*se2 );
    mat.atomSet( [ 2, 0 ], se2*se3 );
    mat.atomSet( [ 2, 1 ], se2*ce3 );
    mat.atomSet( [ 2, 2 ], ce2 );
  }

  else if( ox === 2 && oy === 1 && oz === 2 )
  {
    mat.atomSet( [ 0, 0 ], ce1*ce2*ce3 - se1*se3 );
    mat.atomSet( [ 0, 1 ], - ce1*ce2*se3 - se1*ce3 );
    mat.atomSet( [ 0, 2 ], ce1*se2 );
    mat.atomSet( [ 1, 0 ], se1*ce2*ce3 + ce1*se3 );
    mat.atomSet( [ 1, 1 ], - se1*ce2*se3 + ce1*ce3 );
    mat.atomSet( [ 1, 2 ], se1*se2 );
    mat.atomSet( [ 2, 0 ], - se2*ce3 );
    mat.atomSet( [ 2, 1 ], se2*se3 );
    mat.atomSet( [ 2, 2 ], ce2 );
  }

  return mat;
}

// --
// define class
// --

var Proto =
{

  is : is,
  isZero : isZero,

  make : make,
  make2 : make2,
  makeZero : makeZero,

  zero : zero,

  from : from,
  _from : _from,

  fromAxisAndAngle : fromAxisAndAngle,
  fromQuat : fromQuat,
  fromMatrix : fromMatrix,
  toMatrix : toMatrix,

  fromQuat2 : fromQuat2,
  toQuat2 : toQuat2,
  fromMatrix2 : fromMatrix2,
  toMatrix2 : toMatrix2,

  Order : Order,

}

_.mapExtend( Self,Proto );

})();
