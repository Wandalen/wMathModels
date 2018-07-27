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

  require( '../geometric/aConcepts.s' );

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


function make( test )
{

  test.case = 'src undefined'; /* */

  var src = undefined;
  var got = _.sphere.make( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src null'; /* */

  var src = null;
  var got = _.sphere.make( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src 2'; /* */

  var src = 2;
  var got = _.sphere.make( src );
  var expected = [ 0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src array'; /* */

  var src = [ 0,1,2,3 ];
  var got = _.sphere.make( src );
  var expected = [ 0,1,2,3 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src vector'; /* */

  var src = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.sphere.make( src );
  var expected = [ 0,1,2,3 ];
  test.identical( got,expected );
  test.is( got !== src );

}

//

function makeZero( test )
{

  test.case = 'src undefined'; /* */

  var src = undefined;
  var got = _.sphere.makeZero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src null'; /* */

  var src = null;
  var got = _.sphere.makeZero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src 2'; /* */

  var src = 2;
  var got = _.sphere.makeZero( src );
  var expected = [ 0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src array'; /* */

  var src = [ 0,1,2,3 ];
  var got = _.sphere.makeZero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src vector'; /* */

  var src = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.sphere.makeZero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

}

//

function makeNil( test )
{

  test.case = 'src undefined'; /* */

  var src = undefined;
  var got = _.sphere.makeNil( src );
  var expected = [ 0,0,0,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src null'; /* */

  var src = null;
  var got = _.sphere.makeNil( src );
  var expected = [ 0,0,0,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src 2'; /* */

  var src = 2;
  var got = _.sphere.makeNil( src );
  var expected = [ 0,0,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src array'; /* */

  var src = [ 0,1,2,3 ];
  var got = _.sphere.makeNil( src );
  var expected = [ 0,0,0,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src vector'; /* */

  var src = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.sphere.makeNil( src );
  var expected = [ 0,0,0,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

}

//

function zero( test )
{

  test.case = 'src undefined'; /* */

  var src = undefined;
  var got = _.sphere.zero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src null'; /* */

  var src = null;
  var got = _.sphere.zero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src 2'; /* */

  var src = 2;
  var got = _.sphere.zero( src );
  var expected = [ 0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'dst array'; /* */

  var dst = [ 0,1,2,3 ];
  var got = _.sphere.zero( dst );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got === dst );

  test.case = 'dst vector'; /* */

  var dst = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.sphere.zero( dst );
  var expected = _.vector.fromArray([ 0,0,0,0 ]);
  test.identical( got,expected );
  test.is( got === dst );

  test.case = 'dst array 2d'; /* */

  var dst = [ 0,1,5 ];
  var got = _.sphere.zero( dst );
  var expected = [ 0,0,0 ];
  test.identical( got,expected );
  test.is( got === dst );

}

//

function nil( test )
{

  test.case = 'src undefined'; /* */

  var src = undefined;
  var got = _.sphere.nil( src );
  var expected = [ 0,0,0,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src null'; /* */

  var src = null;
  var got = _.sphere.nil( src );
  var expected = [ 0,0,0,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src 2'; /* */

  var src = 2;
  var got = _.sphere.nil( src );
  var expected = [ 0,0,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'dst array'; /* */

  var dst = [ 0,1,2,3 ];
  var got = _.sphere.nil( dst );
  var expected = [ 0,0,0,-Infinity ];
  test.identical( got,expected );
  test.is( got === dst );

  test.case = 'dst vector'; /* */

  var dst = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.sphere.nil( dst );
  var expected = _.vector.fromArray([ 0,0,0,-Infinity ]);
  test.identical( got,expected );
  test.is( got === dst );

  test.case = 'dst array 2d'; /* */

  var dst = [ 0,1,5 ];
  var got = _.sphere.nil( dst );
  var expected = [ 0,0,-Infinity ];
  test.identical( got,expected );
  test.is( got === dst );

}

//

function centeredOfRadius( test )
{

  test.case = 'src undefined'; /* */

  var src = undefined;
  var got = _.sphere.centeredOfRadius( src );
  var expected = [ 0,0,0,0.5 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src null'; /* */

  var src = null;
  var got = _.sphere.centeredOfRadius( src );
  var expected = [ 0,0,0,0.5 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src 2'; /* */

  var src = 2;
  var got = _.sphere.centeredOfRadius( src );
  var expected = [ 0,0,0.5 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'dst array'; /* */

  var dst = [ 0,1,2,3 ];
  var got = _.sphere.centeredOfRadius( dst );
  var expected = [ 0,0,0,0.5 ];
  test.identical( got,expected );
  test.is( got === dst );

  test.case = 'dst vector'; /* */

  var dst = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.sphere.centeredOfRadius( dst );
  var expected = _.vector.fromArray([ 0,0,0,0.5 ]);
  test.identical( got,expected );
  test.is( got === dst );

  test.case = 'dst array 2d'; /* */

  var dst = [ 0,1,5 ];
  var got = _.sphere.centeredOfRadius( dst );
  var expected = [ 0,0,0.5 ];
  test.identical( got,expected );
  test.is( got === dst );

  /* */

  test.case = 'src undefined'; /* */

  var src = undefined;
  var got = _.sphere.centeredOfRadius( src,2 );
  var expected = [ 0,0,0,2 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src null'; /* */

  var src = null;
  var got = _.sphere.centeredOfRadius( src,2 );
  var expected = [ 0,0,0,2 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src 2'; /* */

  var src = 2;
  var got = _.sphere.centeredOfRadius( src,2 );
  var expected = [ 0,0,2 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'dst array'; /* */

  var dst = [ 0,1,2,3 ];
  var got = _.sphere.centeredOfRadius( dst,2 );
  var expected = [ 0,0,0,2 ];
  test.identical( got,expected );
  test.is( got === dst );

  test.case = 'dst vector'; /* */

  var dst = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.sphere.centeredOfRadius( dst,2 );
  var expected = _.vector.fromArray([ 0,0,0,2 ]);
  test.identical( got,expected );
  test.is( got === dst );

  test.case = 'dst array 2d'; /* */

  var dst = [ 0,1,5 ];
  var got = _.sphere.centeredOfRadius( dst,2 );
  var expected = [ 0,0,2 ];
  test.identical( got,expected );
  test.is( got === dst );

}

//

function fromPoints( test )
{

  test.case = 'Points remain unchanged and Destination sphere changes'; /* */

  var dstSphere = [ 0, 0, 0, 1 ];
  var points = [ [ 1, 1, 0 ], [ 0, 0, 0 ], [ 0, 0, 2 ] ];
  var expected = [ 0, 0, 0, 2 ];

  var gotSphere = _.sphere.fromPoints( dstSphere, points );
  test.identical( gotSphere, expected );
  test.identical( dstSphere, expected );

  var oldpoints = [ [ 1, 1, 0 ], [ 0, 0, 0 ], [ 0, 0, 2 ] ];
  test.identical( points, oldpoints );

  test.case = 'Create sphere of two dimensions'; /* */

  var dstSphere = null;
  var points = [ [ 1, 0 ], [ 0, - 2 ], [ 0, 3 ], [ - 3, 4 ] ];
  var expected = [ 0, 0, 5 ];

  var gotSphere = _.sphere.fromPoints( dstSphere, points );
  test.identical( gotSphere, expected );

  test.case = 'Create sphere three dimensions'; /* */

  var dstSphere = null;
  var points = [ [ 1, 0, 0 ], [ 0, 2, 0 ], [ 0, 0, 3 ] ];
  var expected = [ 0, 0, 0, 3 ];

  var gotSphere = _.sphere.fromPoints( dstSphere, points );
  test.identical( gotSphere, expected );

  test.case = 'Zero points - sphere not expanded'; /* */

  var dstSphere = null;
  var points= [ [ 0, 0, 0 ], [ 0, 0, 0 ] ];
  var expected = [ 0, 0, 0, 0 ];

  var gotSphere = _.sphere.fromPoints( dstSphere, points);
  test.identical( gotSphere, expected );

  test.case = 'sphere expanded'; /* */

  var dstSphere = [ 0, 0, 0, 2 ];
  var points= [ [ - 1, 0, - 1 ], [ 0, 3, 0 ], [ 0, - 3, 0 ] ] ;
  var expected = [ 0, 0, 0, 3 ];

  var gotSphere = _.sphere.fromPoints( dstSphere, points);
  test.identical( gotSphere, expected );

  test.case = 'sphere NOT expanded ( points inside sphere )'; /* */

  var dstSphere = [ 1, 1, 1, 2 ];
  var points= [ [ 0, 1, 1 ], [ 1, 0, 1 ], [ 1, 1, 0 ] ];
  var expected = [ 1,  1, 1, 1 ];

  var gotSphere = _.sphere.fromPoints( dstSphere, points);
  test.identical( gotSphere, expected );

  test.case = 'sphere ( normalized to 1 ) expanded'; /* */

  var dstSphere = [ 0, 0, 0, 0 ];
  var points= [ [ - 0.500, 0, 0 ], [ 0, 0.005, 0 ] ];
  var expected = [ 0, 0, 0, 0.5 ];

  var gotSphere = _.sphere.fromPoints( dstSphere, points);
  test.identical( gotSphere, expected );

  test.case = 'Null sphere of four dimensions expanded'; /* */

  var dstSphere = [ 0, 0, 0, 0, 0 ];
  var points= [ [ 0, 0, 0, 1 ], [ 0, 0, 3 , 4 ] ];
  var expected = [ 0, 0, 0, 0, 5 ];

  var gotSphere = _.sphere.fromPoints( dstSphere, points);
  test.identical( gotSphere, expected );

  test.case = 'Null sphere of 7 dimensions expanded'; /* */

  var dstSphere = [  0, 0, 0, 0, 0, 0, 0, 1 ];
  var points= [ [ 0, 2, 0, 0, 0, 0, 0 ], [ 0, 0, 0 , 4, 0, 0, 0 ] ] ;
  var expected = [ 0, 0, 0, 0, 0, 0, 0, 4 ];

  var gotSphere = _.sphere.fromPoints( dstSphere, points);
  test.identical( gotSphere, expected );

  test.case = 'sphere of 1 dimension expanded'; /* */

  var dstSphere = [ 0, 0 ];
  var points= [ [ - 1 ], [ 0 ], [ 1 ] ];
  var expected = [ 0, 1 ];

  var gotSphere = _.sphere.fromPoints( dstSphere, points);
  test.identical( gotSphere, expected );


  test.case = 'sphere of 1 dimension not expanded - NaN'; /* */

  var dstSphere = [ NaN, NaN ];
  var points= [ [ NaN ], [ NaN ], [ NaN ] ];
  var expected = [ NaN, NaN ];

  var gotSphere = _.sphere.fromPoints( dstSphere, points);
  test.identical( gotSphere, expected );


  test.case = 'sphere of 1 dimension not expanded - NaN'; /* */

  var dstShere = [ NaN, NaN ];
  var points= [ [ 1 ], [ 2 ], [ 0 ] ];
  var expected = [ NaN, NaN ];

  var gotSphere = _.sphere.fromPoints( dstSphere, points);
  test.identical( gotSphere, expected );


  test.case = 'sphere of 1 dimension not expanded - NaN'; /* */

  var dstSphere = [ 0, 1 ];
  var points= [ [ NaN ], [ NaN ], [ NaN ] ];
  var expected = [ 0, NaN ];

  var gotSphere = _.sphere.fromPoints( dstSphere, points);
  test.identical( gotSphere, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.fromPoints();
  });


  test.case = 'Wrong type of argument - none'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.fromPoints( [ ] , [ [ ], [ ] ] );
  });

  test.case = 'Wrong type of argument - string'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.fromPoints( 'sphere', 'points' );
  });

  test.case = 'Wrong type of argument - number'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.fromPoints( null, 4 );
  });

  test.case = 'Too few arguments'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.fromPoints( [ 0, 0, 0 ] );
  });

  test.case = 'Too few arguments - one point'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.fromPoints( [ 0, 0, 0 ], [ 1, 1, 1 ]);
  });

  test.case = 'too many arguments'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.fromPoints( [ 0, 0, 0 ], [ [ 0, 1 ], [ 2, 1 ], [ 0, 3 ] ], [ 1, 0 ] );
  });

  test.case = 'Wrong points dimension (sphere 3D vs points 4D)'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.fromPoints( [ 0, 0, 0, 0 ], [ [ 0, 1, 0, 2 ], [ 0, 1, - 3, 4 ] ] );
  });

  test.case = 'Wrong points dimension (sphere 3D vs points 2D)'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.fromPoints( [ 0, 0, 0, 0 ], [ [ 0, 1 ], [ 2, 1 ], [ 0, 3 ] ] );
  });

  test.case = 'Wrong points dimension (sphere 2D vs points 1D)'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.fromPoints( [ 0, 0, 0 ], [ [ 1 ], [ 0 ] ] );
  });
}

