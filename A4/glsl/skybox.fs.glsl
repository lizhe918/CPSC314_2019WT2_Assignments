#version 300 es

in vec3 texCoord;
out vec4 out_FragColor;

// The cubmap texture is of type SamplerCube
// uniform samplerCube skybox;
uniform samplerCube skyboxCubemap;

void main() {

	// HINT : Sample the texture from the samplerCube object, rememeber that cubeMaps are sampled 
	// using a direction vector that you calculated in the vertex shader

	// Q3 Answer
	// Use texCoord and texture() to perform texture mapping.

	out_FragColor = texture(skyboxCubemap, texCoord);
}
