# Introduction

Стаття описує основні особливості модуля та принципи його використання.

### Why?

### Creating figures

Створення фігури із розмірністю визначеною за замовчуванням

```js
let sphere = _.sphere.make();
console.log( 'Sphere : ', sphere );
/* log : Sphere : [ 0, 0, 0, 0 ] */
```

Створення фігури із довільною розмірністю.

```js
let sphere = _.sphere.make( 3 );
console.log( 'Sphere : ', sphere );
/* log : Sphere : [ 0, 0, 0, 0 ] */
```

### Make

```js
let box = _.box.make();
console.log( 'Box type :', _.strType( box ) );
/* log : Box type : Array */
console.log( 'Box : ', box );
/* log : Box : [ 0, 0, 0, 0, 0, 0 ] */
```

```js
let box = _.box.make( null );
console.log( 'Box type :', _.strType( box ) );
/* log : Box type : Array */
console.log( 'Box : ', box );
/* log : Box : [ 0, 0, 0, 0, 0, 0 ] */
```

```js
let dim = 2;
let box = _.box.make( dim );
console.log( 'Box type :', _.strType( box ) );
/* log : Box type : Array */
console.log( 'Box : ', box );
/* log : Box : [ 0, 0, 0, 0 ] */
```

```js
let srcBox = [ 0, 1, 2, 3 ];
let box = _.box.make( srcBox );
console.log( 'srcBox === box :', srcBox === box )
/* log : srcBox === box : false */
console.log( 'Box type :', _.strType( box ) );
/* log : Box type : Array */
console.log( 'Box : ', box );
/* log : Box : [ 0, 1, 2, 3 ] */
```

### From

```js
let box = _.box.from( null );
console.log( 'Box type :', _.strType( box ) );
/* log : Box type : Array */
console.log( 'Box : ', box );
/* log : Box : [ 0, 0, 0, 0, 0, 0 ] */
```

```js
let srcBox = _.vad.fromLong([ 0, 1, 2, 3 ]);
let box = _.box.from( srcBox );
console.log( 'srcBox === box :', srcBox === box )
/* log : srcBox === box : true */
console.log( 'Box type :', _.strType( box ) );
/* log : Box type : VectorAdapterFromLong */
console.log( 'Box : ', box.toStr() );
/* log : Box : VectorAdapter.x4.Array :: 0.000 1.000 2.000 3.000 */
```

```js
let srcBox = _.vector.make([ 0, 1, 2, 3 ]);
let box = _.box.from( srcBox );
console.log( 'srcBox === box :', srcBox === box )
/* log : srcBox === box : true */
console.log( 'Box type :', _.strType( box ) );
/* log : Box type : F32x */
console.log( 'Box : ', box );
/* log : Box : Float32Array(4) [ 0, 1, 2, 3 ] */
```

### Make vs From

```js
let dim = 2;

let box1 = _.box.make( dim );
console.log( 'Box1 : ', box1 );
/* log : Box1 : [ 0, 0, 0, 0 ] */

let box2 = _.box.from( dim );
/* Error, expects box or null */
```

```js
let srcBox = [ 0, 1, 2, 3 ];

let box1 = _.box.make( srcBox );
console.log( 'srcBox === box1 :', srcBox === box1 )
/* log : srcBox === box1 : false */
console.log( 'Box1 : ', box1 );
/* log : Box1 : [ 0, 1, 2, 3 ] */

let box2 = _.box.from( srcBox );
console.log( 'srcBox === box2 :', srcBox === box2 )
/* log : srcBox === box2 : true */
console.log( 'Box2 : ', box2 );
/* log : Box2 : [ 0, 1, 2, 3 ] */

```

### Keep flat, keep simple

"Плоский" формат представлення фігури означає те, що дані фігури зберігаються у одновимірному контейнері: масив, вектор, вектор адаптер.

Наступні приклади відносяться до двовимірної фігури типу `linePointDir` із даними: ```[ 1, 2, 3, 4 ]```

Візуалізація фігури та розміщення даних фігури в памяті процесу:

<img src="../../img/LinePointDir.png" />

Створення фігури на основі даних:

