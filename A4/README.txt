Q1:
Set the right texture to the correct mapping method and THREE.js will do the work.

Q2:
Pass in the needed uniforms.
Flip the uv vector with respect to the Y axis.
Implement a regular Blinn-Phong Shadding.
Use texture() to perform texture mapping and do the multiplication as instructed.

Q3:
Load the texture images in a correct order.
Create a box and set up its material.
Compute the vertex position of box in world frame.
Use the vertex position of box in world frame to perform texture mapping with texture().

Q4:
Compute normal vector and the vertex position in the camera frame.
Compute the bounce vector using normal and vertex position.
Convert the bounce vector to the world frame.
Use texture() to perform texture mapping.

Q5:
Set the light to cast shadow and a series of meshes to receive shadow.
