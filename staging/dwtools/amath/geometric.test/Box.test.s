( function _Box_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      toolsPath = require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }


  var _ = _global_.wTools;

  _.include( 'wTesting' );
  _.include( 'wMathVector' );

  require( '../geometric/Box.s' );
  require( '../geometric/Sphere.s' );

}

//

var _ = _global_.wTools.withArray.Float32;
var Space = _.Space;
var vector = _.vector;
var vec = _.vector.fromArray;
var avector = _.avector;
var sqrt = _.sqrt;
var Parent = _.Tester;

_.assert( sqrt );

// --
// test
// --

function is( test )
{

  test.description = 'array'; /* */

  test.is( _.box.is( [] ) );
  test.is( _.box.is([ 0,0 ]) );
  test.is( _.box.is([ 1,2,3,4 ]) );
  test.is( _.box.is([ 0,0,0,0,0,0 ]) );

  test.description = 'vector'; /* */

  test.is( _.box.is( _.vector.fromArray([]) ) );
  test.is( _.box.is( _.vector.fromArray([ 0,0 ]) ) );
  test.is( _.box.is( _.vector.fromArray([ 1,2,3,4 ]) ) );
  test.is( _.box.is( _.vector.fromArray([ 0,0,0,0,0,0 ]) ) );

  test.description = 'not box'; /* */

  test.is( !_.box.is([ 0 ]) );
  test.is( !_.box.is([ 0,0,0 ]) );

  test.is( !_.box.is( _.vector.fromArray([ 0 ]) ) );
  test.is( !_.box.is( _.vector.fromArray([ 0,0,0 ]) ) );

  test.is( !_.box.is( 'abc' ) );
  test.is( !_.box.is( { center : [ 0,0,0 ], radius : 1 } ) );
  test.is( !_.box.is( function( a,b,c ){} ) );

}

//

function isEmpty( test )
{

  test.description = 'empty'; /* */

  test.is( _.box.isEmpty([]) );
  test.is( _.box.isEmpty([ 0,0 ]) );
  test.is( _.box.isEmpty([ 0,0,0,0,0,0 ]) );
  test.is( _.box.isEmpty([ 1,1 ]) );
  test.is( _.box.isEmpty([ 5,0,5,0 ]) );
  test.is( _.box.isEmpty([ -3,0,5,-3,0,5 ]) );

  test.is( _.box.isEmpty([ 0,0,0,1 ]) );
  test.is( _.box.isEmpty([ 0,-1 ]) );
  test.is( _.box.isEmpty([ 0,0,0,-1 ]) );
  test.is( _.box.isEmpty([ 0,0,5,0 ]) );

  test.is( _.box.isEmpty([ 0,-Infinity ]) );
  test.is( _.box.isEmpty([ +Infinity,+Infinity,+Infinity,-Infinity,-Infinity,-Infinity ]) );
  test.is( _.box.isEmpty([ 0,0,0,Infinity ]) );

  test.is( _.box.isEmpty([ 0.1,-Infinity ]) );
  test.is( _.box.isEmpty([ 0,0,0.1,-Infinity ]) );

  test.description = 'not empty'; /* */

  test.is( !_.box.isEmpty([ 0,1 ]) );

  test.is( !_.box.isEmpty([ 0,+Infinity ]) );
  test.is( !_.box.isEmpty([ -Infinity,0,0,+Infinity ]) );

  test.is( !_.box.isEmpty([ 0.1,+Infinity ]) );
  test.is( !_.box.isEmpty([ 0,0.00001,0.1,+Infinity ]) );

}

//

function isZero( test )
{

  test.description = 'zero'; /* */

  test.is( _.box.isZero([]) );
  test.is( _.box.isZero([ 0,0 ]) );
  test.is( _.box.isZero([ 0,0,0,0,0,0 ]) );
  test.is( _.box.isZero([ 1,1 ]) );
  test.is( _.box.isZero([ 5,0,5,0 ]) );
  test.is( _.box.isZero([ -3,0,5,-3,0,5 ]) );

  test.description = 'not zero'; /* */

  test.is( !_.box.isZero([ 0,1 ]) );
  test.is( !_.box.isZero([ 0,0,0,1 ]) );

  test.is( !_.box.isZero([ 0,-1 ]) );
  test.is( !_.box.isZero([ 0,0,0,-1 ]) );
  test.is( !_.box.isZero([ 0,0,5,0 ]) );

  test.is( !_.box.isZero([ 0,-Infinity ]) );
  test.is( !_.box.isZero([ +Infinity,+Infinity,+Infinity,-Infinity,-Infinity,-Infinity ]) );

  test.is( !_.box.isZero([ 0,Infinity ]) );
  test.is( !_.box.isZero([ 0,0,0,Infinity ]) );

  test.is( !_.box.isZero([ 0.1,-Infinity ]) );
  test.is( !_.box.isZero([ 0,0,0.1,-Infinity ]) );

}

//

function isNil( test )
{

  test.description = 'nil'; /* */

  test.is( _.box.isNil([ +Infinity,+Infinity,-Infinity,-Infinity ]) );
  test.is( _.box.isNil([ +Infinity,+Infinity,+Infinity,-Infinity,-Infinity,-Infinity ]) );

  test.is( _.box.isNil([ +1,+1,-2,-5 ]) );
  test.is( _.box.isNil([ +1,+1,+1,-2,-3,-4 ]) );

  test.description = 'not nil'; /* */

  test.is( !_.box.isNil([ 0,Infinity ]) );
  test.is( !_.box.isNil([ 0,0,0,Infinity ]) );

  test.is( !_.box.isNil([ Infinity,Infinity ]) );
  test.is( !_.box.isNil([ 0,0,0.1,Infinity ]) );

}

//

