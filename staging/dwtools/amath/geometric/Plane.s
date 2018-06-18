(function _Plane_s_(){

'use strict';

var _ = _global_.wTools;
var avector = _.avector;
var vector = _.vector;
var Self = _.plane = _.plane || Object.create( null );

// --
//
// --

function make( dim )
{
  if( dim === undefined )
  dim = 3;
  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( _.numberIs( dim ) );
  var dst = _.dup( 0,dim+1 );
  return dst;
}

//

function _from( plane )
{
  _.assert( _.plane.is( plane ) );
  _.assert( _.vectorIs( plane ) || _.arrayLike( plane ) );
  _.assert( arguments.length === 1 );
  return _.vector.from( plane );
}

//

function is( plane )
{
  _.assert( arguments.length === 1 );
  return ( _.arrayLike( plane ) || _.vectorIs( plane ) ) && plane.length >= 1;
}

//


/**
* Create a plane from another plane or a normal and a bias. Returns the new plane.
* Planes are stored in Array data structure. Source plane/Normal and bias stay untouched, dst plane changes.
*
* @param { Array } dstplane - Destination plane to be expanded.
* @param { Array } srcplane - Source plane.
* Alternative to srcplane:
* @param { Array } normal - Array of points with normal vector coordinates.
* @param { Number } bias - Number with bias value.
*
* @example
* // returns [ 0, 0, 1, 2 ];
* _.from( [ 0, 0, 0, 0 ] , [ 0, 0, 1, 2 ] );
*
* @example
* // returns [ 0, - 1, 2, 2 ];
* _.from( [ 0, 0, 1, 1 ], [ 0, - 1, 2 ], 2 );
*
* @returns { Array } Returns the array of the new plane.
* @function from
* @throws { Error } An Error if ( arguments.length ) is different than two or three.
* @throws { Error } An Error if ( plane ) is not plane.
* @throws { Error } An Error if ( normal ) is not array.
* @throws { Error } An Error if ( bias ) is not number.
* @memberof wTools.box
*/

function from( plane )
{

  if( plane === null )
  plane = _.plane.make();

  _.assert( arguments.length === 2 || arguments.length === 3 );
  debugger;
  // throw _.err( 'not tested' );

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  if( arguments.length === 2 )
  {
    debugger;
  //  throw _.err( 'not tested' );
    _.avector.assign( _plane,arguments[ 1 ] )
  }
  else if( arguments.length === 3 )
  {
    debugger;
  //  throw _.err( 'not tested' );
    _.avector.assign( normal,vector.from( arguments[ 1 ] ) );
    _.plane.biasSet( _plane,arguments[ 2 ] );
  }
  else _.assert( 0,'unexpected arguments' );

  return plane;
}

//

/**
* Create a plane from a normal and a point. Returns the new plane.
* Planes are stored in Array data structure. Normal and point stay untouched, plane changes.
*
* @param { Array } plane - Plane to be modified.
* @param { Array } anormal - Array of points with normal vector coordinates.
* @param { Array } abias - Array with point coordinates.
*
* @example
* // returns [ 0, 0, 1, 2 ];
* _.fromNormalAndPoint( [ 0, 0, 0, 0 ] , [ 0, 0, 1 ], [ 2, 0, 0 ] );
*
* @returns { Array } Returns the array of the new plane.
* @function fromNormalAndPoint
* @throws { Error } An Error if ( arguments.length ) is different than three.
* @throws { Error } An Error if ( plane ) is not plane.
* @throws { Error } An Error if ( anormal ) is not array.
* @throws { Error } An Error if ( apoint ) is not a point.
* @memberof wTools.box
*/

function fromNormalAndPoint( plane, anormal, apoint )
{

  if( plane === null )
  plane = _.plane.make();

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( arguments.length === 3 );
  debugger;
  //throw _.err( 'not tested' );

  debugger;
  normal.copy( anormal );
  _.plane.biasSet( plane , - _.vector.dot( _.vector.from( apoint ) , normal ) );

  return plane;
}

//

/**
* Create a plane from three points. Returns the new plane.
* Planes are stored in Array data structure. The points remain untouched, plane changes.
*
* @param { Array } plane - Plane to be modified.
* @param { Array } a - First point in the new plane.
* @param { Array } b - Second point in the new plane.
* @param { Array } c - Third point in the new plane.
*
* @example
* // returns [ 0, 1, 0, 0 ];
* _.fromPoints( [ 0, 0, 0 ] , [ 0, 0, 1 ], [ 2, 0, 0 ] );
*
* @returns { Array } Returns the array of the new plane.
* @function fromPoints
* @throws { Error } An Error if ( arguments.length ) is different than four.
* @throws { Error } An Error if ( dim ) point dimension is different than three.
* @throws { Error } An Error if ( plane ) is not plane.
* @throws { Error } An Error if ( a ) is not a point.
* @throws { Error } An Error if ( b ) is not a point.
* @throws { Error } An Error if ( c ) is not a point.
* @memberof wTools.box
*/

function fromPoints( plane,a,b,c )
{

  if( plane === null )
  plane = _.plane.make();

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( arguments.length === 4 );
  debugger;
  //throw _.err( 'not tested' );

  a = _.vector.from( a );
  b = _.vector.from( b );
  c = _.vector.from( c );

  var n1 = vector.subVectors( a.clone() , b );
  var n2 = vector.subVectors( c.clone() , b );
  var normal = vector.cross( n1,n2 );
  debugger;
  normal.normalize();

  _.plane.fromNormalAndPoint( plane, normal, a );

  return plane;
}

//

function dimGet( plane )
{
  var dim = plane.length - 1;

  _.assert( _.plane.is( plane ) );
  _.assert( arguments.length === 1 );

  debugger;

  return dim;
}

//

function normalGet( plane )
{
  var _plane = _.plane._from( plane );
  _.assert( arguments.length === 1 );
  return _plane.subarray( 0,_plane.length-1 );
}

//

function biasGet( plane )
{
  var _plane = _.plane._from( plane );
  _.assert( arguments.length === 1 );
  return _plane.eGet( _plane.length-1 );
}

//

function biasSet( plane,bias )
{
  var _plane = _.plane._from( plane );

  _.assert( _.numberIs( bias ) );
  _.assert( arguments.length === 2 );
  debugger;
  //throw _.err( 'not tested' );

  return _plane.eSet( _plane.length-1,bias );
}

//

/**
* Get the distance between a point and a plane. Returns the distance value.
* The point an the plane remain unchanged.
*
* @param { Array } plane - Source plane.
* @param { Vector } point - Source point.
*
* @example
* // returns 1;
* _.pointsDistance( [ 0, 1, 0, 1 ] , _.vector.from( [ 0, 0, 1 ] ) );
*
* @returns { Number } Returns the distance from the point to the plane.
* @function pointDistance
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( plane ) is not plane.
* @throws { Error } An Error if ( point ) is not a vector.
* @memberof wTools.box
*/

function pointDistance( plane , point )
{

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );
  var _point = _.vector.fromArray( point );

  _.assert( arguments.length === 2 );

  var mod = _.vector.dot(normal, normal);
  mod = Math.sqrt(mod);

  var distance = ( _.vector.dot( normal , point ) + bias ) / mod ;

  // distance = Math.abs( distance );

  return distance;
}

//

/**
* Get the proyection of a point in a plane. Returns the new point coordinates.
* The plane remains unchanged, the point changes.
*
* @param { Array } plane - Source plane.
* @param { Array } point - Source and destination point.
*
* @example
* // returns [ - 1, 2, 2 ];
* _.pointCoplanarGet( [ 1, 0, 0, 1 ] , [ 2, 2, 2 ]);
*
* @returns { Array } Returns the new point in the plane.
* @function pointCoplanarGet
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( plane ) is not plane.
* @throws { Error } An Error if ( point ) is not point.
* @memberof wTools.box
*/

function pointCoplanarGet( plane , point )
{

  if( !point )
  point = [ 0,0,0 ];

  var _point = _.vector.fromArray( point );
  var _plane = _.plane._from( plane.slice() );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  var lambda = - (( _.vector.dot( normal , _point ) + bias ) / _.vector.dot( normal, normal ) ) ;

  _.assert( arguments.length === 1 || arguments.length === 2 );
  debugger;
  //throw _.err( 'not tested' );

  var movement = _.vector.mulScalar( normal, lambda );

  _point = _.avector.add( _point ,  movement  );

  return _point;
}

function OldpointCoplanarGet( plane , point )
{

  if( !point )
  point = [ 0,0,0 ];

  var _point = _.vector.fromArray( point );
  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( arguments.length === 1 || arguments.length === 2 );
  debugger;
  //throw _.err( 'not tested' );

  _.avector.assign( _point , normal  );
  _.avector.mulScalar( _point, -bias );

  return point
}

//

/**
* Get the distance between a plane and a sphere. Returns the distance value.
* The sphere an the plane remain unchanged.
*
* @param { Array } plane - Source plane.
* @param { Array } sphere - Source sphere.
*
* @example
* // returns 1;
* _.sphereDistance( [ 0, 1, 0, 1 ] , [ 0, 0, 2, 1 ]);
*
* @returns { Number } Returns the distance from the sphere to the plane.
* @function sphereDistance
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( plane ) is not plane.
* @throws { Error } An Error if ( sphere ) is not sphere.
* @memberof wTools.box
*/

function sphereDistance( plane , sphere )
{

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  var center = _.sphere.centerGet( sphere );
  center = _.vector.from( center );

  _.assert( arguments.length === 2 );
  debugger;
  //throw _.err( 'not tested' );

  var d = _.plane.pointDistance( plane , center );
  console.log('distance', d);
  d = d - _.sphere.radiusGet( sphere );
  console.log('distance', d, ' radius ', _.sphere.radiusGet( sphere ));
  return d;
}

//


/**
* Check if a plane and a line intersect. Returns true if they intersect.
* The plane and line remain unchanged.
*
* @param { Array } plane - Source plane.
* @param { Array } line -  First and last points in line.
*
* @example
* // returns true
* _.lineIntersects( [ 1, 0, 0, 1 ] , [ - 2, - 2, - 2 ], [ 3, 3, 3 ]);
*
* @example
* // returns false
* _.lineIntersects( [ 1, 0, 0, 1 ] , [ [  2, 2, 2 ], [ 3, 3, 3 ] ]);
*
* @returns { Boolean } Returns true if the line and plane intersect, false if not.
* @function lineIntersects
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( plane ) is not plane.
* @throws { Error } An Error if ( line ) is not line.
* @memberof wTools.box
*/

function lineIntersects( plane , line )
{

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( arguments.length === 2 );
  debugger;
  //throw _.err( 'not tested' );

  var point1 = _.vector.from( line[0] );
  var point2 = _.vector.from( line[1] );

  var b = _.plane.pointDistance( _plane, point1 );
  var e = _.plane.pointDistance( _plane, point2 );

  debugger;
  return ( b <= 0 && e >= 0 ) || ( e <= 0 && b >= 0 );
}

//

function lineIntersection( plane , line , point )
{

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( arguments.length === 3 );
  debugger;
  throw _.err( 'not tested' );

  if( point === null )
  point = [ 0,0,0 ];

  var direction = _.line.pointDirection( point );

  var dot = _.vector.dot( normal , direction );

  if( Math.abs( dot ) < _.EPS2 )
  {

    if( _.plane.pointDistance( plane, line[ 0 ] ) < _.EPS2 )
    {
      _.avector.assign( point,line[ 0 ] );
      return point
    }

    return false;
  }

  var t = - ( _.vector.dot( line[ 0 ] , this.normal ) + bias ) / dot;

  if( t < 0 || t > 1 )
  return false;

  return _.line.at( [ line[ 0 ],direction ] , t );
}

//

function matrixHomogenousApply( plane , matrix )
{

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( arguments.length === 2 );
  debugger;
  throw _.err( 'not tested' );

  normal = normal.clone();

  /* var m = m1.normalProjectionMatrixGet( matrix ); */

  if( matrix.ncol === 4 )
  matrix = matrix.normalProjectionMatrixMake();

  normal = _.space.mul( matrix,normal );

  var point = _.plane.pointCoplanarGet( plane );
  matrix.matrixHomogenousApply( point );

  return _.plane.fromNormalAndPoint( plane , normal , point );
}

//



/**
* Translates a plane by a given offset. Returns the new plane coordinates.
* The offset remains unchanged, the plane changes.
*
* @param { Array } plane - Source and destination plane.
* @param { Array } offset -  Offset to translate the plane.
*
* @example
* // returns [ 1, 0, 0, 1 ];
* _.translate( [ 1, 0, 0, 1 ] , [ 0, 2, 0 ] );
*
* @example
* // returns [ 1, 0, 0, - 1 ]
* _.translate( [ 1, 0, 0, 1 ] ,  [  2, 2, 2 ] );
*
* @returns { Boolean } Returns the translated plane.
* @function translate
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( plane ) is not plane.
* @throws { Error } An Error if ( offset ) is not point.
* @memberof wTools.box
*/

function translate( plane , offset )
{

  var _offset = _.vector.fromArray( offset );
  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( arguments.length === 2 );
  debugger;
//  throw _.err( 'not tested' );

  _.plane.biasSet( plane, bias - _.vector.dot( normal,_offset ) )

  return plane;
}

//

function normalize( plane )
{

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( arguments.length === 1 );
  debugger;
  throw _.err( 'not tested' );

  var scaler = 1.0 / normal.mag();
  normal.mulScalar( scaler );
  _.plane.biasSet( _plane,bias*scaler );

  return plane;
}

//

function negate( plane )
{

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( arguments.length === 1 );
  debugger;
  throw _.err( 'not tested' );

  _.vector.mulScalar( normal,-1 );
  _.plane.biasSet( _plane,-bias );

  return plane;
}

// --
// define class
// --

var Proto =
{

  make : make,
  _from : _from,
  is : is,

  from : from,
  fromNormalAndPoint : fromNormalAndPoint,
  fromPoints : fromPoints,

  dimGet : dimGet,
  normalGet : normalGet,
  biasGet : biasGet,
  biasSet : biasSet,

  pointDistance : pointDistance,
  pointCoplanarGet : pointCoplanarGet,

  sphereDistance : sphereDistance,

  lineIntersects : lineIntersects,

  matrixHomogenousApply : matrixHomogenousApply,
  translate : translate,

  normalize : normalize,
  negate : negate,

}

_.mapSupplement( Self,Proto );

})();
