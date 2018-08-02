(function _Sphere_s_(){

'use strict';

let _ = _global_.wTools;
let avector = _.avector;
let vector = _.vector;
let Self = _.sphere = _.sphere || Object.create( null );

// --
//
// --

function make( dim )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = _.sphere.makeZero( dim );
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

  let result = _.dup( 0,dim+1 );

  return result;
}

//

function makeNil( dim )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = _.sphere.makeZero( dim );
  result[ result.length-1 ] = -Infinity;
  return result;
}

//

function zero( sphere )
{
  if( !_.sphere.is( sphere ) )
  return _.sphere.makeZero( sphere );

  let spherev = _.sphere._from( sphere );
  for( let i = 0 ; i < spherev.length ; i++ )
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

  let spherev = _.sphere._from( sphere );
  for( let i = 0 ; i < spherev.length-1 ; i++ )
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

  // let spherev = _.sphere._from( sphere );
  // let center = _.sphere.centerGet( spherev );
  // let radius = _.sphere.radiusGet( spherev );
  // let dim = _.sphere.dimGet( spherev );

  return _.toStr( sphere,options );
}

//

function from( sphere )
{

  if( _.objectIs( sphere ) )
  {
    _.assert( arguments.length === 1, 'expects single argument' );
    _.assertMapHasOnly( sphere,{ center : 'center' , radius : 'radius' } );
    sphere = [ sphere.center[ 0 ] , sphere.center[ 1 ] , sphere.center[ 2 ] , sphere.radius ]
  }
  else
  {
    _.assert( arguments.length === 1, 'expects single argument' );
  }

  _.assert( _.vectorIs( sphere ) || _.longIs( sphere ) );

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
  _.assert( arguments.length === 1, 'expects single argument' );
  return _.vector.from( sphere );
}

//

/**
  * Create or expand a sphere from an array of points. Returns the expanded sphere. Spheres are stored in Array data structure.
  * Points stay untouched, sphere changes. Created spheres have center in origin.
  *
  * @param { Array } sphere - sphere to be expanded.
  * @param { Array } points - Array of points of reference with expansion dimensions.
  *
  * @example
  * // returns [ 0, 0, 0, 3 ];
  * _.fromPoints( null , [ [ 0, 0, 3 ], [ 0, 2, 0 ], [ 1, 0, 0 ] ] );
  *
  * @example
  * // returns [ 0, - 1, 2 ];
  * _.fromPoints( [ 0, - 1, 1 ], [ [ 1, 0 ], [ 0, -3 ], [ 0, 0 ] ] );
  *
  * @returns { Array } Returns the array of the sphere expanded.
  * @function fromPoints
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @throws { Error } An Error if ( point ) is not array.
  * @memberof wTools.sphere
  */

function fromPoints( sphere, points )
{

  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  debugger;
  //throw _.err( 'not tested' );


  let dimp = points[0].length;

  if( sphere === null )
  sphere = _.sphere.make(dimp);

  let spherev = _.sphere._from( sphere );
  let center = _.sphere.centerGet( spherev );
  let maxr = 0;

  for ( let i = 0 ; i < points.length ; i += 1 )
  {
    maxr = Math.max( maxr, _.vector.distanceSqr( center , _.vector.from( points[ i ] ) ) );
  }

  debugger;
  sphere[ dimp ] = Math.sqrt( maxr );

  return sphere;
}

//

function fromBox( sphere, box )
{

  let boxVector = _.box._from( box );
  let dimB = _.box.dimGet( boxVector );
  let min = _.box.cornerLeftGet( boxVector );
  let max = _.box.cornerRightGet( boxVector );
  let size = _.box.sizeGet( boxVector );

  if( sphere === null )
  sphere = _.sphere.make( dim );

  let spherev = _.sphere._from( sphere );
  let center = _.sphere.centerGet( spherev );
  let radius = _.sphere.radiusGet( spherev );
  let dimS = _.sphere.dimGet( spherev );

  _.assert( dimS === dimB );
  //  _.assert( dim === _.sphere.dimGet(  sphere) );
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

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

/**
  * Create or modify sphere coordinates from a center and a radius. Returns the modified sphere.
  * Spheres are stored in Array data structure. Center and radius stay untouched, sphere changes.
  *
  * @param { Array } sphere - sphere to be modified.
  * @param { Array } center - Array of coordinates for new center of sphere.
  * @param { Number } radius - Value for new radius of sphere.
  *
  * @example
  * // returns [ 0, 2, 0, 1 ];
  * _.fromCenterAndRadius( null , [ 0, 2, 0 ], 1 );
  *
  * @example
  * // returns [ 1, 0, 2 ];
  * _.fromCenterAndRadius( [ 0, - 1, 1 ], [ 1, 0 ], 2 );
  *
  * @returns { Array } Returns the array of the sphere with new coordinates.
  * @function fromCenterAndRadius
  * @throws { Error } An Error if ( arguments.length ) is different than three.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @throws { Error } An Error if ( center ) is not point.
  * @throws { Error } An Error if ( radius ) is not number.
  * @memberof wTools.sphere
  */

function fromCenterAndRadius( sphere, center, radius )
{

  if( sphere === null )
  sphere = _.sphere.make( center.length );

  let spherev = _.sphere._from( sphere );
  let _center = _.sphere.centerGet( spherev );
  let _dim = _.sphere.dimGet( spherev );

  _.assert( arguments.length === 3, 'expects exactly three argument' );
  _.assert( _.longIs( center ) );
  _.assert( _.numberIs( radius ) );
  _.assert( center.length === _dim );

  _center.copy( center );
  _.sphere.radiusSet( spherev , radius );

  return sphere;
}

//

function is( sphere )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  return ( _.longIs( sphere ) || _.vectorIs( sphere ) ) && sphere.length > 0;
}

