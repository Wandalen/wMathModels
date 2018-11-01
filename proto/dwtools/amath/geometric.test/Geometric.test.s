( function _Geometric_test_s_() {

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

  require( '../geometric/Geometric.s' );

}

//

var _ = _global_.wTools;

// --
// samples
// --

var samples =
{

  pair2AndEq :
  [

    { line : [ 0,0, 0,2 ], eq : [ -2,+0,+0 ] },
    { line : [ 0,0, 2,0 ], eq : [ +0,+2,+0 ] },
    { line : [ 0,0, 2,2 ], eq : [ -2,+2,+0 ] },
    { line : [ 1,2, 3,4 ], eq : [ -2,+2,-2 ], points : [ 2,3 ] },
    { line : [ 3,4, 4,3 ], eq : [ +1,+1,-7 ] },
    { line : [ 2,2, 4,0 ], eq : [ +2,+2,-8 ] },

  ],

  pair4 :
  [

    [ 7,9, 4,8, 8,3, 4,0 ],

    [ 0,0 ,0,2, 0,0, 2,0 ],
    [ 0,0 ,2,2, 2,2, 4,0 ],
    [ 7,4, 6,6, 7,4, 4,4 ],
/*
    [ 0,0, 2,2, 2,2, 4,4 ], // same
    [ 0,0, 0,0, 2,2, 4,4 ], // singular
    [ 0,0, 2,2, 2,1, 4,3 ], // parallel
*/

  ],

  matrix2Eq :
  [

    { m : [ 1,3, 2,4 ], y : [ 5,6 ], x : [ -4,+4.5 ] },
    { m : [ 0,1, 2,3 ], y : [ 10,11 ], x : [ -4,+5 ] },

  ],

}

// --
// test
// --

function d2PolygonIsClockwise( test )
{

  test.case = 'simple clockwise'; /* */

  var polygon = [ 0,0, 10,0, 10,10, 0,10 ];
  var got = _.d2PolygonIsClockwise( polygon );
  test.identical( got, true );

  test.case = 'simple counter clockwise'; /* */

  var polygon = [ 0,0, 0,10, 10,10, 10,0 ];
  var got = _.d2PolygonIsClockwise( polygon );
  test.identical( got, false );

}

//

function d2LineGeneralEqWithPoints( test )
{
  var self = this;
  var accuracy = test.accuracy;
  var samples = self.samples.pair2AndEq;

  function testSample( sample )
  {
    var l1 = _.d2LineGeneralEqWithPoints( sample.line.slice( 0,2 ),sample.line.slice( 2,4 ) );
    test.equivalent( l1,sample.eq );
  }

  for( var s = 0 ; s < samples.length ; s++ )
  {
    var sample = samples[ s ];
    testSample.call( this,sample );
  }

}

//

function d2LineGeneraEqPointDistance( test )
{
  var self = this;
  var accuracy = test.accuracy;
  var samples = self.samples.pair2AndEq;

  function _testSample( line,linePoints,point )
  {

    var d1 = _.d2LineGeneraEqPointDistance( line,point );
    var d2 = _.d2LinePointDistance( [ linePoints.slice( 0,2 ),linePoints.slice( 2,4 ) ],point );
    test.equivalent( d1,d2 );
    var d1 = _.d2LineGeneraEqPointDistance( line,point );
    var d2 = _.d2LinePointDistance( [ linePoints.slice( 0,2 ),linePoints.slice( 2,4 ) ],point );

  }

  function testSample( sample )
  {

    var l1 = _.d2LineGeneralEqWithPoints( sample.line.slice( 0,2 ),sample.line.slice( 2,4 ) );

    if( sample.points )
    for( var i = 0 ; i < sample.points.length / 2 ; i++ )
    {
      _testSample.call( this,l1,sample.line,sample.points.slice( i*2,i*2+2 ) );
    }

    for( var i = 0 ; i < 32 ; i++ )
    {
      var p = _.arrayFillTimes( [],2 ).map( function(){ return Math.floor( Math.random() * 10 ) } );
      _testSample.call( this,l1,sample.line,p );
    }

  }

  for( var s = 0 ; s < samples.length ; s++ )
  {
    var sample = samples[ s ];
    testSample.call( this,sample );
  }

}

//

function d2LineLineGeneralEqIntersection( test )
{
  var self = this;
  var accuracy = test.accuracy;
  var samples = self.samples.pair4;

  function testSample( sample )
  {

    debugger; // [ 7,9, 4,8, 8,3, 4,0 ],

    var pair1 = [ sample.slice( 0,2 ),sample.slice( 2,4 ) ];
    var pair2 = [ sample.slice( 4,6 ),sample.slice( 6,8 ) ];

    debugger;

    var l1 = _.d2LineGeneralEqWithPoints( pair1[ 0 ], pair1[ 1 ] );
    var l2 = _.d2LineGeneralEqWithPoints( pair2[ 0 ], pair2[ 1 ] );

    var intersection = _.d2LineLineGeneralEqIntersection( l1,l2 );

    var d1 = _.d2LineGeneraEqPointDistance( l1,intersection );
    var d2 = _.d2LineGeneraEqPointDistance( l2,intersection );

    var distance1 = _.avector.distance.apply( _.avector,pair1 );
    var distance2 = _.avector.distance.apply( _.avector,pair2 );
    var areParallel = _.avector.areParallel( _.avector.subVectors.apply( _.avector,pair1 ),_.avector.subVectors.apply( _.avector,pair2 ) );

    debugger;

    if( distance1 === 0 || distance2 === 0 || areParallel )
    {
      test.equivalent( _.numberIsFinite( d1 ), false );
      test.equivalent( _.numberIsFinite( d2 ), false );
    }
    else
    {
      test.equivalent( d1, 0 );
      test.equivalent( d2, 0 );
    }
/*
    var areParallel = _.avector.areParallel( _.avector.subVectors.apply( _.avector,pair1 ),_.avector.subVectors.apply( _.avector,pair2 ) );
    var intersection = _.d2LineLineGeneralEqIntersection( l1,l2 );
*/
  }

  // for( var s = 0 ; s < samples.length ; s++ )
  for( var s = 0 ; s < 1 ; s++ )
  {
    var sample = samples[ s ];
    testSample.call( this,sample );
  }

  return;

  for( var s = 0 ; s < 100 ; s++ )
  {
    var sample = _.arrayFillTimes( [] , 8 ).map( function(){ return Math.floor( Math.random() * 10 ) } );
    testSample.call( this,sample );
  }

}

//

function d2linearEquationSolve( test )
{
  var self = this;
  var accuracy = test.accuracy;
  var samples = self.samples.matrix2Eq;

/*
  var m1 = _.Space.makeIdentity3();
  m1.set( 1,2,3,4,5,6,7,8,9 );
  console.log( 'm1 :',_.toStr( m1 ) );
*/

  function testSample( sample )
  {

    var x = _.d2linearEquationSolve( sample.m,sample.y );
    test.identical( x,sample.x );

  }

  for( var s = 0 ; s < samples.length ; s++ )
  {

    var sample = samples[ s ];
    testSample.call( this,sample );

  }

/*
  for( var s = 0 ; s < 100 ; s++ )
  {
    var sample = _.arrayFillTimes( [] , 8 ).map( function(){ return Math.floor( Math.random() * 10 ) } );
    testSample.call( this,sample );
  }
*/

}

//

function pairPairIntersectionPoint( test )
{
  var self = this;
  var accuracy = test.accuracy;
  var samples = self.samples.pair4;

  function testSample( sample )
  {

    var pair1 = [ sample.slice( 0,2 ),sample.slice( 2,4 ) ];
    var pair2 = [ sample.slice( 4,6 ),sample.slice( 6,8 ) ];

    logger.log( 'pair1', _.toStr( pair1, { levels : 9 } ) );
    logger.log( 'pair2', _.toStr( pair1, { levels : 9 } ) );

    var eq1 = _.d2LineGeneralEqWithPoints.apply( _,pair1 );
    var eq2 = _.d2LineGeneralEqWithPoints.apply( _,pair2 );
    var a = _.d2LineLineGeneralEqIntersection( eq1,eq2 );
    var b = _.pairPairIntersectionPoint( pair1, pair2 );

    var distance1 = _.avector.distance.apply( undefined,pair1 );
    var distance2 = _.avector.distance.apply( undefined,pair2 );
    var areParallel = _.avector.areParallel( _.avector.subVectors.apply( undefined,pair1.slice() ),_.avector.subVectors.apply( undefined,pair2.slice() ) );

    if( !areParallel && distance1 > 0 && distance2 > 0 )
    if( a[ 0 ] === -Infinity )
    {
      debugger;
      var eq1 = _.d2LineGeneralEqWithPoints.apply( _,pair1 );
      var eq2 = _.d2LineGeneralEqWithPoints.apply( _,pair2 );
      var a = _.d2LineLineGeneralEqIntersection( eq1,eq2 );
      var b = _.pairPairIntersectionPoint( pair1, pair2 );

      var distance1 = _.avector.distance.apply( undefined,pair1 );
      var distance2 = _.avector.distance.apply( undefined,pair2 );
      var areParallel = _.avector.areParallel( _.avector.subVectors.apply( undefined,pair1.slice() ),_.avector.subVectors.apply( undefined,pair2.slice() ) );
      debugger;
    }

    if( !areParallel && distance1 > 0 && distance2 > 0 )
    test.equivalent( a,b );

  }

  for( var s = 0 ; s < samples.length ; s++ )
  {

    var sample = samples[ s ];
    testSample.call( this,sample );

  }

/*
  xxx problem if
  var pair1 =
  [
    [ 0, 1 ],
    [ 1, 1 ]
  ]
  var pair2 =
  [
    [ 1, 0 ],
    [ 0, 0 ]
  ]
*/

  // for( var s = 0 ; s < 1000 ; s++ )
  // {
  //   var sample = _.arrayFillTimes( [] , 8 ).map( function(){ return Math.floor( Math.random() * 2 ) } );
  //   testSample.call( this,sample );
  // }

}

//

function d2Angle( test )
{
  var self = this;
  var accuracy = test.accuracy;
  var minValue = Number.MIN_VALUE;

  var samples =
  [

    [ +1,+0 ],

    /*[ +0,+0 ],*/

    [ +1,+1 ],
    [ +0,+1 ],
    [ -1,+1 ],
    [ -1,+0 ],
    [ -1,-1 ],
    [ +0,-1 ],
    [ +1,-1 ],
    [ +0,+0 ],

  ];

  var add =
  [

    [ 0,0 ],
    [ -minValue,0 ],
    [ +minValue,0 ],
    [ 0,-minValue ],
    [ 0,+minValue ],
    [ -minValue,-minValue ],
    [ -minValue,+minValue ],
    [ +minValue,-minValue ],
    [ +minValue,+minValue ],

  ];

  var functions =
  {
    d2Angle : _.d2Angle,
    d2AngleWithCos : _.d2AngleWithCos,
    d2AngleWithCosFast : _.d2AngleWithCosFast,
  }

  for( var i1 = 0 ; i1 < samples.length ; i1++ )
  {

    for( var i2 = 0 ; i2 < samples.length ; i2++ )
    {

      for( var f in functions )
      {

        for( var a = 0 ; a < add.length ; a++ )
        {

          var sample1 = _.avector.normalize( samples[ i1 ].slice() );
          var sample2 = _.avector.normalize( samples[ i2 ].slice() );

          _.avector.addVectors( sample2,add[ a ] );

          var o = functions[ f ]( sample1,sample2 );
          console.log( _.strForCall( f,[ sample1,sample2 ],o,{ precision : 3 } ) );
/*
          var expected = test.equivalent( isNaN( o ) ||  Math.abs( o ) < 2*3.15, true );
          if( !expected )
          o = functions[ f ]( sample1,sample2 );
*/
        }

      }

      console.log( '' );
    }

    console.log( '-------------------------------------' );
  }

}

d2Angle.experimental = 1;

// --
// declare
// --

var Self =
{

  name : 'Tools/Math/Geometric',
  silencing : 1,
  enabled : 1,
  /*verbosity : 7,*/

  context :
  {
    samples : samples,
  },

  tests :
  {

    d2PolygonIsClockwise : d2PolygonIsClockwise,

    d2LineGeneralEqWithPoints : d2LineGeneralEqWithPoints,
    d2LineGeneraEqPointDistance : d2LineGeneraEqPointDistance,

    d2LineLineGeneralEqIntersection : d2LineLineGeneralEqIntersection,
    d2linearEquationSolve : d2linearEquationSolve,
    pairPairIntersectionPoint : pairPairIntersectionPoint,

    d2Angle : d2Angle,

  },

};

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