function make( test )
{

  test.description = 'src undefined'; /* */

  var src = undefined;
  var got = _.box.make( src );
  var expected = [ 0,0,0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src null'; /* */

  var src = null;
  var got = _.box.make( src );
  var expected = [ 0,0,0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src 2'; /* */

  var src = 2;
  var got = _.box.make( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src array'; /* */

  var src = [ 0,1,2,3 ];
  var got = _.box.make( src );
  var expected = [ 0,1,2,3 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src vector'; /* */

  var src = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.box.make( src );
  var expected = [ 0,1,2,3 ];
  test.identical( got,expected );
  test.is( got !== src );

}

//

function makeZero( test )
{

  test.description = 'src undefined'; /* */

  var src = undefined;
  var got = _.box.makeZero( src );
  var expected = [ 0,0,0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src null'; /* */

  var src = null;
  var got = _.box.makeZero( src );
  var expected = [ 0,0,0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src 2'; /* */

  var src = 2;
  var got = _.box.makeZero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src array'; /* */

  var src = [ 0,1,2,3 ];
  var got = _.box.makeZero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src vector'; /* */

  var src = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.box.makeZero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

}

//

function makeNil( test )
{

  test.description = 'src undefined'; /* */

  var src = undefined;
  var got = _.box.makeNil( src );
  var expected = [ +Infinity,+Infinity,+Infinity,-Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src null'; /* */

  var src = null;
  var got = _.box.makeNil( src );
  var expected = [ +Infinity,+Infinity,+Infinity,-Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src 2'; /* */

  var src = 2;
  var got = _.box.makeNil( src );
  var expected = [ +Infinity,+Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src array'; /* */

  var src = [ 0,1,2,3 ];
  var got = _.box.makeNil( src );
  var expected = [ +Infinity,+Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src vector'; /* */

  var src = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.box.makeNil( src );
  var expected = [ +Infinity,+Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

}

//

function zero( test )
{

  test.description = 'src undefined'; /* */

  var src = undefined;
  var got = _.box.zero( src );
  var expected = [ 0,0,0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src null'; /* */

  var src = null;
  var got = _.box.zero( src );
  var expected = [ 0,0,0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src 2'; /* */

  var src = 2;
  var got = _.box.zero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'dst array'; /* */

  var dst = [ 0,1,2,3 ];
  var got = _.box.zero( dst );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got === dst );

  test.description = 'dst vector'; /* */

  var dst = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.box.zero( dst );
  var expected = _.vector.fromArray([ 0,0,0,0 ]);
  test.identical( got,expected );
  test.is( got === dst );

  test.description = 'dst array 1d'; /* */

  var dst = [ 0,1 ];
  var got = _.box.zero( dst );
  var expected = [ 0,0 ];
  test.identical( got,expected );
  test.is( got === dst );

}

//

function nil( test )
{

  test.description = 'src undefined'; /* */

  var src = undefined;
  var got = _.box.nil( src );
  var expected = [ +Infinity,+Infinity,+Infinity,-Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src null'; /* */

  var src = null;
  var got = _.box.nil( src );
  var expected = [ +Infinity,+Infinity,+Infinity,-Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src 2'; /* */

  var src = 2;
  var got = _.box.nil( src );
  var expected = [ +Infinity,+Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'dst array'; /* */

  var dst = [ 0,1,2,3 ];
  var got = _.box.nil( dst );
  var expected = [ +Infinity,+Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got === dst );

  test.description = 'dst vector'; /* */

  var dst = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.box.nil( dst );
  var expected = _.vector.fromArray([ +Infinity,+Infinity,-Infinity,-Infinity ]);
  test.identical( got,expected );
  test.is( got === dst );

  test.description = 'dst array 2d'; /* */

  var dst = [ 1,3 ];
  var got = _.box.nil( dst );
  var expected = [ +Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got === dst );

}

//

function centeredOfSize( test )
{

  test.description = 'src undefined'; /* */

  var src = undefined;
  var got = _.box.centeredOfSize( src,2 );
  var expected = [ -1,-1,-1,+1,+1,+1 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src null'; /* */

  var src = null;
  var got = _.box.centeredOfSize( src,2 );
  var expected = [ -1,-1,-1,+1,+1,+1 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src 2'; /* */

  var src = 2;
  var got = _.box.centeredOfSize( src,2 );
  var expected = [ -1,-1,+1,+1 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'dst array'; /* */

  var dst = [ 0,1,2,3 ];
  var got = _.box.centeredOfSize( dst,2 );
  var expected = [ -1,-1,+1,+1 ];
  test.identical( got,expected );
  test.is( got === dst );

  test.description = 'dst vector'; /* */

  var dst = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.box.centeredOfSize( dst,2 );
  var expected = _.vector.fromArray([ -1,-1,+1,+1 ]);
  test.identical( got,expected );
  test.is( got === dst );

  test.description = 'dst array 2d'; /* */

  var dst = [ 1,3 ];
  var got = _.box.centeredOfSize( dst,2 );
  var expected = [ -1,+1 ];
  test.identical( got,expected );
  test.is( got === dst );

  /* */

  test.description = 'src undefined, implicit size'; /* */

  var src = undefined;
  var got = _.box.centeredOfSize( src );
  var expected = [ -0.5,-0.5,-0.5,+0.5,+0.5,+0.5 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src null, implicit size'; /* */

  var src = null;
  var got = _.box.centeredOfSize( src );
  var expected = [ -0.5,-0.5,-0.5,+0.5,+0.5,+0.5 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src 2, implicit size'; /* */

  var src = 2;
  var got = _.box.centeredOfSize( src );
  var expected = [ -0.5,-0.5,+0.5,+0.5 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'dst array, implicit size'; /* */

  var dst = [ 0,1,2,3 ];
  var got = _.box.centeredOfSize( dst );
  var expected = [ -0.5,-0.5,+0.5,+0.5 ];
  test.identical( got,expected );
  test.is( got === dst );

  test.description = 'dst vector, implicit size'; /* */

  var dst = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.box.centeredOfSize( dst );
  var expected = _.vector.fromArray([ -0.5,-0.5,+0.5,+0.5 ]);
  test.identical( got,expected );
  test.is( got === dst );

  test.description = 'dst array 2d, implicit size'; /* */

  var dst = [ 1,3 ];
  var got = _.box.centeredOfSize( dst );
  var expected = [ -0.5,+0.5 ];
  test.identical( got,expected );
  test.is( got === dst );

  /* */

  test.description = 'src undefined with sizes in array'; /* */

  var src = undefined;
  var got = _.box.centeredOfSize( src,[ 1,2,4 ] );
  var expected = [ -0.5,-1,-2,+0.5,+1,+2 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src null with sizes in array'; /* */

  var src = null;
  var got = _.box.centeredOfSize( src,[ 1,2,4 ] );
  var expected = [ -0.5,-1,-2,+0.5,+1,+2 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src 2 with sizes in array'; /* */

  var src = 2;
  var got = _.box.centeredOfSize( src,[ 2,4 ] );
  var expected = [ -1,-2,+1,+2 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'dst array with sizes in array'; /* */

  var dst = [ 0,1,2,3 ];
  var got = _.box.centeredOfSize( dst,[ 2,4 ] );
  var expected = [ -1,-2,+1,+2 ];
  test.identical( got,expected );
  test.is( got === dst );

  test.description = 'dst vector with sizes in array'; /* */

  var dst = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.box.centeredOfSize( dst,[ 2,4 ] );
  var expected = _.vector.fromArray([ -1,-2,+1,+2 ]);
  test.identical( got,expected );
  test.is( got === dst );

  test.description = 'dst array 2d with sizes in array'; /* */

  var dst = [ 1,3 ];
  var got = _.box.centeredOfSize( dst,[ 4 ] );
  var expected = [ -2,+2 ];
  test.identical( got,expected );
  test.is( got === dst );

}

//

function boxFromBox( test )
{

  debugger;

  test.description = 'trivial'; /* */

  var expected = [ 0.5,0.5,0.5,sqrt( 0.5 ) ];
  var bbox = [ 0,0,0,0,0,0 ];
  var bbox = [ 0,0,0,1,1,1 ];

  _.box.fromBox( bbox,bbox );
  test.equivalent( bbox,expected );

  var expected = vec( expected );
  var bbox = vec([ 0,0,0,0,0,0 ]);
  var bbox = vec( bbox );

  _.box.fromBox( bbox,bbox );
  test.equivalent( bbox,expected );

  test.description = 'same sizes, different position'; /* */

  var expected = [ -2.5,0.5,5.5,sqrt( 0.5 ) ];
  var bbox = [ 0,0,0,0,0,0 ];
  var bbox = [ -3,0,5,-2,1,6 ];

  _.box.fromBox( bbox,bbox );
  test.equivalent( bbox,expected );

  var expected = vec( expected );
  var bbox = vec([ 0,0,0,0,0,0 ]);
  var bbox = vec( bbox );

  _.box.fromBox( bbox,bbox );
  test.equivalent( bbox,expected );

  test.description = 'different sizes, different position'; /* */

  var expected = [ -2,0.5,7,sqrt( 5 ) ];
  var bbox = [ 0,0,0,0,0,0 ];
  var bbox = [ -3,0,5,-1,1,9 ];

  _.box.fromBox( bbox,bbox );
  test.equivalent( bbox,expected );

  var expected = vec( expected );
  var bbox = vec([ 0,0,0,0,0,0 ]);
  var bbox = vec( bbox );

  _.box.fromBox( bbox,bbox )
  test.equivalent( bbox,expected );

  test.description = 'bad arguments'; /* */

  if( !Config.debug )
  return;

  function shouldThrowError( rname )
  {

    test.shouldThrowErrorSync( () => _.avector[ rname ]() );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1,2 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1,2 ],[ 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1,2 ],[ 3,4 ],[ 5 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1,2 ],[ 3,4 ],1 ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1,2 ],[ 3,4 ],undefined ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1,2 ],[ 3,4 ],'1' ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1,2,3,4 ],[ 1,2,3,4,5 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1,2,3 ],[ 1,2,3,4,5,6 ] ) );

    test.shouldThrowErrorSync( () => _.vector[ rname ]() );
    test.shouldThrowErrorSync( () => _.vector[ rname ]( vec([ 1,2 ]) ) );
    test.shouldThrowErrorSync( () => _.vector[ rname ]( vec([ 1,2 ]),vec([ 3 ]) ) );
    test.shouldThrowErrorSync( () => _.vector[ rname ]( vec([ 1,2 ]),vec([ 3,4 ]),vec([ 5 ]) ) );
    test.shouldThrowErrorSync( () => _.vector[ rname ]( vec([ 1,2 ]),vec([ 3,4 ]),1 ) );
    test.shouldThrowErrorSync( () => _.vector[ rname ]( vec([ 1,2 ]),vec([ 3,4 ]),undefined ) );
    test.shouldThrowErrorSync( () => _.vector[ rname ]( vec([ 1,2 ]),vec([ 3,4 ]),'1' ) );
    test.shouldThrowErrorSync( () => _.vector[ rname ]( vec([ 1,2,3,4 ]),vec([ 1,2,3,4,5 ]) ) );
    test.shouldThrowErrorSync( () => _.vector[ rname ]( vec([ 1,2,3 ]),vec([ 1,2,3,4,5,6 ]) ) );

  }

  shouldThrowError( 'boxFromBox' );

  debugger;
}

//

function boxFromPoints( test )
{

  test.description = 'Box from two points'; /* */

  var pointone = [ - 1, 2, - 3 ];
  var pointtwo = [ 1, - 2, 3 ];
  var expected = [ - 1, - 2, - 3, 1, 2, 3 ];

  var points = [ pointone, pointtwo ];
  var bbox = null;

  bbox = _.box.fromPoints( bbox, points );
  test.equivalent( bbox, expected );

  test.description = 'Box from three points'; /* */

  var pointone = [ - 1, 2, - 3 ];
  var pointtwo = [ 1, - 2, 3 ];
  var pointthree = [ 0, 0, 6 ];
  var expected = [ - 1, - 2, - 3, 1, 2, 6 ];

  var points = [ pointone, pointtwo, pointthree ];
  var bbox = null;

  bbox = _.box.fromPoints( bbox, points );
  test.equivalent( bbox, expected );

  test.description = 'Box from six points'; /* */

  var pointone = [ 0, 0, 3 ];
  var pointtwo = [ 0, 2, 0 ];
  var pointthree = [ 1, 0, 0 ];
  var pointfour = [ - 3, 0, 0 ];
  var pointfive = [ 0, - 2, 0 ];
  var pointsix = [ 0, 0, - 1 ];
  var expected = [ -3, - 2, - 1, 1, 2, 3 ];

  var points = [ pointone, pointtwo, pointthree, pointfour, pointfive, pointsix ];
  var bbox = null;

  bbox = _.box.fromPoints( bbox, points );
  test.equivalent( bbox, expected );

  test.description = 'Box from two decimal points'; /* */

  var pointone = [ 0.001, -0.203, 0.889 ];
  var pointtwo = [ -0.991, 0.203, 0.005 ];
  var expected = [ -0.991, - 0.203, 0.005, 0.001, 0.203, 0.889 ];

  var points = [ pointone, pointtwo ];
  var bbox = null;

  bbox = _.box.fromPoints( bbox, points );
  test.equivalent( bbox, expected );

  test.description = 'Box from Two points with initial box dimension'; /* */

  var pointone = [ 3, 1, 3 ];
  var pointtwo = [ 3, 8, 3 ];
  var expected = [ 2, 1, 2, 4, 8, 4 ];

  var points = [ pointone, pointtwo ];
  var bbox = [ 2, 2, 2, 4, 4, 4 ];

  bbox = _.box.fromPoints( bbox, points );
  test.equivalent( bbox, expected );

  test.description = '0d Box from 0d points'; /* */

  var expected = [];
  var points = [ [], [], [] ];
  var bbox = [];

  bbox = _.box.fromPoints( bbox, points );
  test.equivalent( bbox, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromPoints();
  });

  test.description = 'Wrong type of argument'; /* */

  test.shouldThrowError( function()
  {
    _.box.fromPoints( 'box', 'points' );
  });

  test.description = 'Wrong type of argument'; /* */

  test.shouldThrowError( function()
  {
    _.box.fromPoints( null, 4 );
  });

  test.description = 'Too few arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromPoints( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.description = 'too many arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromPoints( [ 0, 0, 0, 0, 0, 0 ], [ [ 0, 1, 0 ], [ 1, 0, 1 ] ], [ 0, 1, 2 ] );
  });

  test.description = 'Different dimensions between box and points'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromPoints( [ 0, 0, 0, 0, 0, 0 ], [ [ 0, 1 ], [ 1, 0 ] ]);
  });

  test.description = 'Different dimensions between points'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromPoints( [ 0, 0, 0, 0, 0, 0 ], [ [ 0, 1, 0 ], [ 1, 0 ], [ 0 ] ]);
  });
}

//

function pointExpand( test )
{

  test.description = 'Point remains unchanged and Destination box changes'; /* */

  var dstBox = [ 0, 0, 1, 1 ];
  var point = [ 0, 2 ];
  var oldPoint = point.slice();

  var gotBox = _.box.pointExpand( dstBox, point );
  test.identical( gotBox, dstBox );
  test.identical( point, oldPoint );

  var expected = [ 0, 0, 1, 2 ];
  test.identical( gotBox, expected );
  var oldPoint = [ 0, 2 ];
  test.identical( point, oldPoint );

  test.description = 'Null box expanded'; /* */

  var box = null;
  var point = [ 1, 2, 3 ];
  var expected = [ 1, 2, 3, 1, 2, 3 ];

  var gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.description = 'Null box NOT expanded'; /* */

  var box = null;
  var point = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0, 0, 0 ];

  var gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.description = 'One point box expanded'; /* */

  var box = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ - 1, 2, - 3 ];
  var expected = [ - 1,  0, - 3, 0, 2, 0 ];

  var gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.description = 'Box expanded'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ - 1, 3, - 1 ];
  var expected = [ - 1, 0, - 1, 2, 3, 2 ];

  var gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.description = 'Box NOT expanded ( point inside box )'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [  1, 1, 1 ];
  var expected = [ 0,  0, 0, 2, 2, 2 ];

  var gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.description = 'Box ( normalized to 1 ) expanded'; /* */

  var box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  var point = [ -0.900, 0, 0.900 ];
  var expected = [ - 0.900,  0, -0.238, 0.194, 0.766, 0.900 ];

  var gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.description = 'Null box of four dimensions expanded'; /* */

  var box = [ 0, 0, 0, 0, 0, 0, 0, 0 ];
  var point = [ 1, 2, 3 , 4 ];
  var expected = [ 0, 0, 0, 0, 1, 2, 3, 4 ];

  var gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.description = 'Null box of 7 dimensions expanded'; /* */

  var box = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ];
  var point = [ 1, 2, 3 , 4, 5, 6, 7 ];
  var expected = [ 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7 ];

  var gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.description = 'Box of 1 dimension expanded'; /* */

  var box = [ 0, 0 ];
  var point = [ 1 ];
  var expected = [ 0, 1 ];

  var gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.description = 'Box of 0 dimension expanded'; /* */

  var box = [ ];
  var point = [ ];
  var expected = [ ];

  var gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointExpand();
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointExpand( 'box', 'points' );
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointExpand( null, 4 );
  });

  test.description = 'Too few arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointExpand( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.description = 'too many arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointExpand( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0 ], [ 1, 0, 1 ] );
  });

  test.description = 'Wrong point dimension (box 3D vs point 4D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointExpand( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0, 2 ] );
  });

  test.description = 'Wrong point dimension (box 3D vs point 2D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointExpand( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1 ] );
  });

  test.description = 'Wrong point dimension (box 2D vs point 1D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointExpand( [ 0, 0, 0, 0 ], [ 0 ] );
  });
}

