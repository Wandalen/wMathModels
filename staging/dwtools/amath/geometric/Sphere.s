(function _Geometric_s_(){

'use strict';

var _ = _global_.wTools;
var avector = _.avector;
var vector = _.vector;
var Self = _.sphere = _.sphere || Object.create( null );

// --
//
// --

function make( dim )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  var result = _.sphere.makeZero( dim );
  if( _.sphere.is( dim ) )
  _.avector.assign( result,dim );
  return result;
}

//

function makeZero( dim )
{
  if( _.sphere.is( dim ) )
  dim = _.sphere.dimGet( dim );

  if( dim === undefined || dim === null )
  dim = 3;

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( _.numberIs( dim ) );

  var result = _.dup( 0,dim+1 );

  return result;
}

//

function makeNil( dim )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  var result = _.sphere.makeZero( dim );
  result[ result.length-1 ] = -Infinity;
  return result;
}

//

function zero( sphere )
{
  if( !_.sphere.is( sphere ) )
  return _.sphere.makeZero( sphere );

  var spherev = _.sphere._from( sphere );
  for( var i = 0 ; i < spherev.length ; i++ )
  spherev.eSet( i,0 );

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( _.sphere.is( sphere ) );

  return sphere;
}

//

function nil( sphere )
{
  if( !_.sphere.is( sphere ) )
  return _.sphere.makeNil( sphere );

  var spherev = _.sphere._from( sphere );
  for( var i = 0 ; i < spherev.length-1 ; i++ )
  spherev.eSet( i,0 );
  spherev.eSet( spherev.length-1,-Infinity );

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( _.sphere.is( sphere ) );

  return sphere;
}

//

function centeredOfRadius( sphere,radius )
{
  sphere = _.sphere.zero( sphere );

  if( radius === undefined )
  radius = 0.5;

  _.sphere.radiusSet( sphere,radius );

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.sphere.is( sphere ) );

  return sphere;
}

//

function toStr( sphere,options )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.sphere.is( sphere ) );

  // var spherev = _.sphere._from( sphere );
  // var center = _.sphere.centerGet( spherev );
  // var radius = _.sphere.radiusGet( spherev );
  // var dim = _.sphere.dimGet( spherev );

  return _.toStr( sphere,options );
}

//

function from( sphere )
{

  if( _.objectIs( sphere ) )
  {
    _.assert( arguments.length === 1 );
    _.assertMapHasOnly( sphere,{ center : 'center' , radius : 'radius' } );
    sphere = [ sphere.center[ 0 ] , sphere.center[ 1 ] , sphere.center[ 2 ] , sphere.radius ]
  }
  else
  {
    _.assert( arguments.length === 1 );
  }

  _.assert( _.vectorIs( sphere ) || _.arrayLike( sphere ) );

  if( _.vectorIs( sphere ) )
  {
    debugger;
    throw _.err( 'not implemented' );
    return sphere.slice();
  }

  return sphere;
}

//

function _from( sphere )
{
  _.assert( _.sphere.is( sphere ) )
  _.assert( arguments.length === 1 );
  return _.vector.from( sphere );
}

//

function fromPoints( sphere, points )
{

  _.assert( arguments.length === 2 );

  debugger;
  throw _.err( 'not tested' );

  if( sphere === null )
  sphere = _.sphere.make();

  var spherev = _.sphere._from( sphere );
  var center = _.sphere.centerGet( spherev );
  var maxr = 0;

  for ( var i = 0 ; i < points.length ; i += 1 )
  {
    maxr = Math.max( maxr, _.vector.distanceSqr( center , _.vector.from( points[ i ] ) ) );
  }

  sphere[ 3 ] = Math.sqrt( maxr );

  return sphere;
}

//

function fromBox( sphere, box )
{

  var boxv = _.box._from( box );
  var dim = _.box.dimGet( boxv );
  var min = _.box.cornerLeftGet( boxv );
  var max = _.box.cornerRightGet( boxv );
  var size = _.box.sizeGet( boxv );

  if( sphere === null )
  sphere = _.sphere.make( dim );

  var spherev = _.sphere._from( sphere );
  var center = _.sphere.centerGet( spherev );
  var radius = _.sphere.radiusGet( spherev );
  var dim = _.sphere.dimGet( spherev );

  _.assert( dim === _.box.dimGet( box ) );
  _.assert( arguments.length === 2 );

  center.copy( min );
  vector.addVectors( center,max );
  vector.divScalar( center,2 );

  /* radius based on 2 major dimensions */

  // debugger;
  _.avector.sort( size );
  _.sphere.radiusSet( spherev , _.avector.mag( size.slice( 1,3 ) ) / 2 );

  return sphere;
}

