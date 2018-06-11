( function _Sphere_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  //

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

  var s =
`
  test.shouldBe( _.sphere.is([ 0 ]) );
  test.shouldBe( _.sphere.is([ 0,0 ]) );
  test.shouldBe( _.sphere.is([ 0,0,0 ]) );
  test.shouldBe( _.sphere.is([ 0,0,0,0 ]) );
`

  console.log( s );

  test.description = 'array'; //

  test.shouldBe( _.sphere.is([ 0 ]) );
  test.shouldBe( _.sphere.is([ 0,0 ]) );
  test.shouldBe( _.sphere.is([ 0,0,0 ]) );
  test.shouldBe( _.sphere.is([ 0,0,0,0 ]) );

  test.description = 'vector'; //

  test.shouldBe( _.sphere.is( _.vector.fromArray([ 0 ]) ) );
  test.shouldBe( _.sphere.is( _.vector.fromArray([ 0,0 ]) ) );
  test.shouldBe( _.sphere.is( _.vector.fromArray([ 0,0,0 ]) ) );
  test.shouldBe( _.sphere.is( _.vector.fromArray([ 0,0,0,0 ]) ) );

  test.description = 'not sphere'; //

  test.shouldBe( !_.sphere.is( [] ) );
  test.shouldBe( !_.sphere.is( _.vector.fromArray([]) ) );
  test.shouldBe( !_.sphere.is( 'abc' ) );
  test.shouldBe( !_.sphere.is( { center : [ 0,0,0 ], radius : 1 } ) );
  test.shouldBe( !_.sphere.is( function( a,b,c ){} ) );

}

//

function isEmpty( test )
{

  debugger;

  test.description = 'empty'; //

  test.shouldBe( _.sphere.isEmpty([ 0 ]) );
  test.shouldBe( _.sphere.isEmpty([ 0,0 ]) );
  test.shouldBe( _.sphere.isEmpty([ 0,0,0 ]) );
  test.shouldBe( _.sphere.isEmpty([ 0,0,0,0 ]) );

  test.shouldBe( _.sphere.isEmpty([ 0 ]) );
  test.shouldBe( _.sphere.isEmpty([ 1,0 ]) );
  test.shouldBe( _.sphere.isEmpty([ 1,0,0 ]) );
  test.shouldBe( _.sphere.isEmpty([ 1,0,0,0 ]) );

  test.shouldBe( _.sphere.isEmpty([ -1 ]) );
  test.shouldBe( _.sphere.isEmpty([ 0,-1 ]) );
  test.shouldBe( _.sphere.isEmpty([ 0,0,-1 ]) );
  test.shouldBe( _.sphere.isEmpty([ 0,0,0,-1 ]) );

  test.shouldBe( _.sphere.isEmpty([ -Infinity ]) );
  test.shouldBe( _.sphere.isEmpty([ 0,-Infinity ]) );
  test.shouldBe( _.sphere.isEmpty([ 0,0,-Infinity ]) );
  test.shouldBe( _.sphere.isEmpty([ 0,0,0,-Infinity ]) );

  test.shouldBe( _.sphere.isEmpty([ 0.1,-Infinity ]) );
  test.shouldBe( _.sphere.isEmpty([ 0,0.1,-Infinity ]) );
  test.shouldBe( _.sphere.isEmpty([ 0,0,0.1,-Infinity ]) );

  test.description = 'not empty'; //

  test.shouldBe( !_.sphere.isEmpty([ 1 ]) );
  test.shouldBe( !_.sphere.isEmpty([ 0,1 ]) );
  test.shouldBe( !_.sphere.isEmpty([ 0,0,1 ]) );
  test.shouldBe( !_.sphere.isEmpty([ 0,0,0,1 ]) );

  test.shouldBe( !_.sphere.isEmpty([ Infinity ]) );
  test.shouldBe( !_.sphere.isEmpty([ 0,Infinity ]) );
  test.shouldBe( !_.sphere.isEmpty([ 0,0,Infinity ]) );
  test.shouldBe( !_.sphere.isEmpty([ 0,0,0,Infinity ]) );

}