//

function isEmpty( sphere )
{

  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( _.sphere.is( sphere ) );

  let spherev = _.sphere._from( sphere );
  let radius = _.sphere.radiusGet( spherev );

  return( radius <= 0 );
}

//

function isZero( sphere )
{

  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( _.sphere.is( sphere ) );

  let spherev = _.sphere._from( sphere );
  let radius = _.sphere.radiusGet( spherev );

  return( radius === 0 );
}

//

function isNil( sphere )
{

  _.assert( arguments.length === 1, 'expects single argument' );

  // debugger;
  // throw _.err( 'not tested' );

  let spherev = _.sphere._from( sphere );
  let radius = _.sphere.radiusGet( spherev );
  let center = _.sphere.centerGet( spherev );

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
  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( _.sphere.is( sphere ) );
  return sphere.length - 1;
}

//

/**
  * Get the center of a sphere. Returns a vector with the coordinates of the center of the sphere.
  * Sphere stays untouched.
  *
  * @param { Array } sphere - The source sphere.
  *
  * @example
  * // returns   0, 0, 2
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

function centerGet( sphere )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  let spherev = _.sphere._from( sphere );
  return spherev.subarray( 0,sphere.length-1 );
}

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
  _.assert( arguments.length === 1, 'expects single argument' );
  let spherev = _.sphere._from( sphere );
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

function radiusSet( sphere, radius )
{
  _.assert( _.numberIs( radius ) );
  _.assert( _.sphere.is( sphere ) );
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  //if( _.vectorIs( sphere ) )
  //{
  let spherev = _.sphere._from( sphere );
  //return spherev.eSet( sphere.length-1, radius );
  //console.log('vector');
  spherev.eSet( sphere.length-1, radius );
  return spherev;
  //}

  // Alternative solution
  //if( _.longIs( sphere ) )
  //{
  //  sphere[ sphere.length-1 ] = radius;
  //  return sphere;
  //}
  debugger;
}

//

function pointContains( sphere,point )
{

  let spherev = _.sphere._from( sphere );
  let center = _.sphere.centerGet( spherev );
  let radius = _.sphere.radiusGet( spherev );
  let dim = _.sphere.dimGet( spherev );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( dim === point.length );

  debugger;
  //throw _.err( 'not tested' );

  return ( vector.distanceSqr( vector.from( point ) , center ) <= ( radius * radius ) );
}

//

function pointDistance( sphere, point )
{

  let spherev = _.sphere._from( sphere );
  let center = _.sphere.centerGet( spherev );
  let radius = _.sphere.radiusGet( spherev );
  let dim = _.sphere.dimGet( spherev );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( dim === point.length );

  debugger;
  //throw _.err( 'not tested' );

  let distance = vector.distance( vector.from( point ) , center ) - radius;

  if( distance < 0 )
  return 0;
  else
  return distance;
}

//

/**
  * Clamp a point to a sphere. Returns the closest point in the sphere. Sphere and point stay unchanged.
  *
  * @param { Array } sphere - The source sphere.
  * @param { Array } point - The point to be clamped against the box.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns [ 3, 0, 0 ]
  * _.pointClosestPoint( [ 1, 0, 0, 2 ], [ 4, 0, 0 ] );
  *
  *
  * @returns { Array } Returns an array with the coordinates of the clamped point.
  * @function pointClosestPoint
  * @throws { Error } An Error if ( dim ) is different than dimGet( sphere ) (the sphere and the point don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @throws { Error } An Error if ( point ) is not point.
  * @throws { Error } An Error if ( dstPoint ) is not dstPoint.
  * @memberof wTools.sphere
  */

function pointClosestPoint( sphere, srcPoint, dstPoint )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );

  let spherev = _.sphere._from( sphere );
  let center = _.sphere.centerGet( spherev );
  let radius = _.sphere.radiusGet( spherev );
  let dim = _.sphere.dimGet( spherev );

  if( arguments.length === 2 )
  dstPoint = srcPoint.slice();

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  _.assert( dim === srcPoint.length );
  let srcPointv = vector.from( srcPoint );
  _.assert( dim === dstPoint.length );
  let dstPointv = _.vector.from( dstPoint );

  if( _.sphere.pointContains( spherev, srcPointv ) )
  return 0;

  debugger;
  // throw _.err( 'not tested' );

  for( let i = 0; i < dim; i++ )
  {
    dstPointv.eSet( i, srcPointv.eGet( i ) );
  }

  let distanseSqr = vector.distanceSqr( srcPointv , center );
  if( distanseSqr > radius * radius )
  {
    _.vector.subVectors( dstPointv,center );
    _.vector.normalize( dstPointv );
    _.vector.mulScalar( dstPointv,radius );
    _.vector.addVectors( dstPointv,center );
  }

  return dstPoint;
}

