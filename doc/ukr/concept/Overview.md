# Математична модель

Формальний опис системи за допомогою математичних концепцій та мови.
<!-- Formal description of a system using mathematical concepts and language. -->

### Box


Математична модель n-ортотопа, або інакше гіпер-прямокутинака або бокса. <!-- Mathematical model of n-orthotope, also called a hyperrectangle or a box. -->

```js
var box = [ 2, 1, 9, 5 ];
var point = [ 6, 8 ];
var got = _.box.pointDistance( box, point );
console.log( `Distance from box to point : ${ _.toStr( got, { precision : 2 } ) }` );
/* log : Distance from box to point : 3.0 */
```

![Box](../../img/Box.png)

В 2D бокс має вигляд прямокутника. Ліва нижня і права верхня точки цього прямокутника використовуються для опису цієї математичної моделі. Для опису бокса в 2D випадку достатньо 4-х скялярів.

### Segment

Математична модель відрізка.

```js
var segment = [ 2, 1, 9, 4 ];
var point = [ 3, 5 ];
var distance = _.segment.pointDistance( segment, point );
console.log( `Distance from segment to point : ${ _.toStr( distance, { precision : 2 } ) }` );
/* log : Distance from segment to point : 3.3 */
```

![Segment](../../img/Segment.png)

Задається двома точками: початком `( 2, 1 )` та кінцем відрізка `( 9, 4 )`. Для опису відрізка в 2D достатньо 4 скалярів.

### Capsule

Математична модель капсули. Касула це відрізок, котрий має товщину. Капсула як і сегмент описується двома точки що позначають початок і кінець, а також має товщину та заокруглення на кінцях.

```js
var capsule = [ 2, 1, 9, 4, 0.5 ];
var point = [ 3, 5 ];
var distance = _.capsule.pointDistance( capsule, point );
console.log( `Distance from capsule to point : ${ _.toStr( distance, { precision : 2 } ) }` );
/* log : Distance from capsule to point : 2.8 */
```

![Capsule](../../img/Capsule.png)

Капсула в прикладі починається в точці `( 2, 1 )`, закінчується в точці `( 9, 4 )` і має радіус `0.5`. Для опису капсули в 2D достатньо 5 скалярів.

### Sphere

Математична модель гіпер-сфери. В 2D це коло, в 3D це звичайна сфера, в 4D це глом. Описується центром та радіусом.

```js
var sphere = [ 2, 1, 3 ];
var point = [ 5, 6 ];
var distance = _.sphere.pointDistance( sphere, point );
console.log( `Distance from sphere to point : ${ _.toStr( distance, { precision : 2 } ) }` );
/* log : Distance from sphere to point : 2.8 */
```

![Sphere](../../img/Sphere.png)

В 2D сфера перетворюється в коло. Центр кола з прикладу в точці `( 2, 1 )` а його радіус `3`. Для опису сфери в 2D достатньо 3-х скалярів.

### Ray

Математична модель променя. Перша точка позначає початок променя, друга - задає напрям.

```js
var ray = [ 2, 1, 6, 3 ];
var point = [ 2, 3 ];
var distance = _.ray.pointDistance( ray, point );
console.log( `Distance from ray to point : ${ _.toStr( distance, { precision : 2 } ) }` );
/* log : Distance from ray to point : 1.8 */
```

![Ray](../../img/Ray.png)

Промінь `ray` з прикладу починається в точці `( 2, 1 )` та прямує в безкінечність через точку `( 6, 3 )`. Для опису проеменя в 2D достатньо 4-х скалярів.

### LinePoints

Математична модель прямої за двома точками. Описує пряму двома точки, через які вона проходить.

```js
var line = [ 2, 1, 4, 2 ];
var factor = 0.25;
var pair = _.linePoints.pairAt( line, factor );
console.log( `Pair at factor 0.25 : ${ pair }` );
/* log : Pair at factor 0.25 : 2.500 1.250 */
```

![LinePoints](../../img/LinePoints.png)

Перші два скаляри вектора `line` є першою точкою, інші два другою точкою. За цими двома точками будується пряма. Для опису прямої в 2D достатньо 4-х скалярів.

