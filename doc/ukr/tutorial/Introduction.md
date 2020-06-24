# Introduction

Стаття описує основні особливості модуля та принципи його використання.

### Why?

### Математична модель

Формальний опис системи за допомогою математичних концепцій та мови.

### Making an instance

Кожна модель має визначену пару рутин `make` та `from`  для створення її екземаляра. При спробі створити екземпляр без аргументів буде створено екземпляр із параметрами за замовчуванням. Також кожна модель визначає рутину `is` котра дає відповідь на питання: "чи дана сутність є екземпляром даної моделі".

### Routine make

Рутина `make` дозволяє створити екземпляр моделі. Новий екземпляр можливо створити на основі розмірності або іншого екземпляра. Якщо в якості аргумента використано екземпляр існуюючої моделі, то новий екземпляр буде копією оригінального екземпляра.

Cтворення екземпляра моделі `box` із розмірністю визначеною за замовчуванням:

```js
var box = _.box.make();
console.log( `Type : ${ _.strType( box ) }` );
/* log : Type : Array */
console.log( box );
/* log : [ 0, 0, 0, 0, 0, 0 ] */
```

Бокс `box` знаходиться в `3D` просторі. 3 перших скаляри вектора `box` описують одну крайню точку тоді як 3 останніх скаляри описують іншу крайню точку. Це є параметрами моделі бокс за замовучанням.

Кожна модель реалізує рутину `make` та визначає аргументи за замовчуванням для того щоб можливо було створити екземпляр викликом без аргументів.

Викликавши рутину `make` із скаляром можливо задати розмірність.

```js
var dim = 2;
var box = _.box.make( dim );
console.log( `Type : ${ _.strType( box ) }` );
/* log : Type : Array */
console.log( box );
/* log : [ 0, 0, 0, 0 ] */
```

Бокс `box` створюється в 2D просторі на відміну від попереднього приклада, вектор має лише 4 скаляри - по 2 на кожну вершину.

Для створення за зразком передайте в рутину `make` зразок.

```js
var srcBox = [ 0, 1, 2, 3 ];
var box = _.box.make( srcBox );
console.log( `srcBox === box : ${ srcBox === box }` );
/* log : srcBox === box : false */
console.log( `Type : ${ _.strType( box ) }` );
/* log : Type : Array */
console.log( box );
/* log : [ 0, 1, 2, 3 ] */
```

Розмірність та всі дані `box` такі ж як в `srcBox`.

Створення за зразком за замовчуванням:

```js
var box = _.box.make( null );
console.log( `Type : ${ _.strType( box ) }` );
/* log : Type : Array */
console.log( box );
/* log : [ 0, 1, 2, 3 ] */
```

Семантика така ж як в прикладі із викликом без аргументів. Прагматика дещо інша: в якості зразка використовується уявний екземпляр із даними за замовчуванням.

### Routine from

Альтернативним способом створити екземпляр метематичної моделі є використання рутини `from`.
Рутина `from` так само, як і `make` конструює новий екземпляр, але на відміну від рутини `make` ще робить додаткову перевірку. Рутина `from` створює новий екземпляр лише якщо аргументом виклику є не екземпляр даної моделі. Якщо ж на вхід рутини `from` передається екземпляр даної моделі тоді він же повертається без жодних змін.

Створимо екземпляр моделі бокс вручну і передамо її на вхід рутини `from`:

```js
var srcBox = new F32x([ 0, 1, 2, 3 ]);
var box = _.box.from( srcBox );
console.log( `srcBox === box : ${ srcBox === box }` );
/* log : srcBox === box : true */
console.log( `Type : ${ _.strType( box ) }` );
/* log : Type : F32x */
console.log( box );
/* log : Float32Array(4) [ 0, 1, 2, 3 ] */
```

<!-- ... xxx ... -->

Контейнер у вигляді вектора `srcBox` перевіряється на відповідність моделі типу `box`.
З виводу видно, що перевірка була успішною і вектор `srcBox` було повернено рутиною у вигляді результату.

Приклад передавання готової моделі у вигляді вектор адаптера