//

function pointExpand( sphere , point )
{

  let spherev = _.sphere._from( sphere );
  let center = _.sphere.centerGet( spherev );
  let radius = _.sphere.radiusGet( spherev );
  let dim = _.sphere.dimGet( spherev );
  let pointv = vector.from( point );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( dim === point.length );

  // debugger;

  if( radius === -Infinity )
  {
    center.copy( point );
    _.sphere.radiusSet( spherev,0 );
    return sphere;
  }

  let distance = _.vector.distance( center , pointv );
  if( radius < distance )
  {

    _.assert( distance > 0 );

    // _.vector.mix( center, point, 0.5 + ( -radius ) / ( distance*2 ) );
    // _.sphere.radiusSet( spherev,( distance+radius ) / 2 );
    _.sphere.radiusSet( spherev, distance );

  }

  return sphere;
}

//

/**
  * Checks if a sphere contains a box. Returns True if the sphere contains the box.
  * Sphere and box remain unchanged.
  *
  * @param { Array } sphere - Source sphere.
  * @param { Array } box - Source box
  *
  * @example
  * // returns true
  * _.boxContains( [ 1, 1, 1, 2 ], [ 0, 0, 0, 2, 2, 2 ] );
  *
  * @example
  * // returns false
  * _.boxContains( [ - 2, - 2, - 2, 1 ], [ 0, 0, 0, 1, 1, 1 ] );
  *
  * @returns { Boolean } Returns true if the sphere contains the box, and false if not.
  * @function boxContains
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the sphere and box don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @memberof wTools.sphere
  */

function boxContains( sphere, box )
{

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  let _sphere = _.sphere._from( sphere );
  let center = _.sphere.centerGet( _sphere );
  let radius = _.sphere.radiusGet( _sphere );
  let dimS = _.sphere.dimGet( _sphere );

  let boxVector = _.box._from( box );
  let dimB = _.box.dimGet( boxVector );
  let min = _.box.cornerLeftGet( boxVector );
  let max = _.box.cornerRightGet( boxVector );

  _.assert( dimS === dimB, 'Arguments must have same dimension' );

  /* src corners */

  let c = _.Space.makeZero( [ 3, 8 ] );
  let srcMin = _.vector.toArray( min ); let srcMax = _.vector.toArray( max );
  c.colVectorGet( 0 ).copy( [ srcMin[ 0 ], srcMin[ 1 ], srcMin[ 2 ] ] );
  c.colVectorGet( 1 ).copy( [ srcMax[ 0 ], srcMin[ 1 ], srcMin[ 2 ] ] );
  c.colVectorGet( 2 ).copy( [ srcMin[ 0 ], srcMax[ 1 ], srcMin[ 2 ] ] );
  c.colVectorGet( 3 ).copy( [ srcMin[ 0 ], srcMin[ 1 ], srcMax[ 2 ] ] );
  c.colVectorGet( 4 ).copy( [ srcMax[ 0 ], srcMax[ 1 ], srcMax[ 2 ] ] );
  c.colVectorGet( 5 ).copy( [ srcMin[ 0 ], srcMax[ 1 ], srcMax[ 2 ] ] );
  c.colVectorGet( 6 ).copy( [ srcMax[ 0 ], srcMin[ 1 ], srcMax[ 2 ] ] );
  c.colVectorGet( 7 ).copy( [ srcMax[ 0 ], srcMax[ 1 ], srcMin[ 2 ] ] );

  for( let j = 0 ; j < 8 ; j++ )
  {
    let srcCorner = _.vector.toArray( c.colVectorGet( j ) );

    if( _.sphere.pointContains( _sphere, srcCorner ) === false )
    {
    return false;
    }
  }

  return true;
}

//

/**
  * Checks if a sphere and a box Intersect. Returns True if they intersect.
  * Sphere and box remain unchanged.
  *
  * @param { Array } sphere - Source sphere.
  * @param { Array } box - Source box
  *
  * @example
  * // returns true
  * _.boxIntersects( [ - 1, - 1, - 1, 2 ], [ 0, 0, 0, 2, 2, 2 ] );
  *
  * @example
  * // returns false
  * _.boxIntersects( [ - 2, - 2, - 2, 1 ], [ 0, 0, 0, 1, 1, 1 ] );
  *
  * @returns { Boolean } Returns true if the box and the sphere intersect and false if not.
  * @function boxIntersects
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the sphere and box don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @memberof wTools.sphere
  */

function boxIntersects( sphere, box )
{

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  let _sphere = _.sphere._from( sphere );
  let center = _.sphere.centerGet( _sphere );
  let radius = _.sphere.radiusGet( _sphere );
  let dimS = _.sphere.dimGet( _sphere );

  let boxVector = _.box._from( box );
  let dimB = _.box.dimGet( boxVector );

  _.assert( dimS === dimB, 'Arguments must have same dimension' );

  if( _.box.pointContains( boxVector, center ) === true )
  {
    return true;
  }
  else
  {
    let distance = _.box.pointDistance( boxVector, center );
    if( distance <= radius )
    {
      return true;
    }
  }
  return false;
}