//

function pointContains( test )
{

  test.description = 'Box and Point remain unchanged'; /* */

  var box = [  - 1,  - 1 , 1, 1 ];
  var oldBox = box.slice();
  var point = [ 0, 0 ];
  var oldPoint = point.slice();
  var expected = true;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool, expected );
  test.identical( box, oldBox );
  test.identical( point, oldPoint );

  test.description = 'Null box contains empty point'; /* */

  var box = null;
  var point = [ 0, 0, 0 ];
  var expected = true;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Empty box doesn´t contain empty point'; /* */

  var box = [];
  var point = [];
  var expected = false;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Point Box contains Point'; /* */

  var box = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = true;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Box contains point'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [  1, 1, 1 ];
  var expected = true;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Box under point'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ 1, 1, 3 ];
  var expected = false;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Box over point'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ - 1, 1, 1 ];
  var expected = false;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Box ( normalized to 1 ) contains point'; /* */

  var box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  var point = [ 0.050, 0.500, 0.000 ];
  var expected = true;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Box ( normalized to 1 ) doesn´t contain point'; /* */

  var box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  var point = [ 0.050, 0.500, - 0.303 ];
  var expected = false;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Box of four dimensions contains point'; /* */

  var box = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0 , 0 ];
  var expected = true;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Box of four dimensions doesn´t contain point'; /* */

  var box = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, - 2, 0 , 2 ];
  var expected = false;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Box of 7 dimensions contains point'; /* */

  var box = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 1, 1, 1, 1, 1, 1, 1 ];
  var point = [ 0, -1, -1, 0, -1, 0, 0 ];
  var expected = true;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Box of 7 dimensions doesn´t contain point'; /* */

  var box = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 1, 1, 1, 1, 1, 1, 1 ];
  var point = [ 0, 4, 3.5, 0, 5, 2, 2 ];
  var expected = false;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Box of 1 dimension contains point'; /* */

  var box = [ 0, 2 ];
  var point = [ 1 ];
  var expected = true;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Box of 1 dimension desn´t contain point (too big)'; /* */

  var box = [ 0, 2 ];
  var point = [ 3 ];
  var expected = false;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Box of 1 dimension desn´t contain point (too small)'; /* */

  var box = [ 0, 2 ];
  var point = [ - 3 ];
  var expected = false;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointContains();
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointContains( 'box', 'point' );
  });

  test.description = 'Point Null'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointContains( [ 0, 0, 0, 1, 1, 1 ], null );
  });


  test.description = 'Too few arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointContains( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.description = 'too many arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointContains( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0 ], [ 1, 0, 1 ] );
  });

  test.description = 'Wrong point dimension (box 3D vs point 4D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointContains( [ 0, 0, 0, 3, 3, 3 ], [ 0, 1, 0, 2 ] );
  });

  test.description = 'Wrong point dimension (box 3D vs point 2D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointContains( [ 0, 0, 0, 2, 2, 2 ], [ 0, 1 ] );
  });

  test.description = 'Wrong point dimension (box 2D vs point 1D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointContains( [ 0, 0, 0, 0 ], [ 0 ] );
  });
}

//

function pointRelative( test )
{

  test.description = 'Returns same instance point, box remains unchanged'; /* */

  var box = [ 0, 0, 2, 2 ];
  var oldBox = box.slice();
  var point = [ 0, 1 ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, point );
  test.equivalent( oldBox, box );

  var expected = [ 0, 0.5 ];
  test.equivalent( gotPoint, expected );

  var oldBox = [ 0, 0, 2, 2 ];
  test.equivalent( oldBox, box );

  test.description = 'Empty point relative to null box'; /* */

  var box = null;
  var point = [ 0, 0, 0 ];
  var expected = [ NaN, NaN, NaN ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.description = 'Empty point relative to empty box'; /* */

  var box = [];
  var point = [];
  var expected = [];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.description = 'Point relative to zero box'; /* */

  var box = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = [ NaN, NaN, NaN ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.description = 'Point in medium of box'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [  1, 1, 1 ];
  var expected = [ 0.5, 0.5, 0.5 ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.description = 'Point with 1D out of box'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ 1, 1, 3 ];
  var expected = [ 0.5, 0.5, 1.5 ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.description = 'Point with 1D under box'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ - 1, 1, 1 ];
  var expected = [ - 0.5, 0.5, 0.5 ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.description = 'Point (normalized to one) in box'; /* */

  var box = [ 0.000, 0.000, 0.000, 0.050, 0.050, 0.050 ];
  var point = [ 0.100, 0.025, 0.050 ];
  var expected = [ 2, 0.5, 1 ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.description = 'Point (normalized to one) not in box'; /* */

  var box = [ 0.000, 0.000, 0.000, 0.050, 0.050, 0.050 ];
  var point = [ 0.075, 0.075, 0.075 ];
  var expected = [ 1.5, 1.5, 1.5 ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.description = 'Point in four dimensions box'; /* */

  var box = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0 , 0 ];
  var expected = [ 0.5, 0.5, 0.5 , 0.5 ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.description = 'Point out of four dimensions box'; /* */

  var box = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, - 2, 0 , 2 ];
  var expected = [ 0.5, - 0.5, 0.5 , 1.5 ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.description = 'Point in seven dimensions box'; /* */

  var box = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 1, 1, 1, 1, 1, 1, 1 ];
  var point = [ - 0.5, - 2, 1, - 3.5, 4, - 5, 7 ];
  var expected = [ 0.5, 0, 1, - 0.5, 2, - 1, 3 ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.description = 'Point in one dimension box'; /* */

  var box = [ 0, 2 ];
  var point = [ 1 ];
  var expected = [ 0.5 ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.description = 'Point out of one dimension box (smaller)'; /* */

  var box = [ 0, 2 ];
  var point = [ 3 ];
  var expected = [ 1.5 ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.description = 'Point out of one dimension box (bigger)'; /* */

  var box = [ 0, 2 ];
  var point = [ - 3 ];
  var expected = [ - 1.5 ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointRelative();
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointRelative( 'box', 'point' );
  });

  test.description = 'Point Null'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointRelative( [ 0, 0, 0, 1, 1, 1 ], null );
  });


  test.description = 'Too few arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointRelative( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.description = 'too many arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointRelative( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0 ], [ 1, 0, 1 ] );
  });

  test.description = 'Wrong point dimension (box 3D vs point 4D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointRelative( [ 0, 0, 0, 3, 3, 3 ], [ 0, 1, 0, 2 ] );
  });

  test.description = 'Wrong point dimension (box 3D vs point 2D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointRelative( [ 0, 0, 0, 2, 2, 2 ], [ 0, 1 ] );
  });

  test.description = 'Wrong point dimension (box 2D vs point 1D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointRelative( [ 0, 0, 0, 0 ], [ 0 ] );
  });
}

//

function pointClamp( test )
{

  test.description = 'Returns same instance point, box remains unchanged'; /* */

  var box = [ 1, 1, 1, 3, 3, 3 ];
  var oldBox = box.slice();
  var point = [ 0, 1, 2 ];
  var expected = [ 1, 1, 2 ];

  var gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped, point );
  test.identical( oldBox, box );

  test.description = 'Empty point relative to null box'; /* */

  var box = null;
  var point = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0 ];

  var gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Empty point relative to empty box'; /* */

  var box = [];
  var point = [];
  var expected = [];

  var gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Point relative to zero box'; /* */

  var box = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0 ];

  var gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Point in box'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [  1, 1, 1 ];
  var expected = [ 1, 1, 1 ];

  var gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Point over box'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ 1, 1, 3 ];
  var expected = [ 1, 1, 2 ];

  var gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Point under box'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ - 1, 1, 1 ];
  var expected = [ 0, 1, 1 ];

  var gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Point (normalized to one) in box'; /* */

  var box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  var point = [ 0.050, 0.500, 0 ];
  var expected = [ 0.050, 0.500, 0 ];

  var gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Point (normalized to one) not in box'; /* */

  var box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  var point = [ 0.050, 0.500, - 0.303 ];
  var expected = [ 0.050, 0.500, -0.238 ];

  var gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Point in four dimensions box'; /* */

  var box = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0 , 0 ];
  var expected = [ 0, 0, 0 , 0 ];

  var gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Point out of four dimensions box'; /* */

  var box = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, - 2, 0 , 2 ];
  var expected = [ 0, - 1, 0 , 1 ];

  var gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Point in seven dimensions box'; /* */

  var box = [ - 2, 3, 3, - 1, 2, 1, 1, 1, 5, 4, 2, 4, 3, 3 ];
  var point = [ 0, 4, 3.5, 0, 4, 2, 2 ];
  var expected = [ 0, 4, 3.5, 0, 4, 2, 2 ];

  var gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Point out of seven dimensions box'; /* */

  var box = [ - 2, 3, 3, - 1, 2, 1, 1, 1, 5, 4, 2, 4, 3, 3 ];
  var point = [ 0, 4, 3.5, 0, 5, 2, 7 ];
  var expected = [ 0, 4, 3.5, 0, 4, 2, 3 ];

  var gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Point in one dimension box'; /* */

  var box = [ 0, 2 ];
  var point = [ 1 ];
  var expected = [ 1 ];

  var gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Point out of one dimension box (smaller)'; /* */

  var box = [ 0, 2 ];
  var point = [ 3 ];
  var expected = [ 2 ];

  var gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Point out of one dimension box (bigger)'; /* */

  var box = [ 0, 2 ];
  var point = [ - 3 ];
  var expected = [ 0 ];

  var gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointClamp();
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointClamp( 'box', 'point' );
  });

  test.description = 'Point Null'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointClamp( [ 0, 0, 0, 1, 1, 1 ], null );
  });


  test.description = 'Too few arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointClamp( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.description = 'too many arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointClamp( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0 ], [ 1, 0, 1 ] );
  });

  test.description = 'Wrong point dimension (box 3D vs point 4D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointClamp( [ 0, 0, 0, 3, 3, 3 ], [ 0, 1, 0, 2 ] );
  });

  test.description = 'Wrong point dimension (box 3D vs point 2D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointClamp( [ 0, 0, 0, 2, 2, 2 ], [ 0, 1 ] );
  });

  test.description = 'Wrong point dimension (box 2D vs point 1D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointClamp( [ 0, 0, 0, 0 ], [ 0 ] );
  });
}

