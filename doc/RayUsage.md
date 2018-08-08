
# Ray.s Usage [![Ray methods](https://travis-ci.org/Wandalen/wMathConcepts.svg?branch=master)](https://github.com/Wandalen/wMathConcepts/blob/master/staging/dwtools/amath/geometric/Ray.s)

### Definition:
  Ray.s contains a collection of functions to work with the geometrical concept of a ray ( a line starting at an origin point that extends infinitely in a given direction).

  A ray element is defined by an origin [ x0, x1, ..., xn ], and a direction [ d0, d1, ..., dn ] ( where n is the dimension of the vectorial space ).
  Rays are stored as flat vectors according to the following convention: ray = [ x0, x1, ..., xn, d0, d1, ..., dn ];

### Functions:
  - is( ray ): Checks if the input is a ray.
  - make( dim ): makes a ray of dimension dim ( default dim = 3 ).
  - fromPair: Creates a ray out of two points ( first point is used as origin ).
    @Example
    // returns [ 0, 1, 2, 0, 0, 3 ];
    // fromPair( [ 0, 1, 2 ], [ 0, 1, 5 ] );
  - rayAt: Gets a point in a ray with a factor.
    @Example
    // returns [ 0, 2, 4 ];
    // rayAt( [ 0, 1, 2, 0, 1, 2 ], 1 )

### Try out  
```
npm install
node sample/SampleRay.s
```
