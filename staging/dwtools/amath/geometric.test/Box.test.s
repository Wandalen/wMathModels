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

  test.description = 'array'; //

  test.is( _.box.is( [] ) );
  test.is( _.box.is([ 0,0 ]) );
  test.is( _.box.is([ 1,2,3,4 ]) );
  test.is( _.box.is([ 0,0,0,0,0,0 ]) );

  test.description = 'vector'; //

  test.is( _.box.is( _.vector.fromArray([]) ) );
  test.is( _.box.is( _.vector.fromArray([ 0,0 ]) ) );
  test.is( _.box.is( _.vector.fromArray([ 1,2,3,4 ]) ) );
  test.is( _.box.is( _.vector.fromArray([ 0,0,0,0,0,0 ]) ) );

  test.description = 'not box'; //

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

  test.description = 'empty'; //

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

  test.description = 'not empty'; //

  test.is( !_.box.isEmpty([ 0,1 ]) );

  test.is( !_.box.isEmpty([ 0,+Infinity ]) );
  test.is( !_.box.isEmpty([ -Infinity,0,0,+Infinity ]) );

  test.is( !_.box.isEmpty([ 0.1,+Infinity ]) );
  test.is( !_.box.isEmpty([ 0,0.00001,0.1,+Infinity ]) );

}

//

function isZero( test )
{

  test.description = 'zero'; //

  test.is( _.box.isZero([]) );
  test.is( _.box.isZero([ 0,0 ]) );
  test.is( _.box.isZero([ 0,0,0,0,0,0 ]) );
  test.is( _.box.isZero([ 1,1 ]) );
  test.is( _.box.isZero([ 5,0,5,0 ]) );
  test.is( _.box.isZero([ -3,0,5,-3,0,5 ]) );

  test.description = 'not zero'; //

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

  test.description = 'nil'; //

  test.is( _.box.isNil([ +Infinity,+Infinity,-Infinity,-Infinity ]) );
  test.is( _.box.isNil([ +Infinity,+Infinity,+Infinity,-Infinity,-Infinity,-Infinity ]) );

  test.is( _.box.isNil([ +1,+1,-2,-5 ]) );
  test.is( _.box.isNil([ +1,+1,+1,-2,-3,-4 ]) );

  test.description = 'not nil'; //

  test.is( !_.box.isNil([ 0,Infinity ]) );
  test.is( !_.box.isNil([ 0,0,0,Infinity ]) );

  test.is( !_.box.isNil([ Infinity,Infinity ]) );
  test.is( !_.box.isNil([ 0,0,0.1,Infinity ]) );

}

//