function pointDistance( test )
{

  test.description = 'Box and Point remain unchanged'; /* */

  var box = [ 0, 0, 2, 2 ];
  var oldBox = box.slice();
  var point = [ 0, 3 ];
  var oldPoint = point.slice();
  var expected = 1;
  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( expected, gotDist );
  test.equivalent( oldBox,oldBox );
  test.equivalent( point, oldPoint );

  test.description = 'Empty point relative to null box'; /* */

  var box = null;
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Empty point relative to empty box'; /* */

  var box = [];
  var point = [];
  var expected = 0;

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point relative to zero box'; /* */

  var box = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point in box'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [  1, 1, 1 ];
  var expected = 0;

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point over box in one dimension'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ 1, 1, 3 ];
  var expected = 1;
  debugger;
  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point under box'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ - 1, 1, 1 ];
  var expected = 1;

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point away from box in two dimensions'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ 0, - 1, - 1 ];
  var expected = Math.sqrt(2);

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point away from box in three dimensions'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ 3, - 1, - 1 ];
  var expected = Math.sqrt(3);

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point (normalized to one) in box'; /* */

  var box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  var point = [ 0.050, 0.500, 0.000 ];
  var expected = 0;

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point (normalized to one) not in box'; /* */

  var box = [ - 0.050, 0.002, -0.203, 0.194, 0.766, 0.766 ];
  var point = [ 0.050, 0.500, - 0.303 ];
  var expected = 0.1;

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point in four dimensions box'; /* */

  var box = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0 , 0 ];
  var expected = 0;

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point out of four dimensions box'; /* */

  var box = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, - 2, 0 , 2 ];
  var expected = Math.sqrt(2);

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point in seven dimensions box'; /* */

  var box = [ - 2, 3, 3, - 1, 2, 1, 1, 1, 5, 4, 2, 4, 3, 3 ];
  var point = [ 0, 4, 3.5, 0, 3, 2, 2 ];
  var expected = 0;

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point out of seven dimensions box'; /* */

  var box = [ - 2, 3, 3, - 1, 2, 1, 1, 1, 5, 4, 2, 4, 3, 3 ];
  var point = [ 0, 4, 3.5, 0, 4, 2, 7 ];
  var expected = 4;

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point in one dimension box'; /* */

  var box = [ 0, 2 ];
  var point = [ 1 ];
  var expected = 0;

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point out of one dimension box (smaller)'; /* */

  var box = [ 0, 2 ];
  var point = [ 3 ];
  var expected = 1;

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point out of one dimension box (bigger)'; /* */

  var box = [ 0, 2 ];
  var point = [ - 3 ];
  var expected = 3;

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointDistance();
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointDistance( 'box', 'point' );
  });

  test.description = 'Point Null'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointDistance( [ 0, 0, 0, 1, 1, 1 ], null );
  });

  test.description = 'Too few arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointDistance( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.description = 'too many arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointDistance( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0 ], [ 1, 0, 1 ] );
  });

  test.description = 'Wrong point dimension (box 3D vs point 4D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointDistance( [ 0, 0, 0, 3, 3, 3 ], [ 0, 1, 0, 2 ] );
  });

  test.description = 'Wrong point dimension (box 3D vs point 2D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointDistance( [ 0, 0, 0, 2, 2, 2 ], [ 0, 1 ] );
  });

  test.description = 'Wrong point dimension (box 2D vs point 1D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.pointDistance( [ 0, 0, 0, 0 ], [ 0 ] );
  });
}

//

function boxContains( test )
{

  test.description = 'Source box and Destination box remain unchanged'; /* */

  // qqq : vars in case
  var srcBox = [ 0, 0, 3, 3 ];
  var oldSrcBox = srcBox.slice();
  var tstBox = [ 1, 1, 2, 2 ];
  var oldTstBox = tstBox.slice();
  var expected = true;
  var gotBool = _.box.boxContains( srcBox, tstBox );
  test.identical( expected, gotBool );
  test.identical( srcBox, oldSrcBox );
  test.identical( tstBox, oldTstBox );

  test.description = 'Empty box to empty box'; /* */

  var box = [];
  var boxTwo = [];
  var expected = false;

  var gotBool = _.box.boxContains( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Zero box to zero box'; /* */

  var box = [ 0, 0, 0, 0, 0, 0 ];
  var boxTwo = [ 0, 0, 0, 0, 0, 0 ];
  var expected = true;

  var gotBool = _.box.boxContains( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Same boxes'; /* */

  var box = [ 0, 0, 0, 4, 4, 4 ];
  var boxTwo = [ 0, 0, 0, 4, 4, 4 ];
  var expected = true;

  var gotBool = _.box.boxContains( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box in box with a common side'; /* */

  var box = [ 0, 0, 0, 3, 3, 3 ];
  var boxTwo = [ 1, 1, 1, 2, 2, 3 ];
  var expected = true;

  var gotBool = _.box.boxContains( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box in box'; /* */

  var box = [ 0, 0, 0, 3, 3, 3 ];
  var boxTwo = [ 1, 1, 1, 2, 2, 2 ];
  var expected = true;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.description = 'Box in box (other way aroud)'; /* */

  var box = [ 1, 1, 1, 2, 2, 2 ];
  var boxTwo = [ 0, 0, 0, 3, 3, 3 ];
  var expected = false;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.description = 'Box half in box'; /* */

  var box = [ 0, 0, 0, 4, 4, 4 ];
  var boxTwo = [ 2, 2, 2, 6, 6, 6 ];
  var expected = false;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.description = 'Box totally out of box'; /* */

  var box = [ 0, 0, 0, 1, 1, 1 ];
  var boxTwo = [ 2, 2, 2, 3, 3, 3 ];
  var expected = false;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.description = 'Box out of box in two dimensions'; /* */

  var box = [ 0, 0, 0, 4, 4, 4 ];
  var boxTwo = [ 0, - 1, - 1, 1, 0, 0 ];
  var expected = false;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.description = 'Box out of box in one dimensions'; /* */

  var box = [ 0, 0, 0, 4, 4, 4 ];
  var boxTwo = [ 1, 1, 1, 3, 3, 5 ];
  var expected = false;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.description = 'Box in box (both normalized to one)'; /* */

  var box = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.80 ];
  var boxTwo = [ - 0.01, 0, - 0.02, 0.30, 0, 0.64 ];
  var expected = true;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.description = 'Box out of box (normalized to one)'; /* */

  var box = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.80 ];
  var boxTwo = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.90 ];
  var expected = false;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.description = 'Box in box (four dimensions)'; /* */

  var box = [ - 1, - 1, - 1, - 1, 2, 2, 2, 2 ];
  var boxTwo = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var expected = true;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.description = 'Box out of box (four dimensions)'; /* */

  var box = [ - 1, - 1, - 1, - 1, 2, 2, 2, 2 ];
  var boxTwo = [ 0, 0, 0, 0, 1, 1, 1, 3 ];
  var expected = false;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.description = 'Box in box (one dimensions)'; /* */

  var box = [ - 1, 2 ];
  var boxTwo = [ 0, 1 ];
  var expected = true;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.description = 'Box out of box (four dimensions)'; /* */

  var box = [ - 1, 2 ];
  var boxTwo = [ 0, 4 ];
  var expected = false;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.boxContains();
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.boxContains( 'box', 'box2' );
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.boxContains( null, [] );
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.boxContains( [], null );
  });


  test.description = 'Too few arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.boxContains( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.description = 'too many arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.boxContains( [ 0, 0, 0, 0 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 0 ] );
  });

  test.description = 'Different box dimensions (box 3D vs box 2D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.boxContains( [ 0, 0, 0, 3, 3, 3 ], [ 0, 1, 0, 2 ] );
  });

  test.description = 'Wrong box dimension'; /* */
  test.shouldThrowError( function()
  {
    _.box.boxContains( [ 0, 0, 0, 2, 2, 2, 2 ], [ 0, 0, 0, 2, 2, 2, 3 ], );
  });

}

function boxIntersects( test )
{

test.description = 'Source box and Test box remain unchanged'; /* */

  var srcBox = [ 0, 0, 2, 2 ];
  var oldsrcBox = srcBox.slice();
  var tstBox = [  1,  1, 3, 3 ];
  var oldtstBox = tstBox.slice();
  var gotBool = _.box.boxIntersects( srcBox, tstBox );
  var expected = true;
  test.identical( expected, gotBool );
  test.identical( srcBox, oldsrcBox );
  test.identical( tstBox, oldtstBox );

  test.description = 'Empty box to empty box'; /* */

  var box = [];
  var boxTwo = [];
  var expected = false;

  var gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );


  test.description = 'Zero box to zero box'; /* */

  var box = [ 0, 0, 0, 0, 0, 0 ];
  var boxTwo = [ 0, 0, 0, 0, 0, 0 ]; // qqq : why was false?
  var expected = true;

  var gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Same boxes'; /* */

  var box = [ 0, 0, 0, 4, 4, 4 ];
  var boxTwo = [ 0, 0, 0, 4, 4, 4 ];
  var expected = true;

  var gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box in box with a common side'; /* */

  var box = [ 0, 0, 0, 3, 3, 3 ];
  var boxTwo = [ 1, 1, 1, 2, 2, 3 ];
  var expected = true;

  var gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );


  test.description = 'Box out of box with a common side'; /* */

  var box = [ 0, 0, 0, 3, 3, 3 ];
  var boxTwo = [ 4, 4, 3, 5, 5, 5 ];
  var expected = false;

  var gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box in box'; /* */

  var box = [ 0, 0, 0, 3, 3, 3 ];
  var boxTwo = [ 1, 1, 1, 2, 2, 2 ];
  var expected = true;

  var gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box half in box'; /* */

  var box = [ 0, 0, 0, 4, 4, 4 ];
  var boxTwo = [ 2, 2, 2, 6, 6, 6 ];
  var expected = true;

  var gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box totally out of box'; /* */

  var box = [ 0, 0, 0, 1, 1, 1 ];
  var boxTwo = [ 2, 2, 2, 3, 3, 3 ];
  var expected = false;

  var gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box out of box in two dimensions'; /* */

  var box = [ 0, 0, 0, 4, 4, 4 ];
  var boxTwo = [ 0, - 1, - 1, 1, 0, 0 ];
  var expected = true;

  var gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box out of box in one dimensions'; /* */

  var box = [ 0, 0, 0, 4, 4, 4 ];
  var boxTwo = [ 1, 1, 1, 3, 3, 5 ];
  var expected = true;

  var gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box in box (both normalized to one)'; /* */

  var box = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.80 ];
  var boxTwo = [ - 0.01, 0, - 0.02, 0.30, 0, 0.64 ];
  var expected = true;

  var gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box out of box (normalized to one)'; /* */

  var box = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.80 ];
  var boxTwo = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.90 ];
  var expected = true; // qqq : why false??

  var gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box in box (four dimensions)'; /* */

  var box = [ - 1, - 1, - 1, - 1, 2, 2, 2, 2 ];
  var boxTwo = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box out of box in 1D (four dimensions)'; /* */

  var box = [ - 1, - 1, - 1, - 1, 2, 2, 2, 2 ];
  var boxTwo = [ 0, 0, 0, 0, 1, 1, 1, 3 ];
  var expected = true;

  var gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box out of box in 1D (four dimensions)'; /* */

  var box = [ - 1, - 1, - 1, - 1, 2, 2, 2, 2 ];
  var boxTwo = [ 3, 3, 3, 3, 4, 4, 4, 4 ];
  var expected = false;

  var gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box in box (one dimensions)'; /* */

  var box = [ - 1, 2 ];
  var boxTwo = [ 0, 1 ];
  var expected = true;

  var gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box intersects box (one dimensions)'; /* */

  var box = [ - 1, 2 ];
  var boxTwo = [ 0, 4 ];
  var expected = true;

  var gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box out of box (one dimensions)'; /* */

  var box = [ - 1, 2 ];
  var boxTwo = [ 3, 4 ];
  var expected = false;

  var gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.boxIntersects();
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.boxIntersects( 'box', 'box2' );
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.boxIntersects( null, [] );
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.boxIntersects( [], null );
  });

  test.description = 'Too few arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.boxIntersects( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.description = 'too many arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.boxIntersects( [ 0, 0, 0, 0 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 0 ] );
  });

  test.description = 'Different box dimensions (box 3D vs box 2D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.boxIntersects( [ 0, 0, 0, 3, 3, 3 ], [ 0, 1, 0, 2 ] );
  });

  test.description = 'Wrong box dimension'; /* */
  test.shouldThrowError( function()
  {
    _.box.boxIntersects( [ 0, 0, 0, 2, 2, 2, 2 ], [ 0, 0, 0, 2, 2, 2, 3 ], );
  });

}

