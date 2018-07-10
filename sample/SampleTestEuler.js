if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var EulerSeqs = [ 'xyz', 'xzy', 'yxz', 'yzx', 'zxy', 'zyx', 'xyx', 'xzx', 'yxy', 'yzy', 'zxz', 'zyz' ];
var Angle = [ 0, Math.PI / 6, Math.PI / 4, Math.PI / 3 ];
var Quadrant = [ 0, 1, 2, 3 ];
var accuracy = _.EPS;
var Delta = [ -0.1, -Math.sqrt( _.EPS ), -( _.EPS*_.EPS ), 0, +( _.EPS*_.EPS ), +Math.sqrt( _.EPS ), +0.1 ];
var T = 0;
var F = 0;

debugger;
function onEach( euler, eulerEmpty )
{
  var dstEuler = euler.slice();
  dstEuler[ 0 ] = 0;
  dstEuler[ 1 ] = 0;
  dstEuler[ 2 ] = 0;
  var expected = _.euler.toQuat2( euler );
  euler2 = _.euler.fromQuat2( expected, dstEuler );
  var result = _.euler.toQuat2( euler2 );

  var positiveResult = result.slice();
  var negativeResult = _.avector.mul( _.vector.toArray( result ), -1 );
  var expected = _.vector.toArray( expected );
  var eq1 = _.entityEquivalent( positiveResult, expected, { accuracy : accuracy } );
  var eq2 = _.entityEquivalent( negativeResult, expected, { accuracy : accuracy } );

  if( eq1 === true || eq2 === true )
  { T = T+1; }
  else
  {
    result = _.vector.toArray( result );
    expected = _.vector.toArray( expected );
    console.log( 'euler: ', euler[ 0 ],euler[ 1 ],euler[ 2 ], euler[ 3 ],euler[ 4 ],euler[ 5 ] );
    console.log( 'q1: ', expected[ 0 ], expected[ 1 ], expected[ 2 ], expected[ 3 ] );
    console.log( 'q2: ', result[ 0 ], result[ 1 ], result[ 2 ], result[ 3 ] );
    F = F +1; }
  }


for( var i = 0; i < EulerSeqs.length; i++ )
{
  var seq = EulerSeqs[ i ];
  console.log('SEQUENCE ******************** ',seq);
  var euler = [ 0, 0, 0, 0, 0, 0 ];
  euler = _.euler.make2( euler, seq );
  for( var ang = 0; ang < Angle.length; ang++ )
  {
    for( var quad = 0; quad < Quadrant.length; quad++ )
    {
      for( var d = 0; d < Delta.length; d++ )
      {
        euler[ 0 ] = Angle[ ang ] + Quadrant[ quad ]*Math.PI/2 + Delta[ d ];
        for( var ang2 = ang; ang2 < Angle.length; ang2++ )
        {
          for( var quad2 = quad; quad2 < Quadrant.length; quad2++ )
          {
            for( var d2 = d; d2 < Delta.length; d2++ )
            {
              euler[ 1 ] = Angle[ ang2 ] + Quadrant[ quad2 ]*Math.PI/2 + Delta[ d2 ];
              for( var ang3 = ang2; ang3 < Angle.length; ang3++ )
              {
                for( var quad3 = quad2; quad3 < Quadrant.length; quad3++ )
                {
                  for( var d3 = d2; d3 < Delta.length; d3++ )
                  {
                    euler[ 2 ] = Angle[ ang3 ] + Quadrant[ quad3 ]*Math.PI/2 + Delta[ d3 ];
                    var eulerEmpty = _.euler.make2( null, seq );
                    onEach( euler );
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}


console.log( 'T = ', T);
console.log( 'F = ', F);