function make( test )
{

  test.description = 'src undefined'; //

  var src = undefined;
  var got = _.box.make( src );
  var expected = [ 0,0,0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src null'; //

  var src = null;
  var got = _.box.make( src );
  var expected = [ 0,0,0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src 2'; //

  var src = 2;
  var got = _.box.make( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src array'; //

  var src = [ 0,1,2,3 ];
  var got = _.box.make( src );
  var expected = [ 0,1,2,3 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src vector'; //

  var src = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.box.make( src );
  var expected = [ 0,1,2,3 ];
  test.identical( got,expected );
  test.is( got !== src );

}

//

function makeZero( test )
{

  test.description = 'src undefined'; //

  var src = undefined;
  var got = _.box.makeZero( src );
  var expected = [ 0,0,0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src null'; //

  var src = null;
  var got = _.box.makeZero( src );
  var expected = [ 0,0,0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src 2'; //

  var src = 2;
  var got = _.box.makeZero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src array'; //

  var src = [ 0,1,2,3 ];
  var got = _.box.makeZero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src vector'; //

  var src = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.box.makeZero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

}

//

function makeNil( test )
{

  test.description = 'src undefined'; //

  var src = undefined;
  var got = _.box.makeNil( src );
  var expected = [ +Infinity,+Infinity,+Infinity,-Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src null'; //

  var src = null;
  var got = _.box.makeNil( src );
  var expected = [ +Infinity,+Infinity,+Infinity,-Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src 2'; //

  var src = 2;
  var got = _.box.makeNil( src );
  var expected = [ +Infinity,+Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src array'; //

  var src = [ 0,1,2,3 ];
  var got = _.box.makeNil( src );
  var expected = [ +Infinity,+Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src vector'; //

  var src = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.box.makeNil( src );
  var expected = [ +Infinity,+Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

}

//

function zero( test )
{

  test.description = 'src undefined'; //

  var src = undefined;
  var got = _.box.zero( src );
  var expected = [ 0,0,0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src null'; //

  var src = null;
  var got = _.box.zero( src );
  var expected = [ 0,0,0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src 2'; //

  var src = 2;
  var got = _.box.zero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'dst array'; //

  var dst = [ 0,1,2,3 ];
  var got = _.box.zero( dst );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got === dst );

  test.description = 'dst vector'; //

  var dst = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.box.zero( dst );
  var expected = _.vector.fromArray([ 0,0,0,0 ]);
  test.identical( got,expected );
  test.is( got === dst );

  test.description = 'dst array 1d'; //

  var dst = [ 0,1 ];
  var got = _.box.zero( dst );
  var expected = [ 0,0 ];
  test.identical( got,expected );
  test.is( got === dst );

}

//

function nil( test )
{

  test.description = 'src undefined'; //

  var src = undefined;
  var got = _.box.nil( src );
  var expected = [ +Infinity,+Infinity,+Infinity,-Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src null'; //

  var src = null;
  var got = _.box.nil( src );
  var expected = [ +Infinity,+Infinity,+Infinity,-Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src 2'; //

  var src = 2;
  var got = _.box.nil( src );
  var expected = [ +Infinity,+Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'dst array'; //

  var dst = [ 0,1,2,3 ];
  var got = _.box.nil( dst );
  var expected = [ +Infinity,+Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got === dst );

  test.description = 'dst vector'; //

  var dst = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.box.nil( dst );
  var expected = _.vector.fromArray([ +Infinity,+Infinity,-Infinity,-Infinity ]);
  test.identical( got,expected );
  test.is( got === dst );

  test.description = 'dst array 2d'; //

  var dst = [ 1,3 ];
  var got = _.box.nil( dst );
  var expected = [ +Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got === dst );

}

//

function centeredOfSize( test )
{

  test.description = 'src undefined'; //

  var src = undefined;
  var got = _.box.centeredOfSize( src,2 );
  var expected = [ -1,-1,-1,+1,+1,+1 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src null'; //

  var src = null;
  var got = _.box.centeredOfSize( src,2 );
  var expected = [ -1,-1,-1,+1,+1,+1 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src 2'; //

  var src = 2;
  var got = _.box.centeredOfSize( src,2 );
  var expected = [ -1,-1,+1,+1 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'dst array'; //

  var dst = [ 0,1,2,3 ];
  var got = _.box.centeredOfSize( dst,2 );
  var expected = [ -1,-1,+1,+1 ];
  test.identical( got,expected );
  test.is( got === dst );

  test.description = 'dst vector'; //

  var dst = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.box.centeredOfSize( dst,2 );
  var expected = _.vector.fromArray([ -1,-1,+1,+1 ]);
  test.identical( got,expected );
  test.is( got === dst );

  test.description = 'dst array 2d'; //

  var dst = [ 1,3 ];
  var got = _.box.centeredOfSize( dst,2 );
  var expected = [ -1,+1 ];
  test.identical( got,expected );
  test.is( got === dst );

  /* */

  test.description = 'src undefined, implicit size'; //

  var src = undefined;
  var got = _.box.centeredOfSize( src );
  var expected = [ -0.5,-0.5,-0.5,+0.5,+0.5,+0.5 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src null, implicit size'; //

  var src = null;
  var got = _.box.centeredOfSize( src );
  var expected = [ -0.5,-0.5,-0.5,+0.5,+0.5,+0.5 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src 2, implicit size'; //

  var src = 2;
  var got = _.box.centeredOfSize( src );
  var expected = [ -0.5,-0.5,+0.5,+0.5 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'dst array, implicit size'; //

  var dst = [ 0,1,2,3 ];
  var got = _.box.centeredOfSize( dst );
  var expected = [ -0.5,-0.5,+0.5,+0.5 ];
  test.identical( got,expected );
  test.is( got === dst );

  test.description = 'dst vector, implicit size'; //

  var dst = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.box.centeredOfSize( dst );
  var expected = _.vector.fromArray([ -0.5,-0.5,+0.5,+0.5 ]);
  test.identical( got,expected );
  test.is( got === dst );

  test.description = 'dst array 2d, implicit size'; //

  var dst = [ 1,3 ];
  var got = _.box.centeredOfSize( dst );
  var expected = [ -0.5,+0.5 ];
  test.identical( got,expected );
  test.is( got === dst );

  /* */

  test.description = 'src undefined with sizes in array'; //

  var src = undefined;
  var got = _.box.centeredOfSize( src,[ 1,2,4 ] );
  var expected = [ -0.5,-1,-2,+0.5,+1,+2 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src null with sizes in array'; //

  var src = null;
  var got = _.box.centeredOfSize( src,[ 1,2,4 ] );
  var expected = [ -0.5,-1,-2,+0.5,+1,+2 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'src 2 with sizes in array'; //

  var src = 2;
  var got = _.box.centeredOfSize( src,[ 2,4 ] );
  var expected = [ -1,-2,+1,+2 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.description = 'dst array with sizes in array'; //

  var dst = [ 0,1,2,3 ];
  var got = _.box.centeredOfSize( dst,[ 2,4 ] );
  var expected = [ -1,-2,+1,+2 ];
  test.identical( got,expected );
  test.is( got === dst );

  test.description = 'dst vector with sizes in array'; //

  var dst = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.box.centeredOfSize( dst,[ 2,4 ] );
  var expected = _.vector.fromArray([ -1,-2,+1,+2 ]);
  test.identical( got,expected );
  test.is( got === dst );

  test.description = 'dst array 2d with sizes in array'; //

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

  test.description = 'trivial'; //

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

  test.description = 'same sizes, different position'; //

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

  test.description = 'different sizes, different position'; //

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

  test.description = 'bad arguments'; //

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

  test.description = 'Box from two points'; //

  var pointone = [ - 1, 2, - 3 ];
  var pointtwo = [ 1, - 2, 3 ];
  var expected = [ - 1, - 2, - 3, 1, 2, 3 ];

  var points = [ pointone, pointtwo ];
  var bbox  = null;

  bbox  = _.box.fromPoints( bbox, points );
  test.equivalent( bbox, expected );

  test.description = 'Box from three points'; //

  var expected = [ - 1, - 2, - 3, 1, 2, 6 ];
  var pointone = [ - 1, 2, - 3 ];
  var pointtwo = [ 1, - 2, 3 ];
  var pointthree = [ 0, 0, 6 ];

  var points = [ pointone, pointtwo, pointthree ];
  var bbox  = null;

  bbox  = _.box.fromPoints( bbox, points );
  test.equivalent( bbox, expected );

  test.description = 'Box from six points'; //

  var expected = [ -3, - 2, - 1, 1, 2, 3 ];
  var pointone = [ 0, 0, 3 ];
  var pointtwo = [ 0, 2, 0 ];
  var pointthree = [ 1, 0, 0 ];
  var pointfour = [ - 3, 0, 0 ];
  var pointfive = [ 0, - 2, 0 ];
  var pointsix = [ 0, 0, - 1 ];

  var points = [ pointone, pointtwo, pointthree, pointfour, pointfive, pointsix ];
  var bbox  = null;

  bbox  = _.box.fromPoints( bbox, points );
  test.equivalent( bbox, expected );

  test.description = 'Box from two decimal points'; //

  var expected = [ -0.991, - 0.203, 0.005, 0.001, 0.203, 0.889 ];
  var pointone = [ 0.001, -0.203, 0.889 ];
  var pointtwo = [ -0.991, 0.203, 0.005 ];

  var points = [ pointone, pointtwo ];
  var bbox  = null;

  bbox  = _.box.fromPoints( bbox, points );
  test.equivalent( bbox, expected );

  test.description = 'Box from Two points with initial box dimension'; //

  var expected = [ 2, 1, 2, 4, 8, 4 ];
  var pointone = [ 3, 1, 3 ];
  var pointtwo = [ 3, 8, 3 ];

  var points = [ pointone, pointtwo ];
  var bbox  = [ 2, 2, 2, 4, 4, 4 ];

  bbox  = _.box.fromPoints( bbox, points );
  test.equivalent( bbox, expected );

  test.description = '0d Box from 0d points'; //

  var expected = [];
  var points = [ [], [], [] ];
  var bbox  = [];

  bbox  = _.box.fromPoints( bbox, points );
  test.equivalent( bbox, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; //
  test.shouldThrowError( function()
  {
    _.box.fromPoints();
  });

  test.description = 'Wrong type of argument'; //

  test.shouldThrowError( function()
  {
    _.box.fromPoints( 'box', 'points' );
  });

  test.description = 'Wrong type of argument'; //

  test.shouldThrowError( function()
  {
    _.box.fromPoints( null, 4 );
  });

  test.description = 'Too few arguments'; //
  test.shouldThrowError( function()
  {
    _.box.fromPoints( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.description = 'too many arguments'; //
  test.shouldThrowError( function()
  {
    _.box.fromPoints( [ 0, 0, 0, 0, 0, 0 ], [ [ 0, 1, 0 ], [ 1, 0, 1 ] ], [ 0, 1, 2 ] );
  });

  test.description = 'Different dimensions between box and points'; //
  test.shouldThrowError( function()
  {
    _.box.fromPoints( [ 0, 0, 0, 0, 0, 0 ], [ [ 0, 1 ], [ 1, 0 ] ]);
  });

  test.description = 'Different dimensions between points'; //
  test.shouldThrowError( function()
  {
    _.box.fromPoints( [ 0, 0, 0, 0, 0, 0 ], [ [ 0, 1, 0 ], [ 1, 0 ], [ 0 ] ]);
  });
}

//

function pointExpand( test )
{

  test.description = 'Point remains unchanged and Destination box changes'; //

  var dstBox = [ 0, 0, 1, 1 ];
  var point = [ 0, 2 ];

  var gotBox = _.box.pointExpand( dstBox, point );
  test.identical( gotBox, dstBox );

  var expected = [ 0, 0, 1, 2 ];
  test.identical( gotBox, expected );

  var oldPoint = [ 0, 2 ];
  test.identical( point, oldPoint );

  test.description = 'Null box expanded'; //

  var box = null;
  var point = [ 1, 2, 3 ];
  var expected = [ 1, 2, 3, 1, 2, 3 ];

  gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.description = 'Null box NOT expanded'; //

  var box = null;
  var point = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0, 0, 0 ];

  gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.description = 'One point box expanded'; //

  box = [ 0, 0, 0, 0, 0, 0 ];
  point = [ - 1, 2, - 3 ];
  expected = [ - 1,  0, - 3, 0, 2, 0 ];

  gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.description = 'Box expanded'; //

  box = [ 0, 0, 0, 2, 2, 2 ];
  point = [ - 1, 3, - 1 ];
  expected = [ - 1, 0, - 1, 2, 3, 2 ];

  gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.description = 'Box NOT expanded ( point inside box )'; //

  box = [ 0, 0, 0, 2, 2, 2 ];
  point = [  1, 1, 1 ];
  expected = [ 0,  0, 0, 2, 2, 2 ];

  gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.description = 'Box ( normalized to 1 ) expanded'; //

  box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  point = [ -0.900, 0, 0.900 ];
  expected = [ - 0.900,  0, -0.238, 0.194, 0.766, 0.900 ];

  gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.description = 'Null box of four dimensions expanded'; //

  var box = [ 0, 0, 0, 0, 0, 0, 0, 0 ];
  var point = [ 1, 2, 3 , 4 ];
  var expected = [ 0, 0, 0, 0, 1, 2, 3, 4 ];

  gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.description = 'Null box of 7 dimensions expanded'; //

  var box = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ];
  var point = [ 1, 2, 3 , 4, 5, 6, 7 ];
  var expected = [ 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7 ];

  gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.description = 'Box of 1 dimension expanded'; //

  var box = [ 0, 0 ];
  var point = [ 1 ];
  var expected = [ 0, 1 ];

  gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.description = 'Box of 0 dimension expanded'; //

  var box = [ ];
  var point = [ ];
  var expected = [ ];

  gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; //
  test.shouldThrowError( function()
  {
    _.box.pointExpand();
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.pointExpand( 'box', 'points' );
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.pointExpand( null, 4 );
  });

  test.description = 'Too few arguments'; //
  test.shouldThrowError( function()
  {
    _.box.pointExpand( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.description = 'too many arguments'; //
  test.shouldThrowError( function()
  {
    _.box.pointExpand( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0 ], [ 1, 0, 1 ] );
  });

  test.description = 'Wrong point dimension (box 3D vs point 4D)'; //
  test.shouldThrowError( function()
  {
    _.box.pointExpand( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0, 2 ] );
  });

  test.description = 'Wrong point dimension (box 3D vs point 2D)'; //
  test.shouldThrowError( function()
  {
    _.box.pointExpand( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1 ] );
  });

  test.description = 'Wrong point dimension (box 2D vs point 1D)'; //
  test.shouldThrowError( function()
  {
    _.box.pointExpand( [ 0, 0, 0, 0 ], [ 0 ] );
  });
}

//

function pointContains( test )
{

  test.description = 'Box and Point remain unchanged'; //

  var box = [  - 1,  - 1 , 1, 1 ];
  var point = [ 0, 0 ];
  var expected = true;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool, expected );

  var oldBox = [  - 1,  - 1 , 1, 1 ];
  test.identical( box, oldBox );

  var oldPoint = [  0, 0 ];
  test.identical( point, oldPoint );

  test.description = 'Null box contains empty point'; //

  var box = null;
  var point = [ 0, 0, 0 ];
  var expected = true;

  gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Empty box doesn´t contain empty point'; //

  box = [];
  point = [];
  expected = false;

  gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Point Box contains Point'; //

  box = [ 0, 0, 0, 0, 0, 0 ];
  point = [ 0, 0, 0 ];
  expected = true;

  gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Box contains point'; //

  box = [ 0, 0, 0, 2, 2, 2 ];
  point = [  1, 1, 1 ];
  expected = true;

  gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Box under point'; //

  box = [ 0, 0, 0, 2, 2, 2 ];
  point = [ 1, 1, 3 ];
  expected = false;

  gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Box over point'; //

  box = [ 0, 0, 0, 2, 2, 2 ];
  point = [ - 1, 1, 1 ];
  expected = false;

  gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Box ( normalized to 1 ) contains point'; //

  box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  point = [ 0.050, 0.500, 0.000 ];
  expected = true;

  gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Box ( normalized to 1 ) doesn´t contain point'; //

  box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  point = [ 0.050, 0.500, - 0.303 ];
  expected = false;

  gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Box of four dimensions contains point'; //

  box = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  point = [ 0, 0, 0 , 0 ];
  expected = true;

  gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Box of four dimensions doesn´t contain point'; //

  box = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  point = [ 0, - 2, 0 , 2 ];
  expected = false;

  gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Box of 7 dimensions contains point'; //

  box = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 1, 1, 1, 1, 1, 1, 1 ];
  point = [ 0, -1, -1, 0, -1, 0, 0 ];
  expected = true;

  gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Box of 7 dimensions doesn´t contain point'; //

  box = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 1, 1, 1, 1, 1, 1, 1 ];
  point = [ 0, 4, 3.5, 0, 5, 2, 2 ];
  expected = false;

  gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Box of 1 dimension contains point'; //

  box = [ 0, 2 ];
  point = [ 1 ];
  expected = true;

  gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Box of 1 dimension desn´t contain point (too big)'; //

  box = [ 0, 2 ];
  point = [ 3 ];
  expected = false;

  gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.description = 'Box of 1 dimension desn´t contain point (too small)'; //

  box = [ 0, 2 ];
  point = [ - 3 ];
  expected = false;

  gotBool = _.box.pointContains( box, point );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; //
  test.shouldThrowError( function()
  {
    _.box.pointContains();
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.pointContains( 'box', 'point' );
  });

  test.description = 'Point Null'; //
  test.shouldThrowError( function()
  {
    _.box.pointContains( [ 0, 0, 0, 1, 1, 1 ], null );
  });


  test.description = 'Too few arguments'; //
  test.shouldThrowError( function()
  {
    _.box.pointContains( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.description = 'too many arguments'; //
  test.shouldThrowError( function()
  {
    _.box.pointContains( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0 ], [ 1, 0, 1 ] );
  });

  test.description = 'Wrong point dimension (box 3D vs point 4D)'; //
  test.shouldThrowError( function()
  {
    _.box.pointContains( [ 0, 0, 0, 3, 3, 3 ], [ 0, 1, 0, 2 ] );
  });

  test.description = 'Wrong point dimension (box 3D vs point 2D)'; //
  test.shouldThrowError( function()
  {
    _.box.pointContains( [ 0, 0, 0, 2, 2, 2 ], [ 0, 1 ] );
  });

  test.description = 'Wrong point dimension (box 2D vs point 1D)'; //
  test.shouldThrowError( function()
  {
    _.box.pointContains( [ 0, 0, 0, 0 ], [ 0 ] );
  });
}

//

function pointRelative( test )
{

  test.description = 'Returns same instance point, box remains unchanged'; //

  var box = [ 0, 0, 2, 2 ];
  var point = [ 0, 1 ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, point );

  var expected = [ 0, 0.5 ];
  test.equivalent( gotPoint, expected );

  var oldBox = [ 0, 0, 2, 2 ];
  test.equivalent( oldBox, box );

  test.description = 'Empty point relative to null box'; //

  var box = null;
  var point = [ 0, 0, 0 ];
  var expected = [ NaN, NaN, NaN ];

  gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.description = 'Empty point relative to empty box'; //

  var box = [];
  var point = [];
  var expected = [];

  gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.description = 'Point relative to zero box'; //

  box = [ 0, 0, 0, 0, 0, 0 ];
  point = [ 0, 0, 0 ];
  expected = [ NaN, NaN, NaN ];

  gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.description = 'Point in medium of box'; //

  box = [ 0, 0, 0, 2, 2, 2 ];
  point = [  1, 1, 1 ];
  expected = [ 0.5, 0.5, 0.5 ];

  gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.description = 'Point with 1D out of box'; //

  box = [ 0, 0, 0, 2, 2, 2 ];
  point = [ 1, 1, 3 ];
  expected = [ 0.5, 0.5, 1.5 ];

  gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.description = 'Point with 1D under box'; //

  box = [ 0, 0, 0, 2, 2, 2 ];
  point = [ - 1, 1, 1 ];
  expected = [ - 0.5, 0.5, 0.5 ];

  gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.description = 'Point (normalized to one) in box'; //

  box = [ 0.000, 0.000, 0.000, 0.050, 0.050, 0.050 ];
  point = [ 0.100, 0.025, 0.050 ];
  expected = [ 2, 0.5, 1 ];

  gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.description = 'Point (normalized to one) not in box'; //

  box = [ 0.000, 0.000, 0.000, 0.050, 0.050, 0.050 ];
  point = [ 0.075, 0.075, 0.075 ];
  expected = [ 1.5, 1.5, 1.5 ];

  gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.description = 'Point in four dimensions box'; //

  box = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  point = [ 0, 0, 0 , 0 ];
  expected = [ 0.5, 0.5, 0.5 , 0.5 ];

  gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.description = 'Point out of four dimensions box'; //

  box = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  point = [ 0, - 2, 0 , 2 ];
  expected = [ 0.5, - 0.5, 0.5 , 1.5 ];

  gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.description = 'Point in seven dimensions box'; //

  box = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 1, 1, 1, 1, 1, 1, 1 ];
  point = [ - 0.5, - 2, 1, - 3.5, 4, - 5, 7 ];
  expected = [ 0.5, 0, 1, - 0.5, 2, - 1, 3 ];

  gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.description = 'Point in one dimension box'; //

  box = [ 0, 2 ];
  point = [ 1 ];
  expected = [ 0.5 ];

  gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.description = 'Point out of one dimension box (smaller)'; //

  box = [ 0, 2 ];
  point = [ 3 ];
  expected = [ 1.5 ];

  gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.description = 'Point out of one dimension box (bigger)'; //

  box = [ 0, 2 ];
  point = [ - 3 ];
  expected = [ - 1.5 ];

  gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; //
  test.shouldThrowError( function()
  {
    _.box.pointRelative();
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.pointRelative( 'box', 'point' );
  });

  test.description = 'Point Null'; //
  test.shouldThrowError( function()
  {
    _.box.pointRelative( [ 0, 0, 0, 1, 1, 1 ], null );
  });


  test.description = 'Too few arguments'; //
  test.shouldThrowError( function()
  {
    _.box.pointRelative( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.description = 'too many arguments'; //
  test.shouldThrowError( function()
  {
    _.box.pointRelative( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0 ], [ 1, 0, 1 ] );
  });

  test.description = 'Wrong point dimension (box 3D vs point 4D)'; //
  test.shouldThrowError( function()
  {
    _.box.pointRelative( [ 0, 0, 0, 3, 3, 3 ], [ 0, 1, 0, 2 ] );
  });

  test.description = 'Wrong point dimension (box 3D vs point 2D)'; //
  test.shouldThrowError( function()
  {
    _.box.pointRelative( [ 0, 0, 0, 2, 2, 2 ], [ 0, 1 ] );
  });

  test.description = 'Wrong point dimension (box 2D vs point 1D)'; //
  test.shouldThrowError( function()
  {
    _.box.pointRelative( [ 0, 0, 0, 0 ], [ 0 ] );
  });
}

//

function pointClamp( test )
{

  test.description = 'Returns same instance point, box remains unchanged'; //

  var box = [ 1, 1, 1, 3, 3, 3 ];
  var point = [ 0, 1, 2 ];
  var expected = [ 1, 1, 2 ];

  var gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped, point );

  var oldBox = [ 1, 1, 1, 3, 3, 3 ];
  test.identical( oldBox, box );

  test.description = 'Empty point relative to null box'; //

  box = null;
  point = [ 0, 0, 0 ];
  expected = [ 0, 0, 0 ];

  gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Empty point relative to empty box'; //

  box = [];
  point = [];
  expected = [];

  gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Point relative to zero box'; //

  box = [ 0, 0, 0, 0, 0, 0 ];
  point = [ 0, 0, 0 ];
  expected = [ 0, 0, 0 ];

  gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Point in box'; //

  box = [ 0, 0, 0, 2, 2, 2 ];
  point = [  1, 1, 1 ];
  expected = [ 1, 1, 1 ];

  gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Point over box'; //

  box = [ 0, 0, 0, 2, 2, 2 ];
  point = [ 1, 1, 3 ];
  expected = [ 1, 1, 2 ];

  gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Point under box'; //

  box = [ 0, 0, 0, 2, 2, 2 ];
  point = [ - 1, 1, 1 ];
  expected = [ 0, 1, 1 ];

  gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Point (normalized to one) in box'; //

  box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  point = [ 0.050, 0.500, 0 ];
  expected = [ 0.050, 0.500, 0 ];

  gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Point (normalized to one) not in box'; //

  box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  point = [ 0.050, 0.500, - 0.303 ];
  expected = [ 0.050, 0.500, -0.238 ];

  gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Point in four dimensions box'; //

  box = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  point = [ 0, 0, 0 , 0 ];
  expected = [ 0, 0, 0 , 0 ];

  gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Point out of four dimensions box'; //

  box = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  point = [ 0, - 2, 0 , 2 ];
  expected = [ 0, - 1, 0 , 1 ];

  gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Point in seven dimensions box'; //

  box = [ - 2, 3, 3, - 1, 2, 1, 1, 1, 5, 4, 2, 4, 3, 3 ];
  point = [ 0, 4, 3.5, 0, 4, 2, 2 ];
  expected = [ 0, 4, 3.5, 0, 4, 2, 2 ];

  gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Point out of seven dimensions box'; //

  box = [ - 2, 3, 3, - 1, 2, 1, 1, 1, 5, 4, 2, 4, 3, 3 ];
  point = [ 0, 4, 3.5, 0, 5, 2, 7 ];
  expected = [ 0, 4, 3.5, 0, 4, 2, 3 ];

  gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Point in one dimension box'; //

  box = [ 0, 2 ];
  point = [ 1 ];
  expected = [ 1 ];

  gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Point out of one dimension box (smaller)'; //

  box = [ 0, 2 ];
  point = [ 3 ];
  expected = [ 2 ];

  gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  test.description = 'Point out of one dimension box (bigger)'; //

  box = [ 0, 2 ];
  point = [ - 3 ];
  expected = [ 0 ];

  gotClamped = _.box.pointClamp( box, point );
  test.identical( gotClamped,  expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; //
  test.shouldThrowError( function()
  {
    _.box.pointClamp();
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.pointClamp( 'box', 'point' );
  });

  test.description = 'Point Null'; //
  test.shouldThrowError( function()
  {
    _.box.pointClamp( [ 0, 0, 0, 1, 1, 1 ], null );
  });


  test.description = 'Too few arguments'; //
  test.shouldThrowError( function()
  {
    _.box.pointClamp( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.description = 'too many arguments'; //
  test.shouldThrowError( function()
  {
    _.box.pointClamp( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0 ], [ 1, 0, 1 ] );
  });

  test.description = 'Wrong point dimension (box 3D vs point 4D)'; //
  test.shouldThrowError( function()
  {
    _.box.pointClamp( [ 0, 0, 0, 3, 3, 3 ], [ 0, 1, 0, 2 ] );
  });

  test.description = 'Wrong point dimension (box 3D vs point 2D)'; //
  test.shouldThrowError( function()
  {
    _.box.pointClamp( [ 0, 0, 0, 2, 2, 2 ], [ 0, 1 ] );
  });

  test.description = 'Wrong point dimension (box 2D vs point 1D)'; //
  test.shouldThrowError( function()
  {
    _.box.pointClamp( [ 0, 0, 0, 0 ], [ 0 ] );
  });
}

function pointDistance( test )
{

  test.description = 'Box and Point remain unchanged'; //

  var box = [ 0, 0, 2, 2 ];
  var point = [ 0, 3 ];
  var expected = 1;
  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( expected, gotDist );

  var oldBox = [  0,  0, 2, 2 ];
  test.equivalent( oldBox,oldBox );

  var oldPoint = [  0, 3 ];
  test.equivalent( point, oldPoint );

  test.description = 'Empty point relative to null box'; //

  box = null;
  point = [ 0, 0, 0 ];
  expected = 0;

  gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Empty point relative to empty box'; //

  var box = [];
  var point = [];
  var expected = 0;

  gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point relative to zero box'; //

  box = [ 0, 0, 0, 0, 0, 0 ];
  point = [ 0, 0, 0 ];
  expected = 0;

  gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point in box'; //

  box = [ 0, 0, 0, 2, 2, 2 ];
  point = [  1, 1, 1 ];
  expected = 0;

  gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point over box in one dimension'; //

  box = [ 0, 0, 0, 2, 2, 2 ];
  point = [ 1, 1, 3 ];
  expected = 1;
debugger;
  gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point under box'; //

  box = [ 0, 0, 0, 2, 2, 2 ];
  point = [ - 1, 1, 1 ];
  expected = 1;

  gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point away from box in two dimensions'; //

  box = [ 0, 0, 0, 2, 2, 2 ];
  point = [ 0, - 1, - 1 ];
  expected = Math.sqrt(2);

  gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point away from box in three dimensions'; //

  box = [ 0, 0, 0, 2, 2, 2 ];
  point = [ 3, - 1, - 1 ];
  expected = Math.sqrt(3);

  gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point (normalized to one) in box'; //

  box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  point = [ 0.050, 0.500, 0.000 ];
  expected = 0;

  gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point (normalized to one) not in box'; //

  box = [ - 0.050, 0.002, -0.203, 0.194, 0.766, 0.766 ];
  point = [ 0.050, 0.500, - 0.303 ];
  expected = 0.1;

  gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point in four dimensions box'; //

  box = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  point = [ 0, 0, 0 , 0 ];
  expected = 0;

  gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point out of four dimensions box'; //

  box = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  point = [ 0, - 2, 0 , 2 ];
  expected = Math.sqrt(2);

  gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point in seven dimensions box'; //

  box = [ - 2, 3, 3, - 1, 2, 1, 1, 1, 5, 4, 2, 4, 3, 3 ];
  point = [ 0, 4, 3.5, 0, 3, 2, 2 ];
  expected = 0;

  gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point out of seven dimensions box'; //

  box = [ - 2, 3, 3, - 1, 2, 1, 1, 1, 5, 4, 2, 4, 3, 3 ];
  point = [ 0, 4, 3.5, 0, 4, 2, 7 ];
  expected = 4;

  gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point in one dimension box'; //

  box = [ 0, 2 ];
  point = [ 1 ];
  expected = 0;

  gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point out of one dimension box (smaller)'; //

  box = [ 0, 2 ];
  point = [ 3 ];
  expected = 1;

  gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.description = 'Point out of one dimension box (bigger)'; //

  box = [ 0, 2 ];
  point = [ - 3 ];
  expected = 3;

  gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; //
  test.shouldThrowError( function()
  {
    _.box.pointDistance();
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.pointDistance( 'box', 'point' );
  });

  test.description = 'Point Null'; //
  test.shouldThrowError( function()
  {
    _.box.pointDistance( [ 0, 0, 0, 1, 1, 1 ], null );
  });

  test.description = 'Too few arguments'; //
  test.shouldThrowError( function()
  {
    _.box.pointDistance( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.description = 'too many arguments'; //
  test.shouldThrowError( function()
  {
    _.box.pointDistance( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0 ], [ 1, 0, 1 ] );
  });

  test.description = 'Wrong point dimension (box 3D vs point 4D)'; //
  test.shouldThrowError( function()
  {
    _.box.pointDistance( [ 0, 0, 0, 3, 3, 3 ], [ 0, 1, 0, 2 ] );
  });

  test.description = 'Wrong point dimension (box 3D vs point 2D)'; //
  test.shouldThrowError( function()
  {
    _.box.pointDistance( [ 0, 0, 0, 2, 2, 2 ], [ 0, 1 ] );
  });

  test.description = 'Wrong point dimension (box 2D vs point 1D)'; //
  test.shouldThrowError( function()
  {
    _.box.pointDistance( [ 0, 0, 0, 0 ], [ 0 ] );
  });
}

//

function boxContains( test )
{

  test.description = 'Source box and Destination box remain unchanged'; //

  var srcBox = [ 0, 0, 3, 3 ];
  var tstBox = [ 1, 1, 2, 2 ];
  var expected = true;
  var gotBool = _.box.boxContains( srcBox, tstBox );
  test.identical( expected, gotBool );

  var oldSrcBox = [ 0, 0, 3, 3 ];
  test.identical( srcBox, oldSrcBox );

  var oldTstBox = [ 1, 1, 2, 2 ];
  test.identical( tstBox, oldTstBox );

  test.description = 'Empty box to empty box'; //

  var box = [];
  var boxTwo = [];
  var expected = false;

  var gotBool = _.box.boxContains( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Zero box to zero box'; //

  box = [ 0, 0, 0, 0, 0, 0 ];
  boxTwo = [ 0, 0, 0, 0, 0, 0 ];
  expected = true;

  var gotBool = _.box.boxContains( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Same boxes'; //

  box = [ 0, 0, 0, 4, 4, 4 ];
  boxTwo = [ 0, 0, 0, 4, 4, 4 ];
  expected = true;

  var gotBool = _.box.boxContains( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box in box with a common side'; //

  box = [ 0, 0, 0, 3, 3, 3 ];
  boxTwo = [ 1, 1, 1, 2, 2, 3 ];
  expected = true;

  var gotBool = _.box.boxContains( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box in box'; //

  box = [ 0, 0, 0, 3, 3, 3 ];
  boxTwo = [ 1, 1, 1, 2, 2, 2 ];
  expected = true;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.description = 'Box in box (other way aroud)'; //

  box = [ 1, 1, 1, 2, 2, 2 ];
  boxTwo = [ 0, 0, 0, 3, 3, 3 ];
  expected = false;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.description = 'Box half in box'; //

  box = [ 0, 0, 0, 4, 4, 4 ];
  boxTwo = [ 2, 2, 2, 6, 6, 6 ];
  expected = false;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.description = 'Box totally out of box'; //

  box = [ 0, 0, 0, 1, 1, 1 ];
  boxTwo = [ 2, 2, 2, 3, 3, 3 ];
  expected = false;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.description = 'Box out of box in two dimensions'; //

  box = [ 0, 0, 0, 4, 4, 4 ];
  boxTwo = [ 0, - 1, - 1, 1, 0, 0 ];
  expected = false;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.description = 'Box out of box in one dimensions'; //

  box = [ 0, 0, 0, 4, 4, 4 ];
  boxTwo = [ 1, 1, 1, 3, 3, 5 ];
  expected = false;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.description = 'Box in box (both normalized to one)'; //

  box = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.80 ];
  boxTwo = [ - 0.01, 0, - 0.02, 0.30, 0, 0.64 ];
  expected = true;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.description = 'Box out of box (normalized to one)'; //

  box = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.80 ];
  boxTwo = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.90 ];
  expected = false;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.description = 'Box in box (four dimensions)'; //

  box = [ - 1, - 1, - 1, - 1, 2, 2, 2, 2 ];
  boxTwo = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  expected = true;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.description = 'Box out of box (four dimensions)'; //

  box = [ - 1, - 1, - 1, - 1, 2, 2, 2, 2 ];
  boxTwo = [ 0, 0, 0, 0, 1, 1, 1, 3 ];
  expected = false;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.description = 'Box in box (one dimensions)'; //

  box = [ - 1, 2 ];
  boxTwo = [ 0, 1 ];
  expected = true;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.description = 'Box out of box (four dimensions)'; //

  box = [ - 1, 2 ];
  boxTwo = [ 0, 4 ];
  expected = false;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; //
  test.shouldThrowError( function()
  {
    _.box.boxContains();
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.boxContains( 'box', 'box2' );
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.boxContains( null, [] );
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.boxContains( [], null );
  });


  test.description = 'Too few arguments'; //
  test.shouldThrowError( function()
  {
    _.box.boxContains( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.description = 'too many arguments'; //
  test.shouldThrowError( function()
  {
    _.box.boxContains( [ 0, 0, 0, 0 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 0 ] );
  });

  test.description = 'Different box dimensions (box 3D vs box 2D)'; //
  test.shouldThrowError( function()
  {
    _.box.boxContains( [ 0, 0, 0, 3, 3, 3 ], [ 0, 1, 0, 2 ] );
  });

  test.description = 'Wrong box dimension'; //
  test.shouldThrowError( function()
  {
    _.box.boxContains( [ 0, 0, 0, 2, 2, 2, 2 ], [ 0, 0, 0, 2, 2, 2, 3 ], );
  });

}

function boxIntersects( test )
{

test.description = 'Source box and Test box remain unchanged'; //

  var srcBox = [ 0, 0, 2, 2 ];
  var tstBox = [  1,  1, 3, 3 ];
  var gotBool = _.box.boxIntersects( srcBox, tstBox );
  var expected = true;
  test.identical( expected, gotBool );

  var oldsrcBox = [ 0, 0, 2, 2 ];
  test.identical( srcBox, oldsrcBox );

  var oldtstBox = [  1,  1, 3, 3 ];
  test.identical( tstBox, oldtstBox );

  test.description = 'Empty box to empty box'; //

  var box = [];
  var boxTwo = [];
  var expected = false;

  var gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );


  test.description = 'Zero box to zero box'; //

  box = [ 0, 0, 0, 0, 0, 0 ];
  boxTwo = [ 0, 0, 0, 0, 0, 0 ];
  expected = true;

  gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Same boxes'; //

  box = [ 0, 0, 0, 4, 4, 4 ];
  boxTwo = [ 0, 0, 0, 4, 4, 4 ];
  expected = true;

  gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box in box with a common side'; //

  box = [ 0, 0, 0, 3, 3, 3 ];
  boxTwo = [ 1, 1, 1, 2, 2, 3 ];
  expected = true;

  gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );


  test.description = 'Box out of box with a common side'; //

  box = [ 0, 0, 0, 3, 3, 3 ];
  boxTwo = [ 4, 4, 3, 5, 5, 5 ];
  expected = false;

  gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box in box'; //

  box = [ 0, 0, 0, 3, 3, 3 ];
  boxTwo = [ 1, 1, 1, 2, 2, 2 ];
  expected = true;

  gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box half in box'; //

  box = [ 0, 0, 0, 4, 4, 4 ];
  boxTwo = [ 2, 2, 2, 6, 6, 6 ];
  expected = true;

  gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box totally out of box'; //

  box = [ 0, 0, 0, 1, 1, 1 ];
  boxTwo = [ 2, 2, 2, 3, 3, 3 ];
  expected = false;

  gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box out of box in two dimensions'; //

  box = [ 0, 0, 0, 4, 4, 4 ];
  boxTwo = [ 0, - 1, - 1, 1, 0, 0 ];
  expected = true;

  gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box out of box in one dimensions'; //

  box = [ 0, 0, 0, 4, 4, 4 ];
  boxTwo = [ 1, 1, 1, 3, 3, 5 ];
  expected = true;

  gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box in box (both normalized to one)'; //

  box = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.80 ];
  boxTwo = [ - 0.01, 0, - 0.02, 0.30, 0, 0.64 ];
  expected = true;

  gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box out of box (normalized to one)'; //

  box = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.80 ];
  boxTwo = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.90 ];
  expected = true;

  gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box in box (four dimensions)'; //

  box = [ - 1, - 1, - 1, - 1, 2, 2, 2, 2 ];
  boxTwo = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  expected = true;

  gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box out of box in 1D (four dimensions)'; //

  box = [ - 1, - 1, - 1, - 1, 2, 2, 2, 2 ];
  boxTwo = [ 0, 0, 0, 0, 1, 1, 1, 3 ];
  expected = true;

  gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box out of box in 1D (four dimensions)'; //

  box = [ - 1, - 1, - 1, - 1, 2, 2, 2, 2 ];
  boxTwo = [ 3, 3, 3, 3, 4, 4, 4, 4 ];
  expected = false;

  gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box in box (one dimensions)'; //

  box = [ - 1, 2 ];
  boxTwo = [ 0, 1 ];
  expected = true;

  gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box intersects box (one dimensions)'; //

  box = [ - 1, 2 ];
  boxTwo = [ 0, 4 ];
  expected = true;

  gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  test.description = 'Box out of box (one dimensions)'; //

  box = [ - 1, 2 ];
  boxTwo = [ 3, 4 ];
  expected = false;

  gotBool = _.box.boxIntersects( box, boxTwo );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; //
  test.shouldThrowError( function()
  {
    _.box.boxIntersects();
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.boxIntersects( 'box', 'box2' );
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.boxIntersects( null, [] );
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.boxIntersects( [], null );
  });

  test.description = 'Too few arguments'; //
  test.shouldThrowError( function()
  {
    _.box.boxIntersects( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.description = 'too many arguments'; //
  test.shouldThrowError( function()
  {
    _.box.boxIntersects( [ 0, 0, 0, 0 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 0 ] );
  });

  test.description = 'Different box dimensions (box 3D vs box 2D)'; //
  test.shouldThrowError( function()
  {
    _.box.boxIntersects( [ 0, 0, 0, 3, 3, 3 ], [ 0, 1, 0, 2 ] );
  });

  test.description = 'Wrong box dimension'; //
  test.shouldThrowError( function()
  {
    _.box.boxIntersects( [ 0, 0, 0, 2, 2, 2, 2 ], [ 0, 0, 0, 2, 2, 2, 3 ], );
  });

}

function boxExpand( test )
{

  test.description = 'Source box remains unchanged and Destination box changes'; //

  var dstBox = [ 0, 0, 1, 1 ];
  var srcBox = [ - 1, - 1, 0, 2 ];
  var expected = [ - 1, - 1, 1, 2 ];

  var gotBox = _.box.boxExpand( dstBox, srcBox );
  test.identical( dstBox, gotBox );

  var oldSrcBox = [ - 1, - 1, 0, 2 ];
  test.identical( srcBox, oldSrcBox );

  test.description = 'Empty box expands empty box'; //

  var box = [];
  var boxTwo = [];
  var expected = [];

  gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );


  test.description = 'Zero box expands zero box'; //

  box = [ 0, 0, 0, 0, 0, 0 ];
  boxTwo = [ 0, 0, 0, 0, 0, 0 ];
  expected = [ 0, 0, 0, 0, 0, 0 ];

  gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.description = 'Same boxes (no expansion)'; //

  box = [ 0, 0, 0, 4, 4, 4 ];
  boxTwo = [ 0, 0, 0, 4, 4, 4 ];
  expected = [ 0, 0, 0, 4, 4, 4 ];

  gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.description = 'Smaller box (no expansion)'; //

  box = [ 0, 0, 0, 3, 3, 3 ];
  boxTwo = [ 1, 1, 1, 2, 2, 2 ];
  expected = [ 0, 0, 0, 3, 3, 3 ];

  gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.description = '1D expansion'; //

  box = [ 0, 0, 0, 3, 3, 3 ];
  boxTwo = [ 1, 1, 1, 2, 2, 4 ];
  expected = [ 0, 0, 0, 3, 3, 4 ];

  gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.description = '2D expansion'; //

  box = [ 0, 0, 0, 4, 4, 4 ];
  boxTwo = [ 2, - 2, - 2, 4, 6, 6 ];
  expected = [ 0, - 2, - 2, 4, 6, 6 ];

  gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.description = '3D expansion'; //

  box = [ 0, 0, 0, 1, 1, 1 ];
  boxTwo = [ - 2, - 2, - 2, 3, 3, 3 ];
  expected = [ - 2, - 2, - 2, 3, 3, 3 ];

  gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.description = 'Random expansion'; //

  box = [ 0, - 5, 3, 2, 3, 3 ];
  boxTwo = [ - 1, - 1, - 1, 2.5, 2.5, 2.5 ];
  expected = [ - 1, - 5, - 1, 2.5, 3, 3 ];

  gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.description = 'Box expanded (normalized to one)'; //

  box = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.80 ];
  boxTwo = [ - 0.01, 0, - 0.02, 0.30, 0, 0.90 ];
  expected = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.90 ];

  gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.description = 'Box not expanded (normalized to one)'; //

  box = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.80 ];
  boxTwo = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.70 ];
  expected = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.80 ];

  gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.description = 'Box expanded (four dimensions)'; //

  box = [ - 1, - 1, - 1, - 1, 2, 2, 2, 2 ];
  boxTwo = [ 0, 0, 0, 0, 3, 3, 3, 3 ];
  expected = [ - 1, - 1, - 1, - 1, 3, 3, 3, 3 ];

  gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.description = 'Box not expanded (four dimensions)'; //

  box = [ - 1, - 1, - 1, - 1, 2, 2, 2, 2 ];
  boxTwo = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  expected = [ - 1, - 1, - 1, - 1, 2, 2, 2, 2 ];

  gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.description = 'Box expanded (one dimension)'; //

  box = [ - 1, 2 ];
  boxTwo = [ - 2, 10 ];
  expected = [ - 2, 10 ];

  gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.description = 'Box expanded on one side (one dimension)'; //

  box = [ - 1, 2 ];
  boxTwo = [ 0, 4 ];
  expected = [ - 1, 4 ];

  gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.description = 'Box not expanded (one dimension)'; //

  box = [ - 1, 3 ];
  boxTwo = [ 0, 1 ];
  expected = [ - 1, 3 ];

  gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; //
  test.shouldThrowError( function()
  {
    _.box.boxExpand();
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.boxExpand( 'box', 'box2' );
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.boxExpand( null, [] );
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.boxExpand( [], null );
  });

  test.description = 'Too few arguments'; //
  test.shouldThrowError( function()
  {
    _.box.boxExpand( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.description = 'too many arguments'; //
  test.shouldThrowError( function()
  {
    _.box.boxExpand( [ 0, 0, 0, 0 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 0 ] );
  });

  test.description = 'Different box dimensions (box 3D vs box 2D)'; //
  test.shouldThrowError( function()
  {
    _.box.boxExpand( [ 0, 0, 0, 3, 3, 3 ], [ 0, 1, 0, 2 ] );
  });

  test.description = 'Wrong box dimension'; //
  test.shouldThrowError( function()
  {
    _.box.boxExpand( [ 0, 0, 0, 2, 2, 2, 2 ], [ 0, 0, 0, 2, 2, 2, 3 ], );
  });

}

function dimGet( test )
{

  test.description = 'Source box remains unchanged'; //

  var srcBox = [ 0, 0, 1, 1 ];
  var expected = 2;

  var gotDim = _.box.dimGet( srcBox );
  test.identical( gotDim, expected );

  var oldsrcBox = [ 0, 0, 1, 1 ];
  test.identical( srcBox, oldsrcBox );

  test.description = 'Empty box'; //

  var box = [];
  var expected = 0;

  gotDim = _.box.dimGet( box );
  test.identical( gotDim, expected );

  test.description = 'One dimension box'; //

  box = [ 0, 0 ];
  expected = 1;

  gotDim = _.box.dimGet( box );
  test.identical( gotDim, expected );

  test.description = 'Two dimension box'; //

  box = [ 0, 0, 1, 1 ];
  expected = 2;

  gotDim = _.box.dimGet( box );
  test.identical( gotDim, expected );

  test.description = 'Three dimension box'; //

  box = [ - 1, - 2, - 3, 0, 1, 2 ];
  expected = 3;

  gotDim = _.box.dimGet( box );
  test.identical( gotDim, expected );

  test.description = 'Four dimension box'; //

  box = [ - 1, - 2.2, - 3, 5, 0.1, 1, 2, 5.4 ];
  expected = 4;

  gotDim = _.box.dimGet( box );
  test.identical( gotDim, expected );

  test.description = 'Eight dimension box'; //

  box = [ - 1, - 2.2, - 3, 5, 0.1, 1, 2, 5.4, - 1.1, - 3.2, - 3.5, 5.5, 2.3, 27, 2.2, 540 ];
  expected = 8;

  gotDim = _.box.dimGet( box );
  test.identical( gotDim, expected );


  test.description = 'NaN'; //

  box = [ 'Hi', 'world' ];
  expected = 1;

  gotDim = _.box.dimGet( box );
  test.identical( gotDim, expected );

  test.description = 'NaN'; //

  box = [ 'Hi', 'world', null, null, NaN, NaN ];
  expected = 3;

  gotDim = _.box.dimGet( box );
  test.identical( gotDim, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; //
  test.shouldThrowError( function()
  {
    _.box.dimGet();
  });

  test.description = 'Wrong box dimension'; //
  test.shouldThrowError( function()
  {
    _.box.dimGet( [ 0 ] );
  });

  test.description = 'Wrong box dimension'; //
  test.shouldThrowError( function()
  {
    _.box.dimGet( [ 0, 0, 0 ] );
  });

  test.description = 'Wrong box dimension'; //
  test.shouldThrowError( function()
  {
    _.box.dimGet( [ 0, 0, 0, 0, 0 ] );
  });
}

function centerGet( test )
{

  test.description = 'Source box remains unchanged, point changes'; //

  var srcBox = [ 0, 0, 1, 1 ];
  var expected = [ 0.5, 0.5 ];
  var point = [ 0, 5 ];

  var gotCenter = _.box.centerGet( srcBox, point );
  test.equivalent( gotCenter, expected );
  test.equivalent( point, expected );

  var oldSrcBox = [ 0, 0, 1, 1 ];
  test.equivalent( srcBox, oldSrcBox );

  test.description = 'Empty box'; //

  var box = [];
  var point = [];
  var expected = [] ;

  gotCenter = _.box.centerGet( box, point );
  test.equivalent( gotCenter,expected );

  gotCenter = _.box.centerGet( box );
  test.equivalent( gotCenter,expected );
  debugger;

  test.description = 'One dimension box'; //

  box = [ 0, 0 ];
  point = [ 0 ];
  expected = [ 0 ];

  gotCenter = _.box.centerGet( box, point );
  test.equivalent( gotCenter,expected );

  box = [ 0, 0 ];
  gotCenter = _.box.centerGet( box );
  test.equivalent( gotCenter,expected );

  test.description = 'Two dimension box'; //

  box = [ 0, 0, 1, 2 ];
  point = [ 1, 1 ];
  expected = [ 0.5, 1 ];

  gotCenter = _.box.centerGet( box );
  test.equivalent( gotCenter,expected );

  box = [ 0, 0, 1, 2 ];
  gotCenter = _.box.centerGet( box, point );
  test.equivalent( gotCenter,expected );

  test.description = 'Three dimension box'; //

  box = [ 0, - 1, - 2, 0, 1, 2 ];
  expected = [ 0, 0, 0 ];
  point = [ 2, 4, - 6 ];

  gotCenter = _.box.centerGet( box );
  test.equivalent( gotCenter,expected );

  box = [ 0, - 1, - 2, 0, 1, 2 ];

  gotCenter = _.box.centerGet( box, point );
  test.equivalent( gotCenter,expected );

  test.description = 'Four dimension box'; //

  box = [ 0, - 1, - 2, 2, 0, 1, 2, 6 ];
  expected = [ 0, 0, 0, 4 ];
  point = [ 2, 4, - 6, 2 ];

  gotCenter = _.box.centerGet( box );
  test.equivalent( gotCenter,expected );

  box = [ 0, - 1, - 2, 2, 0, 1, 2, 6 ];

  gotCenter = _.box.centerGet( box, point );
  test.identical( gotCenter, expected );

  test.description = 'Eight dimension box'; //

  box = [  0, - 1, - 2, 2, 0, 1, 2, 6, 0, - 1, - 2, 2, 0, 1, 2, 6 ];
  point = [ 2, 4, - 6, 2, 2, 4, - 6, 2 ];
  expected = [ 0, - 1, -2, 2, 0, 1, 2, 6 ];

  gotCenter = _.box.centerGet( box );
  test.identical( gotCenter, expected );

  box = [  0, - 1, - 2, 2, 0, 1, 2, 6, 0, - 1, - 2, 2, 0, 1, 2, 6 ];
  gotCenter = _.box.centerGet( box, point );
  test.identical( gotCenter, expected );

  test.description = 'Point is vector'; //

  box = [ 0, 0, 1, 2 ];
  point = _.vector.from( [ 1, 1 ] );
  expected = [ 0.5, 1 ];
  var expv = _.vector.from( expected );

  gotCenter = _.box.centerGet( box );
  test.equivalent( gotCenter,expected );

  box = [ 0, 0, 1, 2 ];
  gotCenter = _.box.centerGet( box, point );
  test.equivalent( gotCenter,expv );

  test.description = 'Point is null'; //

  box = [ 0, 0, 1, 2 ];
  point = null;
  expected = [ 0.5, 1 ];

  gotCenter = _.box.centerGet( box );
  test.equivalent( gotCenter,expected );

  box = [ 0, 0, 1, 2 ];
  gotCenter = _.box.centerGet( box, point );
  test.equivalent( gotCenter,expected );

  test.description = 'Point is NaN'; //

  box = [ 0, 0, 1, 2 ];
  point = NaN;
  expected = [ 0.5, 1 ];

  gotCenter = _.box.centerGet( box );
  test.equivalent( gotCenter,expected );

  box = [ 0, 0, 1, 2 ];
  gotCenter = _.box.centerGet( box, point );
  test.equivalent( gotCenter, expected );


  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; //
  test.shouldThrowError( function()
  {
    _.box.centerGet();
  });

  test.description = 'Too many arguments'; //
  test.shouldThrowError( function()
  {
    _.box.centerGet( [ 0, 0, 1, 1 ], [ 0, 0, 0 ], [ 0, 0, 0 ] );
  });

  test.description = 'Wrong type of arguments'; //
  test.shouldThrowError( function()
  {
    _.box.centerGet( null );
  });

  test.description = 'Wrong type of arguments'; //
  test.shouldThrowError( function()
  {
    _.box.centerGet( 'string' );
  });

  test.description = 'Wrong type of arguments'; //
  test.shouldThrowError( function()
  {
    _.box.centerGet( null, [ 0, 0 ] );
  });

  test.description = 'Wrong type of arguments'; //
  test.shouldThrowError( function()
  {
    _.box.centerGet( 'string', [ 0, 0 ] );
  });


  test.description = 'Wrong type of arguments'; //
  test.shouldThrowError( function()
  {
    _.box.centerGet( [ 0, 0, 1, 1 ], 'string' );
  });

  test.description = 'Wrong box dimension'; //
  test.shouldThrowError( function()
  {
    _.box.centerGet( [ 0 ] );
  });

  test.description = 'Wrong box dimension'; //
  test.shouldThrowError( function()
  {
    _.box.centerGet( [ 0, 0, 0 ] );
  });

  test.description = 'Wrong box dimension'; //
  test.shouldThrowError( function()
  {
    _.box.centerGet( [ 0, 0, 0, 0, 0 ] );
  });

  test.description = 'Different dimension between box and point'; //
  test.shouldThrowError( function()
  {
    _.box.centerGet( [ 0, 0, 0, 0, 0, 0 ], [ 0, 0 ] );
  });

}


function cornerLeftGet( test )
{

  test.description = 'Source box remains unchanged'; //

  var srcBox = [ 0, 0, 1, 1 ];
  var expected = [ 0, 0 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerLeftGet( srcBox );
  test.identical( gotCorner, expected );

  var oldsrcBox = [ 0, 0, 1, 1 ];
  test.identical( srcBox, oldsrcBox );

  test.description = 'Empty box'; //

  var box = [];
  expected = [];
  expected = _.vector.from(expected);

  gotCorner = _.box.cornerLeftGet( box );
  test.identical( gotCorner, expected );

  test.description = 'One dimension box'; //

  box = [ 0, 1 ];
  expected = [ 0 ];
  expected = _.vector.from(expected);

  gotCorner = _.box.cornerLeftGet( box );
  test.identical( gotCorner, expected );

  test.description = 'Two dimension box'; //

  box = [ 0, 0, 1, 1 ];
  expected = [ 0, 0 ];
  expected = _.vector.from(expected);

  gotCorner = _.box.cornerLeftGet( box );
  test.identical( gotCorner, expected );

  test.description = 'Three dimension box'; //

  box = [ - 1, - 2, - 3, 0, 1, 2 ];
  expected = [ - 1, - 2, - 3 ];
  expected = _.vector.from(expected);

  gotCorner = _.box.cornerLeftGet( box );
  test.identical( gotCorner, expected );

  test.description = 'Four dimension box'; //

  box = [ - 1, - 2.2, - 3, 5, 0.1, 1, 2, 5.4 ];
  expected = [ - 1, - 2.2, - 3, 5 ];
  expected = _.vector.from(expected);

  gotCorner = _.box.cornerLeftGet( box );
  test.identical( gotCorner, expected );

  test.description = 'Eight dimension box'; //

  box = [ - 1, - 2.2, - 3, 5, 0.1, 1, 2, 5.4, - 1.1, - 3.2, - 3.5, 5.5, 2.3, 27, 2.2, 540 ];
  expected = [ - 1, - 2.2, - 3, 5, 0.1, 1, 2, 5.4 ];
  expected = _.vector.from(expected);

  gotCorner = _.box.cornerLeftGet( box );
  test.identical( gotCorner, expected );

  test.description = 'Inverted box'; //

  box = [ 1, 1, 0, 0 ];
  expected = [ 1, 1 ];
  expected = _.vector.from(expected);

  gotCorner = _.box.cornerLeftGet( box );
  test.identical( gotCorner, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; //
  test.shouldThrowError( function()
  {
    _.box.cornerLeftGet();
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.cornerLeftGet( null );
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.cornerLeftGet( NaN );
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.cornerLeftGet( 'Hello' );
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.cornerLeftGet( [ 'Hello', world ] );
  });

  test.description = 'Wrong box dimension'; //
  test.shouldThrowError( function()
  {
    _.box.cornerLeftGet( [ 0 ] );
  });

  test.description = 'Wrong box dimension'; //
  test.shouldThrowError( function()
  {
    _.box.cornerLeftGet( [ 0, 0, 0 ] );
  });

  test.description = 'Wrong box dimension'; //
  test.shouldThrowError( function()
  {
    _.box.cornerLeftGet( [ 0, 0, 0, 0, 0 ] );
  });
}


function cornerRightGet( test )
{

  test.description = 'Source box remains unchanged'; //

  var srcBox = [ 0, 0, 1, 1 ];
  var expected = [ 1, 1 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerRightGet( srcBox );
  test.identical( gotCorner, expected );

  var oldSrcBox = [ 0, 0, 1, 1 ];
  test.identical( srcBox, oldSrcBox );

  test.description = 'Empty box'; //

  var box = [];
  expected = [];
  expected = _.vector.from(expected);

  gotCorner = _.box.cornerRightGet( box );
  test.identical( gotCorner, expected );

  test.description = 'One dimension box'; //

  box = [ 0, 1 ];
  expected = [ 1 ];
  expected = _.vector.from(expected);

  gotCorner = _.box.cornerRightGet( box );
  test.identical( gotCorner, expected );

  test.description = 'Two dimension box'; //

  box = [ 0, 0, 1, 1 ];
  expected = [ 1, 1 ];
  expected = _.vector.from(expected);

  gotCorner = _.box.cornerRightGet( box );
  test.identical( gotCorner, expected );

  test.description = 'Three dimension box'; //

  box = [ - 1, - 2, - 3, 0, 1, 2 ];
  expected = [ 0, 1, 2 ];
  expected = _.vector.from(expected);

  gotCorner = _.box.cornerRightGet( box );
  test.identical( gotCorner, expected );

  test.description = 'Four dimension box'; //

  box = [ - 1, - 2.2, - 3, 5, 0.1, 1, 2, 5.4 ];
  expected = [ 0.1, 1, 2, 5.4 ];
  expected = _.vector.from(expected);

  gotCorner = _.box.cornerRightGet( box );
  test.identical( gotCorner, expected );

  test.description = 'Eight dimension box'; //

  box = [ - 1, - 2.2, - 3, 5, 0.1, 1, 2, 5.4, - 1.1, - 3.2, - 5, 5.5, 2.3, 27, 2.2, 540 ];
  expected = [ -1.1, - 3.2, - 5, 5.5, 2.3, 27, 2.2, 540 ];
  expected = _.vector.from(expected);

  gotCorner = _.box.cornerRightGet( box );
  test.identical( gotCorner, expected );

  test.description = 'Empty box at [ 1, 1 ]'; //

  box = [ 1, 1, 0, 0 ];
  expected = [ 0, 0 ];
  expected = _.vector.from(expected);

  gotCorner = _.box.cornerRightGet( box );
  test.identical( gotCorner, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; //
  test.shouldThrowError( function()
  {
    _.box.cornerRightGet();
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.cornerRightGet( null );
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.cornerRightGet( NaN );
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.cornerRightGet( 'Hello' );
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.cornerRightGet( [ 'Hello', world ] );
  });

  test.description = 'Wrong box dimension'; //
  test.shouldThrowError( function()
  {
    _.box.cornerRightGet( [ 0 ] );
  });

  test.description = 'Wrong box dimension'; //
  test.shouldThrowError( function()
  {
    _.box.cornerRightGet( [ 0, 0, 0 ] );
  });

  test.description = 'Wrong box dimension'; //
  test.shouldThrowError( function()
  {
    _.box.cornerRightGet( [ 0, 0, 0, 0, 0 ] );
  });
}


function sizeGet( test )
{

  test.description = 'Source box remains unchanged, point changes'; //

  var srcBox = [ 0, 0, 1, 1 ];
  var point = [ 0, 5 ];
  var expected = [ 1, 1 ];

  var gotSize = _.box.sizeGet( srcBox, point );
  test.equivalent( gotSize, expected );
  test.equivalent( point, expected );

  var oldSrcBox = [ 0, 0, 1, 1 ];
  test.equivalent( srcBox, oldSrcBox );

  test.description = 'Empty box'; //

  var box = [];
  var point = [];
  var expected = [] ;

  gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );

  gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );
  debugger;

  test.description = 'One dimension box'; //

  box = [ 0, 0 ];
  point = [ 0 ];
  expected = [ 0 ];

  gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );

  box = [ 0, 0 ];
  gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  test.description = 'Two dimension box'; //

  box = [ 0, 1, 1, 2 ];
  point = [ 2, 4 ];
  expected = [ 1, 1 ];

  gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  box = [ 0, 1, 1, 2 ];
  gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );

  test.description = 'Three dimension box'; //

  box = [ 0, - 1, - 2, 0, 1, 2 ];
  expected = [ 0, 2, 4 ];
  point = [ 2, 4, - 6 ];

  gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  box = [ 0, - 1, - 2, 0, 1, 2 ];

  gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );

  test.description = 'Four dimension box'; //

  box = [ 0, - 1, - 2, 2, 0, 1, 2, 6 ];
  expected = [ 0, 2, 4, 4 ];
  point = [ 2, 4, - 6, 2 ];

  gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  box = [ 0, - 1, - 2, 2, 0, 1, 2, 6 ];

  gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );

  test.description = 'Eight dimension box'; //

  box = [  0, - 1, - 2, 2, 0, 1, 2, 6, 0, - 1, - 2, 2, 0, 1, 2, 6 ];
  point = [ 2, 4, - 6, 2, 2, 4, - 6, 2 ];
  expected = [ 0, 0, 0, 0, 0, 0, 0, 0 ];

  gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  box = [  0, - 1, - 2, 2, 0, 1, 2, 6, 0, - 1, - 2, 2, 0, 1, 2, 6 ];
  gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );


  test.description = 'Point is vector'; //

  box = [ 0, 0, 1, 2 ];
  point = _.vector.from( [ 1, 1 ] );
  expected = [ 1, 2 ];
  var expv = _.vector.from( expected );

  gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  box = [ 0, 0, 1, 2 ];
  gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expv );

  test.description = 'Point is null'; //

  box = [ 0, 0, 1, 2 ];
  point = null;
  expected = [ 1, 2 ];

  gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  box = [ 0, 0, 1, 2 ];
  gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );

  test.description = 'Point is NaN'; //

  box = [ 0, 0, 1, 2 ];
  point = NaN;
  expected = [ 1, 2 ];

  gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  box = [ 0, 0, 1, 2 ];
  gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );

  test.description = 'Empty box'; //

  box = [ 1, 1, 0, 0 ];
  point = NaN;
  expected = [ - 1, - 1 ];

  gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  box = [ 1, 1, 0, 0 ];
  gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );



  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; //
  test.shouldThrowError( function()
  {
    _.box.sizeGet();
  });

  test.description = 'Too many arguments'; //
  test.shouldThrowError( function()
  {
    _.box.sizeGet( [ 0, 0, 1, 1 ], [ 0, 0, 0 ], [ 0, 0, 0 ] );
  });

  test.description = 'Wrong type of arguments'; //
  test.shouldThrowError( function()
  {
    _.box.sizeGet( null );
  });

  test.description = 'Wrong type of arguments'; //
  test.shouldThrowError( function()
  {
    _.box.sizeGet( 'string' );
  });

  test.description = 'Wrong type of arguments'; //
  test.shouldThrowError( function()
  {
    _.box.sizeGet( null, [ 0, 0 ] );
  });

  test.description = 'Wrong type of arguments'; //
  test.shouldThrowError( function()
  {
    _.box.sizeGet( 'string', [ 0, 0 ] );
  });


  test.description = 'Wrong type of arguments'; //
  test.shouldThrowError( function()
  {
    _.box.sizeGet( [ 0, 0, 1, 1 ], 'string' );
  });

  test.description = 'Wrong box dimension'; //
  test.shouldThrowError( function()
  {
    _.box.sizeGet( [ 0 ] );
  });

  test.description = 'Wrong box dimension'; //
  test.shouldThrowError( function()
  {
    _.box.sizeGet( [ 0, 0, 0 ] );
  });

  test.description = 'Wrong box dimension'; //
  test.shouldThrowError( function()
  {
    _.box.sizeGet( [ 0, 0, 0, 0, 0 ] );
  });

  test.description = 'Different dimension between box and point'; //
  test.shouldThrowError( function()
  {
    _.box.sizeGet( [ 0, 0, 0, 0, 0, 0 ], [ 0, 0 ] );
  });

}


//

function fromPoints( test )
{

  test.description = 'Points remain unchanged and Destination box changes'; //

  var points = [ [ 1, 1 ], [ 0, 0 ], [ 0, 2 ] ];
  var expected = [ 0, 0, 1, 2 ];
  var dstBox = [ 0, 0, 1, 1 ];

  var gotBox = _.box.fromPoints( dstBox, points );
  test.identical( gotBox, expected );
  test.identical( dstBox, expected );

  var oldpoints = [ [ 1, 1 ], [ 0, 0 ], [ 0, 2 ] ];
  test.identical( points, oldpoints );

  test.description = 'Create box of two dimensions'; //

  var box = null;
  var points = [ [ 1, 0 ], [ 0, - 2 ], [ 0, 3 ], [ - 1, 2 ] ];
  var expected = [ - 1, - 2, 1, 3 ];

  gotBox = _.box.fromPoints( box, points );
  test.identical( gotBox, expected );

  test.description = 'Create box three dimensions'; //

  var box = null;
  var points = [ [ 1, 0, 0 ], [ 0, 2, 0 ], [ 0, 0, 3 ] ];
  var expected = [ 0, 0, 0, 1, 2, 3 ];

  gotBox = _.box.fromPoints( box, points );
  test.identical( gotBox, expected );

  test.description = 'Zero points - box not expanded'; //

  var box = null;
  var points= [ [ 0, 0, 0 ], [ 0, 0, 0 ] ];
  var expected = [ 0, 0, 0, 0, 0, 0 ];

  gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  test.description = 'Box expanded'; //

  box = [ 0, 0, 0, 2, 2, 2 ];
  points= [ [ - 1, 0, - 1 ], [ 0, 3, 0 ], [ 0, - 3, 0 ], [ 2, 2, 3 ] ] ;
  expected = [ - 1, - 3, - 1, 2, 3, 3 ];

  gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  test.description = 'Box out of one point'; //

  box = [ 0, 0, 0, 2, 2, 2 ];
  points= [ [ - 1, 0, - 1 ] ] ;
  expected = [ - 1, 0, - 1, 2, 2, 2 ];

  gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  test.description = 'Box NOT expanded ( points inside box )'; //

  box = [ 0, 0, 0, 2, 2, 2 ];
  points= [ [ 0, 1, 1 ], [ 1, 0, 1 ], [ 1, 1, 0 ] ];
  expected = [ 0,  0, 0, 2, 2, 2 ];

  gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  test.description = 'Box ( normalized to 1 ) expanded'; //

  box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  points= [ [ - 0.900, 0, 0.900 ], [ 0, - 0.001, 0 ], [ 0.900, 0, - 0.900 ] ];
  expected = [ - 0.900,  - 0.001, - 0.900, 0.900, 0.766, 0.900 ];

  gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  test.description = 'Null box of four dimensions expanded'; //

  var box = [ 0, 0, 0, 0, 0, 0, 0, 0 ];
  var points= [ [ - 1, - 2, - 3 , - 4 ], [ 1, 2, 3 , 4 ] ];
  var expected = [ - 1, - 2, - 3 , - 4, 1, 2, 3, 4 ];

  gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  test.description = 'Null box of 7 dimensions expanded'; //

  var box = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ];
  var points= [ [ 1, 2, 3 , 0, 0, 0, 0 ], [ 0, 0, 0 , 4, 5, 6, 7 ] ] ;
  var expected = [ 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7 ];

  gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  test.description = 'Box of 1 dimension expanded'; //

  var box = [ 0, 0 ];
  var points= [ [ - 1 ], [ 0 ], [ 1 ] ];
  var expected = [ - 1, 1 ];

  gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  test.description = 'Box of 0 dimension expanded'; //

  var box = [ ];
  var points= [ [], [] ];
  var expected = [ ];

  gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; //
  test.shouldThrowError( function()
  {
    _.box.fromPoints();
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.fromPoints( 'box', 'points' );
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.fromPoints( null, 4 );
  });

  test.description = 'Too few arguments'; //
  test.shouldThrowError( function()
  {
    _.box.fromPoints( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.description = 'Too few arguments - one point'; //
  test.shouldThrowError( function()
  {
    _.box.fromPoints( [ 0, 0, 0, 0, 0, 0 ], [ 1, 1, 1 ]);
  });

  test.description = 'too many arguments'; //
  test.shouldThrowError( function()
  {
    _.box.fromPoints( [ 0, 0, 0, 0, 0, 0 ], [ [ 0, 1 ], [ 2, 1 ], [ 0, 3 ] ], [ 1, 0, 1 ] );
  });

  test.description = 'Wrong points dimension (box 3D vs points 4D)'; //
  test.shouldThrowError( function()
  {
    _.box.fromPoints( [ 0, 0, 0, 0, 0, 0 ], [ [ 0, 1, 0, 2 ], [ 0, 1, - 3, 4 ] ] );
  });

  test.description = 'Wrong points dimension (box 3D vs points 2D)'; //
  test.shouldThrowError( function()
  {
    _.box.fromPoints( [ 0, 0, 0, 0, 0, 0 ], [ [ 0, 1 ], [ 2, 1 ], [ 0, 3 ] ] );
  });

  test.description = 'Wrong points dimension (box 2D vs points 1D)'; //
  test.shouldThrowError( function()
  {
    _.box.fromPoints( [ 0, 0, 0, 0 ], [ [ 1 ], [ 0 ] ] );
  });
}



//

function fromCenterAndSize( test )
{

  test.description = 'Center and size remain unchanged and Destination box changes'; //

  var dstBox = [ 0, 0, 1, 1 ];
  var center = [ 1, 1 ];
  var size = [ 4, 4 ];
  var expected = [ - 1, - 1, 3, 3 ];

  var gotBox = _.box.fromCenterAndSize( dstBox, center, size );
  test.identical( gotBox, expected );
  test.identical( dstBox, expected );


  var oldcenter = [ 1, 1 ];
  test.identical( center, oldcenter );
  var oldsize = [ 4, 4 ];
  test.identical( size, oldsize );

  test.description = 'Empty box'; //

  var box = [ ];
  center = [ ];
  size = [ ];
  expected = [ ];

  var gotBox = _.box.fromCenterAndSize( box, center, size );
  test.identical( gotBox, expected );

  test.description = 'Trivial expansion'; //

  box = [ 0, 1, 1, 0 ];
  center = [ 1, 1 ];
  size = [ 4, 4 ];
  expected = [ - 1, - 1, 3, 3 ];

  var gotBox = _.box.fromCenterAndSize( box, center, size );
  test.identical( gotBox, expected );

  test.description = 'Different sizes expansion'; //

  box = [ 2, 2, 3, 3 ];
  center = [ 1, 1 ];
  size = [ 4, 2 ];
  expected = [ - 1, 0, 3, 2 ];

  var gotBox = _.box.fromCenterAndSize( box, center, size );
  test.identical( gotBox, expected );

  test.description = 'Decimal values'; //

  box = [ 1.2, 2.4, 3.3, 4.8 ];
  center = [ 1.5, 0.79 ];
  size = [ 0.5, 0.2 ];
  expected = [ 1.25, 0.69, 1.75, 0.89 ];

  var gotBox = _.box.fromCenterAndSize( box, center, size );
  test.equivalent( gotBox, expected );

  test.description = 'Negative size'; //

  box = [ 0, 0, 0, 0 ];
  center = [ 0, 0 ];
  size = [ -2, -2 ];
  expected = [ 1, 1, - 1, - 1 ];

  var gotBox = _.box.fromCenterAndSize( box, center, size );
  test.identical( gotBox, expected );

  test.description = 'Box of three dimensions'; //

  box = [ 1, 3, 2, 2, 4, 4 ];
  center = [ 1, 1, 1 ];
  size = [ 4, 4, 2 ];
  expected = [ - 1, - 1, 0, 3, 3, 2 ];

  var gotBox = _.box.fromCenterAndSize( box, center, size );
  test.identical( gotBox, expected );

  test.description = 'NaN box'; //

  box = [ NaN, NaN, NaN, NaN ];
  center = [ NaN, NaN ];
  size = [ NaN, NaN ];
  expected = [ NaN, NaN, NaN, NaN ];

  var gotBox = _.box.fromCenterAndSize( box, center, size );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; //
  test.shouldThrowError( function()
  {
    _.box.fromCenterAndSize();
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.fromCenterAndSize( 'box', 'center', 'size' );
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.fromCenterAndSize( null, 4, 5 );
  });

  test.description = 'Too few arguments'; //
  test.shouldThrowError( function()
  {
    _.box.fromCenterAndSize( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.description = 'Too few arguments'; //
  test.shouldThrowError( function()
  {
    _.box.fromCenterAndSize( [ 0, 0, 0, 0, 0, 0 ], [ 1, 1, 1 ]);
  });

  test.description = 'too many arguments'; //
  test.shouldThrowError( function()
  {
    _.box.fromCenterAndSize( [ 0, 0, 0, 0, 0, 0 ], [ 1, 1, 1 ], [ 1, 0, 1 ], [ 1, 1, 0 ] );
  });

  test.description = 'Wrong points dimension (box 3D vs points 4D)'; //
  test.shouldThrowError( function()
  {
    _.box.fromCenterAndSize( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0, 2 ], [ 0, 1, - 3, 4 ] );
  });

  test.description = 'Wrong points dimension (box 3D vs points 2D)'; //
  test.shouldThrowError( function()
  {
    _.box.fromCenterAndSize( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1 ], [ 2, 1 ] );
  });

  test.description = 'Wrong points dimension (box 2D vs points 1D)'; //
  test.shouldThrowError( function()
  {
    _.box.fromCenterAndSize( [ 0, 0, 0, 0 ],  [ 1 ], [ 0 ]  );
  });

}


//

function fromSphere( test )
{

  test.description = 'Center and size remain unchanged and Destination box changes'; //

  var dstBox = [ 0, 0, 1, 1 ];
  var sphere = [ 1, 1, 1 ];
  var expected = [ - 1, - 1, 2, 2 ];

  var gotBox = _.box.fromSphere( dstBox, sphere );
  test.identical( gotBox, expected );
  test.identical( dstBox, expected );

  var oldsphere = [ 1, 1, 1 ];
  test.identical( sphere, oldsphere );

  test.description = 'Create box from sphere 1D same center'; //

  box = [ 0, 0 ];
  sphere = [ 0, 1 ];
  expected = [ - 1, 1 ];

  gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.description = 'Create box from sphere 1D different centers'; //

  box = [ 0, 0 ];
  sphere = [ 1, 1 ];
  expected = [ - 1, 2 ];

  gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.description = 'Expand from sphere - sphere in box'; //

  box = [ 0, 2 ];
  sphere = [ 1, 1 ];
  expected = [ - 1, 3 ];

  gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.description = 'Expand from sphere - sphere out of box'; //

  box = [ 0, 2 ];
  sphere = [ 3, 1 ];
  expected = [ - 1, 4 ];

  gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.description = 'Create box from sphere 3D same center'; //

  box = [ 0, 0, 0, 0, 0, 0 ];
  sphere = [ 0, 0, 0, 1 ];
  expected = [ - 1, - 1, - 1, 1, 1, 1 ];

  gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.description = 'Create box from sphere 3D different center'; //

  var box = [ 0, 0, 0, 0, 0, 0 ];
  sphere = [ 1, 1, 1, 1 ];
  expected = [ - 1, - 1, - 1, 2, 2, 2 ];

  gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.description = 'Expand from sphere 3D sphere in box'; //

  box = [ 0, 0, 0, 2, 2, 3 ];
  sphere = [ 1, 1, 1, 1 ];
  expected = [ - 1, - 1, - 1, 3, 3, 4 ];

  gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.description = 'Expand from sphere 3D sphere out box'; //

  box = [ 0, 0, 0, 2, 2, 3 ];
  sphere = [ 3, 3, 3, 1 ];
  expected = [ - 1, - 1, - 1, 4, 4, 4 ];

  gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.description = 'Contract Sphere - sphere in box'; //

  box = [ 0, 0, 0, 2, 2, 3 ];
  sphere = [ 1, 1, 1, - 1 ];
  expected = [ 1, 1, 1, 1, 1, 2 ];

  gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.description = 'Contract Sphere - sphere out of box'; //

  box = [ 0, 0, 0, 2, 2, 3 ];
  sphere = [ 3, 3, 3, - 1 ];
  expected = [ 1, 1, 1, 2, 2, 2 ];

  gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.description = 'NaN box'; //

  box = [ NaN, NaN ];
  sphere = [ 1, 1 ];
  expected = [ NaN, NaN ];

  gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.description = 'NaN Sphere'; //

  box = [ 0, 2 ];
  sphere = [ NaN, NaN ];
  expected = [ NaN, NaN ];

  gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; //
  test.shouldThrowError( function()
  {
    _.box.fromSphere();
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.fromSphere( 'box', 'sphere' );
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.fromSphere( null, [ 0, 1 ] );
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.fromSphere( [ 0, 1 ], null );
  });

  test.description = 'Too few arguments'; //
  test.shouldThrowError( function()
  {
    _.box.fromSphere( [ 0, 0, 0, 0, 0, 0 ]);
  });

  test.description = 'too many arguments'; //
  test.shouldThrowError( function()
  {
    _.box.fromSphere( [ 0, 0, 0, 0, 0, 0 ], [ 1, 1, 1, 1], [ 1, 1, 0, 0 ] );
  });

  test.description = 'Wrong box dimension'; //
  test.shouldThrowError( function()
  {
    _.box.fromSphere( [ 0 ], [ 0 ] );
  });

  test.description = 'Wrong dimension (box 3D vs sphere 4D)'; //
  test.shouldThrowError( function()
  {
    _.box.fromSphere( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0, 2, 1 ] );
  });

  test.description = 'Wrong dimension (box 3D vs sphere 2D)'; //
  test.shouldThrowError( function()
  {
    _.box.fromSphere( [ 0, 0, 0, 0, 0, 0 ], [ 0, 2, 1 ] );
  });

  test.description = 'Wrong dimension (box 2D vs sphere 1D)'; //
  test.shouldThrowError( function()
  {
    _.box.fromSphere( [ 0, 0, 0, 0 ],  [ 0, 1 ]  );
  });

}


//

function expand( test )
{

  test.description = 'Expansion array remains unchanged and Destination box changes'; //

  var dstBox = [ 0, 0, 1, 1 ];
  var expand = [ 0, 2 ];
  var expected = [ 0, - 2, 1, 3 ];

  var gotBox = _.box.expand( dstBox, expand );
  test.identical( gotBox, expected );
  test.identical( dstBox, expected );

  var oldexpand = [ 0, 2 ];
  test.identical( expand, oldexpand );

  test.description = 'Null box expanded'; //

  var box = null;
  var expand = [ 1, 2, 3 ];
  var expected = [ - 1, - 2, - 3, 1, 2, 3 ];

  gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.description = 'Null box NOT expanded'; //

  var box = null;
  var expand = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0, 0, 0 ];

  gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.description = 'One side box expanded'; //

  box = [ 0, 0, 0, 0, 0, 0 ];
  expand = [ 0, 0,  3 ];
  expected = [ 0,  0, - 3, 0, 0, 3 ];

  gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.description = 'Box expanded'; //

  box = [ 0, 0, 0, 2, 2, 2 ];
  expand = [ 1, 3, 1 ];
  expected = [ - 1, - 3, - 1, 3, 5, 3 ];

  gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.description = 'Box expanded by value'; //

  box = [ 0, 0, 0, 2, 2, 2 ];
  expand = 1;
  expected = [ - 1, - 1, - 1, 3, 3, 3 ];

  gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.description = 'Box NOT expanded ( empty expand array )'; //

  box = [ 0, 0, 0, 2, 2, 2 ];
  expand = [  0, 0, 0 ];
  expected = [ 0,  0, 0, 2, 2, 2 ];

  gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.description = 'Box contracted'; //

  box = [ 0, 0, 0, 3, 3, 3 ];
  expand = [ - 1, - 1, - 1 ];
  expected = [ 1, 1, 1, 2, 2, 2 ];

  gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.description = 'Box with decimal numbers expanded'; //

  box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  expand = [ -0.100, 0, 0.100 ];
  expected = [  0.050,  0.002, -0.338, 0.094, 0.766, 0.866 ];

  gotBox = _.box.expand( box, expand );
  test.equivalent( gotBox, expected );

  test.description = 'Null box of four dimensions expanded'; //

  var box = [ 0, 0, 0, 0, 0, 0, 0, 0 ];
  var expand = [ 1, 2, 3 , 4 ];
  var expected = [ - 1, - 2, - 3, - 4, 1, 2, 3, 4 ];

  gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.description = 'Null box of 7 dimensions expanded'; //

  var box = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ];
  var expand = [ 1, 2, 3 , 4, 5, 6, 7 ];
  var expected = [ - 1, - 2, - 3, - 4, - 5, - 6, - 7, 1, 2, 3, 4, 5, 6, 7 ];

  gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.description = 'Box of 1 dimension expanded'; //

  var box = [ 0, 0 ];
  var expand = [ 1 ];
  var expected = [ - 1, 1 ];

  gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.description = 'Box of 0 dimension expanded'; //

  var box = [ ];
  var expand = [ ];
  var expected = [ ];

  gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.description = 'Null box expanded by value'; //

  var box = null;
  var expand =  4 ;
  var expected = [ - 4, -4, -4, 4, 4, 4 ];

  gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; //
  test.shouldThrowError( function()
  {
    _.box.expand();
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.expand( 'box', 'expand' );
  });

  test.description = 'Too few arguments'; //
  test.shouldThrowError( function()
  {
    _.box.expand( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.description = 'too many arguments'; //
  test.shouldThrowError( function()
  {
    _.box.expand( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0 ], [ 1, 0, 1 ] );
  });

  test.description = 'Wrong expand array dimension (box 3D vs array 4D)'; //
  test.shouldThrowError( function()
  {
    _.box.expand( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0, 2 ] );
  });

  test.description = 'Wrong expand array dimension (box 3D vs array 2D)'; //
  test.shouldThrowError( function()
  {
    _.box.expand( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1 ] );
  });

  test.description = 'Wrong expand array dimension (box 2D vs array 1D)'; //
  test.shouldThrowError( function()
  {
    _.box.expand( [ 0, 0, 0, 0 ], [ 0 ] );
  });

  test.description = 'Wrong expand array dimension (null box vs array 2D)'; //
  test.shouldThrowError( function()
  {
    _.box.expand( null, [ 0, 1 ] );
  });

}

//

function fromCube( test )
{

  test.description = 'Cube remains unchanged and Destination box changes'; //

  var dstBox = [ 0, 0, 1, 1 ];
  var cube = 1;
  var expected = [ - 0.5, - 0.5, 0.5, 0.5 ];

  var gotBox = _.box.fromCube( dstBox, cube );
  test.identical( gotBox, expected );
  test.identical( dstBox, expected );

  var oldcube = 1;
  test.identical( cube, oldcube );

  test.description = 'Null box from cube'; //

  var box = null;
  var fromCube = 2;
  var expected = [ - 1, - 1, - 1, 1, 1, 1 ];

  /* qqq : the first case has different style, should has the same */

  gotBox = _.box.fromCube( box, fromCube );
  test.identical( gotBox, expected );

  test.description = 'Null box NOT from cube'; //

  var box = null;
  var fromCube = [ 0 ];
  var expected = [ 0, 0, 0, 0, 0, 0 ];

  debugger;
  gotBox = _.box.fromCube( box, fromCube );
  debugger;
  test.identical( gotBox, expected );

  test.description = 'Box of 1 dimension'; //

  var box = [ 0, 0 ];
  var fromCube = [ 1 ]; /* qqq : that should throw error as well as few other cases */
  var expected = [ - 0.5, 0.5 ];

  gotBox = _.box.fromCube( box, fromCube );
  test.identical( gotBox, expected );

  test.description = 'Box from cube'; //

  box = [ 0, 0, 0, 2, 2, 2 ];
  fromCube = 6;
  expected = [ - 3, - 3, - 3, 3, 3, 3 ];

  gotBox = _.box.fromCube( box, fromCube );
  test.identical( gotBox, expected );

  test.description = 'clean box'; //

  box = [ 0, 0, 0, 2, 2, 2 ];
  fromCube =  0;
  expected = [ 0,  0, 0, 0, 0, 0 ];

  gotBox = _.box.fromCube( box, fromCube );
  test.identical( gotBox, expected );

  test.description = 'Box contracted'; //

  box = [ 0, 0, 0, 3, 3, 3 ];
  fromCube = - 1;
  expected = [ 0.5, 0.5, 0.5, - 0.5, - 0.5, - 0.5 ];

  gotBox = _.box.fromCube( box, fromCube );
  test.identical( gotBox, expected );

  test.description = 'Box with decimal numbers from cube'; //

  box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  fromCube =  0.100;
  expected = [  - 0.050, - 0.050, - 0.050, 0.050, 0.050, 0.050 ];

  gotBox = _.box.fromCube( box, fromCube );
  test.equivalent( gotBox, expected );

  test.description = 'Null box of four dimensions from cube'; //

  var box = [ 0, 0, 0, 0, 0, 0, 0, 0 ];
  var fromCube = 4;
  var expected = [ - 2, - 2, - 2, - 2, 2, 2, 2, 2 ];

  gotBox = _.box.fromCube( box, fromCube );
  test.identical( gotBox, expected );

  test.description = 'Null box of 7 dimensions from cube'; //

  var box = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ];
  var fromCube = 8;
  var expected = [ - 4, - 4, - 4, - 4, - 4, - 4, - 4, 4, 4, 4, 4, 4, 4, 4 ];

  gotBox = _.box.fromCube( box, fromCube );
  test.identical( gotBox, expected );

  test.description = 'Empty box and cube'; //

  var box = [ ];
  var fromCube = [ ];
  var expected = [ ];

  gotBox = _.box.fromCube( box, fromCube );
  test.identical( gotBox, expected );

  test.description = 'If cube is not number, expected NaN'; //

  var box = [ 0, 0, 1, 1 ];
  var fromCube = [ 1, 2 ];
  var expected = [ NaN, NaN, NaN, NaN ];

  gotBox = _.box.fromCube( box, fromCube );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'No arguments'; //
  test.shouldThrowError( function()
  {
    _.box.fromCube();
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.fromCube( 'box', 'cube' );
  });

  test.description = 'Wrong type of argument'; //
  test.shouldThrowError( function()
  {
    _.box.fromCube( 'box', 3 );
  });

  test.description = 'Too few arguments'; //
  test.shouldThrowError( function()
  {
    _.box.fromCube( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.description = 'too many arguments'; //
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
  // routine: 'centerGet',

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
    // fromCube : fromCube, /* qqq : has problems */

  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
