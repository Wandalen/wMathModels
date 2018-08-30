(function _Line_s_(){

'use strict';

let _ = _global_.wTools;
let avector = _.avector;
let vector = _.vector;
let Self = _.line = _.line || Object.create( null );

// --
//
// --
//


function make( dim )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = _.line.makeZero( dim );
  if( _.line.is( dim ) )
  _.avector.assign( result,dim );
  return result;
}

//

function makeZero( dim )
{
  if( _.line.is( dim ) )
  dim = _.line.dimGet( dim );
  if( dim === undefined || dim === null )
  dim = 3;
  _.assert( dim >= 0 );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = _.dup( 0,dim*2 );
  return result;
}

//

function makeNil( dim )
{
  if( _.line.is( dim ) )
  dim = _.line.dimGet( dim );
  if( dim === undefined || dim === null )
  dim = 3;

  _.assert( dim >= 0 );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = [];
  for( let i = 0 ; i < dim ; i++ )
  result[ i ] = +Infinity;
  for( let i = 0 ; i < dim ; i++ )
  result[ dim+i ] = -Infinity;

  return result;
}

//

function zero( line )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( _.line.is( line ) )
  {
    let lineView = _.line._from( line );
    lineView.assign( 0 );
    return line;
  }

  return _.line.makeZero( line );
}

//

function nil( line )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( _.line.is( line ) )
  {
    let lineView = _.line._from( line );
    let min = _.line.originGet( lineView );
    let max = _.line.directionGet( lineView );

    _.vector.assign( min, +Infinity );
    _.vector.assign( max, -Infinity );

    return line;
  }

  return _.line.makeNil( line );
}

//

function from( line )
{

  _.assert( _.line.is( line ) || line === null );
  _.assert( arguments.length === 1, 'expects single argument' );

  if( line === null )
  return _.line.make();

  return line;
}

//

function _from( line )
{
  _.assert( _.line.is( line ) );
  _.assert( arguments.length === 1, 'expects single argument' );
  return _.vector.from( line );
}

//

/**
  * Get a line out of two points. Returns a vector with the coordinates of the line.
  * The pair of points stays untouched.
  *
  * @param { Array } pair - The source points.
  *
  * @example
  * // returns  [ 1, 2, 1, 2 ]
  * _.fromPair( [ 1, 2 ], [ 3, 4 ] );
  *
  * @returns { Vector } Returns the line containing the two points.
  * @function fromPair
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( pair ) is not array.
  * @memberof wTools.line
  */
function fromPair( pair )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( pair.length === 2, 'expects two points' );
  _.assert( pair[ 0 ].length === pair[ 1 ].length, 'expects two points' );

  let result = _.array.makeArrayOfLength( pair[ 0 ].length * 2 );

  for( let i = 0; i < pair[ 0 ].length ; i++ )
  {
    result[ i ] = pair[ 0 ][ i ];
    result[ pair[ 0 ].length + i ] = avector.sub( null, pair[ 1 ], pair[ 0 ] )[ i ];
  }

  debugger;
  return result;
}

fromPair.shaderChunk =
`
  void line_fromPair( out vec2 dstLine[ 2 ], vec2 pair[ 2 ] )
  {
    dstLine[ 0 ] = pair[ 0 ];
    dstLine[ 1 ] = pair[ 1 ] - pair[ 0 ];
  }

  void line_fromPair( out vec3 dstLine[ 2 ], vec3 pair[ 2 ] )
  {
    dstLine[ 0 ] = pair[ 0 ];
    dstLine[ 1 ] = pair[ 1 ] - pair[ 0 ];
  }
`

//

/**
  * Check if input is a line. Returns true if it is a line and false if not.
  *
  * @param { Vector } line - Source line.
  *
  * @example
  * // returns true;
  * _.is( [ 0, 0, 1, 1 ] );
  *
  * @returns { Boolean } Returns true if the input is line.
  * @function is
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @memberof wTools.line
  */
function is( line )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  return ( _.longIs( line ) || _.vectorIs( line ) ) && ( line.length >= 0 ) && ( line.length % 2 === 0 );
}

//

/**
  * Get line dimension. Returns the dimension of the line. Line stays untouched.
  *
  * @param { Vector } line - The source line.
  *
  * @example
  * // returns 2
  * _.dimGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns 1
  * _.dimGet( [ 0, 1 ] );
  *
  * @returns { Number } Returns the dimension of the line.
  * @function dimGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( line ) is not line.
  * @memberof wTools.line
  */
