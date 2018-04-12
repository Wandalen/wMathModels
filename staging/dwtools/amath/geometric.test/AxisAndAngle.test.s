( function _AxisAndAngle_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      require.resolve( toolsPath );
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

  require( '../geometric/AxisAndAngle.s' );
  require( '../geometric/Quat.s' );
  require( '../space/wSpace.s' );

}

//

var _ = _global_.wTools.withArray.Float32;
var Space = _.Space;
var Parent = _.Tester;

var avector = _.avector;
var vector = _.vector;
var pi = Math.PI;
var sin = Math.sin;
var cos = Math.cos;
var atan2 = Math.atan2;
var asin = Math.asin;
var sqr = _.sqr;
var sqrt = _.sqrt;
var clamp = _.clamp;

_.assert( sqrt );

// --
// test
// --

function is( test )
{

  test.description = 'array'; //

  test.shouldBe( !_.axisAndAngle.is([]) );
  test.shouldBe( !_.axisAndAngle.is([ 0 ]) );
  test.shouldBe( !_.axisAndAngle.is([ 0,0 ]) );

  test.shouldBe( !_.axisAndAngle.is([ 0,0,0 ]) );
  test.shouldBe( _.axisAndAngle.is( [ 0,0,0 ],0 ) );
  test.shouldBe( !_.axisAndAngle.is( [ 0,0,0 ],null ) );
  test.shouldBe( !_.axisAndAngle.is( null,0 ) );
  test.shouldBe( !_.axisAndAngle.is( null,null ) );

  test.shouldBe( _.axisAndAngle.is([ 0,0,0,0 ]) );
  test.shouldBe( !_.axisAndAngle.is( [ 0,0,0,0 ],0 ) );
  test.shouldBe( !_.axisAndAngle.is( [ 0,0,0,0 ],null ) );

  test.shouldBe( !_.axisAndAngle.is([ 0,0,0,0,0 ]) );
  test.shouldBe( !_.axisAndAngle.is([ 0,0,0,0,0,0 ]) );
  test.shouldBe( !_.axisAndAngle.is([ 1,2,3,0,1,2 ]) );
  test.shouldBe( !_.axisAndAngle.is([ 0,0,0,0,0,0,0 ]) );

  test.description = 'vector'; //

  test.shouldBe( !_.axisAndAngle.is( _.vector.fromArray([]) ) );
  test.shouldBe( !_.axisAndAngle.is( _.vector.fromArray([ 0 ]) ) );
  test.shouldBe( !_.axisAndAngle.is( _.vector.fromArray([ 0,0 ]) ) );

  test.shouldBe( !_.axisAndAngle.is( _.vector.fromArray([ 0,0,0 ]) ) );
  test.shouldBe( _.axisAndAngle.is( _.vector.fromArray( [ 0,0,0 ]),0 ) );
  test.shouldBe( !_.axisAndAngle.is( _.vector.fromArray( [ 0,0,0 ]),null ) );

  test.shouldBe( _.axisAndAngle.is( _.vector.fromArray( [ 0,0,0,0 ]) ) );
  test.shouldBe( !_.axisAndAngle.is( _.vector.fromArray( [ 0,0,0,0 ] ),0 ) );
  test.shouldBe( !_.axisAndAngle.is( _.vector.fromArray( [ 0,0,0,0 ] ),null ) );

  test.shouldBe( !_.axisAndAngle.is( _.vector.fromArray([ 0,0,0,0,0 ]) ) );
  test.shouldBe( !_.axisAndAngle.is( _.vector.fromArray([ 0,0,0,0,0,0 ]) ) );
  test.shouldBe( !_.axisAndAngle.is( _.vector.fromArray([ 1,2,3,0,1,2 ]) ) );
  test.shouldBe( !_.axisAndAngle.is( _.vector.fromArray([ 0,0,0,0,0,0,0 ]) ) );

  test.description = 'not axisAndAngle'; //

  test.shouldBe( !_.axisAndAngle.is( 'abcdef' ) );
  test.shouldBe( !_.axisAndAngle.is( {} ) );
  test.shouldBe( !_.axisAndAngle.is( function( a,b,c,d,e,f ){} ) );

}

//

