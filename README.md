
# wMathModels [![Status](https://github.com/Wandalen/wMathModels/workflows/Test/badge.svg)](https://github.com/Wandalen/wMathModels/actions?query=workflow%3ATest)

Collection of functions to operate such geometrical models as Sphere, Box, Plane, Frustum, Ray, Axis and Angle, Euler's Angles, Quaternion and other. Why MathModels? Three reasons. All functions of the module are purely functional. MathModels heavily relies on another great concept MathVector what makes the module less sensible to data formats of operational objects. The module provides functions for conversions from one to another conceptual form, for example from Quaternion to Euler's Angles or from Euler's Angles to Quaternion or between different representations of Euler's Angles. Unlike MathModels, many alternatives do conversions inconsistently or inaccurately. MathModels is densely covered by tests and optimized for accuracy. Use MathModels to have uniform experience solving geometrical problems and to get a more flexible program.

MathModels implements algorithms on such math models:

- Axis and angle.
- Box.
- Capsule.
- Convex polygon.
- Euler angles.
- Frustum.
- Line.
- Plane.
- Quaternion.
- Ray.
- Segment.
- Sphere.

### Try out
```
npm install
node sample/Sample.js
```
