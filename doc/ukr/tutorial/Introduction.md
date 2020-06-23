# Introduction

Стаття описує основні особливості модуля та принципи його використання.

### Why?

### Creating models

Створення моделі із розмірністю визначеною за замовчуванням

```js
let sphere1 = _.sphere.make();
console.log( 'Sphere :', sphere1 );
/* log: Sphere : [ 0, 0, 0, 0 ] */
```

Сфера `sphere1` створеється із використанням розмірності визначеної за замовчуванням.
З виводу видно, що кількість елементів в контейнері сфефи `sphere1` відповідає розмірності `3`.


Створення моделі із довільною розмірністю.

```js
let sphere1 = _.sphere.make( 2 );
console.log( 'Sphere :', sphere1 );
/* log: Sphere : [ 0, 0, 0 ] */
```

Сфера `sphere1` створеється із розмірністю `2`.
З виводу видно, що кількість елементів в контейнері сфефи `sphere1` відповідає розмірності `2`.

### Make

Рутина `make` дозволяє створити нову моделейу.
моделейу можна створити на основі розмірності або вже існуючої моделі цього ж типу.
Якщо передано існуючу моделейу, то нова модель буде її копією.

Cтворення моделі `box` із розмірністю визначеною за замовчуванням.

```js
let box1 = _.box.make();
console.log( 'Box type :', _.strType( box1 ) );
/* log: Box type : Array */
console.log( 'Box :', box1 );
/* log: Box : [ 0, 0, 0, 0, 0, 0 ] */
```

Бокс `box1` створюється із використанням розмірності визначеної за замовчуванням.
З виводу видно, що кількість елементів в контейнері боксу `box1` відповідає розмірності `3`.

```js
let box1 = _.box.make( null );
console.log( 'Box type :', _.strType( box1 ) );
/* log: Box type : Array */
console.log( 'Box :', box1 );
/* log: Box : [ 0, 0, 0, 0, 0, 0 ] */
```

Бокс `box1` створюється із використанням аргумента `null`.
Такий виклик рівноцінний виклику без аргументів.
З виводу видно, що кількість елементів в контейнері боксу `box1` відповідає розмірності `3`.

Cтворення моделі `box` із заданою розмірністю.

```js
let dim = 2;
let box1 = _.box.make( dim );
console.log( 'Box type :', _.strType( box1 ) );
/* log: Box type : Array */
console.log( 'Box :', box1 );
/* log: Box : [ 0, 0, 0, 0 ] */
```

Бокс `box1` створюється із розмірністю `2`.
З виводу видно, що кількість елементів в контейнері боксу `box1` відповідає розмірності `2`.

Cтворення копії вже існуючої моделі тиру `box`.

```js
let srcBox = [ 0, 1, 2, 3 ];
let box1 = _.box.make( srcBox );
console.log( 'srcBox === box1 :', srcBox === box1 )
/* log: srcBox === box : false */
console.log( 'Box type :', _.strType( box1 ) );
/* log: Box type : Array */
console.log( 'Box :', box1 );
/* log: Box : [ 0, 1, 2, 3 ] */
```

Cтворюється бокс `box1` на основі розмірності та даних боксу `srcBox`.
З виводу видно, що було створено копію боксу `srcBox`.

### From

Рутина `from` перевіряє вхідні дані на відповідність концепції моделі.
Рутина створює нову моделейу лише за необхідності.

Приклад явного створення нової моделі типу `box`.

```js
let box1 = _.box.from( null );
console.log( 'Box type :', _.strType( box1 ) );
/* log: Box type : Array */
console.log( 'Box :', box1 );
/* log: Box : [ 0, 0, 0, 0, 0, 0 ] */
```

Бокс `box1` створюється із використанням аргумента `null`.
Такий виклик рівноцінний виклику `make` без аргументів.
З виводу видно, що кількість елементів в контейнері боксу `box1` відповідає розмірності `3`.

Приклад передавання готової моделі у вигляді вектор адаптера