```js
let line = _.linePointDir.from( [ 1, 2, 3, 4 ] );
console.log( 'Line: ', line );
/* log : Line : [ 1, 2, 3, 4 ] */
```

Приклад отримання даних фігури:

```js
//How to get origin point
let line = _.linePointDir.from( [ 1, 2, 3, 4 ] );
let origin = _.linePointDir.originGet( line );
console.log( 'Origin: ', origin.toStr() );
/* log : Origin : "1.000 2.000" */

//How to get direction vector
let line = _.linePointDir.from( [ 1, 2, 3, 4 ] );
let direction = _.linePointDir.directionGet( line );
console.log( 'Direction: ', direction.toStr() );
/* log : Origin : "3.000 4.000" */

```

### Isomorphic

Поведінка рутин залишається незмінною при зміні типу фігури.

Наприклад, рутина ```pointContains``` завжди виконує лише перевірку чи фігура містить точку.

```js
var point = [ 0, 1 ];
var plane = [ 0, 1, 1 ];
var contains = _.plane.pointContains( plane, point );
console.log( 'Plane contains point: ', contains );
/* log : Plane contains point: false */
```

```js
var point = [ 0, 1 ];
var line = [ 0, 0, 0, 2 ];
var contains = _.linePointDir.pointContains( line, point );
console.log( 'Line contains point: ', contains );
/* log : Line contains point: true */
```

```js
var point = [ 0, 1 ];
var polygon = _.convexPolygon.make( 2, 3 ).copy
([
  1, 0, 0,
  0, 0, 1
]);
var contains = _.convexPolygon.pointContains( polygon, point );
console.log( 'Polygon contains point: ', contains );
/* log : Polygon contains point: true */
```

### Intuivtive

Рутини маю інтуїтивні назви. Вміння користуватись однією рутиною дозволяє використовути інші рутини однієї категорії змінюючи лише префікс та другий вхідний аргумент( фігуру )

Приклад використання групи рутин *Intersects для перевірки перетину фігури типу
"plane" із іншими фігурами.

```js
var plane = [ -2, 2, 0 ];
var box = [ 0, 0, 1, 1,];
var got = _.plane.boxIntersects( plane, box );
console.log( 'Plane intersects with box: ', got )
/* log : Plane intersects with box: true */
```

```js
var plane = [ -2, 2, 0 ];
var capsule = [ 2, 1, 2, 4, 1 ]
var got = _.plane.capsuleIntersects( plane, capsule );
console.log( 'Plane intersects with capsule: ', got )
/* log : Plane intersects with capsule: true */
```

```js
var plane = [ 1, 0, 0, 1 ];
var frustum = _.Matrix.make( [ 4, 6 ] ).copy
([
  0,   0,   0,   0,  -1,   1,
  1,  -1,   0,   0,   0,   0,
  0,   0,   1,  -1,   0,   0,
 -1,   0,  -1,   0,   0,  -1
]);
var got = _.plane.frustumIntersects( plane, frustum );
console.log( 'Plane intersects with frustum: ', got )
/* log : Plane intersects with frustum: false */
```

```js
var plane = [ -2, 2, 0 ];
var got = _.plane.planeIntersects( plane, plane );
console.log( 'Plane intersects with plane: ', got )
/* log : Plane intersects with plane: true */
```

```js
var plane = [ -2, 2, 0 ];
var line = [ 1, 1, -3, 3 ]
var got = _.plane.lineIntersects( plane, line );
console.log( 'Plane intersects with line: ', got )
/* log : Plane intersects with line: true */
```

```js
var plane = [ -2, 2, 0 ];
var segment = [ -2, -2, 2, 2 ]
var got = _.plane.segmentIntersects( plane, segment );
console.log( 'Plane intersects with segment: ', got )
/* log : Plane intersects with segment: true */
```

```js
var plane = [ -2, 2, 0 ];
var sphere = [ 0, 0, 1 ]
var got = _.plane.sphereIntersects( plane, sphere );
console.log( 'Plane intersects with sphere: ', got )
/* log : Plane intersects with sphere: true */
```

