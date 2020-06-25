# Introduction

The article describes the main features of the module and the principles of its use.

### Mathematical model

Formal description of the system using mathematical concepts and language.

### Making an instance

Every model has a certain pair of routines `make` and `from` for creation an instance of it. Creation an instance without arguments creates an instance with default parameters. In addition, each model defines routine `is` which answers the question: "is this essence an instance of this model".

### Routine make

The routine `make` allows to create an instance of a model. New instance can be created based on a given dimensionality or another instance. If an instance of a model is used as an argument, the new instance will be a copy of the original instance.

Creation of an instance of the model `box` with dimesions by default:

```js
var box = _.box.make();
console.log( `Type : ${ _.strType( box ) }` );
/* log : Type : Array */
console.log( box );
/* log : [ 0, 0, 0, 0, 0, 0 ] */
console.log( `_.box.is( box ) : ${ _.box.is( box ) }` );
/* log : _.box.is( box ) : true */
```

Box `box` is in `3D` space. The first three scalars describe one extreme point, while the last three scalars describe another extreme point. Those are model's default parameters.

Every model implements routine `make` and defines default arguments so that an instance can be created through a call without arguments.

Invocation of the routine `make` with a scalar creates box with a given dimensionality.

```js
var dim = 2;
var box = _.box.make( dim );
console.log( box );
/* log : [ 0, 0, 0, 0 ] */
console.log( `Type : ${ _.strType( box ) }` );
/* log : Type : Array */
console.log( `_.box.is( box ) : ${ _.box.is( box ) }` );
/* log : _.box.is( box ) : true */
```

Box `box` is created in 2D space, unlike the previous example, vector has only 4 scalars - 2 for each apex.

To create with a sample pass the sample as the argument to the routine `make`.

```js
var srcBox = [ 2, 1, 9, 5 ];
var box = _.box.make( srcBox );
console.log( box );
/* log : [ 2, 1, 9, 5 ] */
console.log( `srcBox === box : ${ srcBox === box }` );
/* log : srcBox === box : false */
console.log( `Type : ${ _.strType( box ) }` );
/* log : Type : Array */
console.log( `_.box.is( box ) : ${ _.box.is( box ) }` );
/* log : _.box.is( box ) : true */
```

Dimensions and all the data of the `box` are the same as in `srcBox`.

![Box](../../img/Box.png)

Call `_.box.make( srcBox )` creates and returns a vector which contains 4 scalars, 2 for each point. Two points describe a box.

Creation with default parameters:

```js
var box = _.box.make( null );
console.log( box );
/* log : [ 0, 0, 0, 0 ] */
console.log( `Type : ${ _.strType( box ) }` );
/* log : Type : Array */
console.log( `_.box.is( box ) : ${ _.box.is( box ) }` );
/* log : _.box.is( box ) : true */
```

The semantics is the same as in the example with call without arguments. The pragmatics is different: an imaginary instance with default parameters is used as a sample.

### Routine from

An alternative way to create an instance of a mathematical model is using the routine `from`. The routine `from` the same as `make` constructs a new instance, but unlike the routine `make`, performs an additional checking. The routine `from` creates a new instance only if an argument of the call is not an instance of that model. If an argument of the call `from` is an instance of that model, it is returned without any changes.

Let's create an instance of the box model manually and pass it as the routine input.

```js
var srcBox = new F32x([ 2, 1, 9, 5 ]);
var box = _.box.from( srcBox );
console.log( box );
/* log : Float32Array(4) [ 2, 1, 9, 5 ] */
console.log( `srcBox === box : ${ srcBox === box }` );
/* log : srcBox === box : true */
console.log( `Type : ${ _.strType( box ) }` );
/* log : Type : F32x */
console.log( `_.box.is( box ) : ${ _.box.is( box ) }` );
/* log : _.box.is( box ) : true */
```

The routine `_.box.from()` first of all checks whether `srcBox` is an instance of the model `box`. And `srcBox` is an instance of the model `box` so it is returned without any changes from the routine `_.box.from()`.

Alternatively the routine `from()` takes a vector adapter.

```js
var srcBox = _.vad.fromLong([ 2, 1, 9, 5 ]);
var box = _.box.from( srcBox );
console.log( box );
/* log : VectorAdapter.x4.Array :: 2.000 1.000 9.000 5.000 */
console.log( `srcBox === box : ${ srcBox === box }` );
/* log : srcBox === box : true */
console.log( `_.box.is( box ) : ${ _.box.is( box ) }` );
/* log : _.box.is( box ) : true */
```

The same as in the previous example the routine `_.box.from()` returns `srcBox` without any changes.

If `from` takes `null` as an argument, we'll get the same semantics as in the routine `make`.

```js
var box = _.box.from( null );
console.log( box );
/* log : [ 0, 0, 0, 0, 0, 0 ] */
console.log( `Type : ${ _.strType( box ) }` );
/* log : Type : Array */
console.log( `_.box.is( box ) : ${ _.box.is( box ) }` );
/* log : _.box.is( box ) : true */
```

The routine `_.box.from()` creates a new instance of the box model with default parameters.

### Make vs from

