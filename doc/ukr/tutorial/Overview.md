# Models overview

Огляд доступних фігур та демонструює їх використання.

### Box

```js
let box = [ 0, 0, 2, 2 ];
let point = [ 3, 3 ];
let got = _.box.pointDistance( box, point );
console.log( 'Distance from box to point:', _.toStr( got, { precision : 2 } ) );
/* log: Distance from box to point: 1.4 */
```

### Segment

```js
var segment = [ -2, -2, 2, 2 ]
let point = [ 3, 3 ]
let got = _.segment.pointDistance( segment, point );
console.log( 'Distance from segment to point:', _.toStr( got, { precision : 2 } ) );
/* log: Distance from segment to point: 1.4 */
```

### Capsule

```js
var capsule = [ 2, 1, 2, 4, 1 ];
var point = [ 4, 4 ];
let got = _.capsule.pointDistance( capsule, point );
console.log( 'Distance from capsule to point:', got );
/* log: Distance from capsule to point: 1 */
```

### Triangle

```js
var triangle = [ 0, 0, 2, 3, 4, 0 ];
var point = [ 4, 2 ]
let got = _.triangle.pointDistance( triangle, point );
console.log( 'Distance from triangle to point:', _.toStr( got, { precision : 2 } ) );
/* log: Distance from triangle to point: 1.1 */
```

### ConvexPolygon

```js
let vertices =
[
  1, 2, 4, 5,
  1, 5, 5, 1
]
let polygon = _.convexPolygon.make( vertices, 2 );
let point = [ 3, 6 ];
let got = _.convexPolygon.pointDistance( polygon, point );
console.log( 'Distance from convex polygon to point:', got );
/* log: Distance from convex polygon to point: 1*/
```

### ConcavePolygon

```js
let vertices =
[
  2, 1, 3, 5, 4,
  1, 5, 3, 5, 1
]
let polygon = _.concavePolygon.make( vertices, 2 );
let point = [ 3, 4 ]
let got = _.concavePolygon.pointDistance( polygon, point );
console.log( 'Distance from concave polygon to point:', _.toStr( got, { precision : 2 } ) );
/* log: Distance from concave polygon to point: 0.71 */
```

### Frustum

```js
var frustum = _.frustum.make().copy
([
  0,   0,   0,   0,  -1,   1,
  1,  -1,   0,   0,   0,   0,
  0,   0,   1,  -1,   0,   0,
 -1,   0,  -1,   0,   0,  -1
]);
let point = [ 1, 1, 2 ]
let got = _.frustum.pointDistance( frustum, point );
console.log( 'Distance from frustum to point:', got );
/* log: Distance from frustum to point: 1 */
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

### AxisAndAngle

```js
let axisAndAngle = [ 1, 0, 0, Math.PI / 4 ];
let euler = _.euler.fromAxisAndAngle2( euler, axisAndAngle );
console.log( 'AxisAndAngle to Euler:', _.toStr( euler, { precision : 2 } ) )
/* log: AxisAndAngle to Euler: [ 0.79, 0.0, -0.0, 0.0, 1.0, 2.0 ] */
```

### Euler

```js
var euler = [ Math.PI/4, 0, 0, 0, 1, 2 ];
var quat = _.euler.toQuat( euler, null );
console.log( 'Quat from Euler:', _.toStr( quat, { precision : 2 } ) )
/* log : Quat from Euler: [ 0.38, 0.0, 0.0, 0.92 ] */
```

### Quat

```js
var quat = [ 0.38, 0.0, 0.0, 0.92 ]
var euler = _.quat.toEuler( quat, null )
console.log( 'Quat from Euler:', _.toStr( euler, { precision : 2 } ) )
/* log : Euler from Quat: [ 0.78, 0.0, -0.0, 0.0, 1.0, 2.0 ] */
```

### Ray

```js
var ray = [ 0, 0, 2, 2 ]
let point = [ 2, 3 ];
let got = _.ray.pointDistance( ray, point );
console.log( 'Distance from ray to point:', _.toStr( got, { precision : 2 } ) );
/* log: Distance from ray to point: 0.71 */
```

### Sphere

```js
var sphere = [ 0, 0, 1 ];
var point = [ 1, 1 ];
let got = _.sphere.pointDistance( sphere, point );
console.log( 'Distance from sphere to point:', _.toStr( got, { precision : 2 } ) );
/* log: Distance from sphere to point: 0.41 */
```