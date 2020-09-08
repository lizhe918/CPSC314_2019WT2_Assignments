#version 300 es

out vec4 out_FragColor;

in vec3 vcsNormal;
in vec3 vcsPosition;
in vec2 texCoord;

uniform vec3 lightColor;
uniform vec3 ambientColor;
uniform vec3 lightDirection;
uniform float kDiffuse;
uniform float kAmbient;
uniform float kSpecular;
uniform float shininess;

// List textures are passed in as uniforms
uniform sampler2D colorMap;

void main() {
	// Q2 Answer
	// Perform the normal Blinn-Phong Shadding.
	// Then use the texture() function to map the texture.
	// Finally perform multiplication as instructed.

	// SOME PRE-CALCS FOR BLINN PHONG LIGHTING
	vec3 N = normalize(vcsNormal);
	vec3 L = normalize(vec3(viewMatrix * vec4(lightDirection, 0.0)));
	vec3 V = normalize(- vcsPosition);
	vec3 H = normalize(L + V);

	//AMBIENT
	vec3 light_AMB = kAmbient * lightColor;

	//DIFFUSE
	vec3 diffuse = kDiffuse * lightColor;
	vec3 light_DFF = diffuse * max(0.0, dot(N, L));

	//SPECULAR
	vec3 specular = kSpecular * lightColor;
	vec3 light_SPC = specular * max(0.0, pow(dot(N, H), shininess));

	// Q2 : Multiply the diffuse color with the color sampled from the texture
	// WRITE YOUR CODE HERE
	light_DFF = light_DFF * vec3(texture(colorMap, texCoord));

	//TOTAL
	vec3 TOTAL = light_AMB + light_DFF + light_SPC;

	out_FragColor = vec4(TOTAL, 1.0);
}