//

/**
  * Gets the closest point in a sphere to a box. Returns the calculated point.
  * Sphere and box remain unchanged.
  *
  * @param { Array } srcSphere - Source sphere.
  * @param { Array } srcBox - Source box.
  * @param { Array } dstPoint - Destination point (optional).
  *
  * @example
  * // returns Math.sqrt( 27 ) - 2
  * _.boxClosestPoint( [ 0, 0, 0, 1 ], [ 2, 0, 0, 4, 0, 0 ] );
  *
  * @returns { Array } Returns the closest point in a sphere to a box.
  * @function boxClosestPoint
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the sphere and box don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @memberof wTools.sphere
  */
function boxClosestPoint( srcSphere, srcBox, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );

  let _sphere = _.sphere._from( srcSphere );
  let center = _.sphere.centerGet( _sphere );
  let radius = _.sphere.radiusGet( _sphere );
  let dimS = _.sphere.dimGet( _sphere );

  let boxVector = _.box._from( srcBox );
  let dimB = _.box.dimGet( boxVector );
  let min = _.box.cornerLeftGet( boxVector );
  let max = _.box.cornerRightGet( boxVector );

  _.assert( dimS === dimB );

  if( arguments.length === 2 )
  dstPoint = [ 0, 0, 0 ];

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  _.assert( dimB === dstPoint.length );
  let dstPointVector = _.vector.from( dstPoint );

  if( _.sphere.boxIntersects( _sphere, boxVector ) )
  return 0;

  let boxPoint = _.box.sphereClosestPoint( boxVector, _sphere );
  let point = _.sphere.pointClosestPoint( _sphere, boxPoint );

  for( let i = 0; i < point.length; i++ )
  {
    dstPointVector.eSet( i, point[ i ] );
  }

  return dstPoint;
}

//

/**
  * Expands a sphere with a box. Returns the expanded sphere.
  * Sphere changes and box remains unchanged.
  *
  * @param { Array } dstSphere - Destination sphere.
  * @param { Array } srcBox - Source box
  *
  * @example
  * // returns [ -1, -1, -1, Math.sqrt( 27 )]
  * _.boxExpand( [ - 1, - 1, - 1, 2 ], [ 0, 0, 0, 2, 2, 2 ] );
  *
  * @returns { Sphere } Returns an array with the center and radius of the expanded sphere.
  * @function boxExpand
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the sphere and box don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @memberof wTools.sphere
  */
function boxExpand( dstSphere, srcBox )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  let _sphere = _.sphere._from( dstSphere );
  let center = _.sphere.centerGet( _sphere );
  let radius = _.sphere.radiusGet( _sphere );
  let dimS = _.sphere.dimGet( _sphere );

  let boxVector = _.box._from( srcBox );
  let dimB = _.box.dimGet( boxVector );
  let min = _.box.cornerLeftGet( boxVector );
  let max = _.box.cornerRightGet( boxVector );

  _.assert( dimS === dimB );

  /* box corners */

  let c = _.Space.makeZero( [ 3, 8 ] );
  min = _.vector.toArray( min ); max = _.vector.toArray( max );
  c.colVectorGet( 0 ).copy( [ min[ 0 ], min[ 1 ], min[ 2 ] ] );
  c.colVectorGet( 1 ).copy( [ max[ 0 ], min[ 1 ], min[ 2 ] ] );
  c.colVectorGet( 2 ).copy( [ min[ 0 ], max[ 1 ], min[ 2 ] ] );
  c.colVectorGet( 3 ).copy( [ min[ 0 ], min[ 1 ], max[ 2 ] ] );
  c.colVectorGet( 4 ).copy( [ max[ 0 ], max[ 1 ], max[ 2 ] ] );
  c.colVectorGet( 5 ).copy( [ min[ 0 ], max[ 1 ], max[ 2 ] ] );
  c.colVectorGet( 6 ).copy( [ max[ 0 ], min[ 1 ], max[ 2 ] ] );
  c.colVectorGet( 7 ).copy( [ max[ 0 ], max[ 1 ], min[ 2 ] ] );

  let distance = radius;
  center = _.vector.toArray( center );
  for( let j = 0 ; j < 8 ; j++ )
  {
    let corner = _.vector.toArray( c.colVectorGet( j ) );
    let d = _.avector.distance( corner, center );
    if( d > distance )
    {
      distance = d;
    }
  }

  _.sphere.radiusSet( _sphere, distance );

  return dstSphere;
}

//

