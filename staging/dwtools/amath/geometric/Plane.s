(function _Plane_s_() {

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
  _.assert( _.vectorIs( plane ) || _.longIs( plane ) );
  _.assert( arguments.length === 1, 'expects single argument' );
  return _.vector.from( plane );
}

//

function is( plane )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  return ( _.longIs( plane ) || _.vectorIs( plane ) ) && plane.length >= 1;
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
  * @memberof wTools.plane
  */

function from( plane )
{

  if( plane === null )
  plane = _.plane.make();

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
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
  * @memberof wTools.plane
  */

function fromNormalAndPoint( plane, anormal, apoint )
{

  if( plane === null )
  plane = _.plane.make();

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( arguments.length === 3, 'expects exactly three argument' );
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
  * @memberof wTools.plane
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
  _.assert( arguments.length === 1, 'expects single argument' );

  debugger;

  return dim;
}

//

function normalGet( plane )
{
  var _plane = _.plane._from( plane );
  _.assert( arguments.length === 1, 'expects single argument' );
  return _plane.subarray( 0,_plane.length-1 );
}

//

function biasGet( plane )
{
  var _plane = _.plane._from( plane );
  _.assert( arguments.length === 1, 'expects single argument' );
  return _plane.eGet( _plane.length-1 );
}

//

function biasSet( plane,bias )
{
  var _plane = _.plane._from( plane );

  _.assert( _.numberIs( bias ) );
  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  debugger;
  //throw _.err( 'not tested' );

  return _plane.eSet( _plane.length-1,bias );
}

//

/**
  * Check if a plane contains a point. Returns true if the point is contained.
  * The point an the plane remain unchanged.
  *
  * @param { Array } plane - Source plane.
  * @param { Vector } point - Source point.
  *
  * @example
  * // returns false;
  * _.pointsDistance( [ 0, 1, 0, 1 ] , _.vector.from( [ 0, 0, 1 ] ) );
  *
  * @returns { Boolean } Returns true if the plane contains the point and false if not.
  * @function pointContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( point ) is not a vector.
  * @memberof wTools.plane
  */

function pointContains( plane , point )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  var _plane = _.plane._from( plane );
  var pointVector = _.vector.fromArray( point );

  if( Math.abs( _.plane.pointDistance( plane, pointVector ) ) < 1E-12 )
  return true;
  else
  return false;
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
  * @memberof wTools.plane
  */

function pointDistance( plane , point )
{

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );
  var pointVector = _.vector.fromArray( point );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  var mod = _.vector.dot( normal, normal );
  mod = Math.sqrt( mod );

  var distance = ( _.vector.dot( normal , pointVector ) + bias ) / mod ;

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
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( point ) is not point.
  * @throws { Error } An Error if ( dstPoint ) is not point.
  * @memberof wTools.plane
  */

function pointCoplanarGet( plane , point, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'expects two or three arguments' );

  if( arguments.length === 2 )
  var dstPoint = [ 0, 0, 0 ];

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  var dstPointVector = _.vector.from( dstPoint );
  var pointVector = _.vector.fromArray( point.slice() );
  var _plane = _.plane._from( plane.slice() );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( plane.length - 1 === point.length , 'Plane and point have different dimensions' );
  _.assert( dstPoint.length === point.length , 'Source and test points have different dimensions' );

  var lambda = - (( _.vector.dot( normal , pointVector ) + bias ) / _.vector.dot( normal, normal ) ) ;

  debugger;
  //throw _.err( 'not tested' );

  var movement = _.vector.mulScalar( normal, lambda );

  pointVector = _.avector.add( pointVector ,  movement  );

  for( var i = 0; i < pointVector.length; i++ )
  {
    dstPointVector.eSet( i, pointVector[ i ] );
  }
  return dstPoint;
}

// function pointCoplanarGet( plane , point )
// {

//  if( !point )
//  point = [ 0,0,0 ];

//  var pointVector = _.vector.fromArray( point );
//  var _plane = _.plane._from( plane );
//  var normal = _.plane.normalGet( _plane );
//  var bias = _.plane.biasGet( _plane );

//  _.assert( arguments.length === 1 || arguments.length === 2 );
//  debugger;
//  throw _.err( 'not tested' );

//  _.avector.assign( pointVector , normal  );
//  _.avector.mulScalar( pointVector, -bias );

//  return point
//  }

//

/**
  * Check if a plane and a box intersect. Returns true if they intersect and false if not.
  * The box and the plane remain unchanged.
  *
  * @param { Array } plane - Source plane.
  * @param { Array } srcBox - Source box.
  *
  * @example
  * // returns true;
  * _.boxIntersects( [ 1, 0, 0, 1 ] , [ -1, 2, 2, -1, 2, 8 ]);
  *
  * @example
  * // returns false;
  * _.boxIntersects( [ 0, 1, 0, 1 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Boolean } Returns true if the plane and the box intersect.
  * @function boxIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( dim ) is different than box.dimGet (the plane and box don´t have the same dimension).
  * @memberof wTools.plane
  */

function boxIntersects( plane , srcBox )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  var bool = false;
  var _plane = _.plane._from( plane );
  var dimP = _.plane.dimGet( _plane );
  var boxVector = _.box._from( srcBox );
  var dimB = _.box.dimGet( boxVector );
  var min = _.box.cornerLeftGet( boxVector );
  var max = _.box.cornerRightGet( boxVector );

  _.assert( dimP === dimB );

  /* box corners */

  var c = _.Space.makeZero( [ 3, 8 ] );
  min = _.vector.toArray( min ); max = _.vector.toArray( max );
  var col = c.colVectorGet( 0 ); col.copy( [ min[ 0 ], min[ 1 ], min[ 2 ] ] );
  var col = c.colVectorGet( 1 ); col.copy( [ max[ 0 ], min[ 1 ], min[ 2 ] ] );
  var col = c.colVectorGet( 2 ); col.copy( [ min[ 0 ], max[ 1 ], min[ 2 ] ] );
  var col = c.colVectorGet( 3 ); col.copy( [ min[ 0 ], min[ 1 ], max[ 2 ] ] );
  var col = c.colVectorGet( 4 ); col.copy( [ max[ 0 ], max[ 1 ], max[ 2 ] ] );
  var col = c.colVectorGet( 5 ); col.copy( [ min[ 0 ], max[ 1 ], max[ 2 ] ] );
  var col = c.colVectorGet( 6 ); col.copy( [ max[ 0 ], min[ 1 ], max[ 2 ] ] );
  var col = c.colVectorGet( 7 ); col.copy( [ max[ 0 ], max[ 1 ], min[ 2 ] ] );

  min = _.vector.fromArray( min );
  var distance = _.plane.pointDistance( plane, min );
  if( distance === 0 )
  {
    bool = true;
  }
  else
  {
    var side = distance/ Math.abs( distance );
    for( var j = 1 ; j < 8 ; j++ )
    {
      var corner = c.colVectorGet( j );
      distance = _.plane.pointDistance( plane, corner );
      if( distance === 0 )
      {
        bool = true;
      }
      else
      {
        var newSide = distance/ Math.abs( distance );
        if( side === - newSide )
        {
          bool = true;
        }
        side = newSide;
      }
    }
  }
  return bool;
}