```js
var srcBox = _.vectorAdapter.fromLong([ 0, 1, 2, 3 ]);
var box = _.box.from( srcBox );
console.log( `srcBox === box : ${ srcBox === box }` );
/* log : srcBox === box : true */
console.log( `Type : ${ _.strType( box ) }` );
/* log : Type : VectorAdapterFromLong */
console.log( box );
/* log : VectorAdapter.x4.Array :: 0.000 1.000 2.000 3.000 */
```

Контейнер у вигляді вектор адаптера `srcBox` перевіряється на відповідність моделі типу `box`.
З виводу видно, що перевірка була успішною і вектор адаптер `srcBox` було повернено рутиною у вигляді результату.

Приклад явного створення нової моделі типу `box`.

```js
var box = _.box.from( null );
console.log( `Type : ${ _.strType( box ) }` );
/* log : Type : Array */
console.log( box );
/* log : [ 0, 0, 0, 0, 0, 0 ] */
```

Бокс `box1` створюється із використанням аргумента `null`.
Такий виклик рівноцінний виклику `make` без аргументів.
З виводу видно, що кількість елементів в контейнері боксу `box1` відповідає розмірності `3`.

### Make vs From

Рутина `from` на відміну від `make` створює новий екземпляр моделі лише за явної необхідності.

Рутина `make` завжди створює новий екземпляр моделі.

Приклад створення нового екземпляру моделі типу `box` обома рутинами

```js
var box1 = _.box.make( null );
console.log( `Box1 : ${ box1 }` );
/* log : Box1 : [ 0, 0, 0, 0, 0, 0 ] */

var box2 = _.box.from( null );
console.log( `Box2 : ${ box2 }` );
/* log : Box2 : [ 0, 0, 0, 0, 0, 0 ] */
```

Два виклики створюють новий екземпляр моделі типу `box` із розмірністю визначеною за замовчуванням, що випливає із виводу.

Приклад відмінності в обробці рутинами вже існуючого екземпляра моделі.

```js
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

```

Викликом рутини `make` створюється новий екземпляр моделі на основі даних боксу `srcBox`. Із виводу можливо зробити висновок, що результатом є копія моделі `srcBox`.

Виклик рутини `from` повертає оригінальний екземпляр моделі боксу `srcBox`. Із виводу можна зробити висновок, що було повернуто оринінальний екземпляр моделі `srcBox`.

### Uncoupling data and functionality

Екземпляри всіх математичних моделей реалізованих в даному модулі містять дані в форматі матриці або вектора, а увесь функціонал прив'язаний до неймспейсу даної математичної моделі.

"Плоский" формат представлення моделі означає те, що дані моделі зберігаються у одновимірному контейнері: масиві, векторі, вектор адаптері.

Наступні приклади відносяться до двовимірної моделі типу `linePointDir` із даними: `[ 1, 2, 3, 4 ]`

Візуалізація моделі та розміщення даних моделі в памяті процесу:

![LinePointDir](../../img/LinePointDir.png)

Створення моделі типу `linePointDir` на основі даних:

```js
var line = _.linePointDir.make([ 1, 2, 3, 4 ]);
console.log( `Line : ${ line }` );
/* log : Line : [ 1, 2, 3, 4 ] */
```

Змінна `line` створена на основі координат початкової точки `1,2` та вектору напрямку `3,4`.

Приклад отримання даних моделі:

```js
var line = [ 1, 2, 3, 4 ];

//How to get origin point
var origin = _.linePointDir.originGet( line );
console.log( `Origin : ${ origin }` );
/* log : Origin : VectorAdapter.x2.Array :: 1.000 2.000 */

//How to get direction vector
var direction = _.linePointDir.directionGet( line );
console.log( `Direction : ${ direction }` );
/* log : Direction : VectorAdapter.x2.Array :: 3.000 4.000 */
```

В змінну `origin` повертається вектор адаптер із значеннями `1.000,2.000`, що відповідають координатам початкової точки.

В змінну `direction` повертається вектор адаптер із значеннями `3.000,4.000`, які є вектором напрямку.