function like( test )
{

  test.description = 'array'; //

  test.shouldBe( !_.axisAndAngle.like([]) );
  test.shouldBe( !_.axisAndAngle.like([ 0 ]) );
  test.shouldBe( !_.axisAndAngle.like([ 0,0 ]) );

  test.shouldBe( !_.axisAndAngle.like([ 0,0,0 ]) );
  test.shouldBe( _.axisAndAngle.like( [ 0,0,0 ],0 ) );
  test.shouldBe( _.axisAndAngle.like( [ 0,0,0 ],null ) );
  test.shouldBe( _.axisAndAngle.like( null,0 ) );
  test.shouldBe( _.axisAndAngle.like( null,null ) );

  test.shouldBe( _.axisAndAngle.like([ 0,0,0,0 ]) );
  test.shouldBe( !_.axisAndAngle.like( [ 0,0,0,0 ],0 ) );
  test.shouldBe( !_.axisAndAngle.like( [ 0,0,0,0 ],null ) );

  test.shouldBe( !_.axisAndAngle.like([ 0,0,0,0,0 ]) );
  test.shouldBe( !_.axisAndAngle.like([ 0,0,0,0,0,0 ]) );
  test.shouldBe( !_.axisAndAngle.like([ 1,2,3,0,1,2 ]) );
  test.shouldBe( !_.axisAndAngle.like([ 0,0,0,0,0,0,0 ]) );

  test.description = 'vector'; //

  test.shouldBe( !_.axisAndAngle.like( _.vector.fromArray([]) ) );
  test.shouldBe( !_.axisAndAngle.like( _.vector.fromArray([ 0 ]) ) );
  test.shouldBe( !_.axisAndAngle.like( _.vector.fromArray([ 0,0 ]) ) );

  test.shouldBe( !_.axisAndAngle.like( _.vector.fromArray([ 0,0,0 ]) ) );
  test.shouldBe( _.axisAndAngle.like( _.vector.fromArray( [ 0,0,0 ]),0 ) );
  test.shouldBe( _.axisAndAngle.like( _.vector.fromArray( [ 0,0,0 ]),null ) );

  test.shouldBe( _.axisAndAngle.like( _.vector.fromArray( [ 0,0,0,0 ]) ) );
  test.shouldBe( !_.axisAndAngle.like( _.vector.fromArray( [ 0,0,0,0 ] ),0 ) );
  test.shouldBe( !_.axisAndAngle.like( _.vector.fromArray( [ 0,0,0,0 ] ),null ) );

  test.shouldBe( !_.axisAndAngle.like( _.vector.fromArray([ 0,0,0,0,0 ]) ) );
  test.shouldBe( !_.axisAndAngle.like( _.vector.fromArray([ 0,0,0,0,0,0 ]) ) );
  test.shouldBe( !_.axisAndAngle.like( _.vector.fromArray([ 1,2,3,0,1,2 ]) ) );
  test.shouldBe( !_.axisAndAngle.like( _.vector.fromArray([ 0,0,0,0,0,0,0 ]) ) );

  test.description = 'not axisAndAngle'; //

  test.shouldBe( !_.axisAndAngle.like( 'abcdef' ) );
  test.shouldBe( !_.axisAndAngle.like( {} ) );
  test.shouldBe( !_.axisAndAngle.like( function( a,b,c,d,e,f ){} ) );

}

//

function isZero( test )
{

  test.description = 'zero'; //

  test.shouldBe( _.axisAndAngle.isZero([ 0,0,0,0 ]) );
  test.shouldBe( _.axisAndAngle.isZero([ 1,0,0,0 ]) );
  test.shouldBe( _.axisAndAngle.isZero([ 0,1,0,0 ]) );
  test.shouldBe( _.axisAndAngle.isZero([ 0,0,1,0 ]) );

  test.shouldBe( _.axisAndAngle.isZero( [ 0,0,1 ],0 ) );

  test.description = 'not zero'; //

  test.shouldBe( !_.axisAndAngle.isZero([ 0,0,0,+0.1 ]) );
  test.shouldBe( !_.axisAndAngle.isZero([ 1,0,0,+0.1 ]) );
  test.shouldBe( !_.axisAndAngle.isZero([ 0,1,0,+0.1 ]) );
  test.shouldBe( !_.axisAndAngle.isZero([ 0,0,1,+0.1 ]) );
  test.shouldBe( !_.axisAndAngle.isZero([ 1,0,0,-0.1 ]) );
  test.shouldBe( !_.axisAndAngle.isZero([ 0,1,0,-0.1 ]) );
  test.shouldBe( !_.axisAndAngle.isZero([ 0,0,1,-0.1 ]) );

  test.shouldBe( !_.axisAndAngle.isZero([ 0,0,0 ],+0.1 ) );
  test.shouldBe( !_.axisAndAngle.isZero([ 1,0,0 ],+0.1 ) );
  test.shouldBe( !_.axisAndAngle.isZero([ 0,1,0 ],+0.1 ) );
  test.shouldBe( !_.axisAndAngle.isZero([ 0,0,1 ],+0.1 ) );
  test.shouldBe( !_.axisAndAngle.isZero([ 1,0,0 ],-0.1 ) );
  test.shouldBe( !_.axisAndAngle.isZero([ 0,1,0 ],-0.1 ) );
  test.shouldBe( !_.axisAndAngle.isZero([ 0,0,1 ],-0.1 ) );

  test.shouldBe( !_.axisAndAngle.isZero( [ 0,0,1 ],null ) );
  test.shouldBe( !_.axisAndAngle.isZero( null,0 ) );
  test.shouldBe( !_.axisAndAngle.isZero( null,null ) );

  test.shouldBe( !_.axisAndAngle.isZero( [ 0,0,1,0 ],null ) );
  test.shouldBe( !_.axisAndAngle.isZero( [ 0,0,1,0 ],0 ) );

}