### LinePointDir

Математична модель прямої за точкою та відносним напрямком. Друга точка задається відносної першої.

```js
var line = [ 2, 1, 2, 1 ];
var point = [ 2, 3 ];
var distance = _.linePointDir.pointDistance( line, point );
console.log( `Distance from line by point and direction to point : ${ _.toStr( distance, { precision : 2 } ) }` );
/* log : Distance from line by point and direction to point : 1.8 */
```

![LinePointDir](../../img/LinePointDir1.png)

Перші два скаляри вектора `line` є першою точкою, інші два описують другу точку. Проте в випадку моделі `lineDir` координати другої точки задані відносно координат першої. За цими двома точками будується пряма. Для опису прямої в 2D достатньо 4-х скалярів.

### LinePointCentered

Математична модель прямої, котра проходить через початок координат і задану точку.

```js
var line = [ 4, 2 ];
var point = [ 2, 3 ];
var distance = _.linePointCentered.pointDistanceCentered2D( line, point );
console.log( `Distance from centered line to point : ${ _.toStr( distance, { precision : 2 } ) }` );
/* log : Distance from centered line to point : 1.8 */
```

![LinePointCentered](../../img/LinePointCentered.png)

Два скаляри вектора `line` є точкою через яку проходить пряма. Друга точка завжди початок координат. За цими двома точками будується пряма. Для опису прямої яка проходить через початок координат в 2D достатньо 2-х скалярів.

### Plane ( implicit )

Математична модель гіпер-площини заданої неявним рівнянням. Ця математична модель завжди ділитиме простір в якому він існує на дві половини. В 2D це буде пряма, в 3D це буде площина.

```js
var line = [ -2, -1, 2 ];
var point = [ 2, 3 ];
var distance = _.plane.pointDistance( line, point );
console.log( `Distance from straight to point : ${ _.toStr( distance, { precision : 2 } ) }` );
/* log : Distance from straight to point : 0.89 */
```

![LineImplicit](../../img/LineImplicit.png)

<!-- xxx -->

При використанні лише трьох координат рутини оперують лінією заданою через коєфіцієнти рівняння. Перше число `w` `-2` - константа, а інші вираховуються щоб забезпечити рівність. На зображеній прямої коефіцієнт `a` має значення `1`, а `b` - `2`.

```js
var plane = [ -2, -1, 2, 0 ];
var point = [ 2, 3, -3 ];
var distance = _.plane.pointDistance( plane, point );
console.log( `Distance from 3D plane to point : ${ _.toStr( distance, { precision : 2 } ) }` );
/* log : Distance from 3D plane to point : 0.89 */
```

![Plane](../../img/Plane.png)

Якщо одна із чотирьох координат рівна нулю, рутини оперують математичною моделлю площини. Відповідно зображена площина паралельна осі `z` і з приведеного ракурсу вироджується в лінію як на діаграмі з лінією.

### Triangle

Математична модель трикутника. Має вигляд вектора координат трьох вершин.

```js
var triangle = [ 2, 1, 9, 2, 5, 6 ];
var point = [ 3, 6 ]
var distance = _.triangle.pointDistance( triangle, point );
console.log( `Distance from triangle to point : ${ _.toStr( distance, { precision : 2 } ) }` );
/* log : Distance from triangle to point : 1.7 */
console.log( `Type of triangle : ${ _.strType( triangle ) }` );
/* log : Type of triangle : Array */
```

![Triangle](../../img/Triangle.png)

На діаграмі зображено трикутник з точками `point1` ( 2; 1 ), `point2` ( 9; 2 ) i `point3` ( 5; 6 ).

### ConvexPolygon

Математична модель випуклого полігону. Має вигляд матриці координат вершин полігона.

```js
var vertices =
[
  2,  6,  9,  5,
  1, -1,  2,  6
]
var polygon = _.convexPolygon.make( vertices, 2 );
var point = [ 3, 6 ];
var distance = _.convexPolygon.pointDistance( polygon, point );
console.log( `Distance from convex polygon to point : ${ _.toStr( distance, { precision : 2 } ) }` );
/* log : Distance from convex polygon to point : 1.7 */
console.log( `Type of polygon : ${ _.strType( polygon ) }` );
/* log : Type of polygon : wMatrix */
```