function dimGet( line )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( _.line.is( line ) );
  return line.length / 2;
}

//

/**
  * Get the origin of a line. Returns a vector with the coordinates of the origin of the line.
  * Line stays untouched.
  *
  * @param { Vector } line - The source line.
  *
  * @example
  * // returns   0, 0
  * _.originGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns  1
  * _.originGet( [ 1, 2 ] );
  *
  * @returns { Vector } Returns the coordinates of the origin of the line.
  * @function originGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( line ) is not line.
  * @memberof wTools.line
  */
function originGet( line )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  let lineView = _.line._from( line );
  return lineView.subarray( 0, line.length/ 2 );
}

//

/**
  * Get the direction of a line. Returns a vector with the coordinates of the direction of the line.
  * Line stays untouched.
  *
  * @param { Vector } line - The source line.
  *
  * @example
  * // returns   2, 2
  * _.directionGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns  2
  * _.directionGet( [ 1, 2 ] );
  *
  * @returns { Vector } Returns the direction of the line.
  * @function directionGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( line ) is not line.
  * @memberof wTools.line
  */
function directionGet( line )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  let lineView = _.line._from( line );
  return lineView.subarray( line.length/ 2, line.length );
}

//

/**
  * Get a point in a line. Returns a vector with the coordinates of the point of the line.
  * Line and factor stay untouched.
  *
  * @param { Vector } srcLine - The source line.
  * @param { Vector } factor - The source factor.
  *
  * @example
  * // returns   4, 4
  * _.lineAt( [ 0, 0, 2, 2 ], 2 );
  *
  * @example
  * // returns  1
  * _.lineAt( [ 1, 2 ], 0 );
  *
  * @returns { Vector } Returns a point in the line at a given factor.
  * @function lineAt
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( factor ) is not number.
  * @memberof wTools.line
  */
function lineAt( srcLine, factor )
{

  _.assert( arguments.length === 2, 'expects single argument' );
  _.assert( _.line.is( srcLine ) );
  _.assert( _.numberIs( factor ) );

  let lineView = _.line._from( srcLine )
  let origin = _.line.originGet( lineView );
  let direction = _.line.directionGet( lineView );

  let result = avector.mul( null, direction, factor );
  result = avector.add( result, origin );

  return result;
}

lineAt.shaderChunk =
`
  vec2 lineAt( vec2 srcLine[ 2 ], float factor )
  {

    vec2 result = srcLine[ 1 ]*factor;
    result += srcLine[ 0 ];

    return result;
  }
`

//

/**
* Get the factor of a point inside a line. Returs the calculated factor. Point and line stay untouched.
*
* @param { Array } srcLine - The source line.
* @param { Array } srcPoint - The source point.
*
* @example
* // returns 0.5
* _.getFactor( [ 0, 0, 2, 2 ], [ 1, 1 ] );
*
* @example
* // returns false
* _.getFactor( [ 0, 0, 2, 2 ], [ - 1, 3 ] );
*
* @returns { Number } Returns the factor if the point is inside the line, and false if the point is outside it.
* @function getFactor
* @throws { Error } An Error if ( dim ) is different than point.length (line and point have not the same dimension).
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( srcLine ) is not line.
* @throws { Error } An Error if ( srcPoint ) is not point.
* @memberof wTools.line
*/
function getFactor( srcLine, srcPoint )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  if( srcLine === null )
  srcLine = _.line.make( srcPoint.length );

  let srcLineView = _.line._from( srcLine );
  let origin = _.line.originGet( srcLineView );
  let direction = _.line.directionGet( srcLineView );
  let dimension  = _.line.dimGet( srcLineView )
  let srcPointView = _.vector.from( srcPoint.slice() );

  _.assert( dimension === srcPoint.length, 'The line and the point must have the same dimension' );
  let dOrigin = _.vector.from( avector.subVectors( srcPointView, origin ) );

  let factor;
  if( direction.eGet( 0 ) === 0 )
  {
    if( Math.abs( dOrigin.eGet( 0 ) ) > _.accuracySqr )
    {
      return false;
    }
    else
    {
      factor = 0;
    }
  }
  else
  {
    factor = dOrigin.eGet( 0 ) / direction.eGet( 0 );
  }

  for( var i = 1; i < dOrigin.length; i++ )
  {
    let newFactor;
    if( direction.eGet( i ) === 0 )
    {
      if( Math.abs( dOrigin.eGet( i ) ) > _.accuracySqr )
      {
        return false;
      }
      else
      {
        newFactor = 0;
      }
    }
    else
    {
      newFactor = dOrigin.eGet( i ) / direction.eGet( i );
      if( Math.abs( newFactor - factor ) > _.accuracySqr && newFactor !== 0 && factor !== 0 )
      {
        return false;
      }
      factor = newFactor;
    }
  }

  return factor;
}

