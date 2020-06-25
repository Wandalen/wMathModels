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

To create with a sample pass the sample as the argument to the `make`