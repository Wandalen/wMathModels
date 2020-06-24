# Математична модель

Формальний опис системи за допомогою математичних концепцій та мови.
<!-- Formal description of a system using mathematical concepts and language. -->

### Box

Математична модель паралелепіпеда. Має вигляд вектора, котрий позначає головну діагональ.

```js
var box = [ 2, 1, 9, 5 ];
var point = [ 6, 8 ];
var got = _.box.pointDistance( box, point );
console.log( 'Distance from box to point : ', _.toStr( got, { precision : 2 } ) );
/* log : Distance from box to point : 3.0 */
```

![Box.png](../../img/Box.png)

При використанні двомірних координат паралелепіпед вироджується до прямокутника. На рисунку зображено прямокутник утворений двома точками `lbPoint` ( 2; 1 ) i `rtPoint` ( 9; 5 ), що відповідно позначають ліву нижню і праву верхню точки прямокутника.

### Segment

Математична модель відрізка. Має вигляд вектора з координатами двох точок.

```js
var segment = [ 2, 1, 9, 4 ];
var point = [ 3, 5 ];
var distance = _.segment.pointDistance( segment, point );
console.log( 'Distance from segment to point:', _.toStr( distance, { precision : 2 } ) );
/* log: Distance from segment to point: 1.4 */
```

![Segment.png](../../img/Segment.png)

Приведений відрізок має координати `point1` ( 2; 1 ) і `point2` ( 9; 4 ). Якщо додати третю коодинату, сегмент буде побудовано в просторових координатах.

### Capsule

Математична модель відрізка, котрий має товщину.

```js
var capsule = [ 2, 1, 9, 4, 0.5 ];
var point = [ 3, 5 ];
var distance = _.capsule.pointDistance( capsule, point );
console.log( 'Distance from capsule to point:', distance );
/* log: Distance from capsule to point: 1 */
```

![Capsule.png](../../img/Capsule.png)

Капсула як і сегмент має дві точки що позначають початок і кінець, а також має товщину та заокруглення з радіусом рівному половині товщини. Приведений рисунок показує капсулу, що має радіус `radius` рівним `0.5`.

### Sphere

Математична модель сфери. Має вигляд вектора з координатами центра сфери і радіуса.

```js
var sphere = [ 2, 1, 3 ];
var point = [ 5, 6 ];
var distance = _.sphere.pointDistance( sphere, point );
console.log( 'Distance from sphere to point:', _.toStr( distance, { precision : 2 } ) );
/* log: Distance from sphere to point: 0.41 */
```

![Sphere.png](../../img/Sphere.png)

При використанні двомірних координат сфера вироджується до круга. На рисунку зображено круг з центром `center` ( 2; 1 ) та радіусом `radius` рівним `3`.

### Ray

Математична модель променя. Перша точка позначає початок променя, друга - задає напрям.

```js
var ray = [ 2, 1, 6, 3 ];
var point = [ 2, 3 ];
var distance = _.ray.pointDistance( ray, point );
console.log( 'Distance from ray to point:', _.toStr( distance, { precision : 2 } ) );
/* log: Distance from ray to point: 0.71 */
```

![Ray.png](../../img/Ray.png)

Промінь зображений на рисунку має координати точок `point1` ( 2; 1 ) і `point2` ( 6; 3 ). Перша точка позначає його початок, а друга дозволяє побудувати напрям променя.

### LinePointDir

Математична модель лінії. Перша точка позначає початкові координати, а друга - зміщення відносно першої.

```js
var line = [ 2, 1, 2, 1 ];
var point = [ 2, 2 ];
var distance = _.linePointDir.pointDistance( line, point );
console.log( 'Distance from line by point and direction to point:', distance );
/* log: Distance from line by point and direction to point: 0.8 */
```

![LinePointDir.png](../../img/LinePointDir1.png)

Відмінність лінії від променя в тому, що лінія не обмежена і може безкінечно продовжуватись в обох напрямах.
Лінія побудована з допомогою `linePointDir` використовує першу точку `origin` ( 2; 1 ), як точку відліку, координати наступної точки `dirPoint` ( 4; 2 ) вираховуються шляхом складання відповідних координат в векторі.