//

function fromCenterAndRadius( sphere,center,radius )
{

  if( sphere === null )
  sphere = _.sphere.make( center.length );

  var spherev = _.sphere._from( sphere );
  var _center = _.sphere.centerGet( spherev );
  var _dim = _.sphere.dimGet( spherev );

  _.assert( arguments.length === 3 );
  _.assert( _.arrayLike( center ) );
  _.assert( _.numberIs( radius ) );
  _.assert( center.length === _dim );

  _center.copy( center );
  _.sphere.radiusSet( spherev , radius );

  return sphere;
}

//

function is( sphere )
{
  _.assert( arguments.length === 1 );
  return ( _.arrayLike( sphere ) || _.vectorIs( sphere ) ) && sphere.length > 0;
}

//

function isEmpty( sphere )
{

  _.assert( arguments.length === 1 );
  _.assert( _.sphere.is( sphere ) );

  var spherev = _.sphere._from( sphere );
  var radius = _.sphere.radiusGet( spherev );

  return( radius <= 0 );
}

//

function isZero( sphere )
{

  _.assert( arguments.length === 1 );
  _.assert( _.sphere.is( sphere ) );

  var spherev = _.sphere._from( sphere );
  var radius = _.sphere.radiusGet( spherev );

  return( radius === 0 );
}

//

function isNil( sphere )
{

  _.assert( arguments.length === 1 );

  // debugger;
  // throw _.err( 'not tested' );

  var spherev = _.sphere._from( sphere );
  var radius = _.sphere.radiusGet( spherev );
  var center = _.sphere.centerGet( spherev );

  // debugger;

  if( radius !== -Infinity )
  return false;

  if( !_.vector.allZero( center ) )
  return false;

  return true;
}

//

/**
* Get Sphere dimension. Returns the dimension of the Sphere (number). Sphere stays untouched.
*
* @param { Array } sphere - The source sphere.
*
* @example
* // returns 3
* _.dimGet( [ 0, 0, 2, 2 ] );
*
* @example
* // returns 1
* _.dimGet( [ 0, 1 ] );
*
* @returns { Number } Returns the dimension of the sphere.
* @function dimGet
* @throws { Error } An Error if ( arguments.length ) is different than one.
* @throws { Error } An Error if ( sphere ) is not sphere.
* @memberof wTools.sphere
*/

function dimGet( sphere )
{
  _.assert( arguments.length === 1 );
  _.assert( _.sphere.is( sphere ) );
  return sphere.length - 1;
}

//

/**
* Get the center of a sphere. Returns a vector wit the coordinates of the center of the sphere.
* Sphere stays untouched.
*
* @param { Array } sphere - The source sphere.
*
* @example
* // returns  0, 0, 2
* _.centerGet( [ 0, 0, 2, 2 ] );
*
* @example
* // returns  0
* _.centerGet( [ 0, 1 ] );
*
* @returns { Vector } Returns the coordinates of the center of the sphere.
* @function centerGet
* @throws { Error } An Error if ( arguments.length ) is different than one.
* @throws { Error } An Error if ( sphere ) is not sphere.
* @memberof wTools.sphere
*/

function centerGet( sphere, dst )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );

  var spherev = _.sphere._from( sphere );
  var dim = _.sphere.dimGet( sphere );
  console.log( 'dim: ',dim );
  console.log( 'spherev: ', spherev )
  if( !dst )
  {
    dst = _.dup( 0, dim ) ;
    console.log('no dst, new: ',dst);
  }
  debugger;

  _.assert( dim === dst.length );
  var dstv = _.vector.from( dst );
  console.log('dstv:  ',dstv);

  dstv = spherev.subarray( 0,sphere.length-1 );
  return dstv;
}

//function centerGet( sphere )
//{
//  _.assert( arguments.length === 1 );
//  var spherev = _.sphere._from( sphere );
//  return spherev.subarray( 0,sphere.length-1 );
//}

//

/**
* Get the radius of a sphere. Returns a number with the radius of the sphere.
* Sphere stays untouched.
*
* @param { Array } sphere - The source sphere.
*
* @example
* // returns 2
* _.radiusGet( [ 0, 0, 2, 2 ] );
*
* @example
* // returns  1
* _.radiusGet( [ 0, 1 ] );
*
* @returns { Number } Returns the radius of the sphere.
* @function radiusGet
* @throws { Error } An Error if ( arguments.length ) is different than one.
* @throws { Error } An Error if ( sphere ) is not sphere.
* @memberof wTools.sphere
*/