//

/**
  * Check if two lines are parallel. Returns true if they are parallel and false if not.
  * Lines and accuracySqr stay untouched. Only for 3D.
  *
  * @param { Vector } src1Line - The first source line.
  * @param { Vector } src2Line - The second source line.
  * @param { Vector } accuracySqr - The accuracy.
  *
  * @example
  * // returns   true
  * _.lineParallel( [ 0, 0, 0, 2, 2, 2 ], [ 1, 2, 1, 4, 4, 4 ] );
  *
  * @example
  * // returns  false
  * _.lineParallel( [ 1, 2, 1, 1, 1, 2 ], [ 1, 2, 1, 1, 3, 3 ] );
  *
  * @returns { Boolean } Returns true if the lines are parallel.
  * @function lineParallel
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( src1Line ) is not line.
  * @throws { Error } An Error if ( src2Line ) is not line.
  * @throws { Error } An Error if ( accuracySqr ) is not number.
  * @memberof wTools.line
  */
function lineParallel3D( src1Line, src2Line, accuracySqr )
{
  // _.assert( src1Line.length === 3 );
  // _.assert( src2Line.length === 3 );
  // _.assert( arguments.length === 2 || arguments.length === 3 );

  // if( accuracySqr === undefined )
  // accuracySqr = Self.accuracySqr;

  // return _magSqr( avector.cross( src1Line[ 1 ], src2Line[ 1 ] ) ) <= Self.accuracySqr;

  _.assert( _.line.is( src1Line ) );
  _.assert( _.line.is( src2Line ) );
  _.assert( arguments.length === 2 || arguments.length === 3 );

  if( arguments.length === 2 || accuracySqr === undefined || accuracySqr === null )
  accuracySqr = _.accuracySqr;;

  let direction1 = _.line.directionGet( src1Line );
  let direction2 = _.line.directionGet( src2Line );

  debugger;
  return avector.magSqr( avector.cross( null, direction1, direction2 )) <= accuracySqr;

}

//

function lineParallel( src1Line, src2Line, accuracySqr )
{
  // _.assert( src1Line.length === 3 );
  // _.assert( src2Line.length === 3 );
  // _.assert( arguments.length === 2 || arguments.length === 3 );

  // if( accuracySqr === undefined )
  // accuracySqr = Self.accuracySqr;

  // return _magSqr( avector.cross( src1Line[ 1 ], src2Line[ 1 ] ) ) <= Self.accuracySqr;

  _.assert( _.line.is( src1Line ) );
  _.assert( _.line.is( src2Line ) );
  _.assert( arguments.length === 2 || arguments.length === 3 );
  _.assert( src1Line.length === src2Line.length );

  if( arguments.length === 2 || accuracySqr === undefined || accuracySqr === null )
  accuracySqr = _.accuracySqr;;

  let direction1 = _.line.directionGet( src1Line );
  let direction2 = _.line.directionGet( src2Line );
  let proportion = undefined;

  let zeros1 = 0;                               // Check if Line1 is a point
  for( let i = 0; i < direction1.length ; i++  )
  {
    if( direction1.eGet( i ) === 0 )
    {
      zeros1 = zeros1 + 1;
    }
    if( zeros1 === direction1.length )
    return true;
  }

  let zeros2 = 0;                               // Check if Line2 is a point
  for( let i = 0; i < direction2.length ; i++  )
  {
    if( direction2.eGet( i ) === 0 )
    {
      zeros2 = zeros2 + 1;
    }
    if( zeros2 === direction2.length )
    return true;
  }

  debugger;

  for( let i = 0; i < direction1.length ; i++  )
  {
    if( direction1.eGet( i ) === 0 || direction2.eGet( i ) === 0 )
    {
      if( direction1.eGet( i ) !== direction2.eGet( i ) )
      {
        return false;
      }
    }
    else
    {
      let newProportion = direction1.eGet( i ) / direction2.eGet( i );

      if( proportion !== undefined )
      {
        if( Math.abs( proportion - newProportion ) > accuracySqr)
        return false
      }

      proportion = newProportion;
    }
  }

  return true;
}

