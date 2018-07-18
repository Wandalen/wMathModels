(function _aConcepts_s_() {

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

  _.include( 'wMathScalar' );
  _.include( 'wMathVector' );
  _.include( 'wMathSpace' );

  // require( './Ray.s' );
  require( './Box.s' );
  require( './Sphere.s' );
  require( './Plane.s' );
  require( './Frustum.s' );

  require( './AxisAndAngle.s' );
  require( './Quat.s' );
  require( './Euler.s' );

}

})();
