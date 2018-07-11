if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;




  var angle = 1E-5;
  var expected = [ 0.000004999999873689376,0,0,1 ];
  var got = _.quat.fromAxisAndAngle( null,[ 1,0,0 ],angle );


console.log( 'qf: ', got );
