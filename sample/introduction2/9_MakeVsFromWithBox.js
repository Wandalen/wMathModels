if( typeof module !== 'undefined' )
require( 'wmathmodels' );

var _ = wTools;

/* */

var srcBox = [ 0, 1, 2, 3 ];

var box1 = _.box.make( srcBox );
console.log( `srcBox === box1 : ${ srcBox === box1 }` );
/* log : srcBox === box1 : false */
console.log( `Box1 : ${ box1 }` );
/* log : Box1 : [ 0, 1, 2, 3 ] */

var box2 = _.box.from( srcBox );
console.log( `srcBox === box2 : ${ srcBox === box2 }` );
/* log : srcBox === box2 : true */
console.log( `Box2 : ${ box2 }` );
/* log : Box2 : [ 0, 1, 2, 3 ] */