### LinePoints

Математична модель лінії. Має вигляд вектора, що містить координати двох точок.

```js
var ray = [ 2, 1, 4, 2 ];
var factor = 0.25;
var pair = _.linePoints.pairAt( ray,factor );
console.log( 'Pair at factor 0.25 : ', pair.toStr() );
/* log: Pair at factor 0.25: 2.000 2.000*/
```

![LinePoints.png](../../img/LinePoints.png)

Для побудови лінії за двома точками використовується неймспейс `linePoints`. На рисунку зображено лінію що проходить через точки `point1` ( 2; 1 ) і `point2` ( 4; 2 ).

### LinePointCentered

Математична модель лінії, котра проходить через початок координат і задану точку в просторі.

```js
var line = [ 4, 2 ];
var point = [ 3, 4 ];
var distance = _.linePointCentered.pointDistanceCentered2D( line, point );
console.log( 'Distance from centered line to point:', _.toStr( distance, { precision : 2 } ) );
/* log: Distance from centered line to point: 0.71 */
```

![LinePointCentered.png](../../img/LinePointCentered.png)

Для побудови лінії котра проходить через початок координат простіше викоритовувати рутини неймспейса `linePointCentered`. На рисунку лінія задана лише координатою однієї точки `point` ( 4; 2 ).

### Plane ( implicit )

Математична модель площини. Має вигляд вектора, котрий містить коефіцієнти для неявного рівняння площини.

```js
var line = [ -4, 4, 0 ]; // -2,-2, 2, 2
var point = [ 3, 2 ];
var distance = _.plane.pointDistance( line, point );
console.log( 'Distance from straight to point:', _.toStr( distance, { precision : 2 } ) );
/* log: Distance from straight to point: -0.71*/
```

![LineImplicit.png](../../img/LineImplicit.png)

При використанні лише трьох координат рутини оперують лінією заданою через коєфіцієнти рівняння. Перше число `w` `-2` - константа, а інші вираховуються щоб забезпечити рівність. На зображеній лінії коефіцієнт `a` має значення `1`, а `b` - `2`.

```js
var point = [ 4, 1, -3 ];
var plane = [ 2, -1, 3, 1 ];
var distance = _.plane.pointDistance( plane, point );
console.log( 'Distance from 3D plane to point:', _.toStr( distance, { precision : 2 } ) );
/* log: Distance from 3D plane to point: -0.27 */
```

![Plane.png](../../img/Plane.png)

Якщо одна із чотирьох координат рівна нулю, рутини оперують математичною моделлю площини. Відповідно зображена площина паралельна осі `z` і з приведеного ракурсу вироджується в лінію як на рисунку з лінією.

### Triangle

Математична модель трикутника. Має вигляд вектора координат трьох вершин.

```js
var triangle = [ 2, 1, 9, 2, 5, 6 ];
var point = [ 4, 2 ]
var distance = _.triangle.pointDistance( triangle, point );
console.log( 'Distance from triangle to point:', _.toStr( distance, { precision : 2 } ) );
/* log: Distance from triangle to point: 1.1 */
```

![Triangle.png](../../img/Triangle.png)

На рисунку зображено трикутник з точками `point1` ( 2; 1 ), `point2` ( 9; 2 ) i `point3` ( 5; 6 ).

### ConvexPolygon

Математична модель опулого полігону. Має вигляд матриці координат вершин полігона.

```js
var vertices =
[
  2,  6,  9,  5,
  1, -1,  2,  6
]
var polygon = _.convexPolygon.make( vertices, 2 );
var point = [ 3, 6 ];
var distance = _.convexPolygon.pointDistance( polygon, point );
console.log( 'Distance from convex polygon to point:', distance );
/* log: Distance from convex polygon to point: 1*/
```

![ConvexPolygon.png](../../img/ConvexPolygon.png)

Зображений полігон є випуклим бо жоден з кутів утворених вершинами `point1` ( 2; 1 ), `point2` ( 6; -1 ), `point3` ( 9, 2 ) і `point4` ( 5; 6 ) не більше ніж 180 градусів.