//

function isZero( test )
{

  test.description = 'zero'; //

  test.shouldBe( _.sphere.isZero([ 0 ]) );
  test.shouldBe( _.sphere.isZero([ 0,0 ]) );
  test.shouldBe( _.sphere.isZero([ 0,0,0 ]) );
  test.shouldBe( _.sphere.isZero([ 0,0,0,0 ]) );

  test.shouldBe( _.sphere.isZero([ 0 ]) );
  test.shouldBe( _.sphere.isZero([ 1,0 ]) );
  test.shouldBe( _.sphere.isZero([ 1,0,0 ]) );
  test.shouldBe( _.sphere.isZero([ 1,0,0,0 ]) );

  test.description = 'not zero'; //

  test.shouldBe( !_.sphere.isZero([ 1 ]) );
  test.shouldBe( !_.sphere.isZero([ 0,1 ]) );
  test.shouldBe( !_.sphere.isZero([ 0,0,1 ]) );
  test.shouldBe( !_.sphere.isZero([ 0,0,0,1 ]) );

  test.shouldBe( !_.sphere.isZero([ -1 ]) );
  test.shouldBe( !_.sphere.isZero([ 0,-1 ]) );
  test.shouldBe( !_.sphere.isZero([ 0,0,-1 ]) );
  test.shouldBe( !_.sphere.isZero([ 0,0,0,-1 ]) );

  test.shouldBe( !_.sphere.isZero([ -Infinity ]) );
  test.shouldBe( !_.sphere.isZero([ 0,-Infinity ]) );
  test.shouldBe( !_.sphere.isZero([ 0,0,-Infinity ]) );
  test.shouldBe( !_.sphere.isZero([ 0,0,0,-Infinity ]) );

  test.shouldBe( !_.sphere.isZero([ Infinity ]) );
  test.shouldBe( !_.sphere.isZero([ 0,Infinity ]) );
  test.shouldBe( !_.sphere.isZero([ 0,0,Infinity ]) );
  test.shouldBe( !_.sphere.isZero([ 0,0,0,Infinity ]) );

  test.shouldBe( !_.sphere.isZero([ 0.1,-Infinity ]) );
  test.shouldBe( !_.sphere.isZero([ 0,0.1,-Infinity ]) );
  test.shouldBe( !_.sphere.isZero([ 0,0,0.1,-Infinity ]) );

}

//

function isNil( test )
{

  test.description = 'nil'; //

  test.shouldBe( _.sphere.isNil([ -Infinity ]) );
  test.shouldBe( _.sphere.isNil([ 0,-Infinity ]) );
  test.shouldBe( _.sphere.isNil([ 0,0,-Infinity ]) );
  test.shouldBe( _.sphere.isNil([ 0,0,0,-Infinity ]) );

  test.description = 'not nil'; //

  test.shouldBe( !_.sphere.isNil([ Infinity ]) );
  test.shouldBe( !_.sphere.isNil([ 0,Infinity ]) );
  test.shouldBe( !_.sphere.isNil([ 0,0,Infinity ]) );
  test.shouldBe( !_.sphere.isNil([ 0,0,0,Infinity ]) );

  test.shouldBe( !_.sphere.isNil([ 0.1,-Infinity ]) );
  test.shouldBe( !_.sphere.isNil([ 0,0.1,-Infinity ]) );
  test.shouldBe( !_.sphere.isNil([ 0,0,0.1,-Infinity ]) );

}

//