//

/**
  * Get the closest point in a plane to a box. Returns the calculated point.
  * The box and the plane remain unchanged.
  *
  * @param { Array } srcPlane - Source plane.
  * @param { Array } srcBox - Source box.
  * @param { Array } dstPoint - Destination point.
  *
  * @example
  * // returns [ 2, 2, 2 ];
  * _.boxClosestPoint( [ 0, 1, 0, 1 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Array } Returns the closest point in the plane to the box.
  * @function boxClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( dstPoint ) is not point.
  * @throws { Error } An Error if ( dim ) is different than box.dimGet (the plane and box don´t have the same dimension).
  * @memberof wTools.plane
  */

function boxClosestPoint( srcPlane , srcBox, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'expects two or three arguments' );

  if( arguments.length === 2 )
  var dstPoint = [ 0, 0, 0 ];

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  var dstPointVector = _.vector.from( dstPoint );

  var _plane = _.plane._from( srcPlane );
  var dimP = _.plane.dimGet( _plane );

  var boxVector = _.box._from( srcBox );
  var dimB = _.box.dimGet( boxVector );
  var min = _.box.cornerLeftGet( boxVector );
  var max = _.box.cornerRightGet( boxVector );

  _.assert( dimP === dimB );
  _.assert( dimP === dstPointVector.length );

  if( _.plane.boxIntersects( _plane, boxVector ) )
  return 0;

  var boxPoint = _.box.planeClosestPoint( boxVector, _plane );

  var planePoint = _.plane.pointCoplanarGet( _plane, boxPoint );

  for( var i = 0; i < planePoint.length; i++ )
  {
    dstPointVector.eSet( i, planePoint[ i ] );
  }

  return dstPoint;
}

