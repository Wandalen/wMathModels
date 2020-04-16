# Figures overview

Огляд доступних фігур та демонструює їх використання.

Перелік описаних фігур:

[AxisAndAngle](./FiguresOverview.md#AxisAndAngle)<br>
[Box](./FiguresOverview.md#Box)<br>
[Capsule](./FiguresOverview.md#Capsule)<br>
[ConcavePolygon](./FiguresOverview.md#ConcavePolygon)<br>
[ConvexPolygon](./FiguresOverview.md#ConvexPolygon)<br>
[Euler](./FiguresOverview.md#Euler)<br>
[Frustum](./FiguresOverview.md#Frustum)<br>
[LineImplicit](./FiguresOverview.md#LineImplicit)<br>
[LinePointCentered](./FiguresOverview.md#LinePointCentered)<br>
[LinePointDir](./FiguresOverview.md#LinePointDir)<br>
[LinePoints](./FiguresOverview.md#LinePoints)<br>
[Plane](./FiguresOverview.md#Plane)<br>
[Quat](./FiguresOverview.md#Quat)<br>
[Ray](./FiguresOverview.md#Ray)<br>
[Segment](./FiguresOverview.md#Segment)<br>
[Sphere](./FiguresOverview.md#Sphere)<br>
[Triangle](./FiguresOverview.md#Triangle)<br>

### AxisAndAngle

```js
let axisAndAngle = _.axisAndAngle.from([ 0, 0, 1, Math.PI/2 ]);
let matrix = _.Matrix.Make([ 3, 3 ]);
_.axisAndAngle.toMatrixRotation( axisAndAngle, null )
console.log( 'Rotation matrix from AngleAndAxis:', matrix.toStr() )
/* log:
Rotation matrix from AngleAndAxis:
-8.950, -0.282, 0.141,
0.282, -6.960, 3.980,
-0.141, 3.980, -0.990,
*/

```

### Box

```js
let box = [ 0, 0, 0, 2, 2, 2 ];
let point = [ 1, 1, 3 ];
let got = _.box.pointDistance( box, point );
console.log( 'Distance from box to point:', got );
/* log: Distance from box to point: 1 */
```

### Capsule

```js
var capsule = [ 0, 0, 0, 0, 0, 0, 0 ];
var point = [ 3, 4, 0 ];
let got = _.capsule.pointDistance( capsule, point );
console.log( 'Distance from capsule to point:', got );
/* log: Distance from capsule to point: 5 */
```

### ConcavePolygon

```js
let polygon =
[
  0,1,
  0,1
]
let point = [ 0.5,0 ]
let got = _.concavePolygon.pointDistance( polygon, point );
console.log( 'Distance from concave polygon to point:', got );
/* log: Distance from concave polygon to point: 0 */
```

### ConvexPolygon

```js
var polygon = _.convexPolygon.make( 2, 3 ).copy
([
  1, 0, 0,
  0, 0, 1
]);
var point = [ 0, 1 ];
let got = _.convexPolygon.pointDistance( polygon, point );
console.log( 'Distance from convex polygon to point:', got );
/* log: Distance from convex polygon to point: 0*/
```

### Euler

```js
var euler = [ 1, 0, 0.5, 0, 1, 2 ];
var quat = _.euler.toQuat( euler, null );
console.log( 'Quat from Euler:', _.toStr( quat, { precision : 2 } ) )
/* log : Quat from Euler: [ 0.46, -0.12, 0.22, 0.85 ] */
```

### Frustum

```js
var frustum = _.Matrix.make( [ 4, 6 ] ).copy
([
  0,   0,   0,   0,  -1,   1,
  1,  -1,   0,   0,   0,   0,
  0,   0,   1,  -1,   0,   0,
 -1,   0,  -1,   0,   0,  -1
]);
let point = [ 1,1,2 ]
let got = _.frustum.pointDistance( frustum, point );
console.log( 'Distance from frustum to point:', got );
/* log: Distance from frustum to point: 1 */
```

### LineImplicit

```js
var line = [ -1,3,-3 ];
var point = [ 3,2 ];
let got = _.lineImplicit.pointDistance( line, point );
console.log( 'Distance from straight to point:', got );
/* log: Distance from straight to point: 0*/
```

### LinePointCentered

```js
var line = [ 2,2 ];
var point = [ 3,4 ];
let got = _.linePointCentered.pointDistanceCentered2D( line, point );
console.log( 'Distance from centered line to point:', _.toStr( got, { precision : 2 } ) )
/* log: Distance from centered line to point: 0.71 */
```

### LinePointDir

```js
let line = [ 1, 2, 3, 4 ]
let point = [ 2, 2 ]
let got = _.linePointDir.pointDistance( line, point );
console.log( 'Distance from line by point and direction to point:', got );
/* log: Distance from line by point and direction to point: 0.8 */
```

### LinePoints

```js
var ray = [ 1, 1, 5, 5 ];
var factor = 0.25;
var pair = _.linePoints.pairAt( ray,factor );
console.log( 'Pair at factor 0.25:', pair.toStr() );
/* log: Pair at factor 0.25: 2.000 2.000*/

```

### Plane

```js
var point = [ 0, 1 ];
var plane = [ 0, 1, 1 ];
let got = _.plane.pointDistance( plane, point );
console.log( 'Distance from plane to point:', got );
/* log: Distance from plane to point: 2 */
```

### Quat

```js
var quat = [ 0.46, -0.12, 0.22, 0.85 ]
var euler = _.quat.toEuler( quat, null )
console.log( 'Quat from Euler:', _.toStr( euler, { precision : 2 } ) )
/* log : Euler from Quat: [ 0.99, -0.0016, 0.51, 0.0, 1.0, 2.0 ] */
```

### Ray

```js
var ray = [ 0, 0, 0, 1, 1, 1 ]
let point = [ 1, 2, 1 ];
let got = _.ray.pointDistance( ray, point );
console.log( 'Distance from ray to point:', _.toStr( got, { precision : 2 } ) );
/* log: Distance from ray to point: 0.82 */
```

### Segment

```js
var segment = [ -2, -2, -2, 2, 2, 2 ]
let point = [ 3, 3, 3 ]
let got = _.segment.pointDistance( segment, point );
console.log( 'Distance from segment to point:', _.toStr( got, { precision : 2 } ) );
/* log: Distance from segment to point: 1.7 */
```

### Sphere

```js
var sphere = [ 0, 0, 0, 1 ];
var point = [ 3, 4, 0 ];
let got = _.figure.pointDistance( sphere, point );
console.log( 'Distance from sphere to point:', got );
/* log: Distance from sphere to point: 4 */
```

### Triangle

```js
var triangle = [ 0, 0, 0, 1, 1, 0, 2, 0, 0 ];
var point = [ 1, 1, 1 ]
let got = _.triangle.pointDistance( triangle, point );
console.log( 'Distance from triangle to point:', got );
/* log: Distance from triangle to point: 1 */
```