//

/**
  * Returns the factors for the intersection of two lines. Returns a vector with the intersection factors, 0 if there is no intersection.
  * Lines stay untouched.
  *
  * @param { Vector } src1Line - The first source line.
  * @param { Vector } src2Line - The second source line.
  *
  * @example
  * // returns   0
  * _.lineIntersectionFactors( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  _.vector.from( [ 2, 1 ] )
  * _.lineIntersectionFactors( [ - 2, 0, 1, 0 ], [ 0, - 2, 0, 2 ] );
  *
  * @returns { Array } Returns the factors for the two lines intersection.
  * @function lineIntersectionFactors
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Line ) is not line.
  * @throws { Error } An Error if ( src2Line ) is not line.
  * @memberof wTools.line
  */
function lineIntersectionFactors( r1, r2 )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( r1.length === r2.length,'The two lines must have the same dimension' );

  let r1View = _.line._from( r1.slice() );
  let r2View = _.line._from( r2.slice() );

  let origin1 = _.line.originGet( r1View );
  let origin2 = _.line.originGet( r2View );
  let dOrigin = _.vector.from( avector.subVectors( origin2, origin1 ) );

  let direction1 = _.line.directionGet( r1View );
  let direction2 = _.line.directionGet( r2View );
  let directions = _.Space.make( [ r1.length / 2 , 2 ] );
  directions.colVectorGet( 0 ).copy( direction1 );
  directions.colVectorGet( 1 ).copy( direction2.mulScalar( - 1 ) );

  // Same origin
  let identOrigin = 0;
  for( let i = 0; i < origin1.length; i++ )
  {
    if( origin1.eGet( i ) === origin2.eGet( i ) )
    identOrigin = identOrigin + 1;
  }
  if( identOrigin === origin1.length )
  return _.vector.from( [ 0, 0 ] );

  // Parallel lines
  if( lineParallel( r1, r2 ) === true )
  return 0;

  let result = _.vector.from( [ 0, 0 ] );

  debugger;

  for( let i = 0; i < dOrigin.length - 1 ; i++ )
  {
    logger.log( i )
    let m = _.Space.make( [ 2, 2 ] );
    m.rowSet( 0, directions.rowVectorGet( i ) );
    m.rowSet( 1, directions.rowVectorGet( i + 1 ) );

    let or = _.Space.makeCol( [ dOrigin.eGet( i ), dOrigin.eGet( i + 1 ) ] );

    let o =
    {
      x : null,
      m : m,
      y : or,
      kernel : null,
      pivoting : 1,
    }

    let x = _.Space.solveGeneral( o );
    if( i === 0 )
    {
      result = _.vector.from( x.base )
      logger.log( 'result', result.slice())
    }
    else
    {
      let x1 = x.base.colVectorGet( 0 ).eGet( 0 );
      let x2 = x.base.colVectorGet( 0 ).eGet( 1 );
      logger.log( 'result', result.slice())
      logger.log( 'NEW result', x1, x2 )
      let samex1 = Math.abs( x1 - result.eGet( 0 ) ) < 1E-6 || Math.abs( x1 - result.eGet( 1 ) ) < 1E-6 ;
      let samex2 = Math.abs( x2 - result.eGet( 0 ) ) < 1E-6 || Math.abs( x2 - result.eGet( 1 ) ) < 1E-6 ;

      if( x1 !== 0 )
      {
        if( samex1 )
        {
          result.eSet( 0, _.vector.from( x.base ).eGet( 0 ) );
        }
        else if ( ( result.eGet( 0 ) === 0 || result.eGet( 1 ) === 0 ) && samex2 )
        {
          result.eSet( 0, _.vector.from( x.base ).eGet( 0 ) );
        }
        else
        {
          return 0;
        }
      }
      if( x2 !== 0 )
      {
        if( samex2 )
        {
          result.eSet( 0, _.vector.from( x.base ).eGet( 0 ) );
        }
        else if ( ( result.eGet( 0 ) === 0 || result.eGet( 1 ) === 0 ) && samex1 )
        {
          result.eSet( 1, _.vector.from( x.base ).eGet( 1 ) );
        }
        else
        {
          return 0;
        }
      }

    }
  }

  return result;
}

//