//

/**
  * Check if a plane and a sphere intersect. Returns true if they intersect and false if not.
  * The sphere and the plane remain unchanged.
  *
  * @param { Array } plane - Source plane.
  * @param { Array } sphere - Source sphere.
  *
  * @example
  * // returns true;
  * _.sphereIntersects( [ 1, 0, 0, 1 ] , [ 2, 2, 2, 8 ]);
  *
  * @example
  * // returns false;
  * _.sphereIntersects( [ 0, 1, 0, 1 ] , [ 2, 2, 2, 2 ]);
  *
  * @returns { Boolean } Returns true if the plane and the sphere intersect.
  * @function sphereIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @memberof wTools.plane
  */

function sphereIntersects( plane , sphere )
{
  var bool = false;
  var _plane = _.plane._from( plane );
  _.assert( _.sphere.is( sphere ) );
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  debugger;

  var distance = _.plane.sphereDistance( plane, sphere );

  if( distance <= 0 )
  {
    bool = true;
  }

  return bool;
}

//

/**
  * Get the distance between a plane and a sphere. Returns the distance value.
  * The sphere an the plane remain unchanged.
  * If sphere and plane intersect, it returns 0.
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
  * @memberof wTools.plane
  */

function sphereDistance( plane , sphere )
{

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  var center = _.sphere.centerGet( sphere );
  center = _.vector.from( center );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  debugger;
  //throw _.err( 'not tested' );

  var d = _.plane.pointDistance( plane , center );
  d = Math.abs( d ) - _.sphere.radiusGet( sphere );

  if( d < 0 )
  return 0;
  else
  return d;

}

//

/**
  * Get the closest point in a plane to a sphere. Returns the calculated point.
  * The sphere an the plane remain unchanged.
  * If sphere and plane intersect, it returns 0.
  *
  * @param { Array } plane - Source plane.
  * @param { Array } sphere - Source sphere.
  * @param { Array } dstPoint - Destination point.
  *
  * @example
  * // returns [ 0, 2, 0 ];
  * _.sphereClosestPoint( [ 1, 0, 0, 0 ] , [ 3, 2, 0, 1 ]);
  *
  * @returns { Array } Returns the distance from the sphere to the plane.
  * @function sphereClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @throws { Error } An Error if ( dstPoint ) is not point.
  * @memberof wTools.plane
  */

function sphereClosestPoint( plane , sphere, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'expects two or three arguments' );

  if( arguments.length === 2 )
  var dstPoint = [ 0, 0, 0 ];

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  var dstPointVector = _.vector.from( dstPoint );

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( _plane.length - 1 === dstPoint.length , 'Plane and point must have same dimension' );

  var spherev = _.sphere._from( sphere );
  var center = _.sphere.centerGet( spherev );

  if( _.plane.sphereIntersects( _plane, spherev ) === true )
  return 0;

  var point = _.plane.pointCoplanarGet( _plane, center );

  for( var i = 0; i < point.length; i++ )
  {
    dstPointVector.eSet( i, point[ i ] );
  }

  return dstPoint;
}

//

