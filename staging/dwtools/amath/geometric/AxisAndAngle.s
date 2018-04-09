(function _AxisAndAngle_s_(){

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

_.assert( !_.axisAndAngle );
_.assert( _.avector );

var Self = _.axisAndAngle = _.axisAndAngle || Object.create( _.avector );

// --
//
// --

function is( axisAndAngle,angle )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( !_.arrayLike( axisAndAngle ) && !_.vectorIs( axisAndAngle ) )
  return false;

  return ( ( axisAndAngle.length === 4 ) && ( angle === undefined ) ) || ( ( axisAndAngle.length === 3 ) && ( _.numberIs( angle ) ) );
}

//

function like( axisAndAngle,angle )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( angle !== null && angle !== undefined && !_.numberIs( angle ) )
  return false;

  if( axisAndAngle === null )
  return true;

  if( !_.arrayLike( axisAndAngle ) && !_.vectorIs( axisAndAngle ) )
  return false;

  return ( ( axisAndAngle.length === 4 ) && ( angle === undefined ) ) || ( ( axisAndAngle.length === 3 ) && ( _.numberIs( angle ) || angle === null ) );
}

//

function isZero( axisAndAngle,angle )
{

  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( !this.is( axisAndAngle,angle ) )
  return false;

  if( axisAndAngle && axisAndAngle.length === 3 )
  return angle === 0;

  if( _.vectorIs( axisAndAngle ) )
  return axisAndAngle.eGet( 3 ) === 0;
  else if( _.arrayIs( axisAndAngle ) )
  return axisAndAngle[ 3 ] === 0;
  else _.assert( 0 );
}

//

function make( axisAndAngle,angle )
{
  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 );
  _.assert( axisAndAngle === undefined || axisAndAngle === null || _.axisAndAngle.is( axisAndAngle,angle ) );

  var result = _.axisAndAngle.makeZero();
  var resultv = _.vector.from( result );

  var axisAndAnglev;
  if( axisAndAngle )
  axisAndAnglev = _.vector.from( axisAndAngle );

  if( axisAndAnglev )
  {
    resultv.eSet( 0,axisAndAnglev.eGet( 0 ) );
    resultv.eSet( 1,axisAndAnglev.eGet( 1 ) );
    resultv.eSet( 2,axisAndAnglev.eGet( 2 ) );
  }

  if( _.numberIs( angle ) )
  resultv.eSet( 3,angle );
  else if( axisAndAnglev )
  resultv.eSet( 3,axisAndAnglev.eGet( 3 ) );

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

function from( axisAndAngle,angle )
{

  _.assert( axisAndAngle === null || _.axisAndAngle.like( axisAndAngle,angle ) );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( axisAndAngle === null )
  return _.axisAndAngle.make( axisAndAngle,angle );

  if( _.vectorIs( axisAndAngle ) )
  {
    if( axisAndAngle.length === 4 )
    {
      if( angle !== undefined && angle !== null )
      axisAndAngle.eSet( 3 , angle );
      return axisAndAngle;
    }
    debugger;
    var result = axisAndAngle.resizedArray( 0,4 );
    if( angle !== undefined && angle !== null )
    result[ 3 ] = angle;
    return result;
  }
  else
  {
    if( axisAndAngle.length === 3 )
    {
      axisAndAngle = _.arrayResize( axisAndAngle,0,4 );
      axisAndAngle[ 3 ] = angle === null ? 0 : angle;
    }
  }

  return axisAndAngle;
}

//

function _from( axisAndAngle,angle )
{

  _.assert( axisAndAngle === null || _.axisAndAngle.like( axisAndAngle,angle ) );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( axisAndAngle === null )
  {
    axisAndAngle = _.axisAndAngle.make( axisAndAngle,angle );
  }
  else if( _.vectorIs( axisAndAngle ) )
  {
    if( axisAndAngle.length === 4 )
    {
      if( angle !== undefined && angle !== null )
      axisAndAngle.eSet( 3 , angle );
      return axisAndAngle;
    }
    debugger;
    var result = axisAndAngle.resizedVector( 0,4 );
    if( angle !== undefined && angle !== null )
    result.eSet( 3 , angle );
    return result;
  }
  else
  {
    if( axisAndAngle.length === 3 )
    {
      axisAndAngle = _.arrayResize( axisAndAngle,0,4 );
      axisAndAngle[ 3 ] = angle === null ? 0 : angle;
    }
  }

  return _.vector.fromArray( axisAndAngle );
}

// {
//   _.assert( axisAndAngle === null || _.axisAndAngle.like( axisAndAngle,angle ) );
//   _.assert( arguments.length === 1 || arguments.length === 2 );
//
//   if( axisAndAngle === null )
//   axisAndAngle = _.axisAndAngle.make( axisAndAngle,angle );
//
//   if( _.vectorIs( axisAndAngle ) )
//   {
//     debugger;
//     throw _.err( 'not implemented' );
//     var result = axisAndAngle.slice( 0,4 );
//     if( angle !== undefined )
//     result[ 3 ] = angle;
//     return result;
//   }
//   else
//   {
//     if( axisAndAngle.length === 3 )
//     {
//       axisAndAngle = _.arrayResize( axisAndAngle,0,4 );
//       axisAndAngle[ 3 ] = angle;
//     }
//   }
//
//   return _.vector.from( axisAndAngle );
// }

//

function zero( axisAndAngle,angle )
{

  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 );
  _.assert( axisAndAngle === undefined || axisAndAngle === null || _.axisAndAngle.is( axisAndAngle,angle ) );

  if( axisAndAngle === undefined || axisAndAngle === null )
  return _.axisAndAngle.makeZero();

  var axisAndAnglev = _.vector.from( axisAndAngle );

  axisAndAnglev.eSet( 3,0 );

  return axisAndAngle;
}

// --
// prototype
// --

var Proto =
{

  is : is,
  like : like,
  isZero : isZero,

  make : make,
  makeZero : makeZero,

  from : from,
  _from : _from,

  zero : zero,

}

_.mapExtend( Self,Proto );

})();
