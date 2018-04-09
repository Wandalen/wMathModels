(function _Geometric_s_(){

'use strict';

var _ = _global_.wTools;
var avector = _.avector;
var Self = _.frustum = _.frustum || Object.create( null );

// --
//
// --

function make()
{
  _.assert( arguments.length === 0 );

  var dst = _.Space.make([ 4,6 ]);

  return dst;
}

//

function fromMatrixHomogenous( frustum , m )
{
  var frustum , m;

  if( frustum === null )
  frustum = this.make();

  _.assert( arguments.length === 2 );
  _.assert( _.frustum.is( frustum ) );
  _.assert( _.spaceIs( m ) );
  _.assert( m.hasShape([ 4,4 ]) );

  var col = frustum.colVectorGet( 0 );
  col.copy
  ([
    m.atomGet([ 3,0 ]) - m.atomGet([ 0,0 ]),
    m.atomGet([ 3,1 ]) - m.atomGet([ 0,1 ]),
    m.atomGet([ 3,2 ]) - m.atomGet([ 0,2 ]),
    m.atomGet([ 3,3 ]) - m.atomGet([ 0,3 ]),
  ]);

  var col = frustum.colVectorGet( 1 );
  col.copy
  ([
    m.atomGet([ 3,0 ]) + m.atomGet([ 0,0 ]),
    m.atomGet([ 3,1 ]) + m.atomGet([ 0,1 ]),
    m.atomGet([ 3,2 ]) + m.atomGet([ 0,2 ]),
    m.atomGet([ 3,3 ]) + m.atomGet([ 0,3 ]),
  ]);

  var col = frustum.colVectorGet( 2 );
  col.copy
  ([
    m.atomGet([ 3,0 ]) + m.atomGet([ 1,0 ]),
    m.atomGet([ 3,1 ]) + m.atomGet([ 1,1 ]),
    m.atomGet([ 3,2 ]) + m.atomGet([ 1,2 ]),
    m.atomGet([ 3,3 ]) + m.atomGet([ 1,3 ]),
  ]);

  var col = frustum.colVectorGet( 3 );
  col.copy
  ([
    m.atomGet([ 3,0 ]) - m.atomGet([ 1,0 ]),
    m.atomGet([ 3,1 ]) - m.atomGet([ 1,1 ]),
    m.atomGet([ 3,2 ]) - m.atomGet([ 1,2 ]),
    m.atomGet([ 3,3 ]) - m.atomGet([ 1,3 ]),
  ]);

  var col = frustum.colVectorGet( 4 );
  col.copy
  ([
    m.atomGet([ 3,0 ]) - m.atomGet([ 2,0 ]),
    m.atomGet([ 3,1 ]) - m.atomGet([ 2,1 ]),
    m.atomGet([ 3,2 ]) - m.atomGet([ 2,2 ]),
    m.atomGet([ 3,3 ]) - m.atomGet([ 2,3 ]),
  ]);

  var col = frustum.colVectorGet( 5 );
  col.copy
  ([
    m.atomGet([ 3,0 ]) + m.atomGet([ 2,0 ]),
    m.atomGet([ 3,1 ]) + m.atomGet([ 2,1 ]),
    m.atomGet([ 3,2 ]) + m.atomGet([ 2,2 ]),
    m.atomGet([ 3,3 ]) + m.atomGet([ 2,3 ]),
  ]);

  return frustum;
}

//

function is( frustum )
{
  _.assert( arguments.length === 1 );
  return _.spaceIs( frustum ) && frustum.hasShape([ 4,6 ])
}

//

function sphereIntersects( frustum , sphere )
{

  _.assert( arguments.length === 2 );
  _.assert( _.frustum.is( frustum ) );

  var center = _.sphere.centerGet( sphere );
  var radius = _.sphere.radiusGet( sphere );

  for( var i = 0 ; i < 6 ; i += 1 )
  {

    var plane = frustum.colVectorGet( i );
    var distance = _.plane.pointDistance( plane,center );

    if( distance < radius )
    return false;

  }

  return true;
}

//

function boxIntersects( frustum , box )
{

  _.assert( arguments.length === 2 );
  _.assert( _.frustum.is( frustum ) );
  debugger;

  var p1 = [];
  var p2 = [];

  for ( var i = 0 ; i < 6 ; i += 1 )
  {
    var plane = frustum.colVectorGet( i );

    p1[ 0 ] = plane.eGet( 0 ) > 0 ? box.min[ 0 ] : box.max[ 0 ];
    p2[ 0 ] = plane.eGet( 0 ) > 0 ? box.max[ 0 ] : box.min[ 0 ];
    p1[ 1 ] = plane.eGet( 1 ) > 0 ? box.min[ 1 ] : box.max[ 1 ];
    p2[ 1 ] = plane.eGet( 1 ) > 0 ? box.max[ 1 ] : box.min[ 1 ];
    p1[ 2 ] = plane.eGet( 2 ) > 0 ? box.min[ 2 ] : box.max[ 2 ];
    p2[ 2 ] = plane.eGet( 2 ) > 0 ? box.max[ 2 ] : box.min[ 2 ];

    var d1 = _.plane.pointDistance( plane,p1 );
    var d2 = _.plane.pointDistance( plane,p2 );

    if ( d1 < 0 && d2 < 0 )
    return false;

  }

  return true;
}

//

function pointContains( frustum , point )
{

  _.assert( arguments.length === 2 );
  _.assert( _.frustum.is( frustum ) );

  debugger;

  for( var i = 0 ; i < 6 ; i += 1 )
  {

    var plane = frustum.colVectorGet( i );
    if( _.plane.pointDistance( plane,point ) < 0 )
    return false;

  }

  return true;
}

// --
// prototype
// --

var Proto =
{

  make : make,
  fromMatrixHomogenous : fromMatrixHomogenous,
  is : is,


  sphereIntersects : sphereIntersects,
  boxIntersects : boxIntersects,
  pointContains : pointContains,

}

_.mapSupplement( Self,Proto );

})();
