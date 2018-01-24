(function _aConcepts_s_() {

'use strict';

if( typeof module !== 'undefined' )
{

  debugger;

  if( typeof wBase === 'undefined' )
  try
  {
    try
    {
      require.resolve( '../../../dwtools/Base.s' )/*fff*/;
    }
    finally
    {
      require( '../../../dwtools/Base.s' )/*fff*/;
    }
  }
  catch( err )
  {
    require( 'wTools' );
  }

  var _ = wTools;

  _.include( 'wMathScalar' );
  _.include( 'wMathVector' );
  _.include( 'wMathSpace' );

  require( './Box.s' );
  require( './Sphere.s' );
  require( './Plane.s' );
  require( './Frustum.s' );

  require( './AxisAndAngle.s' );
  require( './Quat.s' );
  require( './Euler.s' );

}

})();
