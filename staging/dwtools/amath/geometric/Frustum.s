(function _Geometric_s_(){

'use strict';

var _ = _global_.wTools;
var avector = _.avector;
var Self = _.frustum = _.frustum || Object.create( null );

// --
//
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
* Check if a frustum intersects with another frustum. Returns true if they intersect.
* Both frustums remain unchanged.
*
* @param { Frustum } srcfrustum - Source frustum.
* @param { Frustum } testfrustum - Frustum to test if it intersects.
*
* @example
* // returns true;
* var srcfrustum = _.Space.make( [ 4, 6 ] ).copy
*  ([ 1, 0, 0, - 1, 0, 0,
*     0, 1, 0, 0, - 1, 0,
*     0, 0, 1, 0, 0, - 1,
*     1, 1, 1, 1, 1, 1 ] );
* var srcfrustum = _.Space.make( [ 4, 6 ] ).copy
*  ([ 1, 0, 0, - 1, 0, 0,
*     0, 1, 0, 0, - 1, 0,
*     0, 0, 1, 0, 0, - 1,
*     6, 6, 6, 6, 6, 6 ] );
* _.frustumIntersect( srcfrustum , testfrustum );
*
* @returns { Boolean } Returns true if the frustums intersect.
* @function frustumIntersect
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( frustum ) is not frustum.
* @memberof wTools.box
*/

function frustumIntersect( srcfrustum , testfrustum )
{

  _.assert( arguments.length === 2 );
  _.assert( _.frustum.is( srcfrustum ) );
  _.assert( _.frustum.is( testfrustum ) );
  debugger;


  var far1 = srcfrustum.colVectorGet( 0 );
  var near1 = srcfrustum.colVectorGet( 1 );
  var top1 = srcfrustum.colVectorGet( 2 );
  var bottom1 = srcfrustum.colVectorGet( 3 );
  var left1 = srcfrustum.colVectorGet( 4 );
  var right1 = srcfrustum.colVectorGet( 5 );

  var p001 = _.plane.threeIntersectionPoint( far1, top1, left1 );
  var p011 = _.plane.threeIntersectionPoint( far1, top1, right1 );
  var p000 = _.plane.threeIntersectionPoint( far1, bottom1, left1 );
  var p010 = _.plane.threeIntersectionPoint( far1, bottom1, right1 );
  var p101 = _.plane.threeIntersectionPoint( near1, top1, left1 );
  var p111 = _.plane.threeIntersectionPoint( near1, top1, right1 );
  var p100 = _.plane.threeIntersectionPoint( near1, bottom1, left1 );
  var p110 = _.plane.threeIntersectionPoint( near1, bottom1, right1 );

//  var p1 = [];
//  var p2 = [];

  for ( var i = 0 ; i < 6 ; i += 1 )
  {
    var plane = frustum.colVectorGet( i );

    //var d1 = _.plane.pointDistance( plane,p1 );
    //var d2 = _.plane.pointDistance( plane,p2 );

    if ( d1 < 0 && d2 < 0 )
    return false;

  }

  return true;
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

  for( var i = 0 ; i < 6 ; i += 1 )
  {

    var plane = frustum.colVectorGet( i );
    var distance = _.plane.pointDistance( plane,center );

    if( Math.abs(distance) < radius )
    return true;

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

  _.assert( arguments.length === 2 );
  _.assert( _.frustum.is( frustum ) );
  debugger;

  var p1 = [];
  var p2 = [];

  for ( var i = 0 ; i < 6 ; i += 1 )
  {
    var plane = frustum.colVectorGet( i );

    p1 = _.box.cornerLeftGet( box );
    p2 = _.box.cornerRightGet( box );

    var d1 = _.plane.pointDistance( plane,p1 );
    var d2 = _.plane.pointDistance( plane,p2 );

    if ( d1 < 0 && d2 < 0 )
    return false;

  }

  return true;
}

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
    if( _.plane.pointDistance( plane,point ) < 0 )
    return false;

  }

  return true;
}

// --
// define class
// --

var Proto =
{

  make : make,
  fromMatrixHomogenous : fromMatrixHomogenous,
  is : is,


  sphereIntersects : sphereIntersects,
  boxIntersects : boxIntersects,
  pointContains : pointContains,

// frustumIntersect : frustumIntersect;
}

_.mapSupplement( Self,Proto );

})();