![ConvexPolygon](../../img/ConvexPolygon.png)

Зображений полігон є випуклим бо жоден з кутів утворених вершинами `point1` ( 2; 1 ), `point2` ( 6; -1 ), `point3` ( 9, 2 ) і `point4` ( 5; 6 ) не більше ніж 180 градусів.

### ConcavePolygon

Математична модель впуклого полігону. Має вигляд матриці координат вершин полігона.

```js
var vertices =
[
  2,  6,  9,  5,
  1,  3,  2,  6
]
var polygon = _.concavePolygon.make( vertices, 2 );
var point = [ 3, 6 ]
var distance = _.concavePolygon.pointDistance( polygon, point );
console.log( `Distance from concave polygon to point : ${ _.toStr( distance, { precision : 2 } ) }` );
/* log : Distance from concave polygon to point : 1.7 */
console.log( `Type of polygon : ${ _.strType( polygon ) }` );
/* log : Type of polygon : wMatrix */
```

![ConcavePolygon](../../img/ConcavePolygon.png)

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
console.log( `Distance from frustum to point : ${ _.toStr( distance, { precision : 2 } ) }` );
/* log : Distance from frustum to point : 1.0 */
console.log( `Type of frustum : ${ _.strType( frustum ) }` );
/* log : Type of frustum : wMatrix */
```

![Frustum](../../img/Frustum.png)

Приведене зображення фрустума показує, що для утворення фігури необхідно задати шість площин. Зі збільшенням відстані від точки спостереження збільшується площа перетину утвореної фігури.

### AxisAndAngle

Задає поворот об'єкта за заданою віссю обертання і кутом повороту.

```js
var axisAndAngle = [ 1, 0, 0, Math.PI / 4 ];
var euler = _.euler.fromAxisAndAngle2( null, axisAndAngle );
console.log( `AxisAndAngle to Euler : ${ _.toStr( euler, { precision : 2 } ) }` )
/* log : AxisAndAngle to Euler : [ 0.79, 0.0, -0.0, 0.0, 1.0, 2.0 ] */
```

![AxisAndAngle](../../img/AxisAndAngle.png)

При використанні повороту за віссю і кутом в переданому векторі позначається вісь відносно якої відбудеться поворот і кут. Відповідно, заданий вектор зображає поворот відносно осі `x` на 45 градусів.

### Euler

Задає поворот об'єкта за вектором утвореним кутами повороту і порядком здійснення поворотів.

```js
var euler = [ Math.PI/4, 0, 0, 0, 1, 2 ];
var quat = _.euler.toQuat( euler, null );
console.log( `Quat from Euler : ${ _.toStr( quat, { precision : 2 } ) }` );
/* log : Quat from Euler : [ 0.38, 0.0, 0.0, 0.92 ] */
```

![Euler](../../img/Euler.png)

Для повороту з допомогою кутів ейлера необхідно позначити кути поворотів відносно осей `x`, `y` i `z` та порядок цих поворотів. Вектор `[ Math.PI/4, 0, 0, 0, 1, 2 ]` показує що здійснюється поворот лише за віссю `x` на 45 градусів.

### Quat

Задає поворот об'єкта використовуючи кватерніони.

```js
var quat = [ 0.38, 0.0, 0.0, 0.92 ]
var euler = _.quat.toEuler( quat, null )
console.log( `Quat from Euler : ${ _.toStr( euler, { precision : 2 } ) }` )
/* log : Euler from Quat : [ 0.78, 0.0, -0.0, 0.0, 1.0, 2.0 ] */
```

![Quat](../../img/Quat.png)

Для повороту з допомогою кватерніона в векторі спочатку передається дійсна частина кватерніона, що визначає поворот, а наступними елементами задається вісь повороту. На приведеному діаграмі здійснюється поворот відносно осі `x` на 45 градусів.