function boxExpand( test )
{

  test.description = 'Source box remains unchanged and Destination box changes'; /* */

  var dstBox = [ 0, 0, 1, 1 ];
  var srcBox = [ - 1, - 1, 0, 2 ];
  var oldSrcBox = srcBox.slice();
  var expected = [ - 1, - 1, 1, 2 ];

  var gotBox = _.box.boxExpand( dstBox, srcBox );
  test.identical( dstBox, gotBox );
  test.identical( srcBox, oldSrcBox );

  test.description = 'Empty box expands empty box'; /* */

  var box = [];
  var boxTwo = [];
  var expected = [];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );


  test.description = 'Zero box expands zero box'; /* */

  var box = [ 0, 0, 0, 0, 0, 0 ];
  var boxTwo = [ 0, 0, 0, 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0, 0, 0 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.description = 'Same boxes (no expansion)'; /* */

  var box = [ 0, 0, 0, 4, 4, 4 ];
  var boxTwo = [ 0, 0, 0, 4, 4, 4 ];
  var expected = [ 0, 0, 0, 4, 4, 4 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.description = 'Smaller box (no expansion)'; /* */

  var box = [ 0, 0, 0, 3, 3, 3 ];
  var boxTwo = [ 1, 1, 1, 2, 2, 2 ];
  var expected = [ 0, 0, 0, 3, 3, 3 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.description = '1D expansion'; /* */

  var box = [ 0, 0, 0, 3, 3, 3 ];
  var boxTwo = [ 1, 1, 1, 2, 2, 4 ];
  var expected = [ 0, 0, 0, 3, 3, 4 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.description = '2D expansion'; /* */

  var box = [ 0, 0, 0, 4, 4, 4 ];
  var boxTwo = [ 2, - 2, - 2, 4, 6, 6 ];
  var expected = [ 0, - 2, - 2, 4, 6, 6 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.description = '3D expansion'; /* */

  var box = [ 0, 0, 0, 1, 1, 1 ];
  var boxTwo = [ - 2, - 2, - 2, 3, 3, 3 ];
  var expected = [ - 2, - 2, - 2, 3, 3, 3 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.description = 'Random expansion'; /* */

  var box = [ 0, - 5, 3, 2, 3, 3 ];
  var boxTwo = [ - 1, - 1, - 1, 2.5, 2.5, 2.5 ];
  var expected = [ - 1, - 5, - 1, 2.5, 3, 3 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.description = 'Box expanded (normalized to one)'; /* */

  var box = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.80 ];
  var boxTwo = [ - 0.01, 0, - 0.02, 0.30, 0, 0.90 ];
  var expected = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.90 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.description = 'Box not expanded (normalized to one)'; /* */

  var box = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.80 ];
  var boxTwo = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.70 ];
  var expected = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.80 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.description = 'Box expanded (four dimensions)'; /* */

  var box = [ - 1, - 1, - 1, - 1, 2, 2, 2, 2 ];
  var boxTwo = [ 0, 0, 0, 0, 3, 3, 3, 3 ];
  var expected = [ - 1, - 1, - 1, - 1, 3, 3, 3, 3 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.description = 'Box not expanded (four dimensions)'; /* */

  var box = [ - 1, - 1, - 1, - 1, 2, 2, 2, 2 ];
  var boxTwo = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var expected = [ - 1, - 1, - 1, - 1, 2, 2, 2, 2 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.description = 'Box expanded (one dimension)'; /* */

  var box = [ - 1, 2 ];
  var boxTwo = [ - 2, 10 ];
  var expected = [ - 2, 10 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.description = 'Box expanded on one side (one dimension)'; /* */

  var box = [ - 1, 2 ];
  var boxTwo = [ 0, 4 ];
  var expected = [ - 1, 4 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.description = 'Box not expanded (one dimension)'; /* */

  var box = [ - 1, 3 ];
  var boxTwo = [ 0, 1 ];
  var expected = [ - 1, 3 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.boxExpand();
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.boxExpand( 'box', 'box2' );
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.boxExpand( null, [] );
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.boxExpand( [], null );
  });

  test.description = 'Too few arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.boxExpand( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.description = 'too many arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.boxExpand( [ 0, 0, 0, 0 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 0 ] );
  });

  test.description = 'Different box dimensions (box 3D vs box 2D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.boxExpand( [ 0, 0, 0, 3, 3, 3 ], [ 0, 1, 0, 2 ] );
  });

  test.description = 'Wrong box dimension'; /* */
  test.shouldThrowError( function()
  {
    _.box.boxExpand( [ 0, 0, 0, 2, 2, 2, 2 ], [ 0, 0, 0, 2, 2, 2, 3 ], );
  });

}

function dimGet( test )
{

  test.description = 'Source box remains unchanged'; /* */

  var srcBox = [ 0, 0, 1, 1 ];
  var oldsrcBox = srcBox.slice();
  var expected = 2;

  var gotDim = _.box.dimGet( srcBox );
  test.identical( gotDim, expected );
  test.identical( srcBox, oldsrcBox );

  test.description = 'Empty box'; /* */

  var box = [];
  var expected = 0;

  var gotDim = _.box.dimGet( box );
  test.identical( gotDim, expected );

  test.description = 'One dimension box'; /* */

  var box = [ 0, 0 ];
  var expected = 1;

  var gotDim = _.box.dimGet( box );
  test.identical( gotDim, expected );

  test.description = 'Two dimension box'; /* */

  var box = [ 0, 0, 1, 1 ];
  var expected = 2;

  var gotDim = _.box.dimGet( box );
  test.identical( gotDim, expected );

  test.description = 'Three dimension box'; /* */

  var box = [ - 1, - 2, - 3, 0, 1, 2 ];
  var expected = 3;

  var gotDim = _.box.dimGet( box );
  test.identical( gotDim, expected );

  test.description = 'Four dimension box'; /* */

  var box = [ - 1, - 2.2, - 3, 5, 0.1, 1, 2, 5.4 ];
  var expected = 4;

  var gotDim = _.box.dimGet( box );
  test.identical( gotDim, expected );

  test.description = 'Eight dimension box'; /* */

  var box = [ - 1, - 2.2, - 3, 5, 0.1, 1, 2, 5.4, - 1.1, - 3.2, - 3.5, 5.5, 2.3, 27, 2.2, 540 ];
  var expected = 8;

  var gotDim = _.box.dimGet( box );
  test.identical( gotDim, expected );


  test.description = 'NaN'; /* */

  var box = [ 'Hi', 'world' ];
  var expected = 1;

  var gotDim = _.box.dimGet( box );
  test.identical( gotDim, expected );

  test.description = 'NaN'; /* */

  var box = [ 'Hi', 'world', null, null, NaN, NaN ];
  var expected = 3;

  var gotDim = _.box.dimGet( box );
  test.identical( gotDim, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.dimGet();
  });

  test.description = 'Wrong box dimension'; /* */
  test.shouldThrowError( function()
  {
    _.box.dimGet( [ 0 ] );
  });

  test.description = 'Wrong box dimension'; /* */
  test.shouldThrowError( function()
  {
    _.box.dimGet( [ 0, 0, 0 ] );
  });

  test.description = 'Wrong box dimension'; /* */
  test.shouldThrowError( function()
  {
    _.box.dimGet( [ 0, 0, 0, 0, 0 ] );
  });
}

function centerGet( test )
{

  test.description = 'Source box remains unchanged, point changes'; /* */

  var srcBox = [ 0, 0, 1, 1 ];
  var oldSrcBox = srcBox.slice();
  var expected = [ 0.5, 0.5 ];
  var point = [ 0, 5 ];

  var gotCenter = _.box.centerGet( srcBox, point );
  test.equivalent( gotCenter, expected );
  test.equivalent( point, expected );
  test.equivalent( srcBox, oldSrcBox );

  test.description = 'Empty box'; /* */

  var box = [];
  var point = [];
  var expected = [] ;

  var gotCenter = _.box.centerGet( box, point );
  test.equivalent( gotCenter,expected );

  var gotCenter = _.box.centerGet( box );
  test.equivalent( gotCenter,expected );
  debugger;

  test.description = 'One dimension box'; /* */

  var box = [ 0, 0 ];
  var point = [ 0 ];
  var expected = [ 0 ];

  var gotCenter = _.box.centerGet( box, point );
  test.equivalent( gotCenter,expected );

  var box = [ 0, 0 ];
  var gotCenter = _.box.centerGet( box );
  test.equivalent( gotCenter,expected );

  test.description = 'Two dimension box'; /* */

  var box = [ 0, 0, 1, 2 ];
  var point = [ 1, 1 ];
  var expected = [ 0.5, 1 ];

  var gotCenter = _.box.centerGet( box );
  test.equivalent( gotCenter,expected );

  var box = [ 0, 0, 1, 2 ];
  var gotCenter = _.box.centerGet( box, point );
  test.equivalent( gotCenter,expected );

  test.description = 'Three dimension box'; /* */

  var box = [ 0, - 1, - 2, 0, 1, 2 ];
  var expected = [ 0, 0, 0 ];
  var point = [ 2, 4, - 6 ];

  var gotCenter = _.box.centerGet( box );
  test.equivalent( gotCenter,expected );

  var box = [ 0, - 1, - 2, 0, 1, 2 ];

  var gotCenter = _.box.centerGet( box, point );
  test.equivalent( gotCenter,expected );

  test.description = 'Four dimension box'; /* */

  var box = [ 0, - 1, - 2, 2, 0, 1, 2, 6 ];
  var expected = [ 0, 0, 0, 4 ];
  var point = [ 2, 4, - 6, 2 ];

  var gotCenter = _.box.centerGet( box );
  test.equivalent( gotCenter,expected );

  var box = [ 0, - 1, - 2, 2, 0, 1, 2, 6 ];

  var gotCenter = _.box.centerGet( box, point );
  test.identical( gotCenter, expected );

  test.description = 'Eight dimension box'; /* */

  var box = [  0, - 1, - 2, 2, 0, 1, 2, 6, 0, - 1, - 2, 2, 0, 1, 2, 6 ];
  var point = [ 2, 4, - 6, 2, 2, 4, - 6, 2 ];
  var expected = [ 0, - 1, -2, 2, 0, 1, 2, 6 ];

  var gotCenter = _.box.centerGet( box );
  test.identical( gotCenter, expected );

  var box = [  0, - 1, - 2, 2, 0, 1, 2, 6, 0, - 1, - 2, 2, 0, 1, 2, 6 ];
  var gotCenter = _.box.centerGet( box, point );
  test.identical( gotCenter, expected );

  test.description = 'Point is vector'; /* */

  var box = [ 0, 0, 1, 2 ];
  var point = _.vector.from( [ 1, 1 ] );
  var expected = [ 0.5, 1 ];
  var expv = _.vector.from( expected );

  var gotCenter = _.box.centerGet( box );
  test.equivalent( gotCenter,expected );

  var box = [ 0, 0, 1, 2 ];
  var gotCenter = _.box.centerGet( box, point );
  test.equivalent( gotCenter,expv );

  test.description = 'Point is null'; /* */

  var box = [ 0, 0, 1, 2 ];
  var point = null;
  var expected = [ 0.5, 1 ];

  var gotCenter = _.box.centerGet( box );
  test.equivalent( gotCenter,expected );

  var box = [ 0, 0, 1, 2 ];
  var gotCenter = _.box.centerGet( box, point );
  test.equivalent( gotCenter,expected );

  test.description = 'Point is NaN'; /* */

  var box = [ 0, 0, 1, 2 ];
  var point = NaN;
  var expected = [ 0.5, 1 ];

  var gotCenter = _.box.centerGet( box );
  test.equivalent( gotCenter,expected );

  var box = [ 0, 0, 1, 2 ];
  var gotCenter = _.box.centerGet( box, point );
  test.equivalent( gotCenter, expected );


  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.centerGet();
  });

  test.description = 'Too many arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.centerGet( [ 0, 0, 1, 1 ], [ 0, 0, 0 ], [ 0, 0, 0 ] );
  });

  test.description = 'Wrong type of arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.centerGet( null );
  });

  test.description = 'Wrong type of arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.centerGet( 'string' );
  });

  test.description = 'Wrong type of arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.centerGet( null, [ 0, 0 ] );
  });

  test.description = 'Wrong type of arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.centerGet( 'string', [ 0, 0 ] );
  });


  test.description = 'Wrong type of arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.centerGet( [ 0, 0, 1, 1 ], 'string' );
  });

  test.description = 'Wrong box dimension'; /* */
  test.shouldThrowError( function()
  {
    _.box.centerGet( [ 0 ] );
  });

  test.description = 'Wrong box dimension'; /* */
  test.shouldThrowError( function()
  {
    _.box.centerGet( [ 0, 0, 0 ] );
  });

  test.description = 'Wrong box dimension'; /* */
  test.shouldThrowError( function()
  {
    _.box.centerGet( [ 0, 0, 0, 0, 0 ] );
  });

  test.description = 'Different dimension between box and point'; /* */
  test.shouldThrowError( function()
  {
    _.box.centerGet( [ 0, 0, 0, 0, 0, 0 ], [ 0, 0 ] );
  });

}