```js
var plane = [ -2, 2, 0 ];
var ray = [ 0, 0, 2, 2 ]
var got = _.plane.rayIntersects( plane, ray );
console.log( 'Plane intersects with ray: ', got )
/* log : Plane intersects with ray: true */
```

### Figures overview

  <!-- -- One sentence per figure + image -->

 [Повний огляд фігур](./FiguresOverview.md)

### Convention dst=null

Рутини, які очікують dst контейнер першим аргументом, можуть створювати новий інстанс фігури, для цього необхідно передати null в якості dst аргумента.

```js

var Point1 = [ 3, 1, 3 ];
var Point2 = [ 3, 8, 3 ];
var box = _.box.fromPoints( null, [ Point1, Point2 ] );
console.log( 'Box: ', box );
/* log : Box: [ 3, 1, 3, 3, 8, 3 ] */

```

### Higher dimension

Одна рутина може виконувати операції для фігур різної розмірності( якщо такий випадок є реалізованим )

```js
var sphere2d = [ 1, 1, 5 ];
var point2d = [ 2, 2 ];
var got = _.sphere.pointContains( sphere2d, point2d );
console.log( 'Sphere contains point: ', got )
/* log : Sphere contains point: true */
```

```js
var sphere3d = [ 2, 2, 2, 5 ];
var point3d = [ 3, 3, 3 ];
var got = _.sphere.pointContains( sphere3d, point3d );
console.log( 'Sphere contains point: ', got )
/* log : Sphere contains point: true */
```

```js
var sphere4d = [ 3, 3, 3, 3, 5 ];
var point4d = [ 4, 4, 4, 4 ];
var box = _.sphere.pointContains( sphere4d, point4d );
console.log( 'Sphere contains point: ', got )
/* log : Sphere contains point: true */
```

```js
var line = [ -4, 4, 0 ]; // -2,-2, 2, 2
var point = [ 3, 2 ];
let got = _.plane.pointDistance( line, point );
console.log( 'Distance from straight to point:', _.toStr( got, { precision : 2 } ) );
/* log: Distance from straight to point: -0.71*/
```

```js
var point = [ 4, 1, -3 ];
var plane = [ 2, -1, 3, 1 ];
let got = _.plane.pointDistance( plane, point );
console.log( 'Distance from 3D plane to point:', _.toStr( got, { precision : 2 } ) );
/* log: Distance from 3D plane to point: -0.27 */
```

### Alternative figures

Фігура може бути перетворена із однієї концептуальної форми в іншу.

Приклад перетворення фігури `linePoints` в `linePointDir` та обчислення точки перетину двох фігур.

```js
var linePoints1 = _.linePoints.from( [ 1, 1, 3, 3 ] );
var linePoints2 = _.linePoints.from( [ 2, 2, 3, 3 ] );
var point = _.linePoints.pairIntersectionPoint( linePoints1, linePoints2 );
console.log( 'Intersection point:', point.toString() );
/* log : Intersection point: 2,2 */

var linePointsDir1 = _.linePointDir.fromPoints2( linePoints1 );
var linePointsDir2 = _.linePointDir.fromPoints2( linePoints2 );
var point = _.linePointDir.lineIntersectionPoint( linePointsDir1, linePointsDir2 );
console.log( 'Intersection point:', point.toString() );
/* log : Intersection point: 2,2 */

```

Приклад передтворення між "Quat" та "Euler":

```js
var euler =  [ 1, 0, 0.5, 0, 1, 2 ] ;
console.log( 'Euler:', _.toStr( euler, { precision : 2 } ) )
/* log : Euler: [ 1.0, 0.0, 0.50, 0.0, 1.0, 2.0 ] */

var quat = _.euler.toQuat( euler, null );
console.log( 'Quat from Euler:', _.toStr( quat, { precision : 2 } ) )
/* log : Quat from Euler: [ 0.46, -0.12, 0.22, 0.85 ] */

var euler2 = _.quat.toEuler( quat, null );
console.log( 'Euler from Quat:', _.toStr( euler2, { precision : 2 } ) )
/* log : Euler from Quat: [ 1.0, 0.0, 0.50, 0.0, 1.0, 2.0 ] */
```


### Summary


[Back to content](../README.md#Tutorials)