//

function fromBox( test )
{

  debugger;

  test.case = 'trivial'; /* */

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

  test.case = 'same sizes, different position'; /* */

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

  test.case = 'different sizes, different position'; /* */

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

  test.case = 'bad arguments'; /* */

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

function fromCenterAndRadius( test )
{

  test.case = 'Center and radius remain unchanged and Destination sphere changes'; /* */

  var dstSphere = [ 0, 0, 0, 1 ];
  var center = [ 0, 0, 2 ];
  var radius = 3;
  var expected = [ 0, 0, 2, 3 ];

  var gotSphere = _.sphere.fromCenterAndRadius( dstSphere, center, radius );
  test.identical( gotSphere, expected );
  test.identical( dstSphere, expected );

  var oldcenter = [ 0, 0, 2 ];
  test.identical( center, oldcenter );
  var oldradius = 3;
  test.identical( radius, oldradius );

  test.case = 'Create sphere of one dimension'; /* */

  var dstSphere = null;
  var center = [ 0 ];
  var radius = 1;
  var expected = [ 0, 1 ];

  var gotSphere = _.sphere.fromCenterAndRadius( dstSphere, center, radius);
  test.identical( gotSphere, expected );

  test.case = 'Create sphere of two dimensions'; /* */

  var dstSphere = null;
  var center = [ 0, 1 ];
  var radius = 1;
  var expected = [ 0, 1, 1 ];

  var gotSphere = _.sphere.fromCenterAndRadius( dstSphere, center, radius );
  test.identical( gotSphere, expected );

  test.case = 'Create sphere three dimensions'; /* */

  var dstSphere = null;
  var center = [ 0, 0, 0 ];
  var radius = 3;
  var expected = [ 0, 0, 0, 3 ];

  var gotSphere = _.sphere.fromCenterAndRadius( dstSphere, center, radius );
  test.identical( gotSphere, expected );

  test.case = 'sphere expanded - center moved'; /* */

  var dstSphere = [ 0, 0, 0, 2 ];
  var center = [ 0, - 5.5, 101 ];
  var radius = 6;
  var expected = [ 0, - 5.5, 101, 6 ];

  var gotSphere = _.sphere.fromCenterAndRadius( dstSphere, center, radius);
  test.identical( gotSphere, expected );

  test.case = 'sphere contracted'; /* */

  var dstSphere = [ 1, 1, 1, 2 ];
  var center = [ 1, 1, 1 ];
  var radius = 1;
  var expected = [ 1,  1, 1, 1 ];

  var gotSphere = _.sphere.fromCenterAndRadius( dstSphere, center, radius);
  test.identical( gotSphere, expected );

  test.case = 'sphere ( normalized to 1 ) expanded'; /* */

  var dstSphere = [ 0.2, - 0.1, 0.6, 0.2 ];
  var center = [ - 0.4,  0.1, 0.3 ];
  var radius = 0.5;
  var expected = [ - 0.4,  0.1, 0.3, 0.5 ];

  var gotSphere = _.sphere.fromCenterAndRadius( dstSphere, center, radius);
  test.identical( gotSphere, expected );

  test.case = 'Zero sphere of four dimensions expanded'; /* */

  var dstSphere = [ 0, 0, 0, 0, 0 ];
  var center = [ 0, 1, 2, 3 ];
  var radius = 1;
  var expected = [ 0, 1, 2, 3, 1 ];

  var gotSphere = _.sphere.fromCenterAndRadius( dstSphere, center, radius);
  test.identical( gotSphere, expected );

  test.case = 'Null sphere of 7 dimensions expanded'; /* */

  var dstSphere = [  0, 0, 0, 0, 0, 0, 0, 1 ];
  var center = [  0, 3, 0, - 2, 0, 3, 0 ];
  var radius = 2;
  var expected = [ 0, 3, 0, - 2, 0, 3, 0, 2 ];

  var gotSphere = _.sphere.fromCenterAndRadius( dstSphere, center, radius);
  test.identical( gotSphere, expected );

  test.case = 'sphere of 1 dimension expanded'; /* */

  var dstSphere = [ 0, 0 ];
  var center = [ 0 ];
  var radius = 1;
  var expected = [ 0, 1 ];

  var gotSphere = _.sphere.fromCenterAndRadius( dstSphere, center, radius);
  test.identical( gotSphere, expected );

  test.case = 'NaN sphere of 1 dimension expanded'; /* */

  var dstSphere = [ NaN, NaN ];
  var center = [ 0 ];
  var radius = 1;
  var expected = [ 0, 1 ];

  var gotSphere = _.sphere.fromCenterAndRadius( dstSphere, center, radius);
  test.identical( gotSphere, expected );

  test.case = 'sphere of 1 dimension no center - center NaN'; /* */

  var dstSphere = [ 0, 1 ];
  var center = [ NaN ];
  var radius = 1;
  var expected = [ NaN, 1 ];

  var gotSphere = _.sphere.fromCenterAndRadius( dstSphere, center, radius);
  test.identical( gotSphere, expected );

  test.case = 'sphere of 1 dimension not expanded - radius NaN'; /* */

  var dstSphere = [ 0, 1 ];
  var center = [ 0 ];
  var radius = NaN;
  var expected = [ 0, NaN ];

  var gotSphere = _.sphere.fromCenterAndRadius( dstSphere, center, radius);
  test.identical( gotSphere, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.fromCenterAndRadius();
  });

  test.case = 'Wrong type of argument - none'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.fromCenterAndRadius( [ ] , [ ], [ ]  );
  });

  test.case = 'Wrong type of argument - string'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.fromCenterAndRadius( 'sphere', 'center', 'radius' );
  });

  test.case = 'Wrong type of argument - number'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.fromCenterAndRadius( 1, 2, 4 );
  });

  test.case = 'Too few arguments'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.fromCenterAndRadius( [ 0, 0, 0 ] );
  });

  test.case = 'Too few arguments - no radius'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.fromCenterAndRadius( [ 0, 0, 0 ], [ 1, 1, 1 ] );
  });

  test.case = 'Too few arguments - no center'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.fromCenterAndRadius( [ 0, 0, 0 ], 1 );
  });

  test.case = 'too many arguments'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.fromCenterAndRadius( [ 0, 0, 0 ], [ 0, 1 ], [ 2, 1 ], 3 );
  });

  test.case = 'Wrong center dimension ( sphere 3D vs center 4D )'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.fromCenterAndRadius( [ 0, 0, 0, 0 ], [ 0, 1, 0, 2 ], 3 );
  });

  test.case = 'Wrong center dimension ( sphere 3D vs center 2D )'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.fromCenterAndRadius( [ 0, 0, 0, 0 ], [ 2, 1 ], 2 );
  });

  test.case = 'Wrong center dimension ( sphere 2D vs center 1D )'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.fromCenterAndRadius( [ 0, 0, 0 ], [ 1 ], 1 );
  });

  test.case = 'Wrong radius dimension'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.fromCenterAndRadius( [ 0, 0, 0 ], [ 1, 1 ], [1,0] );
  });

}

//

function is( test )
{

  var s =
`
  test.is( _.sphere.is([ 0 ]) );
  test.is( _.sphere.is([ 0,0 ]) );
  test.is( _.sphere.is([ 0,0,0 ]) );
  test.is( _.sphere.is([ 0,0,0,0 ]) );
`

  console.log( s );

  test.case = 'array'; /* */

  test.is( _.sphere.is([ 0 ]) );
  test.is( _.sphere.is([ 0,0 ]) );
  test.is( _.sphere.is([ 0,0,0 ]) );
  test.is( _.sphere.is([ 0,0,0,0 ]) );

  test.case = 'vector'; /* */

  test.is( _.sphere.is( _.vector.fromArray([ 0 ]) ) );
  test.is( _.sphere.is( _.vector.fromArray([ 0,0 ]) ) );
  test.is( _.sphere.is( _.vector.fromArray([ 0,0,0 ]) ) );
  test.is( _.sphere.is( _.vector.fromArray([ 0,0,0,0 ]) ) );

  test.case = 'not sphere'; /* */

  test.is( !_.sphere.is( [] ) );
  test.is( !_.sphere.is( _.vector.fromArray([]) ) );
  test.is( !_.sphere.is( 'abc' ) );
  test.is( !_.sphere.is( { center : [ 0,0,0 ], radius : 1 } ) );
  test.is( !_.sphere.is( function( a,b,c ){} ) );

}

//

function isEmpty( test )
{

  debugger;

  test.case = 'empty'; /* */

  test.is( _.sphere.isEmpty([ 0 ]) );
  test.is( _.sphere.isEmpty([ 0,0 ]) );
  test.is( _.sphere.isEmpty([ 0,0,0 ]) );
  test.is( _.sphere.isEmpty([ 0,0,0,0 ]) );

  test.is( _.sphere.isEmpty([ 0 ]) );
  test.is( _.sphere.isEmpty([ 1,0 ]) );
  test.is( _.sphere.isEmpty([ 1,0,0 ]) );
  test.is( _.sphere.isEmpty([ 1,0,0,0 ]) );

  test.is( _.sphere.isEmpty([ -1 ]) );
  test.is( _.sphere.isEmpty([ 0,-1 ]) );
  test.is( _.sphere.isEmpty([ 0,0,-1 ]) );
  test.is( _.sphere.isEmpty([ 0,0,0,-1 ]) );

  test.is( _.sphere.isEmpty([ -Infinity ]) );
  test.is( _.sphere.isEmpty([ 0,-Infinity ]) );
  test.is( _.sphere.isEmpty([ 0,0,-Infinity ]) );
  test.is( _.sphere.isEmpty([ 0,0,0,-Infinity ]) );

  test.is( _.sphere.isEmpty([ 0.1,-Infinity ]) );
  test.is( _.sphere.isEmpty([ 0,0.1,-Infinity ]) );
  test.is( _.sphere.isEmpty([ 0,0,0.1,-Infinity ]) );

  test.case = 'not empty'; /* */

  test.is( !_.sphere.isEmpty([ 1 ]) );
  test.is( !_.sphere.isEmpty([ 0,1 ]) );
  test.is( !_.sphere.isEmpty([ 0,0,1 ]) );
  test.is( !_.sphere.isEmpty([ 0,0,0,1 ]) );

  test.is( !_.sphere.isEmpty([ Infinity ]) );
  test.is( !_.sphere.isEmpty([ 0,Infinity ]) );
  test.is( !_.sphere.isEmpty([ 0,0,Infinity ]) );
  test.is( !_.sphere.isEmpty([ 0,0,0,Infinity ]) );

}

//

function isZero( test )
{

  test.case = 'zero'; /* */

  test.is( _.sphere.isZero([ 0 ]) );
  test.is( _.sphere.isZero([ 0,0 ]) );
  test.is( _.sphere.isZero([ 0,0,0 ]) );
  test.is( _.sphere.isZero([ 0,0,0,0 ]) );

  test.is( _.sphere.isZero([ 0 ]) );
  test.is( _.sphere.isZero([ 1,0 ]) );
  test.is( _.sphere.isZero([ 1,0,0 ]) );
  test.is( _.sphere.isZero([ 1,0,0,0 ]) );

  test.case = 'not zero'; /* */

  test.is( !_.sphere.isZero([ 1 ]) );
  test.is( !_.sphere.isZero([ 0,1 ]) );
  test.is( !_.sphere.isZero([ 0,0,1 ]) );
  test.is( !_.sphere.isZero([ 0,0,0,1 ]) );

  test.is( !_.sphere.isZero([ -1 ]) );
  test.is( !_.sphere.isZero([ 0,-1 ]) );
  test.is( !_.sphere.isZero([ 0,0,-1 ]) );
  test.is( !_.sphere.isZero([ 0,0,0,-1 ]) );

  test.is( !_.sphere.isZero([ -Infinity ]) );
  test.is( !_.sphere.isZero([ 0,-Infinity ]) );
  test.is( !_.sphere.isZero([ 0,0,-Infinity ]) );
  test.is( !_.sphere.isZero([ 0,0,0,-Infinity ]) );

  test.is( !_.sphere.isZero([ Infinity ]) );
  test.is( !_.sphere.isZero([ 0,Infinity ]) );
  test.is( !_.sphere.isZero([ 0,0,Infinity ]) );
  test.is( !_.sphere.isZero([ 0,0,0,Infinity ]) );

  test.is( !_.sphere.isZero([ 0.1,-Infinity ]) );
  test.is( !_.sphere.isZero([ 0,0.1,-Infinity ]) );
  test.is( !_.sphere.isZero([ 0,0,0.1,-Infinity ]) );

}