function cornerLeftGet( test )
{

  test.description = 'Source box remains unchanged'; /* */

  var srcBox = [ 0, 0, 1, 1 ];
  var oldsrcBox = srcBox.slice();
  var expected = [ 0, 0 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerLeftGet( srcBox );
  test.identical( gotCorner, expected );
  test.identical( srcBox, oldsrcBox );

  test.description = 'Empty box'; /* */

  var box = [];
  var expected = [];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerLeftGet( box );
  test.identical( gotCorner, expected );

  test.description = 'One dimension box'; /* */

  var box = [ 0, 1 ];
  var expected = [ 0 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerLeftGet( box );
  test.identical( gotCorner, expected );

  test.description = 'Two dimension box'; /* */

  var box = [ 0, 0, 1, 1 ];
  var expected = [ 0, 0 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerLeftGet( box );
  test.identical( gotCorner, expected );

  test.description = 'Three dimension box'; /* */

  var box = [ - 1, - 2, - 3, 0, 1, 2 ];
  var expected = [ - 1, - 2, - 3 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerLeftGet( box );
  test.identical( gotCorner, expected );

  test.description = 'Four dimension box'; /* */

  var box = [ - 1, - 2.2, - 3, 5, 0.1, 1, 2, 5.4 ];
  var expected = [ - 1, - 2.2, - 3, 5 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerLeftGet( box );
  test.identical( gotCorner, expected );

  test.description = 'Eight dimension box'; /* */

  var box = [ - 1, - 2.2, - 3, 5, 0.1, 1, 2, 5.4, - 1.1, - 3.2, - 3.5, 5.5, 2.3, 27, 2.2, 540 ];
  var expected = [ - 1, - 2.2, - 3, 5, 0.1, 1, 2, 5.4 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerLeftGet( box );
  test.identical( gotCorner, expected );

  test.description = 'Inverted box'; /* */

  var box = [ 1, 1, 0, 0 ];
  var expected = [ 1, 1 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerLeftGet( box );
  test.identical( gotCorner, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.cornerLeftGet();
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.cornerLeftGet( null );
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.cornerLeftGet( NaN );
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.cornerLeftGet( 'Hello' );
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.cornerLeftGet( [ 'Hello', world ] );
  });

  test.description = 'Wrong box dimension'; /* */
  test.shouldThrowError( function()
  {
    _.box.cornerLeftGet( [ 0 ] );
  });

  test.description = 'Wrong box dimension'; /* */
  test.shouldThrowError( function()
  {
    _.box.cornerLeftGet( [ 0, 0, 0 ] );
  });

  test.description = 'Wrong box dimension'; /* */
  test.shouldThrowError( function()
  {
    _.box.cornerLeftGet( [ 0, 0, 0, 0, 0 ] );
  });
}


function cornerRightGet( test )
{

  test.description = 'Source box remains unchanged'; /* */

  var srcBox = [ 0, 0, 1, 1 ];
  var oldSrcBox = srcBox.slice();
  var expected = [ 1, 1 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerRightGet( srcBox );
  test.identical( gotCorner, expected );
  test.identical( srcBox, oldSrcBox );

  test.description = 'Empty box'; /* */

  var box = [];
  var expected = [];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerRightGet( box );
  test.identical( gotCorner, expected );

  test.description = 'One dimension box'; /* */

  var box = [ 0, 1 ];
  var expected = [ 1 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerRightGet( box );
  test.identical( gotCorner, expected );

  test.description = 'Two dimension box'; /* */

  var box = [ 0, 0, 1, 1 ];
  var expected = [ 1, 1 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerRightGet( box );
  test.identical( gotCorner, expected );

  test.description = 'Three dimension box'; /* */

  var box = [ - 1, - 2, - 3, 0, 1, 2 ];
  var expected = [ 0, 1, 2 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerRightGet( box );
  test.identical( gotCorner, expected );

  test.description = 'Four dimension box'; /* */

  var box = [ - 1, - 2.2, - 3, 5, 0.1, 1, 2, 5.4 ];
  var expected = [ 0.1, 1, 2, 5.4 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerRightGet( box );
  test.identical( gotCorner, expected );

  test.description = 'Eight dimension box'; /* */

  var box = [ - 1, - 2.2, - 3, 5, 0.1, 1, 2, 5.4, - 1.1, - 3.2, - 5, 5.5, 2.3, 27, 2.2, 540 ];
  var expected = [ -1.1, - 3.2, - 5, 5.5, 2.3, 27, 2.2, 540 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerRightGet( box );
  test.identical( gotCorner, expected );

  test.description = 'Empty box at [ 1, 1 ]'; /* */

  var box = [ 1, 1, 0, 0 ];
  var expected = [ 0, 0 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerRightGet( box );
  test.identical( gotCorner, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.cornerRightGet();
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.cornerRightGet( null );
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.cornerRightGet( NaN );
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.cornerRightGet( 'Hello' );
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.cornerRightGet( [ 'Hello', world ] );
  });

  test.description = 'Wrong box dimension'; /* */
  test.shouldThrowError( function()
  {
    _.box.cornerRightGet( [ 0 ] );
  });

  test.description = 'Wrong box dimension'; /* */
  test.shouldThrowError( function()
  {
    _.box.cornerRightGet( [ 0, 0, 0 ] );
  });

  test.description = 'Wrong box dimension'; /* */
  test.shouldThrowError( function()
  {
    _.box.cornerRightGet( [ 0, 0, 0, 0, 0 ] );
  });
}


function sizeGet( test )
{

  test.description = 'Source box remains unchanged, point changes'; /* */

  var srcBox = [ 0, 0, 1, 1 ];
  var oldSrcBox = srcBox.slice();
  var point = [ 0, 5 ];
  var expected = [ 1, 1 ];

  var gotSize = _.box.sizeGet( srcBox, point );
  test.equivalent( gotSize, expected );
  test.equivalent( point, expected );
  test.equivalent( srcBox, oldSrcBox );

  test.description = 'Empty box'; /* */

  var box = [];
  var point = [];
  var expected = [] ;

  var gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );

  var gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );
  debugger;

  test.description = 'One dimension box'; /* */

  var box = [ 0, 0 ];
  var point = [ 0 ];
  var expected = [ 0 ];

  var gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );

  var box = [ 0, 0 ];
  var gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  test.description = 'Two dimension box'; /* */

  var box = [ 0, 1, 1, 2 ];
  var point = [ 2, 4 ];
  var expected = [ 1, 1 ];

  var gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  var box = [ 0, 1, 1, 2 ];
  var gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );

  test.description = 'Three dimension box'; /* */

  var box = [ 0, - 1, - 2, 0, 1, 2 ];
  var expected = [ 0, 2, 4 ];
  var point = [ 2, 4, - 6 ];

  var gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  var box = [ 0, - 1, - 2, 0, 1, 2 ];

  var gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );

  test.description = 'Four dimension box'; /* */

  var box = [ 0, - 1, - 2, 2, 0, 1, 2, 6 ];
  var expected = [ 0, 2, 4, 4 ];
  var point = [ 2, 4, - 6, 2 ];

  var gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  var box = [ 0, - 1, - 2, 2, 0, 1, 2, 6 ];

  var gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );

  test.description = 'Eight dimension box'; /* */

  var box = [  0, - 1, - 2, 2, 0, 1, 2, 6, 0, - 1, - 2, 2, 0, 1, 2, 6 ];
  var point = [ 2, 4, - 6, 2, 2, 4, - 6, 2 ];
  var expected = [ 0, 0, 0, 0, 0, 0, 0, 0 ];

  var gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  var box = [  0, - 1, - 2, 2, 0, 1, 2, 6, 0, - 1, - 2, 2, 0, 1, 2, 6 ];
  var gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );


  test.description = 'Point is vector'; /* */

  var box = [ 0, 0, 1, 2 ];
  var point = _.vector.from( [ 1, 1 ] );
  var expected = [ 1, 2 ];
  var expv = _.vector.from( expected );

  var gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  var box = [ 0, 0, 1, 2 ];
  var gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expv );

  test.description = 'Point is null'; /* */

  var box = [ 0, 0, 1, 2 ];
  var point = null;
  var expected = [ 1, 2 ];

  var gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  var box = [ 0, 0, 1, 2 ];
  var gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );

  test.description = 'Point is NaN'; /* */

  var box = [ 0, 0, 1, 2 ];
  var point = NaN;
  var expected = [ 1, 2 ];

  var gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  var box = [ 0, 0, 1, 2 ];
  var gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );

  test.description = 'Empty box'; /* */

  var box = [ 1, 1, 0, 0 ];
  var point = NaN;
  var expected = [ - 1, - 1 ];

  var gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  var box = [ 1, 1, 0, 0 ];
  var gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.sizeGet();
  });

  test.description = 'Too many arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.sizeGet( [ 0, 0, 1, 1 ], [ 0, 0, 0 ], [ 0, 0, 0 ] );
  });

  test.description = 'Wrong type of arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.sizeGet( null );
  });

  test.description = 'Wrong type of arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.sizeGet( 'string' );
  });

  test.description = 'Wrong type of arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.sizeGet( null, [ 0, 0 ] );
  });

  test.description = 'Wrong type of arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.sizeGet( 'string', [ 0, 0 ] );
  });

  test.description = 'Wrong type of arguments'; /* */

  test.shouldThrowError( function()
  {
    _.box.sizeGet( [ 0, 0, 1, 1 ], 'string' );
  });

  test.description = 'Wrong box dimension'; /* */
  test.shouldThrowError( function()
  {
    _.box.sizeGet( [ 0 ] );
  });

  test.description = 'Wrong box dimension'; /* */
  test.shouldThrowError( function()
  {
    _.box.sizeGet( [ 0, 0, 0 ] );
  });

  test.description = 'Wrong box dimension'; /* */
  test.shouldThrowError( function()
  {
    _.box.sizeGet( [ 0, 0, 0, 0, 0 ] );
  });

  test.description = 'Different dimension between box and point'; /* */
  test.shouldThrowError( function()
  {
    _.box.sizeGet( [ 0, 0, 0, 0, 0, 0 ], [ 0, 0 ] );
  });

}