/**
  * Check if two planes intersect. Returns true if they intersect.
  * The planes remain unchanged.
  *
  * @param { Array } srcPlane - Source plane.
  * @param { Array } tstPlane - Test plane.
  *
  * @example
  * // returns [ 0, 2, 0 ];
  * _.planeIntersects( [ 1, 0, 0, 0 ] , [ 3, 2, 0, 1 ]);
  *
  * @returns { Boolean } Returns true if the planes intersect, false if not.
  * @function planeIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( tstPlane ) is not plane.
  * @memberof wTools.plane
  */

function planeIntersects( srcPlane, tstPlane )
{
  var _srcPlane = _.plane._from( srcPlane );
  var srcNormal = _.plane.normalGet( _srcPlane );
  var srcBias = _.plane.biasGet( _srcPlane );

  var _tstPlane = _.plane._from( tstPlane );
  var tstNormal = _.plane.normalGet( _tstPlane );
  var tstBias = _.plane.biasGet( _tstPlane );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  debugger;
  //throw _.err( 'not tested' );

  srcNormal.normalize();
  tstNormal.normalize();

  for( var i = 0; i < srcNormal.length ; i++ )
  {
    if( Math.abs( tstNormal.eGet( i ) - srcNormal.eGet( i ) ) > 1E-7 )
    return true;
  }

  if( Math.abs( tstBias - srcBias ) < 1E-7 )
  return true;

  return false;
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
  * @memberof wTools.plane
  */

function lineIntersects( plane , line )
{

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
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

/**
  * Returns the intersection point between a plane and a line. Returns the intersection point coordinates.
  * The plane and line remain unchanged.
  *
  * @param { Array } plane - Source plane.
  * @param { Array } line -  First and last points in line.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.lineIntersection( [ 1, 0, 0, 0 ] , [ - 2, - 2, - 2 ], [ 3, 3, 3 ]);
  *
  *
  * @returns { Point } Returns the point of intersection between a plane and a line.
  * @function lineIntersection
  * @throws { Error } An Error if ( arguments.length ) is different than three.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( line ) is not line.
  * @throws { Error } An Error if ( point ) is not point.
  * @memberof wTools.plane
  */

function lineIntersection( plane , line , point )
{

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( arguments.length === 3, 'expects exactly three argument' );
  debugger;
  throw _.err( 'not tested' );

  if( point === null )
  point = [ 0,0,0 ];

  var direction = _.line.pointDirection( point );

  var dot = _.vector.dot( normal , direction );

  if( Math.abs( dot ) < _.accuracySqr )
  {

    if( _.plane.pointDistance( plane, line[ 0 ] ) < _.accuracySqr )
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

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
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
  * @memberof wTools.plane
  */

function translate( plane , offset )
{

  var _offset = _.vector.fromArray( offset );
  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  debugger;
  //  throw _.err( 'not tested' );

  _.plane.biasSet( plane, bias - _.vector.dot( normal,_offset ) )

  return plane;
}

//

/**
  * Normalize a plane coordinates. Returns the normalized plane coordinates.
  * The plane changes.
  *
  * @param { Array } plane - Source and destination plane.
  *
  * @example
  * // returns [ 1, 0, 0, 0 ];
  * _.normalize( [ 1, 0, 0, 0 ] );
  *
  * @example
  * // returns [ 1, 0, 0, 2 ]
  * _.translate( [ 1, 0, 0, 2 ]  );
  *
  * @returns { Array } Returns the normalized plane.
  * @function normalize
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @memberof wTools.plane
  */

function normalize( plane )
{

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( arguments.length === 1, 'expects single argument' );
  debugger;
  //throw _.err( 'not tested' );

  var scaler = 1.0 / normal.mag();
  normal.mulScalar( scaler );
  _.plane.biasSet( _plane,bias*scaler );

  return plane;
}

//

/**
  * Negate a plane coordinates. Returns the negated plane coordinates.
  * The plane changes.
  *
  * @param { Array } plane - Source and destination plane.
  *
  * @example
  * // returns [ - 1, 0, 0, 0 ];
  * _.negate( [ 1, 0, 0, 0 ] );
  *
  * @example
  * // returns [ - 1, 0, 0, - 2 ]
  * _.negate( [ 1, 0, 0, 2 ]  );
  *
  * @returns { Array } Returns the negated plane.
  * @function negate
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @memberof wTools.plane
  */

function negate( plane )
{

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( arguments.length === 1, 'expects single argument' );
  debugger;
  // throw _.err( 'not tested' );

  _.vector.mulScalar( normal,-1 );
  _.plane.biasSet( _plane,-bias );

  return plane;
}

//

/**
  * Returns the intersection point between three planes. Returns the intersection point coordinates, NaN if the plane´s intersection is not a point.
  * The planes remain unchanged.
  *
  * @param { Array } planeone - Source plane.
  * @param { Array } planetwo - Source plane.
  * @param { Array } planethree - Source plane.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.threeIntersectionPoint( [ 1, 0, 0, 0 ] , [ 0, 1, 0, 0 ], [ 0, 0, 1, 0 ] );
  *
  *
  * @returns { Point } Returns the point of intersection between three planes.
  * @function threeIntersectionPoint
  * @throws { Error } An Error if ( arguments.length ) is different than three.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @memberof wTools.plane
  */

function threeIntersectionPoint( planeone , planetwo , planethree )
{

  var _planeone = _.plane._from( planeone );
  var normalone = _.plane.normalGet( _planeone );
  var biasone = _.plane.biasGet( _planeone );
  var _planetwo = _.plane._from( planetwo );
  var normaltwo = _.plane.normalGet( _planetwo );
  var biastwo = _.plane.biasGet( _planetwo );
  var _planethree = _.plane._from( planethree );
  var normalthree = _.plane.normalGet( _planethree );
  var biasthree = _.plane.biasGet( _planethree );

  _.assert( arguments.length === 3, 'expects exactly three argument' );
  _.assert( normalone.length === normaltwo.length && normaltwo.length == normalthree.length );

  var Ispoint = _.vector.dot( normalone, _.vector.cross( normaltwo.clone(), normalthree ) );

  if( Ispoint != 0)
  {
    var cross23 = _.vector.cross( normaltwo.clone(), normalthree );
    var cross31 = _.vector.cross( normalthree.clone(), normalone );
    var cross12 = _.vector.cross( normalone.clone(), normaltwo );

    var Mcross23 = _.vector.mulScalar( cross23, - 1.0*biasone );
    var Mcross31 = _.vector.mulScalar( cross31, - 1.0*biastwo );
    var Mcross12 = _.vector.mulScalar( cross12, - 1.0*biasthree );

    var point = _.vector.mulScalar( _.vector.addVectors( Mcross23, Mcross31, Mcross12 ) , 1.0 / Ispoint);

    return point;
  }

  else
  {
    point = NaN;
    return point;
  }

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

  pointContains : pointContains, /* qqq : implement me */
  pointDistance : pointDistance,
  pointCoplanarGet : pointCoplanarGet,
  // pointClosestPoint : pointClosestPoint, /* qqq : implement me - done in pointCoplanarGet */

  boxIntersects : boxIntersects,
  // boxDistance : boxDistance, /* qqq: implement me - Same as _.box.planeDistance */
  boxClosestPoint : boxClosestPoint, /* qqq: implement me */

  sphereIntersects : sphereIntersects,
  sphereDistance : sphereDistance,
  sphereClosestPoint : sphereClosestPoint, /* qqq: implement me */

  planeIntersects : planeIntersects, /* qqq: implement me */
  // planeDistance : planeDistance, /* qqq: implement me */

  // frustumIntersects : frustumIntersects, /* qqq: implement me - Same as _.frustum.planeIntersects */
  // frustumDistance : frustumDistance, /* qqq: implement me - Same as _.frustum.planeDistance */
  // frustumClosestPoint : frustumClosestPoint, /* qqq: implement me */

  lineIntersects : lineIntersects,
  lineIntersection : lineIntersection,

  matrixHomogenousApply : matrixHomogenousApply,
  translate : translate,

  normalize : normalize,
  negate : negate,

  threeIntersectionPoint : threeIntersectionPoint,

}

_.mapSupplement( Self,Proto );

})();