### Isomorphic

Поведінка рутин залишається незмінною при зміні типу моделі.

Наприклад, рутина `pointContains` завжди виконує лише перевірку чи екземпляр моделі містить точку.

```js
var point = [ 0, 1, 2 ];
var plane = [ 1, 2, -1, 0 ];
var contains = _.plane.pointContains( plane, point );
console.log( `Plane contains point : ${ contains }` );
/* log : Plane contains point: true */
```

В змінну `contains` повертається `true` так, як точка `point` знаходиться на площині `plane`.

```js
var point = [ 0, 1 ];
var line = [ 0, 0, 0, 2 ];
var contains = _.linePointDir.pointContains( line, point );
console.log( `Line contains point : ${ contains }` );
/* log : Line contains point: true */
```

В змінну `contains` повертається `true` так, як точка `point` знаходиться на лінії `line`.


```js
var point = [ 0, 1 ];
var vertices =
[
  1, 0, 0,
  0, 0, 1
];
var polygon = _.convexPolygon.make( vertices, 2 );
var contains = _.convexPolygon.pointContains( polygon, point );
console.log( `Polygon contains point : ${ contains }` );
/* log : Polygon contains point: true */
```

Створюється опуклий полігон `polygon` із розміністю `2` на основі координат вершин із вектору `vertices`.
В змінну `contains` повертається `true` так, як точка `point` та третя вершина полігону `polygon1` мають однакові координати.


### Intuitive

Рутини маю інтуiтивні назви. Вміння користуватись однією рутиною дозволяє використовути інші рутини однієї категорії змінюючи лише префікс та другий вхідний аргумент ( екземпляр моделі ).

Приклад використання групи рутин `*Intersects` для перевірки перетину екземпляра моделі типу `plane` із екземплярами інших моделей.

```js
var plane = [ 0, 2, 0, -2 ];
var box = [ 0, 0, 0, 2, 2, 2 ];
var intersected = _.plane.boxIntersects( plane, box );
console.log( `Plane intersects with box : ${ intersected }` );
/* log : Plane intersects with box: true */
```

В змінну `intersected` повертається `true` так, як площина `plane` перетинає бокс `box`.


```js
var plane = [ 1, 0, 0, 1 ];
var capsule = [ - 1, 2, 3, -1, 2, 3, 0  ];
var intersected = _.plane.capsuleIntersects( plane, capsule );
console.log( `Plane intersects with capsule : ${ intersected }` );
/* log : Plane intersects with capsule: true */
```

В змінну `intersected` повертається `true` так, як площина `plane` перетинає капсулу `capsule`.


```js
var plane = [ 1, 0, 0, -0.4 ];
var frustum = _.frustum.make().copy
([
  0,   0,   0,   0,  -1,   1,
  1,  -1,   0,   0,   0,   0,
  0,   0,   1,  -1,   0,   0,
 -1,   0,  -1,   0,   0,  -1
]);
console.log( `Frustum type : ${ _.strType( frustum ) }` );
/* log : Frustum type : wMatrix */
var intersected = _.plane.frustumIntersects( plane, frustum );
console.log( `Plane intersects with frustum : ${ intersected }` );
/* log : Plane intersects with frustum : true */
```

Створюється екземпляр `frustum` моделі типу `frustum` на основі координат її шести вершин.
Із виводу зрозуміло, що контейнером для даних екземпляра моделі є матриця.
В змінну `intersected` повертається `true` так, як площина `plane` перетинає піраміду `frustum`.


```js
var plane = [ 1, 0, 0, 1 ];
var intersected = _.plane.planeIntersects( plane, plane );
console.log( `Plane intersects with plane : ${ intersected }` );
/* log : Plane intersects with plane : true */
```

В змінну `intersected` повертається `true` так, як площина `plane` перетинає сама себе.


```js
var plane = [ 1, 0, 0, 1 ];
var line = [ 1, 0, 1, 1, 1, 1 ];
var intersected = _.plane.lineIntersects( plane, line );
console.log( `Plane intersects with line : ${ intersected }` );
/* log : Plane intersects with line : true */
```

