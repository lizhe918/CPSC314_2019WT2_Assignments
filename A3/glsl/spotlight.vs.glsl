#version 300 es

uniform vec3 spotlightPosition;
uniform vec3 spotDirectPosition;

out vec3 vPosition;
out vec3 sPosition;
out vec3 dPosition;

void main() {

	// TODO: PART 1C
	vPosition = vec3(modelViewMatrix * vec4(position, 1.0));
	sPosition = vec3(viewMatrix * vec4(spotlightPosition, 1.0));
	dPosition = vec3(viewMatrix * vec4(spotDirectPosition, 1.0));
 	gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}