//

function fromPoints( test )
{

  test.description = 'Points remain unchanged and Destination box changes'; /* */

  var points = [ [ 1, 1 ], [ 0, 0 ], [ 0, 2 ] ];
  var expected = [ 0, 0, 1, 2 ];
  var dstBox = [ 0, 0, 1, 1 ];

  var gotBox = _.box.fromPoints( dstBox, points );
  test.identical( gotBox, expected );
  test.identical( dstBox, expected );

  var oldpoints = [ [ 1, 1 ], [ 0, 0 ], [ 0, 2 ] ];
  test.identical( points, oldpoints );

  test.description = 'Create box of two dimensions'; /* */

  var box = null;
  var points = [ [ 1, 0 ], [ 0, - 2 ], [ 0, 3 ], [ - 1, 2 ] ];
  var expected = [ - 1, - 2, 1, 3 ];

  var gotBox = _.box.fromPoints( box, points );
  test.identical( gotBox, expected );

  test.description = 'Create box three dimensions'; /* */

  var box = null;
  var points = [ [ 1, 0, 0 ], [ 0, 2, 0 ], [ 0, 0, 3 ] ];
  var expected = [ 0, 0, 0, 1, 2, 3 ];

  var gotBox = _.box.fromPoints( box, points );
  test.identical( gotBox, expected );

  test.description = 'Zero points - box not expanded'; /* */

  var box = null;
  var points = [ [ 0, 0, 0 ], [ 0, 0, 0 ] ];
  var expected = [ 0, 0, 0, 0, 0, 0 ];

  var gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  test.description = 'Box expanded'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var points = [ [ - 1, 0, - 1 ], [ 0, 3, 0 ], [ 0, - 3, 0 ], [ 2, 2, 3 ] ] ;
  var expected = [ - 1, - 3, - 1, 2, 3, 3 ];

  var gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  test.description = 'Box out of one point'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var points = [ [ - 1, 0, - 1 ] ] ;
  var expected = [ - 1, 0, - 1, 2, 2, 2 ];

  var gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  test.description = 'Box NOT expanded ( points inside box )'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var points = [ [ 0, 1, 1 ], [ 1, 0, 1 ], [ 1, 1, 0 ] ];
  var expected = [ 0,  0, 0, 2, 2, 2 ];

  var gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  test.description = 'Box ( normalized to 1 ) expanded'; /* */

  var box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  var points = [ [ - 0.900, 0, 0.900 ], [ 0, - 0.001, 0 ], [ 0.900, 0, - 0.900 ] ];
  var expected = [ - 0.900,  - 0.001, - 0.900, 0.900, 0.766, 0.900 ];

  var gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  test.description = 'Null box of four dimensions expanded'; /* */

  var box = [ 0, 0, 0, 0, 0, 0, 0, 0 ];
  var points = [ [ - 1, - 2, - 3 , - 4 ], [ 1, 2, 3 , 4 ] ];
  var expected = [ - 1, - 2, - 3 , - 4, 1, 2, 3, 4 ];

  var gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  test.description = 'Null box of 7 dimensions expanded'; /* */

  var box = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ];
  var points = [ [ 1, 2, 3 , 0, 0, 0, 0 ], [ 0, 0, 0 , 4, 5, 6, 7 ] ] ;
  var expected = [ 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7 ];

  var gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  test.description = 'Box of 1 dimension expanded'; /* */

  var box = [ 0, 0 ];
  var points = [ [ - 1 ], [ 0 ], [ 1 ] ];
  var expected = [ - 1, 1 ];

  var gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  test.description = 'Box of 0 dimension expanded'; /* */

  var box = [ ];
  var points= [ [], [] ];
  var expected = [ ];

  var gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromPoints();
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromPoints( 'box', 'points' );
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromPoints( null, 4 );
  });

  test.description = 'Too few arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromPoints( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.description = 'Too few arguments - one point'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromPoints( [ 0, 0, 0, 0, 0, 0 ], [ 1, 1, 1 ]);
  });

  test.description = 'too many arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromPoints( [ 0, 0, 0, 0, 0, 0 ], [ [ 0, 1 ], [ 2, 1 ], [ 0, 3 ] ], [ 1, 0, 1 ] );
  });

  test.description = 'Wrong points dimension (box 3D vs points 4D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromPoints( [ 0, 0, 0, 0, 0, 0 ], [ [ 0, 1, 0, 2 ], [ 0, 1, - 3, 4 ] ] );
  });

  test.description = 'Wrong points dimension (box 3D vs points 2D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromPoints( [ 0, 0, 0, 0, 0, 0 ], [ [ 0, 1 ], [ 2, 1 ], [ 0, 3 ] ] );
  });

  test.description = 'Wrong points dimension (box 2D vs points 1D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromPoints( [ 0, 0, 0, 0 ], [ [ 1 ], [ 0 ] ] );
  });
}



//

function fromCenterAndSize( test )
{

  test.description = 'Center and size remain unchanged and Destination box changes'; /* */

  var dstBox = [ 0, 0, 1, 1 ];
  var center = [ 1, 1 ];
  var oldcenter = center.slice();
  var size = [ 4, 4 ];
  var oldsize = size.slice();
  var expected = [ - 1, - 1, 3, 3 ];

  var gotBox = _.box.fromCenterAndSize( dstBox, center, size );
  test.identical( gotBox, expected );
  test.identical( dstBox, expected );
  test.identical( center, oldcenter );
  test.identical( size, oldsize );

  test.description = 'Empty box'; /* */

  var box = [ ];
  var center = [ ];
  var size = [ ];
  var expected = [ ];

  var gotBox = _.box.fromCenterAndSize( box, center, size );
  test.identical( gotBox, expected );

  test.description = 'Trivial expansion'; /* */

  var box = [ 0, 1, 1, 0 ];
  var center = [ 1, 1 ];
  var size = [ 4, 4 ];
  var expected = [ - 1, - 1, 3, 3 ];

  var gotBox = _.box.fromCenterAndSize( box, center, size );
  test.identical( gotBox, expected );

  test.description = 'Different sizes expansion'; /* */

  var box = [ 2, 2, 3, 3 ];
  var center = [ 1, 1 ];
  var size = [ 4, 2 ];
  var expected = [ - 1, 0, 3, 2 ];

  var gotBox = _.box.fromCenterAndSize( box, center, size );
  test.identical( gotBox, expected );

  test.description = 'Decimal values'; /* */

  var box = [ 1.2, 2.4, 3.3, 4.8 ];
  var center = [ 1.5, 0.79 ];
  var size = [ 0.5, 0.2 ];
  var expected = [ 1.25, 0.69, 1.75, 0.89 ];

  var gotBox = _.box.fromCenterAndSize( box, center, size );
  test.equivalent( gotBox, expected );

  test.description = 'Negative size'; /* */

  var box = [ 0, 0, 0, 0 ];
  var center = [ 0, 0 ];
  var size = [ -2, -2 ];
  var expected = [ 1, 1, - 1, - 1 ];

  var gotBox = _.box.fromCenterAndSize( box, center, size );
  test.identical( gotBox, expected );

  test.description = 'Box of three dimensions'; /* */

  var box = [ 1, 3, 2, 2, 4, 4 ];
  var center = [ 1, 1, 1 ];
  var size = [ 4, 4, 2 ];
  var expected = [ - 1, - 1, 0, 3, 3, 2 ];

  var gotBox = _.box.fromCenterAndSize( box, center, size );
  test.identical( gotBox, expected );

  test.description = 'NaN box'; /* */

  var box = [ NaN, NaN, NaN, NaN ];
  var center = [ NaN, NaN ];
  var size = [ NaN, NaN ];
  var expected = [ NaN, NaN, NaN, NaN ];

  var gotBox = _.box.fromCenterAndSize( box, center, size );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromCenterAndSize();
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromCenterAndSize( 'box', 'center', 'size' );
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromCenterAndSize( null, 4, 5 );
  });

  test.description = 'Too few arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromCenterAndSize( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.description = 'Too few arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromCenterAndSize( [ 0, 0, 0, 0, 0, 0 ], [ 1, 1, 1 ]);
  });

  test.description = 'too many arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromCenterAndSize( [ 0, 0, 0, 0, 0, 0 ], [ 1, 1, 1 ], [ 1, 0, 1 ], [ 1, 1, 0 ] );
  });

  test.description = 'Wrong points dimension (box 3D vs points 4D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromCenterAndSize( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0, 2 ], [ 0, 1, - 3, 4 ] );
  });

  test.description = 'Wrong points dimension (box 3D vs points 2D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromCenterAndSize( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1 ], [ 2, 1 ] );
  });

  test.description = 'Wrong points dimension (box 2D vs points 1D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromCenterAndSize( [ 0, 0, 0, 0 ],  [ 1 ], [ 0 ]  );
  });

}


//