```js
let srcBox = _.vad.fromLong([ 0, 1, 2, 3 ]);
let box = _.box.from( srcBox );
console.log( 'srcBox === box :', srcBox === box )
/* log: srcBox === box : true */
console.log( 'Box type :', _.strType( box ) );
/* log: Box type : VectorAdapterFromLong */
console.log( 'Box :', box.toStr() );
/* log: Box : VectorAdapter.x4.Array :: 0.000 1.000 2.000 3.000 */
```

Контейнер у вигляді вектор адаптера `srcBox` перевіряється на відповідність моделі типу `box`.
З виводу видно, що перевірка була успішною і вектор адаптер `srcBox` було повернено рутиною у вигляді результату.

Приклад передавання готової моделі у вигляді вектора

```js
let srcBox = new F32x([ 0, 1, 2, 3 ]);
let box = _.box.from( srcBox );
console.log( 'srcBox === box :', srcBox === box )
/* log: srcBox === box : true */
console.log( 'Box type :', _.strType( box ) );
/* log: Box type : F32x */
console.log( 'Box :', box );
/* log: Box : Float32Array(4) [ 0, 1, 2, 3 ] */
```

Контейнер у вигляді вектора `srcBox` перевіряється на відповідність моделі типу `box`.
З виводу видно, що перевірка була успішною і вектор `srcBox` було повернено рутиною у вигляді результату.

### Make vs From

Рутина `from` на відміну від `make` створює нову моделейу лише за явної необхідності.
Рутина `make` завжди створює нову моделейу.

Приклад створення нової моделі типу `box` обома рутинами

```js
let box1 = _.box.make( null );
console.log( 'Box1 :', box1 );
/* log: Box1 : [ 0, 0, 0, 0, 0, 0 ] */

let box2 = _.box.from( null );
console.log( 'Box2 :', box2 );
/* log: Box1 : [ 0, 0, 0, 0, 0, 0 ] */
```

Два виклики створюють нову модель типу `box` із розмірністю визначеною за замовчуванням, що випливає із виводу.

Приклад відмінності в обробці рутинами вже існуючої моделі

```js
let srcBox = [ 0, 1, 2, 3 ];

let box1 = _.box.make( srcBox );
console.log( 'srcBox === box1 :', srcBox === box1 )
/* log: srcBox === box1 : false */
console.log( 'Box1 :', box1 );
/* log: Box1 : [ 0, 1, 2, 3 ] */

let box2 = _.box.from( srcBox );
console.log( 'srcBox === box2 :', srcBox === box2 )
/* log: srcBox === box2 : true */
console.log( 'Box2 :', box2 );
/* log: Box2 : [ 0, 1, 2, 3 ] */

```

Викликом рутини `make` створюється нова модель основі даних боксу `srcBox`. Із виводу можна зробити висновок, що результатом є копія моделі `srcBox`.
Виклик рутини `from` повертає оригінальну модель боксу `srcBox`. Із виводу можна зробити висновок, що результат не є копією моделі `srcBox`.

### Keep flat, keep simple

"Плоский" формат представлення моделі означає те, що дані моделі зберігаються у одновимірному контейнері: масив, вектор, вектор адаптер.

Наступні приклади відносяться до двовимірної моделі типу `linePointDir` із даними: ```[ 1, 2, 3, 4 ]```

Візуалізація моделі та розміщення даних моделі в памяті процесу:

<img src="../../img/LinePointDir.png" />

Створення моделі типу `linePointDir` на основі даних:

```js
let line1 = _.linePointDir.make( [ 1, 2, 3, 4 ] );
console.log( 'Line:', line1 );
/* log: Line : [ 1, 2, 3, 4 ] */
```

В змінну `line1` повертається нова модель типу `linePointDir` створена на основі координат початкової точки `1,2`
та вектору напрямку `3,4`.


Приклад отримання даних моделі:

```js
let line = [ 1, 2, 3, 4 ];

//How to get origin point
let origin = _.linePointDir.originGet( line );
console.log( 'Origin:', origin.toStr() );
/* log: Origin : "1.000 2.000" */

//How to get direction vector
let direction = _.linePointDir.directionGet( line );
console.log( 'Direction:', direction.toStr() );
/* log: Origin : "3.000 4.000" */

```