//

function make( test )
{

  test.description = 'src undefined'; //

  var src = undefined;
  var got = _.axisAndAngle.make( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'src null'; //

  var src = null;
  var got = _.axisAndAngle.make( src );
  var expected = [ 0,0,0,0, ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'src array'; //

  var src = [ 0,1,2,5, ];
  var got = _.axisAndAngle.make( src );
  var expected = [ 0,1,2,5 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'src array and angle'; //

  var src = [ 0,1,2 ];
  var got = _.axisAndAngle.make( src,5 );
  var expected = [ 0,1,2,5 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'src vector'; //

  var src = _.vector.fromArray([ 0,1,2,5 ]);
  var got = _.axisAndAngle.make( src );
  var expected = [ 0,1,2,5 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'src vector'; //

  var src = _.vector.fromArray([ 0,1,2 ]);
  var got = _.axisAndAngle.make( src,5 );
  var expected = [ 0,1,2,5 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  if( !Config.debug )
  return;

  test.description = 'bad arguments'; //

  test.shouldThrowErrorSync( () => _.axisAndAngle.make( 0 ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.make( 4 ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.make( '4' ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.make( [ 0,0,0,0 ],2 ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.make( [ 0,0,0 ],2,2 ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.make( [ 0,0,0 ] ) );

}

//

function makeZero( test )
{

  test.description = 'trivial'; //

  var got = _.axisAndAngle.makeZero();
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );

  if( !Config.debug )
  return;

  test.description = 'bad arguments'; //

  test.shouldThrowErrorSync( () => _.axisAndAngle.makeZero( undefined ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.makeZero( null ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.makeZero( 4 ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.makeZero([ 0,0,0 ],1) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.makeZero([ 0,0,0,0 ]) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.makeZero([ 0,0,0,0,1,2 ]) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.makeZero( '4' ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.makeZero( [ 0,0,0,0,1,2 ],2 ) );

}

//

function from( test )
{

  test.description = 'from null'; /* */

  var src = null;
  var got = _.axisAndAngle.from( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'from null and null'; /* */

  var src = null;
  var got = _.axisAndAngle.from( src,null );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'from null and angle'; /* */

  var src = null;
  var got = _.axisAndAngle.from( src,3 );
  var expected = [ 0,0,0,3 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'from array and null'; /* */

  var src = [ 0,1,2 ];
  debugger;
  var got = _.axisAndAngle.from( src,null );
  var expected = [ 0,1,2,0 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'from array'; /* */

  var src = [ 0,1,2,3 ];
  var got = _.axisAndAngle.from( src );
  var expected = [ 0,1,2,3 ];
  test.identical( got,expected );
  test.shouldBe( got === src );

  test.description = 'from array and angle'; /* */

  var src = [ 0,1,2 ];
  var got = _.axisAndAngle.from( src,3 );
  var expected = [ 0,1,2,3 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'from vector'; /* */

  var src = _.vector.from([ 0,1,2,3 ]);
  var got = _.axisAndAngle.from( src );
  var expected = _.vector.from([ 0,1,2,3 ]);
  test.identical( got,expected );
  test.shouldBe( got === src );

  test.description = 'from vector and angle'; /* */

  debugger;
  var src = _.vector.from([ 0,1,2 ]);
  var got = _.axisAndAngle.from( src,3 );
  var expected = [ 0,1,2,3 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  if( !Config.debug )
  return;

  test.description = 'bad arguments'; //

  test.shouldThrowErrorSync( () => _.axisAndAngle.from() );
  test.shouldThrowErrorSync( () => _.axisAndAngle.from( undefined ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.from( null,null,null ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.from( [ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.from( [ 1,2,3,4,5 ] ) );

  test.shouldThrowErrorSync( () => _.axisAndAngle.from( 'abcd' ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.from( {} ) );

}

//

function _from( test )
{

  test.description = '_from null'; /* */

  var src = null;
  var got = _.axisAndAngle._from( src );
  var expected = _.vector.from([ 0,0,0,0 ]);
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = '_from null and null'; /* */

  var src = null;
  var got = _.axisAndAngle._from( src,null );
  var expected = _.vector.from([ 0,0,0,0 ]);
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = '_from null and angle'; /* */

  var src = null;
  var got = _.axisAndAngle._from( src,3 );
  var expected = _.vector.from([ 0,0,0,3 ]);
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = '_from array and null'; /* */

  var src = [ 0,1,2 ];
  debugger;
  var got = _.axisAndAngle._from( src,null );
  var expected = _.vector.from([ 0,1,2,0 ]);
  test.identical( got,expected );
  test.shouldBe( got !== src );
  test.shouldBe( got._vectorBuffer !== src );
  test.shouldBe( !!got._vectorBuffer );

  test.description = '_from array'; /* */

  var src = [ 0,1,2,3 ];
  var got = _.axisAndAngle._from( src );
  var expected = _.vector.from([ 0,1,2,3 ]);
  test.identical( got,expected );
  test.shouldBe( got !== src );
  test.shouldBe( got._vectorBuffer === src );
  test.shouldBe( !!got._vectorBuffer );

  test.description = '_from array and angle'; /* */

  var src = [ 0,1,2 ];
  var got = _.axisAndAngle._from( src,3 );
  var expected = _.vector.from([ 0,1,2,3 ]);
  test.identical( got,expected );
  test.shouldBe( got !== src );
  test.shouldBe( got._vectorBuffer !== src );
  test.shouldBe( !!got._vectorBuffer );

  test.description = '_from vector'; /* */

  var src = _.vector.from([ 0,1,2,3 ]);
  var got = _.axisAndAngle._from( src );
  var expected = _.vector.from([ 0,1,2,3 ]);
  test.identical( got,expected );
  test.shouldBe( got === src );

  test.description = '_from vector and angle'; /* */

  var src = _.vector.from([ 0,1,2 ]);
  var got = _.axisAndAngle._from( src,3 );
  var expected = _.vector.from([ 0,1,2,3 ]);
  test.identical( got,expected );
  test.shouldBe( got !== src );
  test.shouldBe( got._vectorBuffer !== src );
  test.shouldBe( !!got._vectorBuffer );

  if( !Config.debug )
  return;

  test.description = 'bad arguments'; //

  test.shouldThrowErrorSync( () => _.axisAndAngle._from() );
  test.shouldThrowErrorSync( () => _.axisAndAngle._from( undefined ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle._from( null,null,null ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle._from( [ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle._from( [ 1,2,3,4,5 ] ) );

  test.shouldThrowErrorSync( () => _.axisAndAngle._from( _.vector.from([ 1,2,3 ]) ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle._from( _.vector.from([ 1,2,3,4,5 ]) ) );

  test.shouldThrowErrorSync( () => _.axisAndAngle._from( 'abcd' ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle._from( {} ) );

}

//

function zero( test )
{

  test.description = 'src undefined'; //

  var src = undefined;
  var got = _.axisAndAngle.zero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'src null'; //

  var src = null;
  var got = _.axisAndAngle.zero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.shouldBe( got !== src );

  test.description = 'dst array'; //

  var dst = [ 0,1,2,5 ];
  var got = _.axisAndAngle.zero( dst );
  var expected = [ 0,1,2,0 ];
  test.identical( got,expected );
  test.shouldBe( got === dst );

  test.description = 'dst vector'; //

  var dst = _.vector.fromArray([ 0,1,2,5 ]);
  var got = _.axisAndAngle.zero( dst );
  var expected = _.vector.fromArray([ 0,1,2,0 ]);
  test.identical( got,expected );
  test.shouldBe( got === dst );

  if( !Config.debug )
  return;

  test.description = 'bad arguments'; //

  test.shouldThrowErrorSync( () => _.axisAndAngle.zero( 4 ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.zero([ 0,0,0 ]) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.zero( '4' ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.zero( [ 0,0,0,5,5,5 ],2 ) );

}

// --
// proto
// --

var Self =
{

  name : 'Math.AxisAndAngle',
  silencing : 1,
  // routine : 'isZero',

  context :
  {
  },

  tests :
  {

    is : is,
    like : like,
    isZero : isZero,

    make : make,
    makeZero : makeZero,

    from : from,
    _from : _from,

    zero : zero,

  },

}

//

Self = wTestSuit( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