Two alternative ways `make()` and `from()` for creation of instances of mathematical models have similarities and differences.

```js
var box1 = _.box.make( null );
console.log( `Box1 : ${ box1 }` );
/* log : Box1 : [ 0, 0, 0, 0, 0, 0 ] */

var box2 = _.box.from( null );
console.log( `Box2 : ${ box2 }` );
/* log : Box2 : [ 0, 0, 0, 0, 0, 0 ] */

```

Both calls create a new instance of the model `box` with the dimensionality defined by default. Semantics and pragmatics are the same.

The difference between routines `make()` and `from()` is how they react to the prepared instances as arguments.

```js
var src1 = [ 2, 1, 9, 5 ];
var box1 = _.box.make( src1 );
console.log( 'Box1 :', box1 );
/* log : Box1 : [ 2, 1, 9, 5 ] */
console.log( 'src1 === box1 :', src1 === box1 );
/* log : src1 === box1 : false */

var src2 = [ 2, 1, 9, 5 ];
var box2 = _.box.from( src2 );
console.log( 'Box2 :', box2 );
/* log : Box2 : [ 2, 1, 9, 5 ] */
console.log( 'src2 === box2 :', src2 === box2 );
/* log : src2 === box2 : true */
```

Both calls `make()` and `from()` return an instance of the model box with parameters `[ 2, 1, 9, 5 ]`. But the routine `make()` created a copy of `src1`, and the routine `from()` returned `src1` without any changes.

### Uncoupling data and functionality

Data of instances of all mathematical models are stored in the **vector** ( of any form ) or **matrix**. The container for the model box, quaternion, straight line and many others is a **vector**.

A vector might have the following forms:

- array ( Array )
- typed array ( BufferTyped )
- vector adapter ( VectorAdapter )

Vector adapter is a kind of link that defines how to interpret data as the vector.

The container for the model polygon and frustum is a **matrix**. A matrix is capable of transfering multidimensional information, which is a need for models like polygon.

A **zero-copy principle** can be implemented both through the matrix and through the vector adapter.

Uncoupling of the data and functionality:

 - makes it possible to avoid useless copying of data .
 - simplifies the use of the module.
 - standardizes the interface.
 - algorithms of all models are not tied to the form, the format or the type of the data.
 - makes the system more extendable

Algorithms and data are uncoupled. Algorithms are implemented on the abstract interface of the vector adapter or matrix.

```js
var srcBox = new F32x([ 2, 1, 9, 5 ]);
var box = _.box.from( srcBox );
console.log( box );
/* log : Float32Array(4) [ 2, 1, 9, 5 ] */
console.log( `Type : ${ _.strType( box ) }` );
/* log : Type : F32x */
console.log( `srcBox === box : ${ srcBox === box }` );
/* log : srcBox === box : true */
```

Pay attention that `box` is an ordinary vector and not some object. This is a direct manifestation of the **uncoupling of the data and functionality principle**

### Namespaces logistics

All model's algorithms are called through namespace models, for example for box it is `_.box.*`, for quaternion it is `_.quat.*`, while an instance of the model is a **vector** or a **matrix**, and not an instance of some other additional class. All mathematical model's algorithms are called functionally, for example:

```js
var distance = _.plane.pointDistance( plane, point );
```

Here a `plane` is a vector, which is interpreted as an implicit plane equation, `point` is a vector, which is interpreted as a point and `distance` is a returned scalar.

### Components of models

All mathematical models in this module ( vector as well as matrix ) consist of atomic parts, on the lowest level those are scalars, which are often grouped into larger groups.

```js
var box = new F32x([ 2, 1, 9, 5 ]);
var cornerLeft = _.box.cornerLeftGet( box );
var cornerRight = _.box.cornerRightGet( box );
console.log( `cornerLeft : ${ cornerLeft }` );
/* log : cornerLeft : VectorAdapter.x2.F32x :: 2.000 1.000 */
console.log( `cornerRight : ${ cornerRight }` );
/* log : cornerRight : VectorAdapter.x2.F32x :: 9.000 5.000 */
```

An instance of the model `box` is created manually. Routine `_.box.cornerLeftGet( box )` creates vector adapter for the left bottom point of the box and then output it to the log.

Routines for the access to the components of the instances of the models return not a copy of the data but vector adapter. Vector adapter is a kind of link to the data and it doesn't have this data.

```js
var box = new F32x([ 2, 1, 9, 5 ]);
var cornerLeft = _.box.cornerLeftGet( box );
console.log( `cornerLeft : ${ cornerLeft }` );
/* log : cornerLeft : VectorAdapter.x2.F32x :: 2.000 1.000 */
cornerLeft.assign([ 3, 4 ]);
console.log( `box : ${ box }` );
/* log : box : 3,4,9,5 */
```

Vector adapter `cornerLeft` is used to change the value of the first apex of the box.

Routines for the access to the components of the models take vectors in any form, including vector adapters.

