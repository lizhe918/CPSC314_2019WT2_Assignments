#version 300 es

out vec3 vcsNormal;
out vec3 vcsPosition;

void main() {
	// viewing coordinate system
	// Q4 Answer
	// Convert both normal vector and the vertex position to the camera frame.
	vcsNormal = normalMatrix * normal;
	vcsPosition = vec3(modelViewMatrix * vec4(position, 1.0));

	gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}