В змінну `origin` повертається вектор адаптер із значеннями `1.000,2.000`, що відповідають координатам початкової точки.
В змінну `direction` повертається вектор адаптер із значеннями `3.000,4.000`, які є вектором напрямку.`


### Isomorphic

Поведінка рутин залишається незмінною при зміні типу моделі.

Наприклад, рутина ```pointContains``` завжди виконує лише перевірку чи модель містить точку.

```js
var point1 = [ 0, 1, 2 ];
var plane1 = [ 1, 2, -1, 0 ];
var contains = _.plane.pointContains( plane1, point1 );
console.log( 'Plane contains point:', contains );
/* log: Plane contains point: true */
```

В змінну `contains` повертається `true` так, як точка `point1` знаходиться в середині площини `plane1`

```js
var point1 = [ 0, 1 ];
var line1 = [ 0, 0, 0, 2 ];
var contains = _.linePointDir.pointContains( line1, point1 );
console.log( 'Line contains point:', contains );
/* log: Line contains point: true */
```

В змінну `contains` повертається `true` так, як точка `point1` знаходиться на лінії `line1`


```js
var point1 = [ 0, 1 ];
var vertices =
[
  1, 0, 0,
  0, 0, 1
];
var polygon1 = _.convexPolygon.make( vertices, 2 );
var contains = _.convexPolygon.pointContains( polygon1, point1 );
console.log( 'Polygon contains point:', contains );
/* log: Polygon contains point: true */
```

Створюється опуклий полігон `polygon1` із розміністю `2` на основі координат вершин із вектору `vertices`.
В змінну `contains` повертається `true` так, як точка `point1` відповідає одній із вершин полігону `polygon1`.


### Intuivtive

Рутини маю інтуїтивні назви. Вміння користуватись однією рутиною дозволяє використовути інші рутини однієї категорії змінюючи лише префікс та другий вхідний аргумент( моделейу )

Приклад використання групи рутин `*Intersects` для перевірки перетину моделі типу
"plane" із іншими модельми.

```js
var plane1 = [ 0, 2, 0, -2 ];
var box1 = [ 0, 0, 0, 2, 2, 2 ];
var got = _.plane.boxIntersects( plane1, box1 );
console.log( 'Plane intersects with box:', got )
/* log: Plane intersects with box: true */
```

В змінну `got` повертається `true` так, як площина `plane1` перетинає бокс `box1`.


```js
var plane1 = [ 1, 0, 0, 1 ];
var capsule1 = [ - 1, 2, 3, -1, 2, 3, 0  ]
var got = _.plane.capsuleIntersects( plane1, capsule1 );
console.log( 'Plane intersects with capsule:', got )
/* log: Plane intersects with capsule: true */
```

В змінну `got` повертається `true` так, як площина `plane1` перетинає капсулу `capsule1`.


```js
var plane1 = [ 1, 0, 0, -0.4 ];
var frustum1 = _.frustum.make().copy
([
  0,   0,   0,   0,  -1,   1,
  1,  -1,   0,   0,   0,   0,
  0,   0,   1,  -1,   0,   0,
 -1,   0,  -1,   0,   0,  -1
]);
console.log( 'Frustum type:', _.strType( frustum1 ) );
/* log: Frustum type: wMatrix */
var got = _.plane.frustumIntersects( plane1, frustum1 );
console.log( 'Plane intersects with frustum:', got )
/* log: Plane intersects with frustum: true */
```

Створюється піраміда огляду `frustum1` на основі координат її шести вершин.
Із виводу зрозуміло, що контейнером для наних піраміди є матриця.
В змінну `got` повертається `true` так, як площина `plane1` перетинає піраміду `frustum1`.


```js
var plane1 = [ 1, 0, 0, 1 ];
var got = _.plane.planeIntersects( plane1, plane1 );
console.log( 'Plane intersects with plane:', got )
/* log: Plane intersects with plane: true */
```

В змінну `got` повертається `true` так, як площина `plane1` перетинає сама себе.


```js
var plane1 = [ 1, 0, 0, 1 ];
var line1 = [ 1, 0, 1, 1, 1, 1 ]
var got = _.plane.lineIntersects( plane1, line1 );
console.log( 'Plane intersects with line:', got )
/* log: Plane intersects with line: true */
```

В змінну `got` повертається `true` так, як площина `plane1` перетинається лінією `line1`.

```js
var plane1 = [ 1, 0, 0, 1 ];
var segment1 = [ -2, -2, -2, 2, 2, 2 ]
var got = _.plane.segmentIntersects( plane1, segment1 );
console.log( 'Plane intersects with segment:', got )
/* log: Plane intersects with segment: true */
```

В змінну `got` повертається `true` так, як площина `plane1` перетинається із відрізком `segment1`.


```js
var plane1 = [ 0, 2, 0, 2 ];
var sphere1 = [ 0, 0, 0, 1.5 ];
var got = _.plane.sphereIntersects( plane1, sphere1 );
console.log( 'Plane intersects with sphere:', got )
/* log: Plane intersects with sphere: true */