```js
var box = _.vad.from([ 2, 1, 9, 5 ]);
var cornerLeft = _.box.cornerLeftGet( box );
var cornerRight = _.box.cornerRightGet( box );
console.log( `cornerLeft : ${ cornerLeft }` );
/* log : cornerLeft : VectorAdapter.x2.Array :: 2.000 1.000 */
console.log( `cornerRight : ${ cornerRight }` );
/* log : cornerRight : VectorAdapter.x2.Array :: 9.000 5.000 */
```

The output is similar to the first example.

### Isomorphic

The behavior is unchanged when the type of the model changes.

For example, algorithm for checking that the point is on the surface or inside is implemented by the routine `pointContains`. All models for which it's possible to implement such an algorithm have this routine with this name.

```js
var point = [ 0, 1, 2 ];
var plane = [ 1, 2, -1, 0 ];
var contains = _.plane.pointContains( plane, point );
console.log( `Plane contains point : ${ contains }` );
/* log : Plane contains point : true */
```

`true` is returned to the variable `contains`, because the point `point` is on the surface `plane`.

```js
var point = [ 0, 1 ];
var line = [ 0, 0, 0, 2 ];
var contains = _.linePointDir.pointContains( line, point );
console.log( `Line contains point : ${ contains }` );
/* log : Line contains point : true */
```

`true` is returned to the variable `contains`, because the point `point` is on the line `line`.

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
/* log : Polygon contains point : true */
```

A convex polygon `polygon` is created in 2D based on the coordinates of the vertices from the vector `vertices`. `true` is returned to the variable `contains`, because the point `point` and the third vertex of the polygon `polygon` have the same coordinates.

### Intuitive

The routines have intuitive names. Knowledge of one routine helps to guess about other routines. The search in the module and its research can be made by combining prefixes/suffixes

An example of using a group of routines `*Intersects` to check the cross section of the model instance `plane` with instances of other models.

```js
var plane = [ 0, 2, 0, -2 ];
var box = [ 0, 0, 0, 2, 2, 2 ];
var intersected = _.plane.boxIntersects( plane, box );
console.log( `Plane intersects with box : ${ intersected }` );
/* log : Plane intersects with box : true */
```

`true` is returned to the variable `intersected`, because the plane `plane` crosses the box `box`.

```js
var plane = [ 1, 0, 0, 1 ];
var capsule = [ - 1, 2, 3, -1, 2, 3, 0  ];
var intersected = _.plane.capsuleIntersects( plane, capsule );
console.log( `Plane intersects with capsule : ${ intersected }` );
/* log : Plane intersects with capsule: true */
```

`true` is returned to the variable `intersected`, because the plane `plane` crosses the capsule `capsule`.

```js
var plane = [ 1, 0, 0, -0.4 ];
var frustum = _.frustum.make().copy
([
  0,   0,   0,   0,  -1,   1,
  1,  -1,   0,   0,   0,   0,
  0,   0,   1,  -1,   0,   0,
 -1,   0,  -1,   0,   0,  -1
]);
var intersected = _.plane.frustumIntersects( plane, frustum );
console.log( `Plane intersects with frustum : ${ intersected }` );
/* log : Plane intersects with frustum : true */
```

An instance `frustum` of the model `frustum` is created by defining spaces of 6 faces.
From the output, it is clear that the container for the data for the instance of the model is a matrix.
`true` is returned to the variable `intersected`, because the plane `plane` crosses the truncated pyramid `frustum`.

```js
var plane = [ 1, 0, 0, 1 ];
var intersected = _.plane.planeIntersects( plane, plane );
console.log( `Plane intersects with plane : ${ intersected }` );
/* log : Plane intersects with plane : true */
```

`true` is returned to the variable `intersected`, because the plane `plane` crosses itself.

```js
var plane = [ 1, 0, 0, 1 ];
var line = [ 1, 0, 1, 1, 1, 1 ];
var intersected = _.plane.lineIntersects( plane, line );
console.log( `Plane intersects with line : ${ intersected }` );
/* log : Plane intersects with line : true */
```

`true` is returned to the variable `intersected`, because the plane `plane` is crossed by the line `line`.

```js
var plane = [ 1, 0, 0, 1 ];
var segment = [ -2, -2, -2, 2, 2, 2 ];
var intersected = _.plane.segmentIntersects( plane, segment );
console.log( `Plane intersects with segment : ${ intersected }` );
/* log : Plane intersects with segment : true */
```

`true` is returned to the variable `intersected`, because the plane `plane` is crossing with a segment `segment`.

```js
var plane = [ 0, 2, 0, 2 ];
var sphere = [ 0, 0, 0, 1.5 ];
var intersected = _.plane.sphereIntersects( plane, sphere );
console.log( `Plane intersects with sphere : ${ intersected }` );
/* log : Plane intersects with sphere : true */

```

`true` is returned to the variable `intersected`, because the plane `plane` is crossing with a sphere `sphere`.

```js
var plane = [ - 1, 0, 0, 1 ];
var ray = [ 0, 0, 0, 1, 1, 1 ];
var intersected = _.plane.rayIntersects( plane, ray );
console.log( `Plane intersects with ray : ${ intersected }` );
/* log : Plane intersects with ray: true */
```

`true` is returned to the variable `intersected`, because the plane `plane` is crossing with a ray `ray`.

### Convention dst=null