/**
  *Check if the source sphere contains test sphere. Returns true if it is contained, false if not.
  * Spheres are stored in Array data structure and remain unchanged
  *
  * @param { Array } srcSphere - The source sphere (container).
  * @param { Array } tstSphere - The tested sphere (the sphere to check if it is contained in srcSphere).
  *
  * @example
  * // returns true
  * _.sphereContains( [ 0, 0, 0, 2 ], [ 0.5, 0.5, 1, 1 ] );
  *
  * @example
  * // returns false
  * _.sphereContains( [ 0, 0, 0, 2 ], [ 0, 0, 1, 2.5 ] );
  *
  * @returns { Boolean } Returns true if the sphere is contained and false if not.
  * @function sphereContains
  * @throws { Error } An Error if ( dim ) is different than dimGet( sphere ) ( The two spheres don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSphere ) is not sphere
  * @throws { Error } An Error if ( tstSphere ) is not sphere
  * @memberof wTools.sphere
  */

function sphereContains( srcSphere, tstSphere )
{

  let _srcSphere = _.sphere._from( srcSphere );
  let srcCenter = _.sphere.centerGet( _srcSphere );
  let srcRadius = _.sphere.radiusGet( _srcSphere );
  let srcDim = _.sphere.dimGet( _srcSphere );

  let _tstSphere = _.sphere._from( tstSphere );
  let tstCenter = _.sphere.centerGet( _tstSphere );
  let tstRadius = _.sphere.radiusGet( _tstSphere );
  let tstDim = _.sphere.dimGet( _tstSphere );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( srcDim === tstDim );
  debugger;
  // throw _.err( 'not tested' );

  let d = _.sphere.pointDistance( _srcSphere, tstCenter ) + tstRadius;
  if( d <= srcRadius )
  return true;
  else
  return false;
}

//

/**
  * Returns true if the two spheres intersect. Spheres remain unchanged.
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

  let _sphere1 = _.sphere._from( sphere1 );
  let center1 = _.sphere.centerGet( _sphere1 );
  let radius1 = _.sphere.radiusGet( _sphere1 );
  let dim1 = _.sphere.dimGet( _sphere1 );

  let _sphere2 = _.sphere._from( sphere2 );
  let center2 = _.sphere.centerGet( _sphere2 );
  let radius2 = _.sphere.radiusGet( _sphere2 );
  let dim2 = _.sphere.dimGet( _sphere2 );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( dim1 === dim2 );
  debugger;
  // throw _.err( 'not tested' );

  let r = radius1 + radius2;
  return _.vector.distanceSqr( center1,center2 ) <= r*r;
}

//

/**
  * Calculates the distance between two spheres. Returns the distance value, 0 if they intersect.
  * Spheres are stored in Array data structure and remain unchanged.
  *
  * @param { Array } srcSphere - The source sphere.
  * @param { Array } tstSphere - The tested sphere (the sphere to calculate the distance to).
  *
  * @example
  * // returns 0
  * _.sphereDistance( [ 0, 0, 0, 2 ], [ 0.5, 0.5, 1, 1 ] );
  *
  * @example
  * // returns 1
  * _.sphereDistance( [ 0, 0, 0, 2 ], [ 0, 0, 4, 1 ] );
  *
  * @returns { Number } Returns the calculated distance.
  * @function sphereDistance
  * @throws { Error } An Error if ( dim ) is different than dimGet( sphere ) ( The two spheres don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSphere ) is not sphere
  * @throws { Error } An Error if ( tstSphere ) is not sphere
  * @memberof wTools.sphere
  */

function sphereDistance( srcSphere, tstSphere )
{

  let _srcSphere = _.sphere._from( srcSphere );
  let srcCenter = _.sphere.centerGet( _srcSphere );
  let srcRadius = _.sphere.radiusGet( _srcSphere );
  let srcDim = _.sphere.dimGet( _srcSphere );

  let _tstSphere = _.sphere._from( tstSphere );
  let tstCenter = _.sphere.centerGet( _tstSphere );
  let tstRadius = _.sphere.radiusGet( _tstSphere );
  let tstDim = _.sphere.dimGet( _tstSphere );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( srcDim === tstDim );
  debugger;
  // throw _.err( 'not tested' );

  if( _.sphere.sphereIntersects( srcSphere, tstSphere ) )
  return 0;

  let distance = _.vector.distance( srcCenter, tstCenter ) - tstRadius - srcRadius;

  return distance;
}

//

/**
  * Calculates the closest point in a sphere to another sphere. Returns the calculated point.
  * Spheres are stored in Array data structure and remain unchanged.
  *
  * @param { Array } srcSphere - The source sphere.
  * @param { Array } tstSphere - The test sphere.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  * _.sphereClosestPoint( [ 0, 0, 0, 2 ], [ 0.5, 0.5, 1, 1 ] );
  *
  * @example
  * // returns [ 0, 0, 2 ]
  * _.sphereClosestPoint( [ 0, 0, 0, 2 ], [ 0, 0, 4, 1 ] );
  *
  * @returns { Array } Returns the calculated point.
  * @function sphereClosestPoint
  * @throws { Error } An Error if ( dim ) is different than dimGet( sphere ) ( The two spheres don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( tstSphere ) is not sphere.
  * @throws { Error } An Error if ( dstPoint ) is not point.
  * @memberof wTools.sphere
  */