function make( test )
{

  test.description = 'src undefined'; //

  var src = undefined;
  var got = _.sphere.make( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'src null'; //

  var src = null;
  var got = _.sphere.make( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'src 2'; //

  var src = 2;
  var got = _.sphere.make( src );
  var expected = [ 0,0,0 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'src array'; //

  var src = [ 0,1,2,3 ];
  var got = _.sphere.make( src );
  var expected = [ 0,1,2,3 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'src vector'; //

  var src = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.sphere.make( src );
  var expected = [ 0,1,2,3 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

}

//

function makeZero( test )
{

  test.description = 'src undefined'; //

  var src = undefined;
  var got = _.sphere.makeZero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'src null'; //

  var src = null;
  var got = _.sphere.makeZero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'src 2'; //

  var src = 2;
  var got = _.sphere.makeZero( src );
  var expected = [ 0,0,0 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'src array'; //

  var src = [ 0,1,2,3 ];
  var got = _.sphere.makeZero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'src vector'; //

  var src = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.sphere.makeZero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

}

//

function makeNil( test )
{

  test.description = 'src undefined'; //

  var src = undefined;
  var got = _.sphere.makeNil( src );
  var expected = [ 0,0,0,-Infinity ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'src null'; //

  var src = null;
  var got = _.sphere.makeNil( src );
  var expected = [ 0,0,0,-Infinity ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'src 2'; //

  var src = 2;
  var got = _.sphere.makeNil( src );
  var expected = [ 0,0,-Infinity ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'src array'; //

  var src = [ 0,1,2,3 ];
  var got = _.sphere.makeNil( src );
  var expected = [ 0,0,0,-Infinity ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'src vector'; //

  var src = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.sphere.makeNil( src );
  var expected = [ 0,0,0,-Infinity ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

}

//

function zero( test )
{

  test.description = 'src undefined'; //

  var src = undefined;
  var got = _.sphere.zero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'src null'; //

  var src = null;
  var got = _.sphere.zero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'src 2'; //

  var src = 2;
  var got = _.sphere.zero( src );
  var expected = [ 0,0,0 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'dst array'; //

  var dst = [ 0,1,2,3 ];
  var got = _.sphere.zero( dst );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'dst vector'; //

  var dst = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.sphere.zero( dst );
  var expected = _.vector.fromArray([ 0,0,0,0 ]);
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'dst array 2d'; //

  var dst = [ 0,1,5 ];
  var got = _.sphere.zero( dst );
  var expected = [ 0,0,0 ];
  test.identical( got,expected );
  test.shouldBe( got === dst );

}

//

function nil( test )
{

  test.description = 'src undefined'; //

  var src = undefined;
  var got = _.sphere.nil( src );
  var expected = [ 0,0,0,-Infinity ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'src null'; //

  var src = null;
  var got = _.sphere.nil( src );
  var expected = [ 0,0,0,-Infinity ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'src 2'; //

  var src = 2;
  var got = _.sphere.nil( src );
  var expected = [ 0,0,-Infinity ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'dst array'; //

  var dst = [ 0,1,2,3 ];
  var got = _.sphere.nil( dst );
  var expected = [ 0,0,0,-Infinity ];
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'dst vector'; //

  var dst = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.sphere.nil( dst );
  var expected = _.vector.fromArray([ 0,0,0,-Infinity ]);
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'dst array 2d'; //

  var dst = [ 0,1,5 ];
  var got = _.sphere.nil( dst );
  var expected = [ 0,0,-Infinity ];
  test.identical( got,expected );
  test.shouldBe( got === dst );

}

//

function centeredOfRadius( test )
{

  test.description = 'src undefined'; //

  var src = undefined;
  var got = _.sphere.centeredOfRadius( src );
  var expected = [ 0,0,0,0.5 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'src null'; //

  var src = null;
  var got = _.sphere.centeredOfRadius( src );
  var expected = [ 0,0,0,0.5 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'src 2'; //

  var src = 2;
  var got = _.sphere.centeredOfRadius( src );
  var expected = [ 0,0,0.5 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'dst array'; //

  var dst = [ 0,1,2,3 ];
  var got = _.sphere.centeredOfRadius( dst );
  var expected = [ 0,0,0,0.5 ];
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'dst vector'; //

  var dst = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.sphere.centeredOfRadius( dst );
  var expected = _.vector.fromArray([ 0,0,0,0.5 ]);
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'dst array 2d'; //

  var dst = [ 0,1,5 ];
  var got = _.sphere.centeredOfRadius( dst );
  var expected = [ 0,0,0.5 ];
  test.identical( got,expected );
  test.shouldBe( got === dst );

  /* */

  test.description = 'src undefined'; //

  var src = undefined;
  var got = _.sphere.centeredOfRadius( src,2 );
  var expected = [ 0,0,0,2 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'src null'; //

  var src = null;
  var got = _.sphere.centeredOfRadius( src,2 );
  var expected = [ 0,0,0,2 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'src 2'; //

  var src = 2;
  var got = _.sphere.centeredOfRadius( src,2 );
  var expected = [ 0,0,2 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'dst array'; //

  var dst = [ 0,1,2,3 ];
  var got = _.sphere.centeredOfRadius( dst,2 );
  var expected = [ 0,0,0,2 ];
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'dst vector'; //

  var dst = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.sphere.centeredOfRadius( dst,2 );
  var expected = _.vector.fromArray([ 0,0,0,2 ]);
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'dst array 2d'; //

  var dst = [ 0,1,5 ];
  var got = _.sphere.centeredOfRadius( dst,2 );
  var expected = [ 0,0,2 ];
  test.identical( got,expected );
  test.shouldBe( got === dst );

}

//

function sphereFromBox( test )
{

  debugger;

  test.description = 'trivial'; //

  var expected = [ 0.5,0.5,0.5,sqrt( 0.5 ) ];
  var bsphere = [ 0,0,0,0 ];
  var bbox = [ 0,0,0,1,1,1 ];

  _.sphere.fromBox( bsphere,bbox );
  test.equivalent( bsphere,expected );

  var expected = vec( expected );
  var bsphere = vec([ 0,0,0,0 ]);
  var bbox = vec( bbox );

  _.sphere.fromBox( bsphere,bbox );
  test.equivalent( bsphere,expected );

  test.description = 'same sizes, different position'; //

  var expected = [ -2.5,0.5,5.5,sqrt( 0.5 ) ];
  var bsphere = [ 0,0,0,0 ];
  var bbox = [ -3,0,5,-2,1,6 ];

  _.sphere.fromBox( bsphere,bbox );
  test.equivalent( bsphere,expected );

  var expected = vec( expected );
  var bsphere = vec([ 0,0,0,0 ]);
  var bbox = vec( bbox );

  _.sphere.fromBox( bsphere,bbox );
  test.equivalent( bsphere,expected );

  test.description = 'different sizes, different position'; //

  var expected = [ -2,0.5,7,sqrt( 5 ) ];
  var bsphere = [ 0,0,0,0 ];
  var bbox = [ -3,0,5,-1,1,9 ];

  _.sphere.fromBox( bsphere,bbox );
  test.equivalent( bsphere,expected );

  var expected = vec( expected );
  var bsphere = vec([ 0,0,0,0 ]);
  var bbox = vec( bbox );

  _.sphere.fromBox( bsphere,bbox )
  test.equivalent( bsphere,expected );

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

  shouldThrowError( 'sphereFromBox' );

  debugger;
}

//

function sphereExpand( test )
{

  test.description = 'trivial';

  var s1 = [ -2,0,0,1 ];
  var s2 = [ +2,0,0,1 ];

  var expected = [ 0,0,0,3 ];
  var got = _.sphere.sphereExpand( s1,s2 );

  test.equivalent( got,expected );
  test.shouldBe( got === s1 );

  test.description = 'different radius';

  var s1 = [ -2,0,0,2 ];
  var s2 = [ +2,0,0,1 ];
  var expected = [ -0.5,0,0,3.5 ];
  var got = _.sphere.sphereExpand( s1,s2 );

  test.equivalent( got,expected );
  test.shouldBe( got === s1 );

  test.description = 'different radius, one inside of another 1';

  var s1 = [ -2,0,0,3 ];
  var s2 = [ 0,0,0,1 ];
  var expected = [ -2,0,0,3 ];
  var got = _.sphere.sphereExpand( s1,s2 );

  test.equivalent( got,expected );
  test.shouldBe( got === s1 );

  test.description = 'different radius, one inside of another 2';

  var s1 = [ -2,0,0,3 ];
  var s2 = [ +0,0,0,0.5 ];
  var expected = [ -2,0,0,3 ];
  var got = _.sphere.sphereExpand( s1,s2 );

  test.equivalent( got,expected );
  test.shouldBe( got === s1 );

  test.description = 'different radius, overlap';

  var s1 = [ -2,0,0,3 ];
  var s2 = [ +1,0,0,2 ];
  var expected = [ -1,0,0,4 ];
  var got = _.sphere.sphereExpand( s1,s2 );

  test.equivalent( got,expected );
  test.shouldBe( got === s1 );

  test.description = 'different radius, overlap';

  var s1 = [ 1,2,3,5 ];
  var s2 = [ -1,-2,-3,5 ];
  var expected = [ 0,0,0,8.74165738677394 ];
  var got = _.sphere.sphereExpand( s1,s2 );

  test.equivalent( got,expected );
  test.shouldBe( got === s1 );

  test.description = 'empty by identity';

  var s1 = [ 0,0,0,0 ];
  var s2 = [ 0,0,0,1 ];
  var expected = [ 0,0,0,1 ];
  var got = _.sphere.sphereExpand( s1,s2 );

  test.equivalent( got,expected );
  test.shouldBe( got === s1 );

  test.description = 'empty by empty at zero';

  var s1 = [ 0,0,0,0 ];
  var s2 = [ 0,0,0,0 ];
  var expected = [ 0,0,0,0 ];
  var got = _.sphere.sphereExpand( s1,s2 );

  test.equivalent( got,expected );
  test.shouldBe( got === s1 );

  test.description = 'empty by empty not at zero';

  var s1 = [ 0,0,0,0 ];
  var s2 = [ 1,1,1,0 ];
  var expected = [ 0.5,0.5,0.5,_.sqrt( 3 )/2 ];
  var got = _.sphere.sphereExpand( s1,s2 );

  test.equivalent( got,expected );
  test.shouldBe( got === s1 );

  test.description = 'overlap';

  var s1 = [ -3,0,0,3 ];
  var s2 = [ +1,0,0,2 ];
  var expected = [ -1.5,0,0,4.5 ];
  var got = _.sphere.sphereExpand( s1,s2 );

  test.equivalent( got,expected );
  test.shouldBe( got === s1 );

  test.description = 'inside, different centers';

  var s1 = [ 0,0,0,5 ];
  var s2 = [ 1,1,1,2 ];
  var expected = [ 0,0,0,5 ];
  var got = _.sphere.sphereExpand( s1,s2 );

  test.equivalent( got,expected );
  test.shouldBe( got === s1 );

  test.description = 'inside, same centers';

  var s1 = [ 0,0,0,5 ];
  var s2 = [ 0,0,0,2 ];
  var expected = [ 0,0,0,5 ];
  var got = _.sphere.sphereExpand( s1,s2 );

  test.equivalent( got,expected );
  test.shouldBe( got === s1 );

  test.description = 'dst is nil';

  var s1 = _.sphere.makeNil();
  var s2 = [ 0,0,0,2 ];
  var expected = [ 0,0,0,2 ];
  var got = _.sphere.sphereExpand( s1,s2 );

  test.equivalent( got,expected );
  test.shouldBe( got === s1 );

  test.description = 'src is nil';

  var s1 = [ 0,0,0,2 ];
  var s2 = _.sphere.makeNil();
  var expected = [ 0,0,0,2 ];
  var got = _.sphere.sphereExpand( s1,s2 );

  test.equivalent( got,expected );
  test.shouldBe( got === s1 );

  test.description = 'dst and src are nil';

  var s1 = _.sphere.makeNil();
  var s2 = _.sphere.makeNil();
  var expected = [ 0,0,0,-Infinity ];
  var got = _.sphere.sphereExpand( s1,s2 );

  test.equivalent( got,expected );
  test.shouldBe( got === s1 );

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.sphereExpand( ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereExpand( 'boxOne', 'boxTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereExpand( [ 1,2,3,4 ], 'boxTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereExpand( 'boxOne', [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereExpand( [ 1,2,3,4 ] , [ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereExpand( [ 1,2,3 ] , [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereExpand( [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereExpand( [ 1,2,3,4 ] , [ 1,2,3,4 ] , [ 1,2,3,4 ] ) );

}

//

function sphereIntersects( test )
{

  test.description = 'Intersection of empty spheres'; //

  var sphere = [ 0,0,0,0 ];
  var sphere2 = [ 0,0,0,0 ];
  var expected = true;
  var got = _.sphere.sphereIntersects( sphere, sphere2 );

  test.equivalent( got, expected );

  test.description = 'Trivial intersection'; //

  sphere = [ - 1, 2, 0, 2 ];
  sphere2 = [ 1, 3, 0, 2 ];
  expected = true;
  got = _.sphere.sphereIntersects( sphere, sphere2 );

  test.equivalent( got, expected );

  test.description = 'Different radius'; //

  sphere = [ - 1, 0, 0, 3 ];
  sphere2 = [ 1, 0, 0, 2 ];
  expected = true;
  got = _.sphere.sphereIntersects( sphere, sphere2 );

  test.equivalent( got, expected );


  test.description = 'Just touching'; //

  sphere = [ - 1, 0, 0, 1 ];
  sphere2 = [ 1, 0, 0, 1 ];
  expected = true;
  got = _.sphere.sphereIntersects( sphere, sphere2 );

  test.equivalent( got, expected );

  test.description = 'Not intersecting'; //

  sphere = [ - 1.5, 0, 0, 1 ];
  sphere2 = [ 1.5, 0, 0, 1 ];
  expected = false;
  got = _.sphere.sphereIntersects( sphere, sphere2 );

  test.equivalent( got, expected );

  test.description = 'One inside another'; //

  sphere = [ 0, 0, 0, 3 ];
  sphere2 = [ 0, 0, 0, 1 ];
  expected = true;
  got = _.sphere.sphereIntersects( sphere, sphere2 );

  test.equivalent( got, expected );

  test.description = 'One inside another different centers'; //

  sphere = [ 0, 0, 0, 3 ];
  sphere2 = [ 1, 1, 1, 3 ];
  expected = true;
  got = _.sphere.sphereIntersects( sphere, sphere2 );

  test.equivalent( got, expected );

  test.description = 'dst is nil';

  sphere = _.sphere.makeNil();
  sphere2 = [ 0,0,0,2 ];
  expected = true;
  got = _.sphere.sphereIntersects( sphere, sphere2 );

  test.equivalent( got,expected );

  test.description = 'src is nil';

  sphere = _.sphere.makeNil();
  sphere2 = [ 0,0,0,2 ];
  expected = true;
  got = _.sphere.sphereIntersects( sphere, sphere2 );

  test.equivalent( got,expected );

  test.description = 'dst and src are nil';

  test.description = 'src is nil';

  sphere = _.sphere.makeNil();
  sphere2 = _.sphere.makeNil();
  expected = true;
  got = _.sphere.sphereIntersects( sphere, sphere2 );

  test.equivalent( got,expected );


  /* */

  if( !Config.debug )
  return;

    test.shouldThrowErrorSync( () => _.sphere.sphereExpand( ) );
    test.shouldThrowErrorSync( () => _.sphere.sphereExpand( 'boxOne', 'boxTwo' ) );
    test.shouldThrowErrorSync( () => _.sphere.sphereExpand( [ 1,2,3,4 ], 'boxTwo' ) );
    test.shouldThrowErrorSync( () => _.sphere.sphereExpand( 'boxOne', [ 1,2,3,4 ] ) );
    test.shouldThrowErrorSync( () => _.sphere.sphereExpand( [ 1,2,3,4 ] , [ 1,2,3 ] ) );
    test.shouldThrowErrorSync( () => _.sphere.sphereExpand( [ 1,2,3 ] , [ 1,2,3,4 ] ) );
    test.shouldThrowErrorSync( () => _.sphere.sphereExpand( [ 1,2,3,4 ] ) );
    test.shouldThrowErrorSync( () => _.sphere.sphereExpand( [ 1,2,3,4 ] , [ 1,2,3,4 ] , [ 1,2,3,4 ] ) );



}

//

function pointExpand( test )
{
  debugger;

  test.description = 'expand zero by zero';

  var sphere = [ 0,0,0,0 ];
  var point = [ 0,0,0 ];
  var expected = [ 0,0,0,0 ];
  var got = _.sphere.pointExpand( sphere, point );

  test.equivalent( got, expected );
  test.shouldBe( got === sphere );

  test.description = 'expand zero by non zero';

  var sphere = [ 0, 0, 0, 0 ];
  var center = _.sphere.centerGet( sphere );
  var point = [ 1,1,1 ];
  var expected = [ 0.5,0.5,0.5,_.sqrt( 3 ) / 2 ];
  var got = _.sphere.pointExpand( sphere, point );
  var d1 = _.avector.distance( point, center );
  debugger;
  var d2 = _.avector.distance( _.dup( 0,3 ),center );

  test.equivalent( got,expected );
  test.equivalent( d1,d2 );
  test.equivalent( d1,_.sphere.radiusGet( sphere ) );
  test.shouldBe( got === sphere );

  test.description = 'expand non zero by non zero';

  var sphere = [ 1,1,1,1 ];
  var center = _.sphere.centerGet( sphere );
  var point = [ -1,-1,-1 ];
  var expected = [ 0.28867513459481287, 0.28867513459481287, 0.28867513459481287,2.232050807568877 ];
  var got = _.sphere.pointExpand( sphere,point );
  var d1 = _.avector.distance( point,center );
  var d2 = _.avector.distance( _.dup( 1+_.sqrt( 3 ) / 3, 3 ),center );

  test.equivalent( got,expected );
  test.equivalent( d1,d2 );
  test.equivalent( d1,_.sphere.radiusGet( sphere ) );
  test.shouldBe( got === sphere );

  test.description = 'expand nil sphere by point';

  var sphere = [ 1,1,1,-Infinity ];
  var center = _.sphere.centerGet( sphere );
  var point = [ -1,-1,-1 ];
  var expected = [ -1,-1,-1,0 ];
  var got = _.sphere.pointExpand( sphere,point );

  test.equivalent( got,expected );
  test.shouldBe( got === sphere );

}

// --
// proto
// --

var Self =
{

  name : 'Math.Sphere',
  silencing : 1,
  // verbosity : 7,
  // debug : 1,

  tests :
  {

//    is : is,
//    isEmpty : isEmpty,
//    isZero : isZero,
//    isNil : isNil,

//    make : make,
//    makeZero : makeZero,
//    makeNil : makeNil,

//    zero : zero,
//    nil : nil,
//    centeredOfRadius : centeredOfRadius,

//    sphereFromBox : sphereFromBox,
    sphereExpand : sphereExpand,
    sphereIntersects : sphereIntersects,

//    pointExpand : pointExpand,

  },

}

//

Self = wTestSuit( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
