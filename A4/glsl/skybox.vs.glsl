#version 300 es

out vec3 texCoord;

void main() {
	// Q3 (HINT) : The cube that the texture is mapped to is centered at the origin, using this information 
	// calculate the correct direction vector in the world coordinate system
	// which is used to sample a color from the cubemap
	// Q3 Answer
	// As the cube is located at the origin, then its vertex position in world frame is the vector used to perform
	// texture mapping. So we compute its vertex position in world frame here.
	texCoord = vec3(modelMatrix * vec4(position, 1.0));

	// Q3 : Offset your pixel vertex position by the cameraPostion (given to you in world space) 
	// so that the cube is always in front of the camera even with zoom
	gl_Position = projectionMatrix * viewMatrix * vec4((texCoord + cameraPosition), 1.0);
}