function sphereClosestPoint( srcSphere, tstSphere, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );

  let _srcSphere = _.sphere._from( srcSphere );
  let srcCenter = _.sphere.centerGet( _srcSphere );
  let srcRadius = _.sphere.radiusGet( _srcSphere );
  let srcDim = _.sphere.dimGet( _srcSphere );

  let _tstSphere = _.sphere._from( tstSphere );
  let tstCenter = _.sphere.centerGet( _tstSphere );
  let tstRadius = _.sphere.radiusGet( _tstSphere );
  let tstDim = _.sphere.dimGet( _tstSphere );

  _.assert( srcDim === tstDim );

  debugger;
  // throw _.err( 'not tested' );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( srcDim );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  _.assert( srcDim === dstPoint.length );
  let dstPointv = _.vector.from( dstPoint );

  if( _.sphere.sphereIntersects( srcSphere, tstSphere ) )
  return 0;

  let point = _.sphere.pointClosestPoint( _srcSphere, tstCenter );

  for( let i = 0; i < point.length; i++ )
  {
    dstPointv.eSet( i, point[ i ] );
  }

  return dstPoint;
}

//

/**
  * Expands an sphere with a second sphere. Returns an array with the corrdinates of the expanded sphere
  *
  * @param { Array } sphereDst - Destination sphere.
  * @param { Array } sphereSrc - Source Sphere.
  *
  * @example
  * // returns [ 0, 0, 0, 3 ]
  * _.sphereExpand( [ 0, 0, 0, 2 ], [ 0, 0, 0, 3 ] );
  *
  * @returns { Array } Returns an array with the coordinates of the expanded sphere.
  * @function sphereExpand
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the two spheres have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @memberof wTools.sphere
  */

function sphereExpand( sphereDst, sphereSrc )
{

  let _sphereDst = _.sphere._from( sphereDst );
  let centerDst = _.sphere.centerGet( _sphereDst );
  let radiusDst = _.sphere.radiusGet( _sphereDst );
  let dimDst = _.sphere.dimGet( _sphereDst );

  let _sphereSrc = _.sphere._from( sphereSrc );
  let centerSrc = _.sphere.centerGet( _sphereSrc );
  let radiusSrc = _.sphere.radiusGet( _sphereSrc );
  let dimSrc = _.sphere.dimGet( _sphereSrc );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
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

  let distance = _.vector.distance( centerDst,centerSrc );
  if( radiusDst < distance+radiusSrc )
  {
    //if( distance > 0 )
    //_.vector.mix( centerDst, centerSrc, 0.5 + ( radiusSrc-radiusDst ) / ( distance*2 ) );

    //if( distance > 0 )
    //_.sphere.radiusSet( _sphereDst,( distance+radiusSrc+radiusDst ) / 2 );
    _.sphere.radiusSet( _sphereDst,( distance + radiusSrc ) );
    //else
    //_.sphere.radiusSet( _sphereDst,Math.max( radiusDst,radiusSrc ) );

  }

  return sphereDst;
}

//

/**
  * Returns the closest point in a sphere to a plane.
  * Sphere and plane remain unchanged.
  *
  * @param { Array } sphere - Source sphere
  * @param { Array } plane - Source plane
  * @param { Array } dstPoint - Destination point
  *
  * @example
  * // returns 0
  * _.planeIntersects( [ 0, 0, 0, 2 ], [ 1, 0, 0, 1 ] );
  *
  * @example
  * // returns [ -2, 0, 0 ]
  * _.planeIntersects( [ 0, 0, 0, 2 ], [ 1, 0, 0, 3 ] );
  *
  * @returns { Array } Returns the calculated point.
  * @function planeIntersects
  * @throws { Error } An Error if ( dim ) is different than plane.dimGet (the sphere and the plane don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @memberof wTools.sphere
  */

function planeClosestPoint( sphere, plane, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'expects two or three arguments' );

  let _sphere = _.sphere._from( sphere );
  let center = _.sphere.centerGet( _sphere );
  let radius = _.sphere.radiusGet( _sphere );
  let dim = _.sphere.dimGet( _sphere );

  let _plane = _.plane._from( plane );
  let normal = _.plane.normalGet( _plane );
  let bias = _.plane.biasGet( _plane );
  let dimP = _.plane.dimGet( _plane );

  _.assert( dim === dimP );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( dim );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  _.assert( dim === dstPoint.length );

  let dstPointVector = _.vector.from( dstPoint );

  if( _.plane.sphereIntersects( _plane, _sphere ) )
  return 0;

  debugger;
  // throw _.err( 'not tested' );

  let planePoint = _.plane.pointCoplanarGet( _plane, center.slice() );
  let spherePoint = _.sphere.pointClosestPoint( _sphere, planePoint );

  for ( let i = 0; i < spherePoint.length; i++ )
  {
    dstPointVector.eSet( i, spherePoint[ i ] );
  }

  return dstPoint;
}

//