//

function isNil( test )
{

  test.case = 'nil'; /* */

  test.is( _.sphere.isNil([ -Infinity ]) );
  test.is( _.sphere.isNil([ 0,-Infinity ]) );
  test.is( _.sphere.isNil([ 0,0,-Infinity ]) );
  test.is( _.sphere.isNil([ 0,0,0,-Infinity ]) );

  test.case = 'not nil'; /* */

  test.is( !_.sphere.isNil([ Infinity ]) );
  test.is( !_.sphere.isNil([ 0,Infinity ]) );
  test.is( !_.sphere.isNil([ 0,0,Infinity ]) );
  test.is( !_.sphere.isNil([ 0,0,0,Infinity ]) );

  test.is( !_.sphere.isNil([ 0.1,-Infinity ]) );
  test.is( !_.sphere.isNil([ 0,0.1,-Infinity ]) );
  test.is( !_.sphere.isNil([ 0,0,0.1,-Infinity ]) );

}

//

function dimGet( test )
{

  test.case = 'Source sphere remains unchanged'; /* */

  var srcSphere = [ 0, 0, 1, 1 ];
  var oldSrcSphere = srcSphere.slice();
  var expected = 3;

  var gotDim = _.sphere.dimGet( srcSphere );
  test.identical( gotDim, expected );
  test.identical( srcSphere, oldSrcSphere );

  test.case = 'Nil sphere sphere'; /* */

  var sphere = [ 1, 1, 1, -Infinity ];
  var expected = 3;

  var gotDim = _.sphere.dimGet( sphere );
  test.identical( gotDim, expected );

  test.case = 'Zero dimension sphere'; /* */

  var sphere = [ 1 ];
  var expected = 0;

  var gotDim = _.sphere.dimGet( sphere );
  test.identical( gotDim, expected );

  test.case = 'One dimension sphere'; /* */

  var sphere = [ 0, 0 ];
  var expected = 1;

  var gotDim = _.sphere.dimGet( sphere );
  test.identical( gotDim, expected );

  test.case = 'Two dimension sphere'; /* */

  var sphere = [ 0, - 1, 1.5 ];
  var expected = 2;

  var gotDim = _.sphere.dimGet( sphere );
  test.identical( gotDim, expected );

  test.case = 'Three dimension sphere'; /* */

  var sphere = [ - 1, 0, 1.2, 2 ];
  var expected = 3;

  var gotDim = _.sphere.dimGet( sphere );
  test.identical( gotDim, expected );

  test.case = 'Four dimension sphere'; /* */

  var sphere = [ - 1, - 2.2, 1, 2, 5.4 ];
  var expected = 4;

  var gotDim = _.sphere.dimGet( sphere );
  test.identical( gotDim, expected );

  test.case = 'Eight dimension sphere'; /* */

  var sphere = [ - 1, - 2.2, - 3, 5, 0.1, 1, 2, 5.4, - 1.1 ];
  var expected = 8;

  var gotDim = _.sphere.dimGet( sphere );
  test.identical( gotDim, expected );


  test.case = 'NaN'; /* */

  var sphere = [ 'Hi', 'world' ];
  var expected = 1;

  var gotDim = _.sphere.dimGet( sphere );
  test.identical( gotDim, expected );

  test.case = 'NaN'; /* */

  var sphere = [ 'Hi', 'world', null, null, NaN, NaN ];
  var expected = 5;

  var gotDim = _.sphere.dimGet( sphere );
  test.identical( gotDim, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.dimGet();
  });

  test.case = 'Wrong Sphere dimension'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.dimGet( [] );
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.dimGet( 'Hi' );
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.dimGet( null );
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.dimGet( 3 );
  });

  test.case = 'To many arguments'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.dimGet( [ 0, 1 ], [ 0, 1 ] );
  });

}

//

function centerGet( test )
{

  test.case = 'Source sphere remains unchanged'; /* */

  var srcSphere = [ 0, 0, 1, 1 ];
  var oldSrcSphere = srcSphere.slice();
  var expected = [ 0, 0, 1 ];
  expected = _.vector.from(expected);

  var gotCenter = _.sphere.centerGet( srcSphere );

  test.equivalent( srcSphere, oldSrcSphere );
  test.identical( gotCenter, expected );

  test.case = 'Zero dimension sphere'; /* */

  var sphere = [ 0 ];
  var expected = [ ];
  expected = _.vector.from(expected);

  var gotCenter = _.sphere.centerGet( sphere );
  test.identical( gotCenter, expected );

  test.case = 'One dimension sphere'; /* */

  var sphere = [ 0, 0 ];
  var expected = [ 0 ];
  expected = _.vector.from(expected);

  var gotCenter = _.sphere.centerGet( sphere );
  test.identical( gotCenter, expected );

  test.case = 'Two dimension sphere'; /* */

  var sphere = [ 0, 0, 2 ];
  var expected = [ 0, 0 ];
  expected = _.vector.from(expected);

  var gotCenter = _.sphere.centerGet( sphere );
  test.identical( gotCenter, expected );

  test.case = 'Three dimension sphere'; /* */

  var sphere = [ 0, - 1, - 2, 2 ];
  var expected = [ 0, - 1, - 2 ];
  expected = _.vector.from(expected);

  var gotCenter = _.sphere.centerGet( sphere );
  test.identical( gotCenter, expected );

  test.case = 'Four dimension sphere'; /* */

  var sphere = [ 0, - 1, - 2, 2, 0 ];
  var expected = [ 0, - 1, - 2, 2 ];
  expected = _.vector.from(expected);

  var gotCenter = _.sphere.centerGet( sphere );
  test.identical( gotCenter, expected );

  test.case = 'Eight dimension sphere'; /* */

  var sphere = [  0, - 1, - 2, 2, 0, 1, 2, 6, - 1 ];
  var expected = [ 0, - 1, -2, 2, 0, 1, 2, 6 ];
  expected = _.vector.from(expected);

  var gotCenter = _.sphere.centerGet( sphere );
  test.identical( gotCenter, expected );

  test.case = 'normalized sphere'; /* */

  var sphere = [ 0.624, 0.376, 0.52 ];
  var expected = [ 0.624, 0.376 ];
  expected = _.vector.from(expected);

  var gotCenter = _.sphere.centerGet( sphere );
  test.identical( gotCenter, expected );

  test.case = 'negative radius'; /* */

  var sphere = [ 1, 2, - 3 ];
  var expected = [ 1, 2 ];
  expected = _.vector.from(expected);

  var gotCenter = _.sphere.centerGet( sphere );
  test.identical( gotCenter, expected );


  test.case = 'NaN radius'; /* */

  var sphere = [ 1, 2, NaN ];
  var expected = [ 1, 2 ];
  expected = _.vector.from(expected);

  var gotCenter = _.sphere.centerGet( sphere );
  test.identical( gotCenter, expected );

  test.case = 'NaN sphere'; /* */

  var sphere = [ NaN, NaN, NaN ];
  var expected = [ NaN, NaN ];
  expected = _.vector.from(expected);

  var gotCenter = _.sphere.centerGet( sphere );
  test.identical( gotCenter, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.centerGet();
  });

  test.case = 'Too many arguments'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.centerGet( [ 0, 0, 1, 1 ], [ 0, 0, 0, 0 ] );
  });

  test.case = 'Wrong type of arguments'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.centerGet( null );
  });

  test.case = 'Wrong type of arguments'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.centerGet( 'string' );
  });

  test.case = 'Wrong type of arguments'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.centerGet( 4 );
  });

  test.case = 'Wrong sphere dimension'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.centerGet( [ ] );
  });

}

//

function radiusGet( test )
{

  test.case = 'Source sphere remains unchanged'; /* */

  var srcSphere = [ 0, 0, 1, 1 ];
  var oldSrcSphere = srcSphere.slice();
  var expected =  1 ;
  // expected = _.vector.from(expected);

  var gotRadius = _.sphere.radiusGet( srcSphere );

  test.equivalent( srcSphere, oldSrcSphere );
  test.identical( gotRadius, expected );

  test.case = 'Zero dimension sphere'; /* */

  var sphere = [ 0 ];
  var expected = 0;

  var gotRadius = _.sphere.radiusGet( sphere );
  test.identical( gotRadius, expected );

  test.case = 'One dimension sphere'; /* */

  var sphere = [ 0, 0 ];
  var expected =  0 ;

  var gotRadius = _.sphere.radiusGet( sphere );
  test.identical( gotRadius, expected );

  test.case = 'Two dimension sphere'; /* */

  var sphere = [ 0, 0, 2 ];
  var expected = 2;

  var gotRadius = _.sphere.radiusGet( sphere );
  test.identical( gotRadius, expected );

  test.case = 'Three dimension sphere'; /* */

  var sphere = [ 0, - 1, - 2, 2 ];
  var expected = 2;

  var gotRadius = _.sphere.radiusGet( sphere );
  test.identical( gotRadius, expected );

  test.case = 'Four dimension sphere'; /* */

  var sphere = [ 0, - 1, - 2, 2, 0 ];
  var expected =  0;

  var gotRadius = _.sphere.radiusGet( sphere );
  test.identical( gotRadius, expected );

  test.case = 'Eight dimension sphere'; /* */

  var sphere = [  0, - 1, - 2, 2, 0, 1, 2, 6, 1 ];
  var expected = 1;

  var gotRadius = _.sphere.radiusGet( sphere );
  test.identical( gotRadius, expected );

  test.case = 'normalized sphere'; /* */

  var sphere = [ 0.624, 0.376, 0.52 ];
  var expected = 0.52;

  var gotRadius = _.sphere.radiusGet( sphere );
  test.identical( gotRadius, expected );

  test.case = 'negative radius'; /* */

  var sphere = [ 1, 2, - 3 ];
  var expected = -3;

  var gotRadius = _.sphere.radiusGet( sphere );
  test.identical( gotRadius, expected );


  test.case = 'NaN radius'; /* */

  var sphere = [ 1, 2, NaN ];
  var expected = NaN;

  var gotRadius = _.sphere.radiusGet( sphere );
  test.identical( gotRadius, expected );

  test.case = 'NaN sphere'; /* */

  var sphere = [ NaN, NaN, NaN ];
  var expected = NaN;

  var gotRadius = _.sphere.radiusGet( sphere );
  test.identical( gotRadius, expected );

  test.case = 'radiusGet+Set two dimensions'; /* */

  var sphere = [ 0, 1, 1 ];
  var radiusOld = 1;
  var radiusSph = _.sphere.radiusGet( sphere );
  test.equivalent( radiusSph, radiusOld );

  var radius = 2;
  var expected = [ 0, 1, 2 ];
  expected = _.vector.from(expected);
  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.identical( gotSphere, expected );

  var radiusSph = _.sphere.radiusGet( sphere );
  test.equivalent( radius, radiusSph );

  test.case = 'radiusGet+Set three dimensions'; /* */

  var sphere = [ 0, 0, 1, 1 ];
  var radiusOld = 1;
  var radiusSph = _.sphere.radiusGet( sphere );
  test.equivalent( radiusOld, radiusSph );

  var radius = 2;
  var expected = [ 0, 0, 1, 2 ];
  expected = _.vector.from(expected);
  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.equivalent( gotSphere, expected );

  var radiusSph = _.sphere.radiusGet( gotSphere );
  test.equivalent( radius, radiusSph );

  test.case = 'NaN sphere'; /* */

  var sphere = [ NaN, NaN, NaN ];
  var expected = NaN;

  var gotSphere = _.sphere.radiusGet( sphere );
  test.equivalent( gotSphere, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.radiusGet();
  });

  test.case = 'Too many arguments'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.radiusGet( [ 0, 0, 1, 1 ], [ 0, 0, 0, 0 ] );
  });

  test.case = 'Wrong type of arguments'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.radiusGet( null );
  });

  test.case = 'Wrong type of arguments'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.radiusGet( 'string' );
  });

  test.case = 'Wrong type of arguments'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.radiusGet( 4 );
  });

  test.case = 'Wrong sphere dimension'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.radiusGet( [ ] );
  });

}

//

