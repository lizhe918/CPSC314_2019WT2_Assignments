#version 300 es

precision highp float;
precision highp int;

uniform vec3 spotlightPosition;
uniform vec3 spotDirectPosition;

in vec3 vPosition;
in vec3 sPosition;
in vec3 dPosition;

out vec4 out_FragColor;

void main() {
	// TODO: PART 1D


	vec3 sDirection = normalize(dPosition - sPosition);
	vec3 lDirection = normalize(vPosition - sPosition);

	float angle = acos(dot(sDirection, lDirection));
	float slCos = cos(angle);


	float spotExponent = 5.0;
	
	vec3 SpotColor = vec3(1.0, 1.0, 0.0);

	float intensity = 0.0;


	intensity = pow(slCos, spotExponent);

	out_FragColor = vec4(SpotColor * intensity, 1.0);
}