/**
  * Expands a sphere with a plane equation.
  * Plane remains unchanged.
  *
  * @param { Array } dstSphere - Destination sphere
  * @param { Array } srcPlane - Source plane
  *
  * @example
  * // returns [ 0, 0, 0, 2 ]
  * _.planeExpand( [ 0, 0, 0, 2 ], [ 1, 0, 0, 1 ] );
  *
  * @example
  * // returns [ 0, 0, 0, 3 ]
  * _.planeExpand( [ 0, 0, 0, 2 ], [ 1, 0, 0, 3 ] );
  *
  * @returns { Array } Returns the expanded sphere.
  * @function planeExpand
  * @throws { Error } An Error if ( dim ) is different than plane.dimGet (the sphere and the plane don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @memberof wTools.sphere
  */

function planeExpand( dstSphere, srcPlane )
{
  _.assert( arguments.length === 2 , 'expects two arguments' );

  let _sphere = _.sphere._from( dstSphere );
  let center = _.sphere.centerGet( _sphere );
  let radius = _.sphere.radiusGet( _sphere );
  let dim = _.sphere.dimGet( _sphere );

  let _plane = _.plane._from( srcPlane );
  let normal = _.plane.normalGet( _plane );
  let bias = _.plane.biasGet( _plane );
  let dimP = _.plane.dimGet( _plane );

  _.assert( dim === dimP );

  if( _.plane.sphereIntersects( _plane, _sphere ) )
  return dstSphere;

  debugger;
  // throw _.err( 'not tested' );

  let planePoint = _.plane.pointCoplanarGet( _plane, center.slice() );
  let sphere = _.sphere.pointExpand( _sphere.slice(), planePoint );

  for ( let i = 0; i < sphere.length; i++ )
  {
    _sphere.eSet( i, sphere[ i ] );
  }

  return dstSphere;
}

//

/**
  * Check if a sphere contains a frustum. Returns true if frustum is contained.
  * Frustum and sphere remain unchanged.
  *
  * @param { Sphere } srcSphere - Source sphere.
  * @param { Frustum } tstFrustum - Test frustum.
  *
  * @example
  * // returns false;
  * _.frustumContains( [ 2, 2, 2, 1 ], _.frustum.make() );
  **
  * @returns { Boolean } Returns true if the sphere contains the frustum.
  * @function frustumContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( tstFrustum ) is not frustum.
  * @memberof wTools.sphere
  */

function frustumContains( srcSphere, tstFrustum )
{

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.frustum.is( tstFrustum ) );

  let srcSphereVector = _.sphere._from( srcSphere );
  let center = _.sphere.centerGet( srcSphereVector );
  let radius = _.sphere.radiusGet( srcSphereVector );
  let dimS = _.sphere.dimGet( srcSphereVector );

  let points = _.frustum.cornersGet( tstFrustum );

  for( let i = 0 ; i < points.length ; i += 1 )
  {
    let point = points.colVectorGet( i );
    let c = _.sphere.pointContains( srcSphereVector, point );
    if( c === false )
    return false;
  }

  return true;
}

//

/**
  * Calculates the distance between a sphere and a frustum. Returns the calculated distance.
  * Frustum and sphere remain unchanged.
  *
  * @param { Sphere } srcSphere - Source sphere.
  * @param { Frustum } tstFrustum - Test frustum.
  *
  * @example
  * // returns 1;
  * let frustum = _.Space.make( [ 4, 6 ] ).copy(
  *   [ 0,   0,   0,   0, - 1,   1,
  *     1, - 1,   0,   0,   0,   0,
  *     0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ] );
  * _.frustumDistance( [ 1, 3, 1, 1 ], frustum );
  *
  * @returns { Number } Returns the distance between sphere and frustum.
  * @function frustumDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( tstFrustum ) is not frustum.
  * @memberof wTools.sphere
  */

function frustumDistance( srcSphere, tstFrustum )
{

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.frustum.is( tstFrustum ) );

  let srcSphereVector = _.sphere._from( srcSphere );
  let center = _.sphere.centerGet( srcSphereVector );
  let radius = _.sphere.radiusGet( srcSphereVector );
  let dimS = _.sphere.dimGet( srcSphereVector );

  if( _.frustum.sphereIntersects( tstFrustum, srcSphereVector ) )
  return 0;

  let closestPoint = _.frustum.sphereClosestPoint( tstFrustum, srcSphereVector );
  let distance = _.avector.distance( closestPoint, center ) - radius;

  return distance;
}

//

/**
  * Calculates the closest point in a sphere to a frustum. Returns the calculated point.
  * Frustum and sphere remain unchanged.
  *
  * @param { Sphere } srcSphere - Source sphere.
  * @param { Frustum } tstFrustum - Test frustum.
  * @param { Point } dstPoint - Destination point.
  *
  * @example
  * // returns [ 2, 0, 0 ];
  * let frustum = _.Space.make( [ 4, 6 ] ).copy(
  *   [ 0,   0,   0,   0, - 1,   1,
  *     1, - 1,   0,   0,   0,   0,
  *     0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ] );
  * _.frustumClosestPoint( [ 3, 0, 0, 1 ], frustum );
  *
  * @returns { Array } Returns the closest point to a frustum.
  * @function frustumClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two pr three.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( tstFrustum ) is not frustum.
  * @throws { Error } An Error if ( dstPoint ) is not point.
  * @memberof wTools.sphere
  */