function lineIntersectionFactors2( r1, r2 )
{
  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( r1.length === r2.length,'The two lines must have the same dimension' );

  let r1View = _.line._from( r1 );
  let origin1 = _.line.originGet( r1View );
  let direction1 = _.line.directionGet( r1View );
  let r2View = _.line._from( r2 );
  let origin2 = _.line.originGet( r2View );
  let direction2 = _.line.directionGet( r2View );

  // Same origin
  let identOrigin = 0;
  for( let i = 0; i < origin1.length; i++ )
  {
    if( origin1.eGet( i ) === origin2.eGet( i ) )
    identOrigin = identOrigin + 1;
  }
  if( identOrigin === origin1.length )
  return [ 0, 0 ];

  // Parallel lines
  if( lineParallel( r1, r2 ) === true )
  return 0;

  let x = [];
  let origin1x = origin1.eGet( 0 ); let origin1y = origin1.eGet( 1 );
  let dir1x = direction1.eGet( 0 ); let dir1y = direction1.eGet( 1 );
  let origin2x = origin2.eGet( 0 ); let origin2y = origin2.eGet( 1 );
  let dir2x = direction2.eGet( 0 ); let dir2y = direction2.eGet( 1 );
  x[ 1 ] = ( dir1x*( origin2y - origin1y ) + dir1y*( origin1x -origin2x ) ) / ( dir2x*dir1y - dir2y*dir1x );
  let w = 1;
  while( isNaN( x[ 1 ] ) && w < origin1.length - 1 )
  {
    let origin1y = origin1.eGet( w + 1 ); let dir1y = direction1.eGet( w + 1 );
    let origin2y = origin1.eGet( w + 1 ); let dir2y = direction1.eGet( w + 1 );
    x[ 1 ] = ( dir1x*( origin2y - origin1y ) + dir1y*( origin1x -origin2x ) ) / ( dir2x*dir1y - dir2y*dir1x );
    w = w + 1;
  }

  x[ 0 ] = ( origin2x + dir2x*x[ 1 ] - origin1x )/ dir1x;

  if(  x[ 0 ] === Infinity || x[ 1 ] === Infinity )
  return 0;
  if(  !_.numberIs( x[ 0 ] ) || isNaN( x[ 0 ] ) || !_.numberIs( x[ 1 ] ) || isNaN( x[ 1 ] ) )
  return 0;

  // Check other dimensions in line coincide with the calculated factor
  for( let i = 0; i < origin1.length; i++ )
  {
    let point1 = origin1.eGet( i ) + direction1.eGet( i )*x[ 0 ];
    let point2 = origin2.eGet( i ) + direction2.eGet( i )*x[ 1 ];
    if( Math.abs( point1 - point2 ) > 1E-7 )
    return 0;
  }

  return x;
}

lineIntersectionFactors.shaderChunk =
`
  vec2 lineIntersectionFactors( vec2 r1[ 2 ], vec2 r2[ 2 ] )
  {

    vec2 dorigin = r2[ 0 ] - r1[ 0 ];

    vec2 y;
    y[ 0 ] = + dorigin[ 0 ];
    y[ 1 ] = - dorigin[ 1 ];

    mat2 m;
    m[ 0 ][ 0 ] = + r1[ 1 ][ 0 ];
    m[ 1 ][ 0 ] = - r1[ 1 ][ 1 ];
    m[ 0 ][ 1 ] = - r2[ 1 ][ 0 ];
    m[ 1 ][ 1 ] = + r2[ 1 ][ 1 ];

    vec2 x = d2linearEquationSolve( m,y );
    return x;

  }
`

//

/**
  * Returns the points of the intersection of two lines. Returns an array with the intersection points, 0 if there is no intersection.
  * Lines stay untouched.
  *
  * @param { Vector } src1Line - The first source line.
  * @param { Vector } src2Line - The second source line.
  *
  * @example
  * // returns   0
  * _.lineIntersectionPoints( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  [ [ 0, 0 ], [ 0, 0 ] ]
  * _.lineIntersectionPoints( [ -3, 0, 1, 0 ], [ 0, -2, 0, 1 ] );
  *
  * @returns { Array } Returns the points of intersection of the two lines.
  * @function lineIntersectionPoints
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Line ) is not line.
  * @throws { Error } An Error if ( src2Line ) is not line.
  * @memberof wTools.line
  */