В змінну `intersected` повертається `true` так, як площина `plane` перетинається лінією `line`.

```js
var plane = [ 1, 0, 0, 1 ];
var segment = [ -2, -2, -2, 2, 2, 2 ];
var intersected = _.plane.segmentIntersects( plane, segment );
console.log( `Plane intersects with segment : ${ intersected }` );
/* log : Plane intersects with segment : true */
```

В змінну `intersected` повертається `true` так, як площина `plane` перетинається із відрізком `segment`.


```js
var plane = [ 0, 2, 0, 2 ];
var sphere = [ 0, 0, 0, 1.5 ];
var intersected = _.plane.sphereIntersects( plane, sphere );
console.log( `Plane intersects with sphere : ${ intersected }` );
/* log : Plane intersects with sphere : true */

```

В змінну `intersected` повертається `true` так, як площина `plane` перетинається із сферою `sphere`.

```js
var plane = [ - 1, 0, 0, 1 ];
var ray = [ 0, 0, 0, 1, 1, 1 ];
var intersected = _.plane.rayIntersects( plane, ray );
console.log( `Plane intersects with ray : ${ intersected }` );
/* log : Plane intersects with ray: true */
```

В змінну `intersected` повертається `true` так, як площина `plane` перетинається із променем `ray`.


### Convention dst=null

Рутини, які очікують `dst` контейнер першим аргументом, можуть створювати новий інстанс моделі, для цього необхідно передати `null` в якості `dst` аргумента.

```js
var point1 = [ 3, 1 ];
var point2 = [ 0, 8 ];
var box = _.box.fromPoints( null, [ point1, point2 ] );
console.log( `Box : ${ box }` );
/* log : Box : [ 0, 1, 3, 8 ] */
```

Екземпляр `box` моделі типу `box` створюється із точок `point1` та `point2`. З виводу видно, що `box` містить точки
`point1` та `point2`.

Приклад використання існуючого `dst` контейнера для створення екземпляра моделі типу `box`

```js
var point1 = [ 3, 1 ];
var point2 = [ 0, 8 ];
var dstBox = _.vectorAdapter.make( 4 );
_.box.fromPoints( dstBox, [ point1, point2 ] );
console.log( `Box : ${ dstBox }` );
/* log : Box : VectorAdapter.x4.F32x :: 0.000 0.000 3.000 8.000 */
```

Створюється вектор адаптер `dstBox` для даних екземпляра моделі типу `box` довжиною в чотири елементи.
Створюється екземпляр моделі типу `box` із точок `point1` та `point2`, дані точок записуються в кінцевий контейнер `dstBox`.
З виводу видно, що бокс `dstBox` містить координати точок `point1` та `point2`.

### Higher dimension

Одна рутина може виконувати операції для екземплярів моделей різної розмірності ( якщо такий випадок реалізований )

```js
var sphere2d = [ 1, 1, 5 ];
var point2d = [ 2, 2 ];
var contains = _.sphere.pointContains( sphere2d, point2d );
console.log( `Sphere contains point : ${ contains }` );
/* log : Sphere contains point : true */
```

В змінну `contains` повертається `true` так, як точка `point2d` знаходиться в середині сфери `sphere2d`.


```js
var sphere3d = [ 2, 2, 2, 5 ];
var point3d = [ 3, 3, 3 ];
var contains = _.sphere.pointContains( sphere3d, point3d );
console.log( `Sphere contains point : ${ contains }` );
/* log : Sphere contains point : true */
```

В змінну `contains` повертається `true` так, як точка `point3d` знаходиться в середині сфери `sphere3d`.


```js
var sphere4d = [ 3, 3, 3, 3, 5 ];
var point4d = [ 4, 4, 4, 4 ];
var contains = _.sphere.pointContains( sphere4d, point4d );
console.log( `Sphere contains point : ${ contains }` );
/* log : Sphere contains point: true */
```

В змінну `contains` повертається `true` так, як точка `point4d` знаходиться в середині сфери `sphere4d`.