```

В змінну `got` повертається `true` так, як площина `plane1` перетинається із сферою `sphere1`.

```js
var plane1 = [ - 1, 0, 0, 1 ];
var ray1 = [ 0, 0, 0, 1, 1, 1 ];
var got = _.plane.rayIntersects( plane1, ray1 );
console.log( 'Plane intersects with ray:', got )
/* log: Plane intersects with ray: true */
```

В змінну `got` повертається `true` так, як площина `plane1` перетинається із променем `ray1`.


### Convention dst=null

Рутини, які очікують dst контейнер першим аргументом, можуть створювати новий інстанс моделі, для цього необхідно передати null в якості dst аргумента.

```js

var Point1 = [ 3, 1 ];
var Point2 = [ 0, 8 ];
var box1 = _.box.fromPoints( null, [ Point1, Point2 ] );
console.log( 'Box:', box1 );
/* log: Box: [ 0, 1, 3, 8 ] */

```

Бокс `box1` створюється із точок `Point1` та `Point2`. З виводу видно, що `box1` містить точки
`Point1` та `Point2`.

Приклад використання існуючого dst контейнера для створення моделі типу `box`

```js

var Point1 = [ 3, 1 ];
var Point2 = [ 0, 8 ];
var dstBox = _.vad.make( 4 );
_.box.fromPoints( dstBox, [ Point1, Point2 ] );
console.log( 'Box:', dstBox.toStr() );
/* log: Box: VectorAdapter.x4.F32x :: 0.000 0.000 3.000 8.000 */

```

Створюється вектор адаптер `dstBox` для даних моделі типу `box` довжиною в чотири елементи.
Створюється бокс із точок `Point1` та `Point2`, дані точок записуються в кінцевий контейнер `dstBox`.
З виводу видно, що бокс `dstBox` містить координати точок `Point1` та `Point2`.

### Higher dimension

Одна рутина може виконувати операції для моделей різної розмірності( якщо такий випадок є реалізованим )

```js
var sphere2d = [ 1, 1, 5 ];
var point2d = [ 2, 2 ];
var got = _.sphere.pointContains( sphere2d, point2d );
console.log( 'Sphere contains point:', got )
/* log: Sphere contains point: true */
```

В змінну `got` повертається `true` так, як точка `point2d` знаходиться в середині сфери `sphere2d`.


```js
var sphere3d = [ 2, 2, 2, 5 ];
var point3d = [ 3, 3, 3 ];
var got = _.sphere.pointContains( sphere3d, point3d );
console.log( 'Sphere contains point:', got )
/* log: Sphere contains point: true */
```

В змінну `got` повертається `true` так, як точка `point3d` знаходиться в середині сфери `sphere3d`.


```js
var sphere4d = [ 3, 3, 3, 3, 5 ];
var point4d = [ 4, 4, 4, 4 ];
var box = _.sphere.pointContains( sphere4d, point4d );
console.log( 'Sphere contains point:', got )
/* log: Sphere contains point: true */

