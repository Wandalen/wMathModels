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