Приклад визначення відстані між точкою та лінією представленою у вигляді даних неявної функції

```js
var point = [ 3, 2 ];
var line = [ -4, 4, 0 ];
var distance = _.plane.pointDistance( line, point );
console.log( `Distance from straight to point : ${ _.toStr( distance, { precision : 2 } ) }` );
/* log : Distance from straight to point: -0.71*/
```

В змінну `distance` повертається відстань між точкою `point` та лінією `line`, яка відповідає значенню `-0.71`.

Приклад визначення відстані між точкою та площиною

```js
var point = [ 4, 1, -3 ];
var plane = [ 2, -1, 3, 1 ];
var distance = _.plane.pointDistance( plane, point );
console.log( `Distance from 3D plane to point : ${ _.toStr( distance, { precision : 2 } ) }` );
/* log : Distance from 3D plane to point : -0.27 */
```

В змінну `distance` повертається відстань між площиною `plane` та точкою `point`, яка відповідає значенню `-0.27`.


### Alternative models

Екземпляр моделі може бути перетворений із однієї концептуальної форми в іншу.

Приклад перетворення екземпляра моделі `linePoints` в екземпляр моделі `linePointDir` та обчислення точки їх перетину.

```js
var linePoints1 = _.linePoints.from( [ 1, 1, 3, 3 ] );
var linePoints2 = _.linePoints.from( [ 2, 2, 3, 3 ] );
var point1 = _.linePoints.pairIntersectionPoint( linePoints1, linePoints2 );
console.log( `Intersection point : ${ point1 }` );
/* log : Intersection point : [ 2, 2 ] */

var linePointsDir1 = _.linePointDir.fromPoints2( linePoints1 );
var linePointsDir2 = _.linePointDir.fromPoints2( linePoints2 );
var point2 = _.linePointDir.lineIntersectionPoint( linePointsDir1, linePointsDir2 );
console.log( `Intersection point : ${ point2 }` );
/* log : Intersection point: [ 2, 2 ] */

```

Створюються дві лінії за двох точками `linePoints1` та `linePoints2` на основі координат переданих як вектори.
В змінну `point1` повертається ( 2,2 ), що є координатами точки перетину між двома лініями `linePoints1` та `linePoints2`.
Створюються дві лінії за точкою і вектором напрямку `linePointsDir1` та `linePointsDir1` на основі ліній `linePoints1` та `linePoints2`.
В змінну `point2` повертається ( 2,2 ), що є координатами точки перетину між двома лініями `linePointsDir1` та `linePointsDir2`.
З отриманого виводу зрозуміло що перетворення між двома концептуальними формами представлення лінії відбулось успішно.

Приклад перетворення між "Quat" та "Euler":

```js
var euler1 =  [ 1, 0, 0.5, 0, 1, 2 ] ;
console.log( 'Euler:', _.toStr( euler1, { precision : 2 } ) )
/* log : Euler: [ 1.0, 0.0, 0.50, 0.0, 1.0, 2.0 ] */

var quat1 = _.euler.toQuat( euler1, null );
console.log( 'Quat from Euler:', _.toStr( quat1, { precision : 2 } ) )
/* log : Quat from Euler: [ 0.46, -0.12, 0.22, 0.85 ] */

var euler2 = _.quat.toEuler( quat1, null );
console.log( 'Euler from Quat:', _.toStr( euler2, { precision : 2 } ) )
/* log : Euler from Quat: [ 1.0, 0.0, 0.50, 0.0, 1.0, 2.0 ] */
```

Створюється контейнер із даними про кути Еулера `euler1`.
В змінну `quat1` записується кватерніон, який є результатом перетворення із кутів Еулера `euler1`
В змінну `euler2` записується значення кутів Еулера, які є результатом перетворення кватерніону `quat1` в кути Еулера.
Вивід підтверджує, що перетворенням між кутами Еулера та кватерніоном відбулось успішно.

### Models overview

Повний перелік математичних моделей доступних в цьому модулі [тут.](./Overview.md)

### Summary

[Back to content](../README.md#Tutorials)