function lineIntersectionPoints( r1,r2 )
{
  let factors = lineIntersectionFactors2( r1,r2 );
  if( factors === 0 )
  return 0;

  let factorsView = _.vector.from( factors );
  let result = [ Self.lineAt( r1, factorsView.eGet( 0 ) ), Self.lineAt( r2, factorsView.eGet( 1 ) ) ];
  return result;
}

lineIntersectionPoints.shaderChunk =
`
  void lineIntersectionPoints( out vec2 result[ 2 ], vec2 r1[ 2 ], vec2 r2[ 2 ] )
  {

    vec2 factors = lineIntersectionFactors( r1,r2 );
    result[ 0 ] = lineAt( r1,factors[ 0 ] );
    result[ 1 ] = lineAt( r2,factors[ 1 ] );

  }
`

//

/**
  * Returns the point of the intersection of two lines. Returns an array with the intersection point, 0 if there is no intersection.
  * Lines stay untouched.
  *
  * @param { Vector } src1Line - The first source line.
  * @param { Vector } src2Line - The second source line.
  *
  * @example
  * // returns   0
  * _.lineIntersectionPoint( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  [ [ 0, 0 ], [ 0, 0 ] ]
  * _.lineIntersectionPoint( [ -3, 0, 1, 0 ], [ 0, -2, 0, 1 ] );
  *
  * @returns { Array } Returns the point of intersection of the two lines.
  * @function lineIntersectionPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Line ) is not line.
  * @throws { Error } An Error if ( src2Line ) is not line.
  * @memberof wTools.line
  */
function lineIntersectionPoint( r1,r2 )
{

  let factors = Self.lineIntersectionFactors( r1,r2 );

  if( factors === 0 )
  return 0;

  return Self.lineAt( r1,factors.eGet( 0 ) );

}

lineIntersectionPoint.shaderChunk =
`
  vec2 lineIntersectionPoint( vec2 r1[ 2 ], vec2 r2[ 2 ] )
  {

    vec2 factors = lineIntersectionFactors( r1,r2 );
    return lineAt( r1,factors[ 0 ] );

  }
`

//

/**
  * Returns the point of the intersection of two lines. Returns an array with the intersection point, 0 if there is no intersection.
  * Lines stay untouched. Only for 2D.
  *
  * @param { Vector } src1Line - The first source line.
  * @param { Vector } src2Line - The second source line.
  *
  * @example
  * // returns   0
  * _.lineIntersectionPointAccurate( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  [ [ 0, 0 ], [ 0, 0 ] ]
  * _.lineIntersectionPointAccurate( [ -3, 0, 1, 0 ], [ 0, -2, 0, 1 ] );
  *
  * @returns { Array } Returns the point of intersection of the two lines.
  * @function lineIntersectionPointAccurate
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Line ) is not line.
  * @throws { Error } An Error if ( src2Line ) is not line.
  * @memberof wTools.line
  */
function lineIntersectionPointAccurate( r1,r2 )
{

  let closestPoints = Self.lineIntersectionPoints( r1,r2 );
  debugger;

  if( closestPoints === 0)
  return 0;

  return _.avector.mulScalar( _.avector.add( null, closestPoints[ 0 ], closestPoints[ 1 ] ), 0.5 );

}

lineIntersectionPointAccurate.shaderChunk =
`
  vec2 lineIntersectionPointAccurate( vec2 r1[ 2 ], vec2 r2[ 2 ] )
  {

    vec2 closestPoints[ 2 ];
    lineIntersectionPoints( closestPoints,r1,r2 );
    return ( closestPoints[ 0 ] + closestPoints[ 1 ] ) * 0.5;

  }
`




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

  from : from,
  _from : _from,
  fromPair : fromPair, // fromPoints : fromPoints,

  is : is,
  dimGet : dimGet,
  originGet : originGet,
  directionGet : directionGet,

  lineAt : lineAt,
  getFactor : getFactor,

  lineParallel3D : lineParallel3D,
  lineParallel : lineParallel,
  lineIntersectionFactors : lineIntersectionFactors,
  lineIntersectionFactors2 : lineIntersectionFactors2,
  lineIntersectionPoints : lineIntersectionPoints,
  lineIntersectionPoint : lineIntersectionPoint,
  lineIntersectionPointAccurate : lineIntersectionPointAccurate,


}

_.mapSupplement( Self, Proto );

//

if( typeof module !== 'undefined' )
{

  require( './Sphere.s' );

}

})();
