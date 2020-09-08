#version 300 es

precision highp float;

uniform vec3 lightColor;
uniform vec3 ambientColor;
uniform vec3 lightDirection;
uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;

in vec3 vertPos;
in vec3 interpNormal;
in vec3 lightDir;

out vec4 out_FragColor;

void main() {

	//AMBIENT
	vec3 light_AMB = kAmbient * ambientColor;

	//DIFFUSE
	float diffuse = max(dot(normalize(lightDir), normalize(interpNormal)), 0.0);
	vec3 light_DFF = diffuse * kDiffuse * lightColor;

	//SPECULAR
	float specular = 1.0;

	vec3 halfVec = normalize(normalize(lightDir) - normalize(vertPos));
	specular = max(dot(normalize(interpNormal), halfVec), 0.0);
	specular = pow(specular, shininess);
	vec3 light_SPC = specular * kSpecular * lightColor;

	//TOTAL
	vec3 TOTAL = light_AMB + light_DFF + light_SPC;
	out_FragColor = vec4(TOTAL, 1.0);

}