function radiusGet( sphere )
{
  _.assert( arguments.length === 1 );
  var spherev = _.sphere._from( sphere );
  return spherev.eGet( sphere.length-1 );
}

//


/**
* Set the radius of a sphere. Returns a vector with the sphere including the new radius.
* Radius stays untouched.
*
* @param { Array } sphere - The source and destination sphere.
* @param { Number } radius - The source radius to set.
*
* @example
* // returns [ 0, 0, 2, 4 ]
* _.radiusSet( [ 0, 0, 2, 2 ], 4 );
*
* @example
* // returns  [ 0, - 2 ]
* _.radiusSet( [ 0, 1 ], -2 );
*
* @returns { Array } Returns the sphere with the modified radius.
* @function radiusSet
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( sphere ) is not sphere.
* @throws { Error } An Error if ( radius ) is not number.
* @memberof wTools.sphere
*/

function radiusSet( sphere,radius )
{
  _.assert( _.numberIs( radius ) );
  _.assert( _.sphere.is( sphere ) );
  _.assert( arguments.length === 2 );

  //if( _.vectorIs( sphere ) )
  //{
    var spherev = _.sphere._from( sphere );
  //return spherev.eSet( sphere.length-1, radius );
  //console.log('vector');
    spherev.eSet( sphere.length-1, radius );
    return spherev;
  //}

  // Alternative solution
  //if( _.arrayLike( sphere ) )
  //{
  //  sphere[ sphere.length-1 ] = radius;
  //  return sphere;
  //}
  debugger;
}

//

function pointContains( sphere,point )
{

  var spherev = _.sphere._from( sphere );
  var center = _.sphere.centerGet( spherev );
  var radius = _.sphere.radiusGet( spherev );
  var dim = _.sphere.dimGet( spherev );

  _.assert( arguments.length === 2 );
  _.assert( dim === point.length );

  debugger;
  throw _.err( 'not tested' );

  return ( vector.distanceSqr( vector.from( point ) , center ) <= ( radius * radius ) );
}

//

function pointDistance( sphere,point )
{

  var spherev = _.sphere._from( sphere );
  var center = _.sphere.centerGet( spherev );
  var radius = _.sphere.radiusGet( spherev );

  _.assert( arguments.length === 2 );
  _.assert( dim === point.length );

  debugger;
  throw _.err( 'not tested' );

  return( vector.distance( vector.from( point ) , center ) - radius );
}

//

function pointClamp( sphere, point )
{

  var spherev = _.sphere._from( sphere );
  var center = _.sphere.centerGet( spherev );
  var radius = _.sphere.radiusGet( spherev );
  var dim = _.sphere.dimGet( spherev );
  var pointv = vector.from( point );

  _.assert( arguments.length === 2 );
  _.assert( dim === point.length );

  debugger;
  throw _.err( 'not tested' );

  var distanseSqr = vector.distanceSqr( pointv , center );

  if( distanseSqr > radius * radius )
  {

    _.vector.subVectors( pointv,center );
    _.vector.normalize( pointv );
    _.vector.mulScalar( pointv,radius );
    _.vector.addVectors( pointv,center );

  }

  return sphere;
}

//

function pointExpand( sphere , point )
{

  var spherev = _.sphere._from( sphere );
  var center = _.sphere.centerGet( spherev );
  var radius = _.sphere.radiusGet( spherev );
  var dim = _.sphere.dimGet( spherev );
  var pointv = vector.from( point );

  _.assert( arguments.length === 2 );
  _.assert( dim === point.length );

  // debugger;

  if( radius === -Infinity )
  {
    center.copy( point );
    _.sphere.radiusSet( spherev,0 );
    return sphere;
  }

  var distance = _.vector.distance( center , pointv );
  if( radius < distance )
  {

    _.assert( distance > 0 );

    _.vector.mix( center, point, 0.5 + ( -radius ) / ( distance*2 ) );
    _.sphere.radiusSet( spherev,( distance+radius ) / 2 );

  }

  return sphere;
}

//