function radiusSet( test )
{

  test.case = 'Source radius remains unchanged'; /* */

  var sphere = [ 0, 0, 1, 1 ];
  var srcRadius = 2;
  var expected =  [ 0, 0, 1, 2 ] ;
  expected = _.vector.from(expected);

  var gotSphere = _.sphere.radiusSet( sphere, srcRadius );
  test.identical( gotSphere, expected );

  var oldSrcRadius = 2;
  test.equivalent( srcRadius, oldSrcRadius );

  test.case = 'Zero dimension sphere'; /* */

  var sphere = [ 0 ];
  var radius = 1;
  var expected = [ 1 ];
  expected = _.vector.from(expected);

  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.identical( gotSphere, expected );

  test.case = 'One dimension sphere'; /* */

  var sphere = [ 0, 0 ];
  var radius = 2;
  var expected = [ 0, 2 ] ;
  expected = _.vector.from(expected);

  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.identical( gotSphere, expected );

  test.case = 'Two dimension sphere'; /* */

  var sphere = [ 0, 0, 2 ];
  var radius = 3;
  var expected = [ 0, 0, 3 ];
  expected = _.vector.from(expected);

  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.identical( gotSphere, expected );

  test.case = 'Three dimension sphere'; /* */

  var sphere = [ 0, - 1, - 2, 2 ];
  var radius = 4;
  var expected = [ 0, - 1, - 2, 4 ];
  expected = _.vector.from(expected);

  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.identical( gotSphere, expected );

  test.case = 'Four dimension sphere'; /* */

  var sphere = [ 0, - 1, - 2, 2, 0 ];
  var radius = 5;
  var expected =  [ 0, - 1, - 2, 2, 5 ];
  expected = _.vector.from(expected);

  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.identical( gotSphere, expected );

  test.case = 'Eight dimension sphere'; /* */

  var sphere = [  0, - 1, - 2, 2, 0, 1, 2, 6, 1 ];
  var radius = 2;
  var expected = [  0, - 1, - 2, 2, 0, 1, 2, 6, 2 ];
  expected = _.vector.from(expected);

  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.identical( gotSphere, expected );

  test.case = 'normalized sphere'; /* */

  var sphere = [ 0.624, 0.376, 0.52 ];
  var radius = 0.777;
  var expected = [ 0.624, 0.376, 0.777 ];
  expected = _.vector.from(expected);

  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.identical( gotSphere, expected );

  test.case = 'negative radius'; /* */

  var sphere = [ 1, 2, - 3 ];
  var radius = - 2;
  var expected = [ 1, 2, - 2 ];
  expected = _.vector.from(expected);

  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.identical( gotSphere, expected );

  test.case = 'NaN radius'; /* */

  var sphere = [ 1, 2, 3 ];
  var radius = NaN;
  var expected = [ 1, 2, NaN ];
  expected = _.vector.from(expected);

  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.identical( gotSphere, expected );

  test.case = 'NaN sphere'; /* */

  var sphere = [ NaN, NaN, NaN ];
  var radius = 2;
  var expected = [ NaN, NaN, 2 ];
  expected = _.vector.from(expected);

  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.identical( gotSphere, expected );

  test.case = 'radiusSet+Get two dimensions'; /* */

  var sphere = [ 0, 2, 3 ];
  var radiusOld = 3;
  var radiusSph = _.sphere.radiusGet( sphere );
  test.equivalent( radiusOld, radiusSph );

  var radius = 2;
  var expected = [ 0, 2, 2 ];
  expected = _.vector.from(expected);

  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.identical( gotSphere, expected );

  var radiusSph = _.sphere.radiusGet( sphere );
  test.equivalent( radius, radiusSph );

  test.case = 'radiusSet+Get three dimensions'; /* */

  var sphere = [ 0, 1, 1, 3 ];
  var radiusOld = 3;
  var radiusSph = _.sphere.radiusGet( sphere );
  test.equivalent( radiusOld, radiusSph );

  var radius = 2;
  var expected = [ 0, 1, 1, 2 ];
  expected = _.vector.from(expected);

  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.identical( gotSphere, expected );

  var radiusSph = _.sphere.radiusGet( sphere );
  test.equivalent( radius, radiusSph );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.radiusSet();
  });

  test.case = 'Too many arguments'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.radiusSet( [ 0, 0, 1, 1 ], 2, 3 );
  });

  test.case = 'Wrong type of arguments'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.radiusSet( [ 0, 0, 1, 1 ], [ 0, 0, 0, 0 ] );
  });

  test.case = 'Wrong type of arguments'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.radiusSet( null, null );
  });

  test.case = 'Wrong type of arguments'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.radiusSet( 'string', 'Hi' );
  });

  test.case = 'Wrong type of arguments'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.radiusSet( 4, 3 );
  });

  test.case = 'Wrong sphere dimension'; /* */
  test.shouldThrowError( function()
  {
    _.sphere.radiusSet( [ ], 2 );
  });

}

//

