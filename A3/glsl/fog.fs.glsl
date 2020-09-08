#version 300 es

uniform vec3 lightColor;
uniform vec3 lightFogColor;
uniform vec3 ambientColor;
uniform vec3 lightDirection;
uniform float kAmbient;
uniform float kDiffuse;
uniform float fogDensity;

in vec3 vertPos;
in vec3 interpNormal;
in vec3 lightDir;

out vec4 out_FragColor;

void main() {

	float distance = sqrt(dot(vertPos, vertPos));
	float exponent = distance * fogDensity;
	float fogLevel = 1.0 / exp(exponent);
	vec3 light_FOG = (1.0 - fogLevel) * lightFogColor;


	//DIFFUSE
	float diffuse = max(dot(normalize(lightDir), normalize(interpNormal)), 0.0);
	vec3 light_DFF = diffuse * kDiffuse * fogLevel * lightFogColor;

	//TOTAL
	vec3 TOTAL = light_DFF + light_FOG;
	out_FragColor = vec4(TOTAL, 1.0);

}