```

В змінну `got` повертається `true` так, як точка `point4d` знаходиться в середині сфери `sphere4d`.


Приклад визначення відстані між точкою та лінією представленою у вигляді даних неявної функції

```js
var line1 = [ -4, 4, 0 ];
var point1 = [ 3, 2 ];
let got = _.plane.pointDistance( line1, point1 );
console.log( 'Distance from straight to point:', _.toStr( got, { precision : 2 } ) );
/* log: Distance from straight to point: -0.71*/
```

В змінну `got` повертається відстань між точкою `point1` та лінією `line1`, яка відповідає значенню `-0.71`.

Приклад визначення відстані між точкою та площиною

```js
var point1 = [ 4, 1, -3 ];
var plane1 = [ 2, -1, 3, 1 ];
let got = _.plane.pointDistance( plane1, point1 );
console.log( 'Distance from 3D plane to point:', _.toStr( got, { precision : 2 } ) );
/* log: Distance from 3D plane to point: -0.27 */
```

В змінну `got` повертається відстань між площиною `plane1` та точкою `point1`, яка відповідає значенню `-0.27`.


### Alternative models

Модель може бути перетворена із однієї концептуальної форми в іншу.

Приклад перетворення моделі `linePoints` в `linePointDir` та обчислення точки перетину двох моделей.

```js
var linePoints1 = _.linePoints.from( [ 1, 1, 3, 3 ] );
var linePoints2 = _.linePoints.from( [ 2, 2, 3, 3 ] );
var point1 = _.linePoints.pairIntersectionPoint( linePoints1, linePoints2 );
console.log( 'Intersection point:', point1.toString() );
/* log: Intersection point: 2,2 */

var linePointsDir1 = _.linePointDir.fromPoints2( linePoints1 );
var linePointsDir2 = _.linePointDir.fromPoints2( linePoints2 );
var point2 = _.linePointDir.lineIntersectionPoint( linePointsDir1, linePointsDir2 );
console.log( 'Intersection point:', point2.toString() );
/* log: Intersection point: 2,2 */

```

Створюються дві лінії за двох точками `linePoints1` та `linePoints2` на основі координах переданих як вектори.
В змінну `point1` повертається ( 2,2 ), що є координатами точки перетину між двома лініями `linePoints1` та `linePoints2`.
Створюються дві лінії за точкою і вектором напрямку `linePointsDir1` та `linePointsDir1` на основі ліній `linePoints1` та `linePoints2`.
В змінну `point2` повертається ( 2,2 ), що є координатами точки перетину між двома лініями `linePoints1` та `linePoints2`.
З отриманого виводу зрозуміло що перетворення між двома концептуальними формами предвставлення лінії відбулось успішно.

Приклад передтворення між "Quat" та "Euler":

```js
var euler1 =  [ 1, 0, 0.5, 0, 1, 2 ] ;
console.log( 'Euler:', _.toStr( euler1, { precision : 2 } ) )
/* log: Euler: [ 1.0, 0.0, 0.50, 0.0, 1.0, 2.0 ] */

var quat1 = _.euler.toQuat( euler1, null );
console.log( 'Quat from Euler:', _.toStr( quat1, { precision : 2 } ) )
/* log: Quat from Euler: [ 0.46, -0.12, 0.22, 0.85 ] */

var euler2 = _.quat.toEuler( quat1, null );
console.log( 'Euler from Quat:', _.toStr( euler2, { precision : 2 } ) )
/* log: Euler from Quat: [ 1.0, 0.0, 0.50, 0.0, 1.0, 2.0 ] */
```

Створюється контейнер із даними про кути Еулера `euler1`.
В змінну `quat1` записується кватерніон, який є результатом перетворення із кутів Еулера `euler1`
В змінну `euler2` записується значення кутів Еулера, які є результатом перетворення кватерніону `quat1` в кути Еулера.
Вивід підтверджує, що перетворенням між кутами Еулера та кватерніоном відбулось успішно.

### Models overview

Повний перелік математичних моделей доступних в цьому модулі [тут.](./Overview.md)

### Summary

[Back to content](../README.md#Tutorials)