function frustumClosestPoint( srcSphere, tstFrustum, dstPoint )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.frustum.is( tstFrustum ) );

  if( arguments.length === 2 )
  dstPoint = [ 0, 0, 0 ];

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let dstPointVector = _.vector.from( dstPoint );

  let srcSphereVector = _.sphere._from( srcSphere );
  let center = _.sphere.centerGet( srcSphereVector );
  let radius = _.sphere.radiusGet( srcSphereVector );
  let dimS = _.sphere.dimGet( srcSphereVector );

  _.assert( dimS === dstPoint.length );

  if( _.frustum.sphereIntersects( tstFrustum, srcSphereVector ) )
  return 0;

  let fClosestPoint = _.frustum.sphereClosestPoint( tstFrustum, srcSphereVector );
  let sClosestPoint = _.sphere.pointClosestPoint( srcSphereVector, fClosestPoint );

  for( let i = 0; i < sClosestPoint.length; i++ )
  {
    dstPointVector.eSet( i, sClosestPoint[ i ] );
  }

  return dstPoint;
}

//

/**
  * Expands an sphere with a frustum. Returns the expanded sphere.
  * Frustum remains unchanged.
  *
  * @param { Sphere } dstSphere - Destination sphere.
  * @param { Frustum } tstFrustum - Source frustum.
  *
  * @example
  * // returns [ 3, 0, 0, 3.3166247903554 ];
  * let frustum = _.Space.make( [ 4, 6 ] ).copy(
  *   [ 0,   0,   0,   0, - 1,   1,
  *     1, - 1,   0,   0,   0,   0,
  *     0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ] );
  * _.frustumExpand( [ 3, 0, 0, 1 ], frustum );
  *
  * @returns { Array } Returns an array with the expanded sphere dimensions.
  * @function frustumExpand
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( tstFrustum ) is not frustum.
  * @memberof wTools.sphere
  */

function frustumExpand( dstSphere, srcFrustum )
{

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.frustum.is( srcFrustum ) );

  let dstSphereVector = _.sphere._from( dstSphere );
  let center = _.sphere.centerGet( dstSphereVector );
  let radius = _.sphere.radiusGet( dstSphereVector );
  let dimS = _.sphere.dimGet( dstSphereVector );

  if( _.sphere.frustumContains( dstSphereVector, srcFrustum ) )
  return dstSphere;

  let points = _.frustum.cornersGet( srcFrustum );

  for( let i = 0 ; i < points.length ; i += 1 )
  {
    let point = points.colVectorGet( i );
    if( _.sphere.pointContains( dstSphereVector, point ) === false )
    _.sphere.pointExpand( dstSphereVector, point )

  }

  return dstSphere;
}

//

function matrixHomogenousApply( sphere,matrix )
{

  let spherev = _.sphere._from( sphere );
  let center = _.sphere.centerGet( spherev );
  let radius = _.sphere.radiusGet( spherev );
  let dim = _.sphere.dimGet( spherev );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.spaceIs( matrix ) );
  _.assert( dim+1 === matrix.ncol );

  matrix.matrixHomogenousApply( center );
  _.sphere.radiusSet( spherev,radius * matrix.scaleMaxGet() )

  return sphere;
}

//

function translate( sphere,offset )
{

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( _.spaceIs( matrix ) );
  debugger;
  throw _.err( 'not tested' );

  let spherev = _.sphere._from( sphere );
  let center = _.sphere.centerGet( spherev );
  let radius = _.sphere.radiusGet( spherev );
  let dim = _.sphere.dimGet( spherev );

  debugger;

  center.add( offset );

  return sphere;
}

// --
// define class
// --

let Proto =
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
  pointClosestPoint : pointClosestPoint,
  // pointClosestPoint : pointClosestPoint, /* qqq : implement me - Already implemented - to test */
  pointExpand : pointExpand,

  boxContains : boxContains, /* qqq : implement me */
  boxIntersects : boxIntersects,
  // boxDistance : boxDistance, /* qqq : implement me - Same as _.box.sphereDistance */
  boxClosestPoint : boxClosestPoint, /* qqq : implement me */
  boxExpand : boxExpand,

  sphereContains : sphereContains, /* qqq : implement me */
  sphereIntersects : sphereIntersects,
  sphereDistance : sphereDistance, /* qqq : implement me */
  sphereClosestPoint : sphereClosestPoint, /* qqq : implement me */
  sphereExpand : sphereExpand,

  // planeIntersects : planeIntersects, /* qqq : implement me - Same as _.plane.sphereIntersects */
  // planeDistance : planeDistance, /* qqq : implement me - Same as _.plane.sphereDistance */
  planeClosestPoint : planeClosestPoint, /* qqq : implement me */
  planeExpand : planeExpand, /* qqq : implement me */

  frustumContains : frustumContains, /* qqq : implement me */
  // frustumIntersects : frustumIntersects, /* qqq : implement me - Same as _.frustum.sphereIntersects */
  frustumDistance : frustumDistance, /* qqq : implement me */
  frustumClosestPoint : frustumClosestPoint, /* qqq : implement me */
  frustumExpand : frustumExpand, /* qqq : implement me */

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
