
if( typeof module !== 'undefined' )
require( 'wmathconcepts' );

var _ = wTools;

var box = _.box.centeredOfSize( null );
console.log( 'box centered :',box );

// var expected = [ -0.5,-0.5,-0.5,+0.5,+0.5,+0.5 ];

 var box = [ 0, 0, 2, 2 ];
 var box = _.vector.fromArray( box );
 var box = undefined;
 var box = _.box.from( box );

 console.log( box );
debugger;
