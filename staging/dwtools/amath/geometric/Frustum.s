(function _Geometric_s_(){

'use strict';

var _ = _global_.wTools;
var avector = _.avector;
var Self = _.frustum = _.frustum || Object.create( null );

// --
//  Frustum planes convention: frustum ( right, left, bottom, top, far, near );
//  Frustum planes must have director vectors pointing outside frustum;
// --

function make()
{
  _.assert( arguments.length === 0 );

  var dst = _.Space.make([ 4,6 ]);

  return dst;
}

//

function fromMatrixHomogenous( frustum , m )
{
  var frustum , m;

  if( frustum === null )
  frustum = this.make();

  _.assert( arguments.length === 2 );
  _.assert( _.frustum.is( frustum ) );
  _.assert( _.spaceIs( m ) );
  _.assert( m.hasShape([ 4,4 ]) );

  var col = frustum.colVectorGet( 0 );
  col.copy
  ([
    m.atomGet([ 3,0 ]) - m.atomGet([ 0,0 ]),
    m.atomGet([ 3,1 ]) - m.atomGet([ 0,1 ]),
    m.atomGet([ 3,2 ]) - m.atomGet([ 0,2 ]),
    m.atomGet([ 3,3 ]) - m.atomGet([ 0,3 ]),
  ]);

  var col = frustum.colVectorGet( 1 );
  col.copy
  ([
    m.atomGet([ 3,0 ]) + m.atomGet([ 0,0 ]),
    m.atomGet([ 3,1 ]) + m.atomGet([ 0,1 ]),
    m.atomGet([ 3,2 ]) + m.atomGet([ 0,2 ]),
    m.atomGet([ 3,3 ]) + m.atomGet([ 0,3 ]),
  ]);

  var col = frustum.colVectorGet( 2 );
  col.copy
  ([
    m.atomGet([ 3,0 ]) + m.atomGet([ 1,0 ]),
    m.atomGet([ 3,1 ]) + m.atomGet([ 1,1 ]),
    m.atomGet([ 3,2 ]) + m.atomGet([ 1,2 ]),
    m.atomGet([ 3,3 ]) + m.atomGet([ 1,3 ]),
  ]);

  var col = frustum.colVectorGet( 3 );
  col.copy
  ([
    m.atomGet([ 3,0 ]) - m.atomGet([ 1,0 ]),
    m.atomGet([ 3,1 ]) - m.atomGet([ 1,1 ]),
    m.atomGet([ 3,2 ]) - m.atomGet([ 1,2 ]),
    m.atomGet([ 3,3 ]) - m.atomGet([ 1,3 ]),
  ]);

  var col = frustum.colVectorGet( 4 );
  col.copy
  ([
    m.atomGet([ 3,0 ]) - m.atomGet([ 2,0 ]),
    m.atomGet([ 3,1 ]) - m.atomGet([ 2,1 ]),
    m.atomGet([ 3,2 ]) - m.atomGet([ 2,2 ]),
    m.atomGet([ 3,3 ]) - m.atomGet([ 2,3 ]),
  ]);

  var col = frustum.colVectorGet( 5 );
  col.copy
  ([
    m.atomGet([ 3,0 ]) + m.atomGet([ 2,0 ]),
    m.atomGet([ 3,1 ]) + m.atomGet([ 2,1 ]),
    m.atomGet([ 3,2 ]) + m.atomGet([ 2,2 ]),
    m.atomGet([ 3,3 ]) + m.atomGet([ 2,3 ]),
  ]);

  return frustum;
}

//

function is( frustum )
{
  _.assert( arguments.length === 1 );
  return _.spaceIs( frustum ) && frustum.hasShape([ 4,6 ])
}
//

/**
* Returns the coordinates of the corners of a frustum. Returns an space object where each column is a point.
* Frustum remain unchanged. Frustum need to follow planes convention ( see top of the file )
*
* @param { Frustum } srcfrustum - Source frustum.
*
* @example
* // returns furstumCorners =
* [ 0, 0, 0, 0, 1, 1, 1, 1,
*   1, 0, 1, 0, 1, 0, 1, 0,
*   1, 1, 0, 0, 1, 1, 0, 0,
* ];
* var srcfrustum = _.Space.make( [ 4, 6 ] ).copy
*  ([ 0, 0, 0, 0, - 1, 1,
*     1, - 1, 0, 0, 0, 0,
*     0, 0, 1, - 1, 0, 0,
*     - 1, 0, - 1, 0, 0, - 1 ] );
*
* _.frustumCorners( srcfrustum );
*
* @returns { Space } Returns the coordintes of the points in the frustum corners.
* @function frustumCorners
* @throws { Error } An Error if ( arguments.length ) is different than one.
* @throws { Error } An Error if ( frustum ) is not frustum.
* @memberof wTools.box
*/

function frustumCorners( srcfrustum )
{

  _.assert( arguments.length === 1 );
  _.assert( _.frustum.is( srcfrustum ) );
  debugger;

  var dims = _.Space.dimsOf( srcfrustum ) ;
  var rows = dims[ 0 ];
  var cols = dims[ 1 ];
  var pointsFru = _.Space.makeZero( [ rows - 1, cols + 2 ] );

  var right = _.vector.from(srcfrustum.colVectorGet( 0 ));
  var left = srcfrustum.colVectorGet( 1 );
  var top = srcfrustum.colVectorGet( 2 );
  var bottom = srcfrustum.colVectorGet( 3 );
  var far = srcfrustum.colVectorGet( 4 );
  var near = srcfrustum.colVectorGet( 5 );

  var point = _.plane.threeIntersectionPoint( far, top, right );
  if( ! _.vectorIs(point) ){ return false; }
  else{
    point = _.vector.toArray( point );
    pointsFru.atomSet( [ 0, 0 ], point[ 0 ] ); pointsFru.atomSet( [ 1, 0 ], point[ 1 ] ); pointsFru.atomSet( [ 2, 0 ], point[ 2 ] );}

  point =  _.plane.threeIntersectionPoint( far, top, left );
  if( ! _.vectorIs(point) ){ return false; }
  else{
    point = _.vector.toArray( point );
    pointsFru.atomSet( [ 0, 1 ], point[ 0 ] ); pointsFru.atomSet( [ 1, 1 ], point[ 1 ] ); pointsFru.atomSet( [ 2, 1 ], point[ 2 ] );}

  point =  _.plane.threeIntersectionPoint( far, bottom, right );
  if( ! _.vectorIs(point) ){ return false; }
  else{
    point = _.vector.toArray( point );
    pointsFru.atomSet( [ 0, 2 ], point[ 0 ] ); pointsFru.atomSet( [ 1, 2 ], point[ 1 ] ); pointsFru.atomSet( [ 2, 2 ], point[ 2 ] );}

  point =  _.plane.threeIntersectionPoint( far, bottom, left );
  if( ! _.vectorIs(point) ){ return false; }
  else{
    point = _.vector.toArray( point );
    pointsFru.atomSet( [ 0, 3 ], point[ 0 ] ); pointsFru.atomSet( [ 1, 3 ], point[ 1 ] ); pointsFru.atomSet( [ 2, 3 ], point[ 2 ] );}

  point = _.plane.threeIntersectionPoint( near, top, right );
  if( ! _.vectorIs(point) ){ return false; }
  else{
    point = _.vector.toArray( point );
    pointsFru.atomSet( [ 0, 4 ], point[ 0 ] ); pointsFru.atomSet( [ 1, 4 ], point[ 1 ] ); pointsFru.atomSet( [ 2, 4 ], point[ 2 ] );}

  point =  _.plane.threeIntersectionPoint( near, top, left );
  if( ! _.vectorIs(point) ){ return false; }
  else{
    point = _.vector.toArray( point );
    pointsFru.atomSet( [ 0, 5 ], point[ 0 ] ); pointsFru.atomSet( [ 1, 5 ], point[ 1 ] ); pointsFru.atomSet( [ 2, 5 ], point[ 2 ] );}

  point =  _.plane.threeIntersectionPoint( near, bottom, right );
  if( ! _.vectorIs(point) ){ return false; }
  else{
    point = _.vector.toArray( point );
    pointsFru.atomSet( [ 0, 6 ], point[ 0 ] ); pointsFru.atomSet( [ 1, 6 ], point[ 1 ] ); pointsFru.atomSet( [ 2, 6 ], point[ 2 ] );}

  point = _.plane.threeIntersectionPoint( near, bottom, left );
  if( ! _.vectorIs(point) ){ return false; }
  else{
    point = _.vector.toArray( point );
    pointsFru.atomSet( [ 0, 7 ], point[ 0 ] ); pointsFru.atomSet( [ 1, 7 ], point[ 1 ] ); pointsFru.atomSet( [ 2, 7 ], point[ 2 ] );}
  debugger;

  return pointsFru;
}

//

/**
* Check if a frustum intersects with another frustum. Returns true if they intersect.
* Both frustums remain unchanged.
*
* @param { Frustum } srcfrustum - Source frustum.
* @param { Frustum } testfrustum - Frustum to test if it intersects.
*
* @example
* // returns true;
* var srcfrustum = _.Space.make( [ 4, 6 ] ).copy(
*   [ 0,   0,   0,   0, - 1,   1,
*     1, - 1,   0,   0,   0,   0,
*     0,   0,   1, - 1,   0,   0,
*   - 1,   0, - 1,   0,   0, - 1 ] );
* var srcfrustum = _.Space.make( [ 4, 6 ] ).copy(
*  [ 0,   0,   0,   0, - 1,   1,
*    1, - 1,   0,   0,   0,   0,
*    0,   0,   1, - 1,   0,   0,
*   -0.5,-0.5,-0.5,-0.5,-0.5,-0.5 ] );
* _.frustumIntersects( srcfrustum , testfrustum );
*
* @returns { Boolean } Returns true if the frustums intersect.
* @function frustumIntersects
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( frustum ) is not frustum.
* @memberof wTools.box
*/

function frustumIntersects( srcfrustum , testfrustum )
{

  _.assert( arguments.length === 2 );
  _.assert( _.frustum.is( srcfrustum ) );
  _.assert( _.frustum.is( testfrustum ) );
  debugger;

 var points = _.frustum.frustumCorners( srcfrustum );

  for ( var i = 0 ; i < points.length ; i += 1 )
  {
    var point = points.colVectorGet( i );
    var c = _.frustum.pointContains( testfrustum, point );
    if ( c == true )
    return true;

  }

  var points2 = _.frustum.frustumCorners( testfrustum );

  for ( var i = 0 ; i < points2.length ; i += 1 )
  {
    var point = points2.colVectorGet( i );
    var c = _.frustum.pointContains( srcfrustum, point );
    if ( c == true )
    return true;

  }

  return false;
}

//

/**
* Check if a frustum and a sphere intersect. Returns true if they intersect.
* Frustum and sphere remain unchanged.
*
* @param { Frustum } frustum - Source frustum.
* @param { Sphere } sphere - Source sphere.
*
* @example
* // returns false;
* _.sphereIntersects( _.frustum.make() , [ 2, 2, 2, 1 ] );
**
* @returns { Boolean } Returns true if the frustum and the sphere intersect.
* @function sphereIntersects
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( frustum ) is not frustum.
* @throws { Error } An Error if ( sphere ) is not sphere.
* @memberof wTools.box
*/

function sphereIntersects( frustum , sphere )
{

  _.assert( arguments.length === 2 );
  _.assert( _.frustum.is( frustum ) );

  var center = _.sphere.centerGet( sphere );
  var radius = _.sphere.radiusGet( sphere );

  if( _.frustum.pointContains( frustum, _.vector.from( center )) == true ){
    return true; }
  else{
    var newc = _.vector.from( center.slice() );
    var proj = _.frustum.pointClosestPoint( frustum, center );
    var d = _.avector.distance( _.vector.toArray( proj ), _.vector.toArray( center ) );
    if( d <= radius ){
      return true; }
  }
  return false;
}

//


/**
* Check if a frustum and a box intersect. Returns true if they intersect.
* Frustum and box remain unchanged.
*
* @param { Frustum } frustum - Source frustum.
* @param { Array } box - Source box.
*
* @example
* // returns false;
* _.sphereIntersects( _.frustum.make() , [ 2, 2, 2, 3, 3, 3 ] );
**
* @returns { Boolean } Returns true if the frustum and the box intersect.
* @function boxIntersects
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( frustum ) is not frustum.
* @throws { Error } An Error if ( box ) is not box.
* @memberof wTools.box
*/

function boxIntersects( frustum , box )
{

  var _box = _.box._from( box );
  var dim1 = _.box.dimGet( _box );
  var min1 = _.box.cornerLeftGet( _box );
  var max1 = _.box.cornerRightGet( _box );
  _.assert( arguments.length === 2 );
  _.assert( _.frustum.is( frustum ) );
  debugger;

  var c0 = _.vector.from(_.vector.toArray( min1 ));
  var c4 = _.vector.from(_.vector.toArray( max1 ));
  var c0 = _.vector.toArray( c0 );
  var c4 = _.vector.toArray( c4 );

  var c1 = c0.slice(); c1[0] = c4[ 0 ];
  var c2 = c0.slice(); c2[1] = c4[ 1 ];
  var c3 = c0.slice(); c3[2] = c4[ 2 ];
  var c5 = c0.slice(); c5[0] = c4[ 0 ]; c5[ 2 ] = c4[ 2 ];
  var c6 = c0.slice(); c6[1] = c4[ 1 ]; c6[ 0 ] = c4[ 0 ];
  var c7 = c0.slice(); c7[2] = c4[ 2 ]; c7[ 1 ] = c4[ 1 ];

  if ( _.frustum.pointContains( frustum, _.vector.from( c0.slice( ) ) ) == true ){ return true; }
  if ( _.frustum.pointContains( frustum, _.vector.from( c1.slice( ) ) ) == true ){ return true; }
  if ( _.frustum.pointContains( frustum, _.vector.from( c2.slice( ) ) ) == true ){ return true; }
  if ( _.frustum.pointContains( frustum, _.vector.from( c3.slice( ) ) ) == true ){ return true; }
  if ( _.frustum.pointContains( frustum, _.vector.from( c4.slice( ) ) ) == true ){ return true; }
  if ( _.frustum.pointContains( frustum, _.vector.from( c5.slice( ) ) ) == true ){ return true; }
  if ( _.frustum.pointContains( frustum, _.vector.from( c6.slice( ) ) ) == true ){ return true; }
  if ( _.frustum.pointContains( frustum, _.vector.from( c7.slice( ) ) ) == true ){ return true; }

  var fpoints = _.frustum.frustumCorners( frustum );
  _.assert( _.spaceIs( fpoints ) );

  for ( var i = 0 ; i < 6 ; i += 1 )
  {
    var point = _.vector.toArray( fpoints.colVectorGet( i ) );
    var point = _.vector.from( point );

    if ( _.box.pointContains( box, point ) == true ){ return true; }
   }
  return false;
}

//function boxIntersects( frustum , box )
//{
//
//  _.assert( arguments.length === 2 );
//  _.assert( _.frustum.is( frustum ) );
//  debugger;
//
//  var p1 = [];
//  var p2 = [];
//
//  for ( var i = 0 ; i < 6 ; i += 1 )
//  {
//    var plane = frustum.colVectorGet( i );
//
//    p1 = _.box.cornerLeftGet( box );
//    p2 = _.box.cornerRightGet( box );
//
//    var d1 = _.plane.pointDistance( plane,p1 );
//    var d2 = _.plane.pointDistance( plane,p2 );
//
//    if ( d1 < 0 && d2 < 0 )
//    return false;
//
//  }
//
//  return true;
//}

//

/**
* Check if a frustum contains a point. Returns true if it contains it.
* Frustum and point remain unchanged.
*
* @param { Frustum } frustum - Source frustum.
* @param { Array } point - Source point.
*
* @example
* // returns false;
* _.pointContains( _.frustum.make() , [ 1, 1, 1 ] );
**
* @returns { Boolean } Returns true if the frustum contains the point.
* @function pointContains
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( frustum ) is not frustum.
* @throws { Error } An Error if ( point ) is not point.
* @memberof wTools.box
*/

function pointContains( frustum , point )
{

  _.assert( arguments.length === 2 );
  _.assert( _.frustum.is( frustum ) );

  debugger;

  for( var i = 0 ; i < 6 ; i += 1 )
  {

    var plane = frustum.colVectorGet( i );
    if( _.plane.pointDistance( plane, point ) > 1E-12 )
    return false;

  }

  return true;
}

//

/**
* Returns the closest point in a frustum to a point. Returns the coordinates of the closest point.
* Frustum and point remain unchanged.
*
* @param { Frustum } frustum - Source frustum.
* @param { Array } srcpoint - Source point.
*
* @example
* // returns [ 0, 0, 0 ];
* var frustum = _.Space.make( [ 4, 6 ] ).copy(
*   [ 0,   0,   0,   0, - 1,   1,
*     1, - 1,   0,   0,   0,   0,
*     0,   0,   1, - 1,   0,   0,
*   - 1,   0, - 1,   0,   0, - 1 ] );
* _.pointClosestPoint( frustum , [ - 1, - 1, - 1 ] );
*
* @returns { Array } Returns the array of coordinates of the closest point in the frustum.
* @function pointClosestPoint
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( frustum ) is not frustum.
* @throws { Error } An Error if ( point ) is not point.
* @memberof wTools.box
*/

function pointClosestPoint( frustum , point )
{

  _.assert( arguments.length === 2 );
  _.assert( _.frustum.is( frustum ) );
  var point = _.vector.from( point );
  var _point = _.vector.from( point.slice() );
  var dstpoint = _.vector.fromArray( [ 0, 0, 0 ] );
  var dims = _.Space.dimsOf( frustum ) ;
  var rows = dims[ 0 ];
  var cols = dims[ 1 ];
  var fpoints = _.frustum.frustumCorners( frustum );

  _.assert( _.spaceIs( fpoints ) );
  _.assert( fpoints.hasShape([ 3,8 ]) );

  var max = fpoints.colVectorGet( 0 );
  var min = fpoints.colVectorGet( 0 );
  max = _.vector.toArray( max );
  min = _.vector.toArray( min );
  dstpoint = _.vector.toArray( dstpoint );
  var _point = _.vector.toArray( _point.slice() );

  for ( var j = 1 ; j < cols ; j++ )
  {
    var newp = _.vector.toArray( fpoints.colVectorGet( j ) );
    if( newp[ 0 ] < min[ 0 ] ) { min[ 0 ] = newp[ 0 ]; }
    if( newp[ 1 ] < min[ 1 ] ) { min[ 1 ] = newp[ 1 ]; }
    if( newp[ 2 ] < min[ 2 ] ) { min[ 2 ] = newp[ 2 ]; }
    if( newp[ 0 ] > max[ 0 ] ) { max[ 0 ] = newp[ 0 ]; }
    if( newp[ 1 ] > max[ 1 ] ) { max[ 1 ] = newp[ 1 ]; }
    if( newp[ 2 ] > max[ 2 ] ) { max[ 2 ] = newp[ 2 ]; }
  }

  for( var i = 0 ; i < 3 ; i++ )
  {
   if( _point[ i ] >= max[ i ] ){ dstpoint[ i ] = max[ i ]; }
   else if( _point[ i ] <= min[ i ] ){ dstpoint[ i ] = min[ i ]; }
   else{ dstpoint[ i ] = _point[ i ]; }
  }

  dstpoint = _.vector.from( dstpoint );
  if( _.frustum.pointContains( frustum, dstpoint ) == true ){ return dstpoint;  }
  else
  { var d0 = 1.79E+308;
    var _point = _.vector.toArray( _point );
    var finalpoint = dstpoint;

    for( var i = 0 ; i < cols ; i++ )
    {
      var plane = _.vector.from( frustum.colVectorGet( i ) );
      var p =  _.plane.pointCoplanarGet( plane, _.vector.from( dstpoint.slice() ) );
      p = _.vector.toArray( p );
      var d = _.avector.distance( _point, p );
      if( d < d0  && _.frustum.pointContains( frustum, _.vector.from( p ) ) )
      { finalpoint = p ; d0 = d; }
     }
      dstpoint = _.vector.from( finalpoint );
   }

 dstpoint = _.vector.from( dstpoint );
 _.assert( _.frustum.pointContains( frustum, dstpoint ) == true );
return dstpoint;

}


/**
* Returns the closest point in a frustum to a box. Returns the coordinates of the closest point.
* Frustum and box remain unchanged.
*
* @param { Frustum } frustum - Source frustum.
* @param { Array } box - Source box.
*
* @example
* // returns [ 0, 0, 0 ];
* var frustum = _.Space.make( [ 4, 6 ] ).copy(
*   [ 0,   0,   0,   0, - 1,   1,
*     1, - 1,   0,   0,   0,   0,
*     0,   0,   1, - 1,   0,   0,
*   - 1,   0, - 1,   0,   0, - 1 ] );
* _.boxClosestPoint( frustum , [ - 1, - 1, - 1, -0.1, -0.1, -0.1 ] );
*
* @returns { Array } Returns the array of coordinates of the closest point in the frustum.
* @function boxClosestPoint
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( frustum ) is not frustum.
* @throws { Error } An Error if ( box ) is not box.
* @memberof wTools.box
*/

function boxClosestPoint( frustum , box )
{
  var _box = _.box._from( box );
  var dim1 = _.box.dimGet( _box );
  var min1 = _.box.cornerLeftGet( _box );
  var max1 = _.box.cornerRightGet( _box );
  var dims = _.Space.dimsOf( frustum ) ;
  var rows = dims[ 0 ];
  var cols = dims[ 1 ];
  var dstpoint = _.vector.fromArray( [ 0, 0, 0 ] );
  _.assert( arguments.length === 2 );
  _.assert( _.frustum.is( frustum ) );
  _.assert( dim1 === 3 );

 if( _.frustum.boxIntersects( frustum, _box ) ){ return 0; }

 // frustum corners
 var fpoints = _.frustum.frustumCorners( frustum );
 var dist = 1.79E+308;
 for ( var j = 0 ; j < cols ; j++ )
 {
   var newp = _.vector.from( _.vector.toArray( fpoints.colVectorGet( j ) ) );
   var d = _.box.pointDistance( _box, newp );

   if( d < dist ){ dstpoint = newp; dist = d; }
 }

 // box corners
 var c = _.Space.makeZero( [ 3, 8 ] );
 min1 = _.vector.toArray( min1 ); max1 = _.vector.toArray( max1 );
 var col = c.colVectorGet( 0 ); col.copy( [min1[ 0 ], min1[ 1 ], min1[ 2 ] ]);
 var col = c.colVectorGet( 1 ); col.copy( [max1[ 0 ], min1[ 1 ], min1[ 2 ] ]);
 var col = c.colVectorGet( 2 ); col.copy( [min1[ 0 ], max1[ 1 ], min1[ 2 ] ]);
 var col = c.colVectorGet( 3 ); col.copy( [min1[ 0 ], min1[ 1 ], max1[ 2 ] ]);
 var col = c.colVectorGet( 4 ); col.copy( [max1[ 0 ], max1[ 1 ], max1[ 2 ] ]);
 var col = c.colVectorGet( 5 ); col.copy( [min1[ 0 ], max1[ 1 ], max1[ 2 ] ]);
 var col = c.colVectorGet( 6 ); col.copy( [max1[ 0 ], min1[ 1 ], max1[ 2 ] ]);
 var col = c.colVectorGet( 7 ); col.copy( [max1[ 0 ], max1[ 1 ], min1[ 2 ] ]);

 for ( var j = 0 ; j < 8 ; j++ )
 {
   var corner = _.vector.toArray( c.colVectorGet( j ) );
   corner = _.vector.from( corner );
   var proj = _.frustum.pointClosestPoint( frustum, corner );
   var d = _.avector.distance( corner, _.vector.toArray( proj ) );
   if( d < dist ){ dstpoint = proj; dist = d; }
 }



 return dstpoint;
}


/**
* Returns the closest point in a frustum to a sphere. Returns the coordinates of the closest point.
* Frustum and sphere remain unchanged.
*
* @param { Frustum } frustum - Source frustum.
* @param { Array } sphere - Source sphere.
*
* @example
* // returns [ 0, 0, 0 ];
* var frustum = _.Space.make( [ 4, 6 ] ).copy(
*   [ 0,   0,   0,   0, - 1,   1,
*     1, - 1,   0,   0,   0,   0,
*     0,   0,   1, - 1,   0,   0,
*   - 1,   0, - 1,   0,   0, - 1 ] );
* _.sphereClosestPoint( frustum , [ - 1, - 1, - 1, 0.1 ] );
*
* @returns { Array } Returns the array of coordinates of the closest point in the frustum.
* @function sphereClosestPoint
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( frustum ) is not frustum.
* @throws { Error } An Error if ( sphere ) is not sphere.
* @memberof wTools.box
*/

function sphereClosestPoint( frustum , sphere )
{
  var spherev = _.sphere._from( sphere );
  var center = _.sphere.centerGet( spherev );
  var radius = _.sphere.radiusGet( spherev );
  var dim = _.sphere.dimGet( spherev );

  _.assert( arguments.length === 2 );
  _.assert( dim === 3 );
  _.assert( _.frustum.is( frustum ) );

  if( _.frustum.sphereIntersects( frustum, spherev ) == true ){ console.log('i');return 0; }

  var dstpoint = _.frustum.pointClosestPoint( frustum, center );

  return dstpoint;

}

// --
// define class
// --

var Proto =
{

  make : make,
  fromMatrixHomogenous : fromMatrixHomogenous,
  is : is,

  frustumCorners : frustumCorners,

  frustumIntersects : frustumIntersects,
  sphereIntersects : sphereIntersects,
  boxIntersects : boxIntersects,
  pointContains : pointContains,

  pointClosestPoint : pointClosestPoint,
  boxClosestPoint : boxClosestPoint,
  sphereClosestPoint : sphereClosestPoint,



}

_.mapSupplement( Self,Proto );

})();