### ConcavePolygon

Математична модель впуклого полігону. Має вигляд матриці координат вершин полігона.

```js
var vertices =
[
  2, 1, 3, 5, 4,
  1, 5, 3, 5, 1
]
var polygon = _.concavePolygon.make( vertices, 2 );
var point = [ 3, 4 ]
var distance = _.concavePolygon.pointDistance( polygon, point );
console.log( 'Distance from concave polygon to point:', _.toStr( distance, { precision : 2 } ) );
/* log: Distance from concave polygon to point: 0.71 */
```

![ConcavePolygon.png](../../img/ConcavePolygon.png)

Зображений полігон є впуклим бо кут утворений вершинами `point1` ( 2; 1 ), `point2` ( 6; 3 ), `point3` ( 9, 2 ) більше ніж 180 градусів. Будь-який впуклий полігон може бути розділений на декілька опуклих. Так, приведений полігон може бути розділений на 2 трикутни полігона за віссю `point2` i `point4`.

### Frustum

Математична модель фрустума. Має вигляд матриці площин.

```js
var frustum = _.frustum.make().copy
([
  0,   0,   0,   0,  -1,   1,
  1,  -1,   0,   0,   0,   0,
  0,   0,   1,  -1,   0,   0,
 -1,   0,  -1,   0,   0,  -1
]);
var point = [ 1, 1, 2 ]
var distance = _.frustum.pointDistance( frustum, point );
console.log( 'Distance from frustum to point:', distance );
/* log: Distance from frustum to point: 1 */
```

![Frustum.png](../../img/Frustum.png)

Приведене зображення фрустума показує, що для утворення фігури необхідно задати шість площин. Зі збільшенням відстані від точки спостереження збільшується площа перетину утвореної фігури.

### AxisAndAngle

Задає поворот об'єкта за заданою віссю обертання і кутом повороту.

```js
var axisAndAngle = [ 1, 0, 0, Math.PI / 4 ];
var euler = _.euler.fromAxisAndAngle2( euler, axisAndAngle );
console.log( 'AxisAndAngle to Euler:', _.toStr( euler, { precision : 2 } ) )
/* log: AxisAndAngle to Euler: [ 0.79, 0.0, -0.0, 0.0, 1.0, 2.0 ] */
```

![AxisAndAngle.png](../../img/AxisAndAngle.png)

При використанні повороту за віссю і кутом в переданому векторі позначається вісь відносно якої відбудеться поворот і кут. Відповідно, заданий вектор зображає поворот відносно осі `x` на 45 градусів.

### Euler

Задає поворот об'єкта за вектором утвореним кутами повороту і порядком здійснення поворотів.

```js
var euler = [ Math.PI/4, 0, 0, 0, 1, 2 ];
var quat = _.euler.toQuat( euler, null );
console.log( 'Quat from Euler:', _.toStr( quat, { precision : 2 } ) )
/* log : Quat from Euler: [ 0.38, 0.0, 0.0, 0.92 ] */
```

![Euler.png](../../img/Euler.png)

Для повороту з допомогою кутів ейлера необхідно позначити кути поворотів відносно осей `x`, `y` i `z` та порядок цих поворотів. Вектор `[ Math.PI/4, 0, 0, 0, 1, 2 ]` показує що здійснюється поворот лише за віссю `x` на 45 градусів.

### Quat

Задає поворот об'єкта використовуючи кватерніони.

```js
var quat = [ 0.38, 0.0, 0.0, 0.92 ]
var euler = _.quat.toEuler( quat, null )
console.log( 'Quat from Euler:', _.toStr( euler, { precision : 2 } ) )
/* log : Euler from Quat: [ 0.78, 0.0, -0.0, 0.0, 1.0, 2.0 ] */
```

![Quat.png](../../img/Quat.png)

Для повороту з допомогою кватерніона в векторі спочатку передається дійсна частина кватерніона, що визначає поворот, а наступними елементами задається вісь повороту. На приведеному рисунку здійснюється поворот відносно осі `x` на 45 градусів.