function sphereExpand( sphereDst, sphereSrc )
{

  var _sphereDst = _.sphere._from( sphereDst );
  var centerDst = _.sphere.centerGet( _sphereDst );
  var radiusDst = _.sphere.radiusGet( _sphereDst );
  var dimDst = _.sphere.dimGet( _sphereDst );

  var _sphereSrc = _.sphere._from( sphereSrc );
  var centerSrc = _.sphere.centerGet( _sphereSrc );
  var radiusSrc = _.sphere.radiusGet( _sphereSrc );
  var dimSrc = _.sphere.dimGet( _sphereSrc );

  _.assert( arguments.length === 2 );
  _.assert( dimDst === dimSrc );

  if( radiusSrc === -Infinity )
  {
    return sphereDst;
  }

  if( radiusDst === -Infinity )
  {
    _sphereDst.copy( _sphereSrc );
    return sphereDst;
  }

  var distance = _.vector.distance( centerDst,centerSrc );
  if( radiusDst < distance+radiusSrc )
  {

    if( distance > 0 )
    _.vector.mix( centerDst, centerSrc, 0.5 + ( radiusSrc-radiusDst ) / ( distance*2 ) );

    if( distance > 0 )
    _.sphere.radiusSet( _sphereDst,( distance+radiusSrc+radiusDst ) / 2 );
    else
    _.sphere.radiusSet( _sphereDst,Math.max( radiusDst,radiusSrc ) );

  }

  return sphereDst;
}

//

/**
* Returns true if the two spheres intersect.
*
* @param { Array } sphere one
* @param { Array } sphere two
*
* @example
* // returns true
* _.sphereIntersects( [ - 1, 0, 0, 2 ], [ 1, 0, 0, 2 ] );
*
* @example
* // returns false
* _.sphereIntersects( [ - 2, 0, 0, 1 ], [ 2, 0, 0, 1 ] );
*
* @returns { Boolean } Returns true if the two spheres intersect and false if not.
* @function sphereIntersects
* @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the two spheres have not the same dimension).
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @memberof wTools.sphere
*/

function sphereIntersects( sphere1, sphere2 )
{

  var _sphere1 = _.sphere._from( sphere1 );
  var center1 = _.sphere.centerGet( _sphere1 );
  var radius1 = _.sphere.radiusGet( _sphere1 );
  var dim1 = _.sphere.dimGet( _sphere1 );

  var _sphere2 = _.sphere._from( sphere2 );
  var center2 = _.sphere.centerGet( _sphere2 );
  var radius2 = _.sphere.radiusGet( _sphere2 );
  var dim2 = _.sphere.dimGet( _sphere2 );

  _.assert( arguments.length === 2 );
  _.assert( dim1 === dim2 );
  debugger;
  // throw _.err( 'not tested' );

  var r = radius1 + radius2;
  return _.vector.distanceSqr( center1,center2 ) <= r*r;
}

//

function matrixHomogenousApply( sphere,matrix )
{

  var spherev = _.sphere._from( sphere );
  var center = _.sphere.centerGet( spherev );
  var radius = _.sphere.radiusGet( spherev );
  var dim = _.sphere.dimGet( spherev );

  _.assert( arguments.length === 2 );
  _.assert( _.spaceIs( matrix ) );
  _.assert( dim+1 === matrix.ncol );

  matrix.matrixHomogenousApply( center );
  _.sphere.radiusSet( spherev,radius * matrix.scaleMaxGet() )

  return sphere;
}

//

function translate( sphere,offset )
{

  _.assert( arguments.length === 2 );
  _.assert( _.spaceIs( matrix ) );
  debugger;
  throw _.err( 'not tested' );

  var spherev = _.sphere._from( sphere );
  var center = _.sphere.centerGet( spherev );
  var radius = _.sphere.radiusGet( spherev );
  var dim = _.sphere.dimGet( spherev );

  debugger;

  center.add( offset );

  return sphere;
}

// --
// prototype
// --

var Proto =
{

  make : make,
  makeZero : makeZero,
  makeNil : makeNil,

  zero : zero,
  nil : nil,
  centeredOfRadius : centeredOfRadius,

  toStr : toStr,

  from : from,
  _from : _from,
  fromPoints : fromPoints,
  fromBox : fromBox,
  fromCenterAndRadius : fromCenterAndRadius,

  is : is,
  isEmpty : isEmpty,
  isZero : isZero,
  isNil : isNil,

  dimGet : dimGet,
  centerGet : centerGet,
  radiusGet : radiusGet,
  radiusSet : radiusSet,

  pointContains : pointContains,
  pointDistance : pointDistance,
  pointClamp : pointClamp,
  pointExpand : pointExpand,

  sphereExpand : sphereExpand,
  sphereIntersects : sphereIntersects,

  matrixHomogenousApply : matrixHomogenousApply,
  translate : translate,

}

_.mapSupplement( Self,Proto );

//

if( typeof module !== 'undefined' )
{
  require( './Box.s' );
}

})();