function pointContains( test )
{
  test.case = 'Sphere and point remain unchanged';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 0, 0, 2 ];
  var gotContains = _.sphere.pointContains( sphere, point );

  var expected = false;
  test.identical( gotContains, expected );

  var oldSphere = [ 0, 0, 0, 1 ];
  test.identical( sphere, oldSphere );

  var oldPoint = [ 0, 0, 2 ];
  test.identical( point, oldPoint );

  test.case = 'Not contained in 1D';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 3, 0, 0 ];

  var expected = false;
  var gotContains = _.sphere.pointContains( sphere, point );

  test.identical( gotContains, expected );

  test.case = 'Not contained in 2D';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 3, 4, 0 ];

  var expected = false;
  var gotContains = _.sphere.pointContains( sphere, point );

  test.identical( gotContains, expected );

  test.case = 'Not contained in 3D';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 3, 3, 3 ];

  var expected = false;
  var gotContains = _.sphere.pointContains( sphere, point );

  test.equivalent( gotContains, expected );

  test.case = 'Point below the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ - 3, - 3, - 3 ];

  var expected = false;
  var gotContains = _.sphere.pointContains( sphere, point );

  test.equivalent( gotContains, expected );

  test.case = 'Point touching the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 1, 0, 0 ];

  var expected = true;
  var gotContains = _.sphere.pointContains( sphere, point );

  test.identical( gotContains, expected );

  test.case = 'Point inside the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 0, 0, 0.5 ];
  var expected = true;

  var gotContains = _.sphere.pointContains( sphere, point );

  test.identical( gotContains, expected );

  test.case = 'Point in the middle of the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 0, 0, 0 ];
  var expected = true;

  var gotContains = _.sphere.pointContains( sphere, point );

  test.identical( gotContains, expected );

  test.case = 'Center of the sphere not in the origin - point inside';

  var sphere = [ 1, 1, 2, 1 ];
  var point = [ 1, 1, 1.5 ];
  var expected = true;

  var gotContains = _.sphere.pointContains( sphere, point );

  test.identical( gotContains, expected );

  test.case = 'Center of the sphere not in the origin - point outside';

  var sphere = [ 1, 1, 2, 1 ];
  var point = [ 1, 1, 4.3 ];
  var expected = false;

  var gotContains = _.sphere.pointContains( sphere, point );

  test.equivalent( gotContains, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.pointContains( ) );
  test.shouldThrowErrorSync( () => _.sphere.pointContains( [ 0, 0, 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointContains( [ 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointContains( [ 0, 0, 0, 1 ], [ 1, 2, 3 ], [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointContains( [ 1, 2, 3, 4 ], [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointContains( [ 1, 2, 3, 4, 5 ], [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointContains( null, [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointContains( [ 0, 0, 0, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.pointContains( NaN, [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointContains( [ 0, 0, 0, 1 ], NaN ) );
}

//

function pointDistance( test )
{
  test.case = 'Sphere and point remain unchanged';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 0, 0, 2 ];
  var oldSphere = [ 0, 0, 0, 1 ];
  var oldPoint = [ 0, 0, 2 ];
  var expected = 1;
  var gotDistance = _.sphere.pointDistance( sphere, point );

  test.identical( gotDistance, expected );
  test.identical( sphere, oldSphere );
  test.identical( point, oldPoint );

  test.case = 'Distance in 1D';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 3, 0, 0 ];
  var expected = 2;

  var gotDistance = _.sphere.pointDistance( sphere, point );

  test.identical( gotDistance, expected );

  test.case = 'Distance in 2D';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 3, 4, 0 ];
  var expected = 4;

  var gotDistance = _.sphere.pointDistance( sphere, point );

  test.identical( gotDistance, expected );

  test.case = 'Distance in 3D';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 3, 3, 3 ];
  var expected = 4.196152422706632;

  var gotDistance = _.sphere.pointDistance( sphere, point );

  test.equivalent( gotDistance, expected );

  test.case = 'Point below the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ - 3, - 3, - 3 ];
  var expected = 4.196152422706632;

  var gotDistance = _.sphere.pointDistance( sphere, point );

  test.equivalent( gotDistance, expected );

  test.case = 'Point touching the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 1, 0, 0 ];
  var expected = 0;

  var gotDistance = _.sphere.pointDistance( sphere, point );

  test.identical( gotDistance, expected );

  test.case = 'Point inside the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 0, 0, 0.5 ];
  var expected = 0;

  var gotDistance = _.sphere.pointDistance( sphere, point );

  test.identical( gotDistance, expected );

  test.case = 'Point in the middle of the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotDistance = _.sphere.pointDistance( sphere, point );

  test.identical( gotDistance, expected );

  test.case = 'Center of the sphere not in the origin - point inside';

  var sphere = [ 1, 1, 2, 1 ];
  var point = [ 1, 1, 1.5 ];
  var expected = 0;

  var gotDistance = _.sphere.pointDistance( sphere, point );

  test.identical( gotDistance, expected );

  test.case = 'Center of the sphere not in the origin - point outside';

  var sphere = [ 1, 1, 2, 1 ];
  var point = [ 1, 1, 4.3 ];
  var expected = 1.3;

  var gotDistance = _.sphere.pointDistance( sphere, point );

  test.equivalent( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.pointDistance( ) );
  test.shouldThrowErrorSync( () => _.sphere.pointDistance( [ 0, 0, 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointDistance( [ 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointDistance( [ 0, 0, 0, 1 ], [ 1, 2, 3 ], [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointDistance( [ 1, 2, 3, 4 ], [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointDistance( [ 1, 2, 3, 4, 5 ], [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointDistance( null, [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointDistance( [ 0, 0, 0, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.pointDistance( NaN, [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointDistance( [ 0, 0, 0, 1 ], NaN ) );
}

//

function pointClosestPoint( test )
{
  test.case = 'Sphere and point remain unchanged';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 0, 0, 2 ];
  var oldSphere = [ 0, 0, 0, 1 ];
  var oldPoint = [ 0, 0, 2 ];
  var expected = [ 0, 0, 1 ];
  var gotClosestPoint = _.sphere.pointClosestPoint( sphere, point );

  test.identical( gotClosestPoint, expected );
  test.identical( sphere, oldSphere );
  test.identical( point, oldPoint );

  test.case = 'ClosestPoint in 1D';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 3, 0, 0 ];
  var expected = [ 1, 0, 0 ];

  var gotClosestPoint = _.sphere.pointClosestPoint( sphere, point );

  test.identical( gotClosestPoint, expected );

  test.case = 'ClosestPoint in 2D';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 3, 4, 0 ];
  var expected = [ 0.6, 0.8, 0 ];

  var gotClosestPoint = _.sphere.pointClosestPoint( sphere, point );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'ClosestPoint in 3D';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 2, 4, 6 ];
  var expected = [ 0.2672612419124244, 0.5345224838248488, 0.8017837257372732 ];

  var gotClosestPoint = _.sphere.pointClosestPoint( sphere, point );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'Point below the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ - 3, - 3, - 3 ];
  var expected = [ -0.5773502691896257, -0.5773502691896257, -0.5773502691896257 ];

  var gotClosestPoint = _.sphere.pointClosestPoint( sphere, point );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'Point touching the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 1, 0, 0 ];
  var expected = 0;

  var gotClosestPoint = _.sphere.pointClosestPoint( sphere, point );

  test.identical( gotClosestPoint, expected );

  test.case = 'Point inside the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 0, 0, 0.5 ];
  var expected = 0;

  var gotClosestPoint = _.sphere.pointClosestPoint( sphere, point );

  test.identical( gotClosestPoint, expected );

  test.case = 'Point in the middle of the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotClosestPoint = _.sphere.pointClosestPoint( sphere, point );

  test.identical( gotClosestPoint, expected );

  test.case = 'Center of the sphere not in the origin - point inside';

  var sphere = [ 1, 1, 2, 1 ];
  var point = [ 1, 1, 1.5 ];
  var expected = 0;

  var gotClosestPoint = _.sphere.pointClosestPoint( sphere, point );

  test.identical( gotClosestPoint, expected );

  test.case = 'Center of the sphere not in the origin - point outside';

  var sphere = [ 1, 1, 2, 1 ];
  var point = [ 1, 1, 4.3 ];
  var expected = [ 1, 1, 3 ];

  var gotClosestPoint = _.sphere.pointClosestPoint( sphere, point );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'dstPoint is array';

  var sphere = [ 1, 1, 2, 1 ];
  var point = [ 1, 1, 4.3 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = [ 1, 1, 3 ];

  var gotClosestPoint = _.sphere.pointClosestPoint( sphere, point, dstPoint );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'dstPoint is vector';

  var sphere = [ 1, 1, 2, 1 ];
  var point = [ 1, 1, 4.3 ];
  var dstPoint = _.vector.fromArray( [ 0, 0, 0 ] );
  var expected = _.vector.fromArray( [ 1, 1, 3 ] );

  var gotClosestPoint = _.sphere.pointClosestPoint( sphere, point, dstPoint );

  test.equivalent( gotClosestPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.pointClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.sphere.pointClosestPoint( [ 0, 0, 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointClosestPoint( [ 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointClosestPoint( [ 1, 2, 3, 4 ], [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointClosestPoint( [ 1, 2, 3, 4, 5 ], [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointClosestPoint( null, [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointClosestPoint( [ 0, 0, 0, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.pointClosestPoint( NaN, [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointClosestPoint( [ 0, 0, 0, 1 ], NaN ) );
}

//

function pointExpand( test )
{
  debugger;

  test.case = 'expand zero by zero';

  var sphere = [ 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0 ];
  var got = _.sphere.pointExpand( sphere, point );

  test.equivalent( got, expected );
  test.is( got === sphere );

  test.case = 'expand zero by non zero';

  var sphere = [ 0, 0, 0, 0 ];
  //var center = _.sphere.centerGet( sphere );
  var point = [ 1, 1, 1 ];
  var expected = [ 0, 0, 0, _.sqrt( 3 ) ];
  var got = _.sphere.pointExpand( sphere, point );
  //var d1 = _.avector.distance( point, center );
  debugger;
  //var d2 = _.avector.distance( _.dup( 0,3 ), center );

  test.equivalent( got,expected );
  // test.equivalent( d1, d2 );
  // test.equivalent( d1,_.sphere.radiusGet( sphere ) );
  test.is( got === sphere );

  test.case = 'expand non zero by non zero';

  var sphere = [ 1, 1, 1, 1 ];
  var center = _.sphere.centerGet( sphere );
  var point = [ -1, -1, -1 ];
  var expected = [ 1, 1, 1, 3.4641016151377544 ];
  var got = _.sphere.pointExpand( sphere, point );
  // var d1 = _.avector.distance( point, center );
  // var d2 = _.avector.distance( _.dup( 1+_.sqrt( 3 ) / 3, 3 ),center );

  test.equivalent( got,expected );
  // test.equivalent( d1,d2 );
  // test.equivalent( d1,_.sphere.radiusGet( sphere ) );
  test.is( got === sphere );

  test.case = 'expand nil sphere by point';

  var sphere = [ 1, 1, 1, -Infinity ];
  var center = _.sphere.centerGet( sphere );
  var point = [ -1, -1, -1 ];
  var expected = [ -1, -1, -1, 0 ];
  var got = _.sphere.pointExpand( sphere,point );

  test.equivalent( got,expected );
  test.is( got === sphere );

  test.case = 'Point in sphere - no expansion';

  var sphere = [ 1, 1, 1, 3 ];
  var point = [ 0, 0, 0 ];
  var expected = [ 1, 1, 1, 3 ];
  var got = _.sphere.pointExpand( sphere,point );

  test.equivalent( got,expected );
  test.is( got === sphere );

  test.case = 'Point out of sphere - expansion';

  var sphere = [ 1, 1, 1, 3 ];
  var point = [ 1, 5, 1 ];
  var expected = [ 1, 1, 1, 4 ];
  var got = _.sphere.pointExpand( sphere,point );

  test.equivalent( got,expected );
  test.is( got === sphere );


}

//

function boxContains( test )
{
  test.case = 'Sphere and box remain unchanged'; /* */

  var sphere = [ 0, 0, 0, 1 ];
  var oldSphere = [ 0, 0, 0, 1 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var oldBox = [ 0, 0, 0, 1, 1, 1 ];
  var expected = false;
  var gotBool = _.sphere.boxContains( sphere, box );

  test.identical( gotBool, expected );
  test.identical( sphere, oldSphere );
  test.identical( box, oldBox );

  test.case = 'Empty sphere contains empty box'; /* */

  var sphere = [ 0, 0, 0, 0 ];
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = true;
  var gotBool = _.sphere.boxContains( sphere, box );

  test.equivalent( gotBool, expected );

  test.case = 'Sphere contains box'; /* */

  var sphere = [ 0, 0, 0, 2 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;
  var gotBool = _.sphere.boxContains( sphere, box );

  test.equivalent( gotBool, expected );

  test.case = 'Sphere inside box'; /* */

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ - 2, - 2, - 2, 2, 2, 2 ];
  var expected = false;
  var gotBool = _.sphere.boxContains( sphere, box );

  test.equivalent( gotBool, expected );

  test.case = 'Box inside sphere'; /* */

  var sphere = [ 0, 0, 0, 6 ];
  var box = [ - 2, - 2, - 2, 2, 2, 2 ];
  var expected = true;
  var gotBool = _.sphere.boxContains( sphere, box );

  test.equivalent( gotBool, expected );

  test.case = 'Just touching'; /* */

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 1, 0, 0, 2, 1, 1 ];
  var expected = false;
  var gotBool = _.sphere.boxContains( sphere, box );

  test.equivalent( gotBool, expected );

  test.case = 'Not intersecting'; /* */

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 2, 2, 2, 3, 3, 3 ];
  var expected = false;
  var gotBool = _.sphere.boxContains( sphere, box );

  test.equivalent( gotBool, expected );

  test.case = 'One corner of the box in sphere'; /* */

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expected = false;
  var gotBool = _.sphere.boxContains( sphere, box );

  test.equivalent( gotBool, expected );

  test.case = 'Sphere is nil';

  var sphere = _.sphere.makeNil();
  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expected = true;
  var gotBool = _.sphere.boxContains( sphere, box );

  test.equivalent( gotBool,expected );

  test.case = 'box is nil';

  var sphere = [ 0, 0, 0, 2 ];
  var box = _.box.makeNil();
  var expected = false;
  var gotBool = _.sphere.boxContains( sphere, box );

  test.equivalent( gotBool,expected );

  test.case = 'Negative distance no intersection';

  var sphere = [ 0, 0, 0, 2 ];
  var box = [ -4, -4, -4, -3, -3, -3 ];
  var expected = false;
  var gotBool = _.sphere.boxContains( sphere, box );

  test.equivalent( gotBool,expected );

  test.case = 'Negative distance - sphere contains box';

  var sphere = [ -3, -3, -3, 4 ];
  var box = [ -4, -4, -4, -1, -1, -1 ];
  var expected = true;
  var gotBool = _.sphere.boxContains( sphere, box );

  test.equivalent( gotBool,expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.boxContains( ) );
  test.shouldThrowErrorSync( () => _.sphere.boxContains( [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxContains( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4, 5, 6 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxContains( 'sphere', 'box' ) );
  test.shouldThrowErrorSync( () => _.sphere.boxContains( [ 1, 2, 3, 4 ], 'box' ) );
  test.shouldThrowErrorSync( () => _.sphere.boxContains( 'sphere', [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxContains( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxContains( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4, 5, 6, 7 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxContains( [ 1, 2, 3, 4 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.boxContains( null, [ 1, 2, 3, 4 ] ) );

}

//

function boxIntersects( test )
{
  test.case = 'Sphere and box remain unchanged'; /* */

  var sphere = [ 0, 0, 0, 1 ];
  var oldSphere = [ 0, 0, 0, 1 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var oldBox = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;
  var gotBool = _.sphere.boxIntersects( sphere, box );

  test.identical( gotBool, expected );
  test.identical( sphere, oldSphere );
  test.identical( box, oldBox );

  test.case = 'Intersection of empty sphere and box'; /* */

  var sphere = [ 0, 0, 0, 0 ];
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = true;
  var gotBool = _.sphere.boxIntersects( sphere, box );

  test.equivalent( gotBool, expected );

  test.case = 'Trivial intersection'; /* */

  var sphere = [ - 1, 2, 0, 2 ];
  var box = [ - 2, 0, 0, 0, 2, 1 ];
  var expected = true;
  var gotBool = _.sphere.boxIntersects( sphere, box );

  test.equivalent( gotBool, expected );

  test.case = 'Sphere inside box'; /* */

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ - 2, - 2, - 2, 2, 2, 2 ];
  var expected = true;
  var gotBool = _.sphere.boxIntersects( sphere, box );

  test.equivalent( gotBool, expected );

  test.case = 'Box inside sphere'; /* */

  var sphere = [ 0, 0, 0, 6 ];
  var box = [ - 2, - 2, - 2, 2, 2, 2 ];
  var expected = true;
  var gotBool = _.sphere.boxIntersects( sphere, box );

  test.equivalent( gotBool, expected );

  test.case = 'Just touching'; /* */

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 1, 0, 0, 2, 1, 1 ];
  var expected = true;
  var gotBool = _.sphere.boxIntersects( sphere, box );

  test.equivalent( gotBool, expected );

  test.case = 'Not intersecting'; /* */

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 2, 2, 2, 3, 3, 3 ];
  var expected = false;
  var gotBool = _.sphere.boxIntersects( sphere, box );

  test.equivalent( gotBool, expected );

  test.case = 'One corner of the box in sphere'; /* */

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expected = true;
  var gotBool = _.sphere.boxIntersects( sphere, box );

  test.equivalent( gotBool, expected );

  test.case = 'Sphere is nil';

  var sphere = _.sphere.makeNil();
  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expected = true;
  var gotBool = _.sphere.boxIntersects( sphere, box );

  test.equivalent( gotBool,expected );

  test.case = 'box is nil';

  var sphere = [ 0, 0, 0, 2 ];
  var box = _.box.makeNil();
  var expected = false;
  var gotBool = _.sphere.boxIntersects( sphere, box );

  test.equivalent( gotBool,expected );

  test.case = 'Negative distance no intersection';

  var sphere = [ 0, 0, 0, 2 ];
  var box = [ -4, -4, -4, -3, -3, -3 ];
  var expected = false;
  var gotBool = _.sphere.boxIntersects( sphere, box );

  test.equivalent( gotBool,expected );

  test.case = 'Negative distance - intersection';

  var sphere = [ 0, 0, 0, 2 ];
  var box = [ -4, -4, -4, -1, -1, -1 ];
  var expected = true;
  var gotBool = _.sphere.boxIntersects( sphere, box );

  test.equivalent( gotBool,expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.boxIntersects( ) );
  test.shouldThrowErrorSync( () => _.sphere.boxIntersects( [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxIntersects( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4, 5, 6 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxIntersects( 'sphere', 'box' ) );
  test.shouldThrowErrorSync( () => _.sphere.boxIntersects( [ 1, 2, 3, 4 ], 'box' ) );
  test.shouldThrowErrorSync( () => _.sphere.boxIntersects( 'sphere', [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxIntersects( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxIntersects( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4, 5, 6, 7 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxIntersects( [ 1, 2, 3, 4 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.boxIntersects( null, [ 1, 2, 3, 4 ] ) );

}

//

function boxClosestPoint( test )
{
  test.case = 'Sphere and point remain unchanged';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 0, 0, 2, 1, 1, 3 ];
  var expected = [ 0, 0, 1 ];
  var gotClosestPoint = _.sphere.boxClosestPoint( sphere, box );

  test.identical( gotClosestPoint, expected );
  var oldSphere = [ 0, 0, 0, 1 ];
  test.identical( sphere, oldSphere );
  var oldBox = [ 0, 0, 2, 1, 1, 3 ];
  test.identical( box, oldBox );

  test.case = 'ClosestPoint in 1D';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 3, 0, 0, 5, 2, 2 ];
  var expected = [ 1, 0, 0 ];

  var gotClosestPoint = _.sphere.boxClosestPoint( sphere, box );

  test.identical( gotClosestPoint, expected );

  test.case = 'ClosestPoint in 2D';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 3, 4, 0, 7, 8, 9 ];
  var expected = [ 0.6, 0.8, 0 ];

  var gotClosestPoint = _.sphere.boxClosestPoint( sphere, box );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'ClosestPoint in 3D';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 2, 4, 6, 3, 7, 7 ];
  var expected = [ 0.2672612419124244, 0.5345224838248488, 0.8017837257372732 ];

  var gotClosestPoint = _.sphere.boxClosestPoint( sphere, box );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'Box below the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ -5, -6, -4, - 3, - 3, - 3 ];
  var expected = [ -0.5773502691896257, -0.5773502691896257, -0.5773502691896257 ];

  var gotClosestPoint = _.sphere.boxClosestPoint( sphere, box );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'Box corner touching the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 1, 0, 0, 2, 0, 2 ];
  var expected = 0;

  var gotClosestPoint = _.sphere.boxClosestPoint( sphere, box );

  test.identical( gotClosestPoint, expected );

  test.case = 'Box and sphere intersect';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 0, 0, 0.5, 1, 1, 1 ];
  var expected = 0;

  var gotClosestPoint = _.sphere.boxClosestPoint( sphere, box );

  test.identical( gotClosestPoint, expected );

  test.case = 'Box inside the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 0, 0, 0, 0.5, 0.5, 0.5 ];
  var expected = 0;

  var gotClosestPoint = _.sphere.boxClosestPoint( sphere, box );

  test.identical( gotClosestPoint, expected );

  test.case = 'Sphere inside box';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ -1, -1, -1, 1, 1, 1 ];
  var expected = 0;

  var gotClosestPoint = _.sphere.boxClosestPoint( sphere, box );

  test.identical( gotClosestPoint, expected );

  test.case = 'dstPoint is array';

  var sphere = [ 1, 1, 2, 1 ];
  var box = [ 1, 1, 4.3, 2, 2, 5 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = [ 1, 1, 3 ];

  var gotClosestPoint = _.sphere.boxClosestPoint( sphere, box, dstPoint );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'dstPoint is vector';

  var sphere = [ 1, 1, 2, 1 ];
  var box = [ 1, 1, 4.3, 2, 2, 5 ];
  var dstPoint = _.vector.fromArray( [ 0, 0, 0 ] );
  var expected = _.vector.fromArray( [ 1, 1, 3 ] );

  var gotClosestPoint = _.sphere.boxClosestPoint( sphere, box, dstPoint );

  test.equivalent( gotClosestPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.boxClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.sphere.boxClosestPoint( [ 0, 0, 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxClosestPoint( [ 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxClosestPoint( [ 1, 2, 3, 4 ], [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxClosestPoint( [ 1, 2, 3, 4, 5 ], [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxClosestPoint( null, [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxClosestPoint( [ 0, 0, 0, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.boxClosestPoint( NaN, [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxClosestPoint( [ 0, 0, 0, 1 ], NaN ) );
}

//

function boxExpand( test )
{
  test.case = 'Sphere changes and box remains unchanged'; /* */

  var sphere = [ 0, 0, 0, 1 ];
  var oldSphere = [ 0, 0, 0, 1 ];
  var box = [ 0, 0, 0, 4, 3, 0 ];
  var oldBox = [ 0, 0, 0, 4, 3, 0 ];
  var expected = [ 0, 0, 0, 5 ];;
  var gotSphere = _.sphere.boxExpand( sphere, box );

  test.is( gotSphere === sphere );
  test.identical( gotSphere, expected );
  test.identical( box, oldBox );

  test.case = 'Expansion of empty sphere'; /* */

  var sphere = [ 0, 0, 0, 0 ];
  var box = [ 0, 0, 0, 0, 0, 1 ];
  var expected = [ 0, 0, 0, 1 ];
  var gotSphere = _.sphere.boxExpand( sphere, box );

  test.is( gotSphere === sphere );
  test.identical( gotSphere, expected );

  test.case = 'Trivial expansion'; /* */

  var sphere = [ - 1, 0, 0, 2 ];
  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expected = [ - 1, 0, 0, 4.1231056256 ];
  var gotSphere = _.sphere.boxExpand( sphere, box );

  test.is( gotSphere === sphere );
  test.equivalent( gotSphere, expected );

  test.case = 'Expansion - box is point'; /* */

  var sphere = [ - 1, 0, 0, 2 ];
  var box = [ 3, 0, 0, 3, 0, 0 ];
  var expected = [ - 1, 0, 0, 4 ];
  var gotSphere = _.sphere.boxExpand( sphere, box );

  test.is( gotSphere === sphere );
  test.identical( gotSphere, expected );

  test.case = 'Sphere inside box'; /* */

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ - 2, - 2, - 2, 2, 2, 2 ];
  var expected = [ 0, 0, 0, 3.46410161513 ];
  var gotSphere = _.sphere.boxExpand( sphere, box );

  test.is( gotSphere === sphere );
  test.equivalent( gotSphere, expected );

  test.case = 'Box inside sphere - no expansion'; /* */

  var sphere = [ 0, 0, 0, 6 ];
  var box = [ - 2, - 2, - 2, 2, 2, 2 ];
  var expected = [ 0, 0, 0, 6 ];
  var gotSphere = _.sphere.boxExpand( sphere, box );

  test.is( gotSphere === sphere );
  test.identical( gotSphere, expected );

  test.case = 'Zero Box - no expansion'; /* */

  var sphere = [ 0, 0, 0, 6 ];
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = [ 0, 0, 0, 6 ];
  var gotSphere = _.sphere.boxExpand( sphere, box );

  test.is( gotSphere === sphere );
  test.identical( gotSphere, expected );

  test.case = 'Just touching - expansion'; /* */

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 1, 0, 0, 2, 1, 1 ];
  var expected = [ 0, 0, 0, 2.449489742 ];
  var gotSphere = _.sphere.boxExpand( sphere, box );

  test.is( gotSphere === sphere );
  test.equivalent( gotSphere, expected );

  test.case = 'Just touching - no expansion'; /* */

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 0, 0, 0, 0, 0, 1 ];
  var expected = [ 0, 0, 0, 1 ];
  var gotSphere = _.sphere.boxExpand( sphere, box );

  test.is( gotSphere === sphere );
  test.identical( gotSphere, expected );

  test.case = 'One corner of the box in sphere'; /* */

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 0, 0, 0, 2, - 2, 2 ];
  var expected = [ 0, 0, 0, 3.4641016151 ];
  var gotSphere = _.sphere.boxExpand( sphere, box );

  test.is( gotSphere === sphere );
  test.equivalent( gotSphere, expected );

  test.case = 'Sphere is nil';

  var sphere = _.sphere.makeNil();
  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expected =  [ 0, 0, 0, 3.4641016151 ];
  var gotSphere = _.sphere.boxExpand( sphere, box );

  test.is( gotSphere === sphere );
  test.equivalent( gotSphere,expected );

  test.case = 'box is nil';

  var sphere = [ 0, 0, 0, 2 ];
  var box = _.box.makeNil();
  var expected = [ 0, 0, 0, Infinity ];
  var gotSphere = _.sphere.boxExpand( sphere, box );

  test.is( gotSphere === sphere );
  test.identical( gotSphere,expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.boxExpand( ) );
  test.shouldThrowErrorSync( () => _.sphere.boxExpand( [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxExpand( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4, 5, 6 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxExpand( 'sphere', 'box' ) );
  test.shouldThrowErrorSync( () => _.sphere.boxExpand( [ 1, 2, 3, 4 ], 'box' ) );
  test.shouldThrowErrorSync( () => _.sphere.boxExpand( 'sphere', [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxExpand( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxExpand( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4, 5, 6, 7 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxExpand( [ 1, 2, 3, 4 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.boxExpand( null, [ 1, 2, 3, 4 ] ) );

}

//

function sphereContains( test )
{
  test.case = 'Source and test spheres remain unchanged'; /* */

  var srcSphere = [ 0, 0, 0, 0 ];
  var tstSphere = [ 0, 0, 0, 0 ];
  var expected = true;
  var gotBool = _.sphere.sphereContains( srcSphere, tstSphere );
  test.identical( gotBool, expected );

  var oldSrcSphere = [ 0, 0, 0, 0 ];
  test.identical( srcSphere, oldSrcSphere );

  var oldTstSphere = [ 0, 0, 0, 0 ];
  test.identical( tstSphere, oldTstSphere );

  test.case = 'Empty sphere contains empty sphere'; /* */

  var srcSphere = [ 0, 0, 0, 0 ];
  var tstSphere = [ 0, 0, 0, 0 ];
  var expected = true;
  var gotBool = _.sphere.sphereContains( srcSphere, tstSphere );

  test.identical( gotBool, expected );

  test.case = 'Same spheres'; /* */

  var srcSphere = [ 0, 1, 0, 2 ];
  var tstSphere = [ 0, 1, 0, 2 ];
  var expected = true;
  var gotBool = _.sphere.sphereContains( srcSphere, tstSphere );

  test.identical( gotBool, expected );

  test.case = 'Trivial intersection - not contained'; /* */

  var srcSphere = [ - 1, 2, 0, 2 ];
  var tstSphere = [ 1, 3, 0, 2 ];
  var expected = false;
  var gotBool = _.sphere.sphereContains( srcSphere, tstSphere );

  test.identical( gotBool, expected );

  test.case = 'Different radius - src > tst'; /* */

  var srcSphere = [ 1, 0, 0, 3 ];
  var tstSphere = [ 1, 0, 0, 2 ];
  var expected = true;
  var gotBool = _.sphere.sphereContains( srcSphere, tstSphere );

  test.identical( gotBool, expected );

  test.case = 'Different radius - tst > src'; /* */

  var srcSphere = [ 1, 0, 0, 2 ];
  var tstSphere = [ 1, 0, 0, 3 ];
  var expected = false;
  var gotBool = _.sphere.sphereContains( srcSphere, tstSphere );

  test.identical( gotBool, expected );

  test.case = 'Just touching'; /* */

  var srcSphere = [ - 1, 0, 0, 1 ];
  var tstSphere = [ 1, 0, 0, 1 ];
  var expected = false;
  var gotBool = _.sphere.sphereContains( srcSphere, tstSphere );

  test.identical( gotBool, expected );

  test.case = 'Not intersecting'; /* */

  var srcSphere = [ - 1.5, 0, 0, 1 ];
  var tstSphere = [ 1.5, 0, 0, 1 ];
  var expected = false;
  var gotBool = _.sphere.sphereContains( srcSphere, tstSphere );

  test.identical( gotBool, expected );

  test.case = 'One inside another different centers'; /* */

  var srcSphere = [ 0, 0, 0, 3 ];
  var tstSphere = [ 1, 1, 1, 1 ];
  var expected = true;
  var gotBool = _.sphere.sphereContains( srcSphere, tstSphere );

  test.identical( gotBool, expected );

  test.case = 'src is nil';

  var srcSphere = _.sphere.makeNil();
  var tstSphere = [ 0,0,0,2 ];
  var expected = false;
  var gotBool = _.sphere.sphereContains( srcSphere, tstSphere );

  test.identical( gotBool, expected );

  test.case = 'tst is nil';

  var srcSphere = [ 0,0,0,2 ];
  var tstSphere = _.sphere.makeNil();
  var expected = true;
  var gotBool = _.sphere.sphereContains( srcSphere, tstSphere );

  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.sphereContains( ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereContains( 'sphereOne', 'sphereTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereContains( [ 1,2,3,4 ], 'sphereTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereContains( 'sphereOne', [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereContains( [ 1,2,3,4 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereContains( null, [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereContains( [ 1,2,3,4 ], NaN ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereContains( NaN, [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereContains( [ 1,2,3,4 ] , [ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereContains( [ 1,2,3 ] , [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereContains( [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereContains( [ 1,2,3,4 ] , [ 1,2,3,4 ] , [ 1,2,3,4 ] ) );

}

//

function sphereIntersects( test )
{

  test.case = 'Intersection of empty spheres'; /* */

  var sphere = [ 0,0,0,0 ];
  var sphere2 = [ 0,0,0,0 ];
  var expected = true;
  var gotBool = _.sphere.sphereIntersects( sphere, sphere2 );

  test.identical( gotBool, expected );

  test.case = 'Trivial intersection'; /* */

  var sphere = [ - 1, 2, 0, 2 ];
  var sphere2 = [ 1, 3, 0, 2 ];
  var expected = true;
  var gotBool = _.sphere.sphereIntersects( sphere, sphere2 );

  test.identical( gotBool, expected );

  test.case = 'Different radius'; /* */

  var sphere = [ - 1, 0, 0, 3 ];
  var sphere2 = [ 1, 0, 0, 2 ];
  var expected = true;
  var gotBool = _.sphere.sphereIntersects( sphere, sphere2 );

  test.identical( gotBool, expected );

  test.case = 'Just touching'; /* */

  var sphere = [ - 1, 0, 0, 1 ];
  var sphere2 = [ 1, 0, 0, 1 ];
  var expected = true;
  var gotBool = _.sphere.sphereIntersects( sphere, sphere2 );

  test.identical( gotBool, expected );

  test.case = 'Not intersecting'; /* */

  var sphere = [ - 1.5, 0, 0, 1 ];
  var sphere2 = [ 1.5, 0, 0, 1 ];
  var expected = false;
  var gotBool = _.sphere.sphereIntersects( sphere, sphere2 );

  test.identical( gotBool, expected );

  test.case = 'One inside another'; /* */

  var sphere = [ 0, 0, 0, 3 ];
  var sphere2 = [ 0, 0, 0, 1 ];
  var expected = true;
  var gotBool = _.sphere.sphereIntersects( sphere, sphere2 );

  test.identical( gotBool, expected );

  test.case = 'One inside another different centers'; /* */

  var sphere = [ 0, 0, 0, 3 ];
  var sphere2 = [ 1, 1, 1, 3 ];
  var expected = true;
  var gotBool = _.sphere.sphereIntersects( sphere, sphere2 );

  test.identical( gotBool, expected );

  test.case = 'dst is nil';

  var sphere = _.sphere.makeNil();
  var sphere2 = [ 0,0,0,2 ];
  var expected = true;
  var gotBool = _.sphere.sphereIntersects( sphere, sphere2 );

  test.identical( gotBool,expected );

  test.case = 'src is nil';

  var sphere = _.sphere.makeNil();
  var sphere2 = [ 0,0,0,2 ];
  var expected = true;
  var gotBool = _.sphere.sphereIntersects( sphere, sphere2 );

  test.identical( gotBool,expected );

  test.case = 'dst and src are nil';

  var sphere = _.sphere.makeNil();
  var sphere2 = _.sphere.makeNil();
  var expected = true;
  var gotBool = _.sphere.sphereIntersects( sphere, sphere2 );

  test.identical( gotBool,expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.sphereIntersects( ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereIntersects( 'sphereOne', 'sphereTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereIntersects( [ 1,2,3,4 ], 'sphereTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereIntersects( 'sphereOne', [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereIntersects( [ 1,2,3,4 ] , [ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereIntersects( [ 1,2,3 ] , [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereIntersects( [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereIntersects( [ 1,2,3,4 ] , [ 1,2,3,4 ] , [ 1,2,3,4 ] ) );

}

//

function sphereDistance( test )
{
  test.case = 'Source and test spheres remain unchanged'; /* */

  var srcSphere = [ 0, 0, 0, 0 ];
  var tstSphere = [ 0, 0, 0, 0 ];
  var expected = 0;
  var gotDistance = _.sphere.sphereDistance( srcSphere, tstSphere );
  test.identical( gotDistance, expected );

  var oldSrcSphere = [ 0, 0, 0, 0 ];
  test.identical( srcSphere, oldSrcSphere );

  var oldTstSphere = [ 0, 0, 0, 0 ];
  test.identical( tstSphere, oldTstSphere );

  test.case = 'Empty spheres'; /* */

  var srcSphere = [ 0, 0, 0, 0 ];
  var tstSphere = [ 0, 0, 0, 0 ];
  var expected = 0;
  var gotDistance = _.sphere.sphereDistance( srcSphere, tstSphere );

  test.identical( gotDistance, expected );

  test.case = 'Same spheres'; /* */

  var srcSphere = [ 0, 1, 0, 2 ];
  var tstSphere = [ 0, 1, 0, 2 ];
  var expected = 0;
  var gotDistance = _.sphere.sphereDistance( srcSphere, tstSphere );

  test.identical( gotDistance, expected );

  test.case = 'Intersection'; /* */

  var srcSphere = [ - 1, 2, 0, 2 ];
  var tstSphere = [ 1, 3, 0, 2 ];
  var expected = 0;
  var gotDistance = _.sphere.sphereDistance( srcSphere, tstSphere );

  test.identical( gotDistance, expected );

  test.case = 'Different centers 1D'; /* */

  var srcSphere = [ 2, 0, 0, 1 ];
  var tstSphere = [ -2, 0, 0, 1 ];
  var expected = 2;
  var gotDistance = _.sphere.sphereDistance( srcSphere, tstSphere );

  test.identical( gotDistance, expected );

  test.case = 'Different centers 2D'; /* */

  var srcSphere = [ 2, 2, 0, 1 ];
  var tstSphere = [ -2, -2, 0, 1 ];
  var expected = Math.sqrt( 32 ) - 2;
  var gotDistance = _.sphere.sphereDistance( srcSphere, tstSphere );

  test.equivalent( gotDistance, expected );

  test.case = 'Different centers 3D'; /* */

  var srcSphere = [ 2, 2, 2, 1 ];
  var tstSphere = [ -2, -2, -2, 1 ];
  var expected = Math.sqrt( 48 ) - 2;
  var gotDistance = _.sphere.sphereDistance( srcSphere, tstSphere );

  test.equivalent( gotDistance, expected );

  test.case = 'Different centers - different radius'; /* */

  var srcSphere = [ 2, 0, 0, 1 ];
  var tstSphere = [ -2, 0, 0, 2 ];
  var expected = 1;
  var gotDistance = _.sphere.sphereDistance( srcSphere, tstSphere );

  test.identical( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.sphereDistance( ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereDistance( 'sphereOne', 'sphereTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereDistance( [ 1,2,3,4 ], 'sphereTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereDistance( 'sphereOne', [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereDistance( [ 1,2,3,4 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereDistance( null, [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereDistance( [ 1,2,3,4 ], NaN ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereDistance( NaN, [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereDistance( [ 1,2,3,4 ] , [ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereDistance( [ 1,2,3 ] , [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereDistance( [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereDistance( [ 1,2,3,4 ] , [ 1,2,3,4 ] , [ 1,2,3,4 ] ) );

}

//

function sphereClosestPoint( test )
{
  test.case = 'Source and test spheres remain unchanged'; /* */

  var srcSphere = [ 0, 0, 0, 0 ];
  var tstSphere = [ 0, 0, 0, 0 ];
  var expected = 0;
  var gotClosestPoint = _.sphere.sphereClosestPoint( srcSphere, tstSphere );
  test.identical( gotClosestPoint, expected );

  var oldSrcSphere = [ 0, 0, 0, 0 ];
  test.identical( srcSphere, oldSrcSphere );

  var oldTstSphere = [ 0, 0, 0, 0 ];
  test.identical( tstSphere, oldTstSphere );

  test.case = 'Empty spheres'; /* */

  var srcSphere = [ 0, 0, 0, 0 ];
  var tstSphere = [ 0, 0, 0, 0 ];
  var expected = 0;
  var gotClosestPoint = _.sphere.sphereClosestPoint( srcSphere, tstSphere );

  test.identical( gotClosestPoint, expected );

  test.case = 'Same spheres'; /* */

  var srcSphere = [ 0, 1, 0, 2 ];
  var tstSphere = [ 0, 1, 0, 2 ];
  var expected = 0;
  var gotClosestPoint = _.sphere.sphereClosestPoint( srcSphere, tstSphere );

  test.identical( gotClosestPoint, expected );

  test.case = 'Intersection'; /* */

  var srcSphere = [ - 1, 2, 0, 2 ];
  var tstSphere = [ 1, 3, 0, 2 ];
  var expected = 0;
  var gotClosestPoint = _.sphere.sphereClosestPoint( srcSphere, tstSphere );

  test.identical( gotClosestPoint, expected );

  test.case = 'Different centers 1D'; /* */

  var srcSphere = [ 2, 0, 0, 1 ];
  var tstSphere = [ -2, 0, 0, 1 ];
  var expected = [ 1, 0, 0 ];
  var gotClosestPoint = _.sphere.sphereClosestPoint( srcSphere, tstSphere );

  test.identical( gotClosestPoint, expected );

  test.case = 'Different centers 2D'; /* */

  var srcSphere = [ 2, 2, 0, 1 ];
  var tstSphere = [ -2, -2, 0, 1 ];
  var expected = [ 1.2928932188134525,  1.2928932188134525, 0 ];
  var gotClosestPoint = _.sphere.sphereClosestPoint( srcSphere, tstSphere );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'Different centers 3D'; /* */

  var srcSphere = [ 2, 2, 2, 1 ];
  var tstSphere = [ -2, -2, -2, 1 ];
  var expected = [ 1.4226497308103743, 1.4226497308103743, 1.4226497308103743 ];
  var gotClosestPoint = _.sphere.sphereClosestPoint( srcSphere, tstSphere );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'Different centers - different radius 1D'; /* */

  var srcSphere = [ 2, 0, 0, 1 ];
  var tstSphere = [ -2, 0, 0, 2 ];
  var expected = [ 1, 0, 0 ];
  var gotClosestPoint = _.sphere.sphereClosestPoint( srcSphere, tstSphere );

  test.identical( gotClosestPoint, expected );

  test.case = 'DstPoint is array'; /* */

  var srcSphere = [ 2, 2, 0, 1 ];
  var tstSphere = [ -2, -2, 0, 2 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = [ 1.2928932188134525,  1.2928932188134525, 0 ];
  var gotClosestPoint = _.sphere.sphereClosestPoint( srcSphere, tstSphere, dstPoint );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'DstPoint is vector'; /* */

  var srcSphere = [ 2, 2, 2, 1 ];
  var tstSphere = [ -2, -2, -2, 1 ];
  var dstPoint = _.vector.fromArray( [ 0, 0, 0 ] );
  var expected = _.vector.fromArray( [ 1.4226497308103743, 1.4226497308103743, 1.4226497308103743 ] );
  var gotClosestPoint = _.sphere.sphereClosestPoint( srcSphere, tstSphere, dstPoint );

  test.equivalent( gotClosestPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.sphereClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereClosestPoint( 'sphereOne', 'sphereTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereClosestPoint( [ 1,2,3,4 ], 'sphereTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereClosestPoint( 'sphereOne', [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereClosestPoint( [ 1,2,3,4 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereClosestPoint( null, [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereClosestPoint( [ 1,2,3,4 ], NaN ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereClosestPoint( NaN, [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereClosestPoint( [ 1,2,3,4 ] , [ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereClosestPoint( [ 1,2,3 ] , [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereClosestPoint( [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereClosestPoint( [ 1,2,3,4 ] , [ 1,2,3,4 ] , [ 1,2,3,4 ] ) );

}

//

function sphereExpand( test )
{

  test.case = 'trivial';

  var s1 = [ -2, 0, 0, 1 ];
  var s2 = [ +2, 0, 0, 1 ];

  var expected = [ -2, 0, 0, 5 ];
  var got = _.sphere.sphereExpand( s1, s2 );

  test.identical( got, expected );
  test.is( got === s1 );

  test.case = 'different radius';

  var s1 = [ -2, 0, 0, 2 ];
  var s2 = [ +2, 0, 0, 1 ];
  var expected = [ -2, 0, 0, 5 ];
  var got = _.sphere.sphereExpand( s1, s2 );

  test.identical( got, expected );
  test.is( got === s1 );

  test.case = 'different radius, one inside of another 1';

  var s1 = [ -2, 0, 0, 3 ];
  var s2 = [ 0, 0, 0, 1 ];
  var expected = [ -2, 0, 0, 3 ];
  var got = _.sphere.sphereExpand( s1, s2 );

  test.identical( got, expected );
  test.is( got === s1 );

  test.case = 'different radius, one inside of another 2';

  var s1 = [ -2, 0, 0, 3 ];
  var s2 = [ +0, 0, 0, 0.5 ];
  var expected = [ -2, 0, 0, 3 ];
  var got = _.sphere.sphereExpand( s1, s2 );

  test.identical( got, expected );
  test.is( got === s1 );

  test.case = 'different radius, overlap';

  var s1 = [ -2, 0, 0, 3 ];
  var s2 = [ +1, 0, 0, 2 ];
  var expected = [ -2, 0, 0, 5 ];
  var got = _.sphere.sphereExpand( s1, s2 );

  test.equivalent( got, expected );
  test.is( got === s1 );

  test.case = 'different radius, overlap';

  var s1 = [ 1, 2, 3, 5 ];
  var s2 = [ -1, -2, -3, 5 ];
  var expected = [ 1, 2, 3, 12.483314773547882 ];
  var got = _.sphere.sphereExpand( s1, s2 );

  test.equivalent( got, expected );
  test.is( got === s1 );

  test.case = 'empty by identity';

  var s1 = [ 0, 0, 0, 0 ];
  var s2 = [ 0, 0, 0, 1 ];
  var expected = [ 0, 0, 0, 1 ];
  var got = _.sphere.sphereExpand( s1, s2 );

  test.identical( got, expected );
  test.is( got === s1 );

  test.case = 'empty by empty at zero';

  var s1 = [ 0, 0, 0, 0 ];
  var s2 = [ 0, 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0 ];
  var got = _.sphere.sphereExpand( s1, s2 );

  test.identical( got, expected );
  test.is( got === s1 );

  test.case = 'empty by empty not at zero';

  var s1 = [ 0, 0, 0, 0 ];
  var s2 = [ 1, 1, 1, 0 ];
  var expected = [ 0, 0, 0, _.sqrt( 3 ) ];
  var got = _.sphere.sphereExpand( s1, s2 );

  test.equivalent( got, expected );
  test.is( got === s1 );

  test.case = 'overlap';

  var s1 = [ -3, 0, 0, 3 ];
  var s2 = [ +1, 0, 0, 2 ];
  var expected = [ -3, 0, 0, 6 ];
  var got = _.sphere.sphereExpand( s1, s2 );

  test.identical( got, expected );
  test.is( got === s1 );

  test.case = 'inside, different centers';

  var s1 = [ 0, 0, 0, 5 ];
  var s2 = [ 1, 1, 1, 2 ];
  var expected = [ 0, 0, 0, 5 ];
  var got = _.sphere.sphereExpand( s1, s2 );

  test.identical( got, expected );
  test.is( got === s1 );

  test.case = 'inside, same centers';

  var s1 = [ 0, 0, 0, 5 ];
  var s2 = [ 0, 0, 0, 2 ];
  var expected = [ 0, 0, 0, 5 ];
  var got = _.sphere.sphereExpand( s1, s2 );

  test.identical( got, expected );
  test.is( got === s1 );

  test.case = 'dst is nil';

  var s1 = _.sphere.makeNil();
  var s2 = [ 0, 0, 0, 2 ];
  var expected = [ 0, 0, 0, 2 ];
  var got = _.sphere.sphereExpand( s1, s2 );

  test.identical( got, expected );
  test.is( got === s1 );

  test.case = 'src is nil';

  var s1 = [ 0, 0, 0, 2 ];
  var s2 = _.sphere.makeNil();
  var expected = [ 0, 0, 0, 2 ];
  var got = _.sphere.sphereExpand( s1, s2 );

  test.identical( got, expected );
  test.is( got === s1 );

  test.case = 'dst and src are nil';

  var s1 = _.sphere.makeNil();
  var s2 = _.sphere.makeNil();
  var expected = [ 0, 0, 0, -Infinity ];
  var got = _.sphere.sphereExpand( s1, s2 );

  test.identical( got, expected );
  test.is( got === s1 );

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

function planeClosestPoint( test )
{
  test.case = 'Source sphere and test plane remain unchanged'; /* */

  var srcSphere = [ 0, 0, 0, 0 ];
  var tstPlane = [ 1, 0, 0, 0 ];
  var expected = 0;
  var gotClosestPoint = _.sphere.planeClosestPoint( srcSphere, tstPlane );
  test.identical( gotClosestPoint, expected );

  var oldSrcSphere = [ 0, 0, 0, 0 ];
  test.identical( srcSphere, oldSrcSphere );

  var oldTstPlane = [ 1, 0, 0, 0 ];
  test.identical( tstPlane, oldTstPlane );

  test.case = 'Empty sphere in plane'; /* */

  var srcSphere = [ 0, 0, 0, 0 ];
  var tstPlane = [ 1, 0, 0, 0 ];
  var expected = 0;
  var gotClosestPoint = _.sphere.planeClosestPoint( srcSphere, tstPlane );

  test.identical( gotClosestPoint, expected );

  test.case = 'Empty sphere not in plane'; /* */

  var srcSphere = [ 0, 0, 0, 0 ];
  var tstPlane = [ 1, 0, 0, 1 ];
  var expected = [ 0, 0, 0 ];
  var gotClosestPoint = _.sphere.planeClosestPoint( srcSphere, tstPlane );

  test.identical( gotClosestPoint, expected );

  test.case = 'Intersection'; /* */

  var srcSphere = [ 0, 0, 0, 2 ];
  var tstPlane = [ 1, 0, 0, 1 ];
  var expected = 0;
  var gotClosestPoint = _.sphere.planeClosestPoint( srcSphere, tstPlane );

  test.identical( gotClosestPoint, expected );

  test.case = 'Plane touches sphere'; /* */

  var srcSphere = [ 0, 0, 0, 1 ];
  var tstPlane = [ 1, 0, 0, 1 ];
  var expected = 0;
  var gotClosestPoint = _.sphere.planeClosestPoint( srcSphere, tstPlane );

  test.identical( gotClosestPoint, expected );

  test.case = 'Plane separate from sphere - plane under sphere'; /* */

  var srcSphere = [ 0, 0, 0, 1 ];
  var tstPlane = [ 1, 0, 0, 3 ];
  var expected = [ -1, 0, 0 ];
  var gotClosestPoint = _.sphere.planeClosestPoint( srcSphere, tstPlane );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'Plane separate from sphere - plane over sphere'; /* */

  var srcSphere = [ 0, 0, 0, 1 ];
  var tstPlane = [ 1, 0, 0, - 3 ];
  var expected = [ 1, 0, 0 ];
  var gotClosestPoint = _.sphere.planeClosestPoint( srcSphere, tstPlane );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'DstPoint is array'; /* */

  var srcSphere = [ 2, 2, 0, 1 ];
  var tstPlane = [ 1, 1, 0, 0 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = [ 1.2928932188134525,  1.2928932188134525, 0 ];
  var gotClosestPoint = _.sphere.planeClosestPoint( srcSphere, tstPlane, dstPoint );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'DstPoint is vector'; /* */

  var srcSphere = [ 2, 2, 2, 1 ];
  var tstPlane = [ 1, 1, 1, 0 ];
  var dstPoint = _.vector.fromArray( [ 0, 0, 0 ] );
  var expected = _.vector.fromArray( [ 1.4226497308103743, 1.4226497308103743, 1.4226497308103743 ] );
  var gotClosestPoint = _.sphere.planeClosestPoint( srcSphere, tstPlane, dstPoint );

  test.equivalent( gotClosestPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.planeClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.sphere.planeClosestPoint( 'sphereOne', 'sphereTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.planeClosestPoint( [ 1,2,3,4 ], 'sphereTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.planeClosestPoint( 'sphereOne', [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.planeClosestPoint( [ 1,2,3,4 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.planeClosestPoint( null, [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.planeClosestPoint( [ 1,2,3,4 ], NaN ) );
  test.shouldThrowErrorSync( () => _.sphere.planeClosestPoint( NaN, [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.planeClosestPoint( [ 1,2,3,4 ] , [ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.planeClosestPoint( [ 1,2,3 ] , [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.planeClosestPoint( [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.planeClosestPoint( [ 1,2,3,4 ] , [ 1,2,3,4 ] , [ 1,2,3,4 ] ) );

}

//

function planeExpand( test )
{
  test.case = 'Source sphere and test plane remain unchanged'; /* */

  var srcSphere = [ 0, 0, 0, 0 ];
  var tstPlane = [ 1, 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0 ];
  var gotExpand = _.sphere.planeExpand( srcSphere, tstPlane );
  test.identical( gotExpand, expected );

  var oldSrcSphere = [ 0, 0, 0, 0 ];
  test.identical( srcSphere, oldSrcSphere );

  var oldTstPlane = [ 1, 0, 0, 0 ];
  test.identical( tstPlane, oldTstPlane );

  test.case = 'Empty sphere in plane - no expansion'; /* */

  var srcSphere = [ 0, 0, 0, 0 ];
  var tstPlane = [ 1, 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0 ];
  var gotExpand = _.sphere.planeExpand( srcSphere, tstPlane );

  test.identical( gotExpand, expected );

  test.case = 'Empty sphere not in plane - expansion'; /* */

  var srcSphere = [ 0, 0, 0, 0 ];
  var tstPlane = [ 1, 0, 0, 1 ];
  var expected = [ 0, 0, 0, 1 ];
  var gotExpand = _.sphere.planeExpand( srcSphere, tstPlane );

  test.identical( gotExpand, expected );

  test.case = 'Intersection'; /* */

  var srcSphere = [ 0, 0, 0, 2 ];
  var tstPlane = [ 1, 0, 0, 1 ];
  var expected = [ 0, 0, 0, 2 ];
  var gotExpand = _.sphere.planeExpand( srcSphere, tstPlane );

  test.identical( gotExpand, expected );

  test.case = 'Plane touches sphere'; /* */

  var srcSphere = [ 0, 0, 0, 1 ];
  var tstPlane = [ 1, 0, 0, 1 ];
  var expected = [ 0, 0, 0, 1 ];
  var gotExpand = _.sphere.planeExpand( srcSphere, tstPlane );

  test.identical( gotExpand, expected );

  test.case = 'Plane separate from sphere - plane under sphere'; /* */

  var srcSphere = [ 0, 0, 0, 1 ];
  var tstPlane = [ 1, 0, 0, 3 ];
  var expected = [ 0, 0, 0, 3 ];
  var gotExpand = _.sphere.planeExpand( srcSphere, tstPlane );

  test.equivalent( gotExpand, expected );

  test.case = 'Plane separate from sphere - plane over sphere'; /* */

  var srcSphere = [ 0, 0, 0, 1 ];
  var tstPlane = [ 1, 0, 0, - 3 ];
  var expected = [ 0, 0, 0, 3 ];
  var gotExpand = _.sphere.planeExpand( srcSphere, tstPlane );

  test.equivalent( gotExpand, expected );

  test.case = 'Expansion 2D'; /* */

  var srcSphere = [ 2, 2, 0, 1 ];
  var tstPlane = [ 1, 1, 0, 0 ];
  var expected = [ 2, 2, 0, 2.8284271247461903 ];
  var gotExpand = _.sphere.planeExpand( srcSphere, tstPlane );

  test.equivalent( gotExpand, expected );

  test.case = 'Expansion 3D'; /* */

  var srcSphere = [ 2, 2, 2, 1 ];
  var tstPlane = [ 1, 1, 1, 0 ];
  var expected = [ 2, 2, 2, 3.4641016151377544 ];
  var gotExpand = _.sphere.planeExpand( srcSphere, tstPlane );

  test.equivalent( gotExpand, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.planeExpand( ) );
  test.shouldThrowErrorSync( () => _.sphere.planeExpand( 'sphereOne', 'sphereTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.planeExpand( [ 1,2,3,4 ], 'sphereTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.planeExpand( 'sphereOne', [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.planeExpand( [ 1,2,3,4 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.planeExpand( null, [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.planeExpand( [ 1,2,3,4 ], NaN ) );
  test.shouldThrowErrorSync( () => _.sphere.planeExpand( NaN, [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.planeExpand( [ 1,2,3,4 ] , [ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.planeExpand( [ 1,2,3 ] , [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.planeExpand( [ 1,2,3,4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.planeExpand( [ 1,2,3,4 ] , [ 1,2,3,4 ] , [ 1,2,3,4 ] ) );

}

// --
// define class
// --

var Self =
{

  name : 'Tools/Math/Sphere',
  silencing : 1,
  enabled : 1,
  // verbosity : 7,
  // debug : 1,
  // routine : 'sphereExpand',

  tests :
  {

    make : make,
    makeZero : makeZero,
    makeNil : makeNil,

    zero : zero,
    nil : nil,
    centeredOfRadius : centeredOfRadius,

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
    pointExpand : pointExpand,

    boxContains : boxContains,
    boxIntersects : boxIntersects,
    boxClosestPoint : boxClosestPoint,
    boxExpand : boxExpand,

    sphereContains : sphereContains,
    sphereIntersects : sphereIntersects,
    sphereDistance : sphereDistance,
    sphereClosestPoint : sphereClosestPoint,
    sphereExpand : sphereExpand,

    planeClosestPoint : planeClosestPoint,
    planeExpand : planeExpand,

  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