function fromSphere( test )
{

  test.description = 'Center and size remain unchanged and Destination box changes'; /* */

  var dstBox = [ 0, 0, 1, 1 ];
  var sphere = [ 1, 1, 1 ];
  var oldsphere = sphere.slice();
  var expected = [ - 1, - 1, 2, 2 ];

  var gotBox = _.box.fromSphere( dstBox, sphere );
  test.identical( gotBox, expected );
  test.identical( dstBox, expected );
  test.identical( sphere, oldsphere );

  test.description = 'Create box from sphere 1D same center'; /* */

  var box = [ 0, 0 ];
  var sphere = [ 0, 1 ];
  var expected = [ - 1, 1 ];

  var gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.description = 'Create box from sphere 1D different centers'; /* */

  var box = [ 0, 0 ];
  var sphere = [ 1, 1 ];
  var expected = [ - 1, 2 ];

  var gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.description = 'Expand from sphere - sphere in box'; /* */

  var box = [ 0, 2 ];
  var sphere = [ 1, 1 ];
  var expected = [ - 1, 3 ];

  var gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.description = 'Expand from sphere - sphere out of box'; /* */

  var box = [ 0, 2 ];
  var sphere = [ 3, 1 ];
  var expected = [ - 1, 4 ];

  var gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.description = 'Create box from sphere 3D same center'; /* */

  var box = [ 0, 0, 0, 0, 0, 0 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = [ - 1, - 1, - 1, 1, 1, 1 ];

  var gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.description = 'Create box from sphere 3D different center'; /* */

  var box = [ 0, 0, 0, 0, 0, 0 ];
  var sphere = [ 1, 1, 1, 1 ];
  var expected = [ - 1, - 1, - 1, 2, 2, 2 ];

  var gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.description = 'Expand from sphere 3D sphere in box'; /* */

  var box = [ 0, 0, 0, 2, 2, 3 ];
  var sphere = [ 1, 1, 1, 1 ];
  var expected = [ - 1, - 1, - 1, 3, 3, 4 ];

  var gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.description = 'Expand from sphere 3D sphere out box'; /* */

  var box = [ 0, 0, 0, 2, 2, 3 ];
  var sphere = [ 3, 3, 3, 1 ];
  var expected = [ - 1, - 1, - 1, 4, 4, 4 ];

  var gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.description = 'Contract Sphere - sphere in box'; /* */

  var box = [ 0, 0, 0, 2, 2, 3 ];
  var sphere = [ 1, 1, 1, - 1 ];
  var expected = [ 1, 1, 1, 1, 1, 2 ];

  var gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.description = 'Contract Sphere - sphere out of box'; /* */

  var box = [ 0, 0, 0, 2, 2, 3 ];
  var sphere = [ 3, 3, 3, - 1 ];
  var expected = [ 1, 1, 1, 2, 2, 2 ];

  var gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.description = 'NaN box'; /* */

  var box = [ NaN, NaN ];
  var sphere = [ 1, 1 ];
  var expected = [ NaN, NaN ];

  var gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.description = 'NaN Sphere'; /* */

  var box = [ 0, 2 ];
  var sphere = [ NaN, NaN ];
  var expected = [ NaN, NaN ];

  var gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromSphere();
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromSphere( 'box', 'sphere' );
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromSphere( null, [ 0, 1 ] );
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromSphere( [ 0, 1 ], null );
  });

  test.description = 'Too few arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromSphere( [ 0, 0, 0, 0, 0, 0 ]);
  });

  test.description = 'too many arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromSphere( [ 0, 0, 0, 0, 0, 0 ], [ 1, 1, 1, 1], [ 1, 1, 0, 0 ] );
  });

  test.description = 'Wrong box dimension'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromSphere( [ 0 ], [ 0 ] );
  });

  test.description = 'Wrong dimension (box 3D vs sphere 4D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromSphere( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0, 2, 1 ] );
  });

  test.description = 'Wrong dimension (box 3D vs sphere 2D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromSphere( [ 0, 0, 0, 0, 0, 0 ], [ 0, 2, 1 ] );
  });

  test.description = 'Wrong dimension (box 2D vs sphere 1D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromSphere( [ 0, 0, 0, 0 ],  [ 0, 1 ]  );
  });

}


//

function expand( test )
{

  test.description = 'Expansion array remains unchanged and Destination box changes'; /* */

  var dstBox = [ 0, 0, 1, 1 ];
  var expand = [ 0, 2 ];
  var oldexpand = expand.slice();
  var expected = [ 0, - 2, 1, 3 ];

  var gotBox = _.box.expand( dstBox, expand );
  test.identical( gotBox, expected );
  test.identical( dstBox, expected );
  test.identical( expand, oldexpand );

  test.description = 'Null box expanded'; /* */

  var box = null;
  var expand = [ 1, 2, 3 ];
  var expected = [ - 1, - 2, - 3, 1, 2, 3 ];

  var gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.description = 'Null box NOT expanded'; /* */

  var box = null;
  var expand = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0, 0, 0 ];

  var gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.description = 'One side box expanded'; /* */

  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expand = [ 0, 0,  3 ];
  var expected = [ 0,  0, - 3, 0, 0, 3 ];

  var gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.description = 'Box expanded'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expand = [ 1, 3, 1 ];
  var expected = [ - 1, - 3, - 1, 3, 5, 3 ];

  var gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.description = 'Box expanded by value'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expand = 1;
  var expected = [ - 1, - 1, - 1, 3, 3, 3 ];

  var gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.description = 'Box NOT expanded ( empty expand array )'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expand = [  0, 0, 0 ];
  var expected = [ 0,  0, 0, 2, 2, 2 ];

  var gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.description = 'Box contracted'; /* */

  var box = [ 0, 0, 0, 3, 3, 3 ];
  var expand = [ - 1, - 1, - 1 ];
  var expected = [ 1, 1, 1, 2, 2, 2 ];

  var gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.description = 'Box with decimal numbers expanded'; /* */

  var box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  var expand = [ -0.100, 0, 0.100 ];
  var expected = [  0.050,  0.002, -0.338, 0.094, 0.766, 0.866 ];

  var gotBox = _.box.expand( box, expand );
  test.equivalent( gotBox, expected );

  test.description = 'Null box of four dimensions expanded'; /* */

  var box = [ 0, 0, 0, 0, 0, 0, 0, 0 ];
  var expand = [ 1, 2, 3 , 4 ];
  var expected = [ - 1, - 2, - 3, - 4, 1, 2, 3, 4 ];

  var gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.description = 'Null box of 7 dimensions expanded'; /* */

  var box = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ];
  var expand = [ 1, 2, 3 , 4, 5, 6, 7 ];
  var expected = [ - 1, - 2, - 3, - 4, - 5, - 6, - 7, 1, 2, 3, 4, 5, 6, 7 ];

  var gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.description = 'Box of 1 dimension expanded'; /* */

  var box = [ 0, 0 ];
  var expand = [ 1 ];
  var expected = [ - 1, 1 ];

  var gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.description = 'Box of 0 dimension expanded'; /* */

  var box = [ ];
  var expand = [ ];
  var expected = [ ];

  var gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.description = 'Null box expanded by value'; /* */

  var box = null;
  var expand =  4 ;
  var expected = [ - 4, -4, -4, 4, 4, 4 ];

  var gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.expand();
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.expand( 'box', 'expand' );
  });

  test.description = 'Too few arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.expand( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.description = 'too many arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.expand( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0 ], [ 1, 0, 1 ] );
  });

  test.description = 'Wrong expand array dimension (box 3D vs array 4D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.expand( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0, 2 ] );
  });

  test.description = 'Wrong expand array dimension (box 3D vs array 2D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.expand( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1 ] );
  });

  test.description = 'Wrong expand array dimension (box 2D vs array 1D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.expand( [ 0, 0, 0, 0 ], [ 0 ] );
  });

  test.description = 'Wrong expand array dimension (null box vs array 2D)'; /* */
  test.shouldThrowError( function()
  {
    _.box.expand( null, [ 0, 1 ] );
  });

}

//

function fromCube( test )
{

  test.description = 'Cube remains unchanged and Destination box changes'; /* */

  var dstBox = [ 0, 0, 1, 1 ];
  var cube = 1;
  var expected = [ - 0.5, - 0.5, 0.5, 0.5 ];

  var gotBox = _.box.fromCube( dstBox, cube );
  test.identical( gotBox, expected );
  test.identical( dstBox, expected );

  var oldcube = 1;
  test.identical( cube, oldcube );

  test.description = 'Null box from cube'; /* */

  var box = null;
  var fromCube = 2;
  var expected = [ - 1, - 1, - 1, 1, 1, 1 ];

  var gotBox = _.box.fromCube( box, fromCube );
  test.identical( gotBox, expected );

  test.description = 'Null box NOT from cube'; /* */

  /* qqq : the first case has different style, should has the same */

  var box = null;
  var fromCube = 0 ;
  var expected = [ -0, -0, -0, 0, 0, 0 ];

  var gotBox = _.box.fromCube( box, fromCube );
  test.identical( gotBox, expected );

  test.description = 'Box from cube'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var fromCube = 6;
  var expected = [ - 3, - 3, - 3, 3, 3, 3 ];

  var gotBox = _.box.fromCube( box, fromCube );
  test.identical( gotBox, expected );

  test.description = 'clean box'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var fromCube =  0;
  var expected = [ - 0, - 0, - 0, 0, 0, 0 ];

  var gotBox = _.box.fromCube( box, fromCube );
  test.identical( gotBox, expected );

  test.description = 'Box contracted'; /* */

  var box = [ 0, 0, 0, 3, 3, 3 ];
  var fromCube = - 1;
  var expected = [ 0.5, 0.5, 0.5, - 0.5, - 0.5, - 0.5 ];

  var gotBox = _.box.fromCube( box, fromCube );
  test.identical( gotBox, expected );

  test.description = 'Box with decimal numbers from cube'; /* */

  var box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  var fromCube =  0.100;
  var expected = [  - 0.050, - 0.050, - 0.050, 0.050, 0.050, 0.050 ];

  var gotBox = _.box.fromCube( box, fromCube );
  test.equivalent( gotBox, expected );

  test.description = 'Null box of four dimensions from cube'; /* */

  var box = [ 0, 0, 0, 0, 0, 0, 0, 0 ];
  var fromCube = 4;
  var expected = [ - 2, - 2, - 2, - 2, 2, 2, 2, 2 ];

  var gotBox = _.box.fromCube( box, fromCube );
  test.identical( gotBox, expected );

  test.description = 'Null box of 7 dimensions from cube'; /* */

  var box = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ];
  var fromCube = 8;
  var expected = [ - 4, - 4, - 4, - 4, - 4, - 4, - 4, 4, 4, 4, 4, 4, 4, 4 ];

  gotBox = _.box.fromCube( box, fromCube );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromCube();
  });

  test.description = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromCube( 'box', 'cube' );
  });

  test.description = 'Cube not number'; /* */

  test.shouldThrowError( function()
  {
    _.box.fromCube( [ 0, 0, 1, 1 ], [ 1, 2 ] );
  });

  test.description = 'Cube not number'; /* */

  test.shouldThrowError( function()
  {
    _.box.fromCube( [ 0, 0 ], [ 1 ] );
  });

  test.description = 'Empty cube and box'; /* */

  test.shouldThrowError( function()
  {
    _.box.fromCube( [ ], [ ] );
  });

  test.description = 'Wrong type of argument'; /* */

  test.shouldThrowError( function()
  {
    _.box.fromCube( 'box', 3 );
  });

  test.description = 'Too few arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromCube( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.description = 'too many arguments'; /* */
  test.shouldThrowError( function()
  {
    _.box.fromCube( [ 0, 0, 0, 0, 0, 0 ], 2, 3 );
  });

}


// --
// define class
// --

var Self =
{

  name : 'Tools/Math/Box',
  silencing : 1,
  // verbosity : 7,
  // debug : 1,
  // routine: 'fromCube',

  tests :
  {

    is : is,
    isEmpty : isEmpty,
    isZero : isZero,
    isNil : isNil,

    make : make,
    makeZero : makeZero,
    makeNil : makeNil,

    zero : zero,
    nil : nil,
    centeredOfSize : centeredOfSize,
    boxFromPoints : boxFromPoints,

    pointExpand : pointExpand,
    pointContains : pointContains,
    pointRelative : pointRelative,
    pointClamp : pointClamp,
    pointDistance : pointDistance,

    boxContains : boxContains,
    boxIntersects : boxIntersects,
    boxExpand : boxExpand,
    expand : expand,

    dimGet : dimGet,
    cornerLeftGet : cornerLeftGet,
    cornerRightGet : cornerRightGet,
    centerGet : centerGet,
    sizeGet : sizeGet,

    fromPoints : fromPoints,
    fromCenterAndSize : fromCenterAndSize,
    fromSphere : fromSphere,
    fromCube : fromCube, /* qqq : has problems */
  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
