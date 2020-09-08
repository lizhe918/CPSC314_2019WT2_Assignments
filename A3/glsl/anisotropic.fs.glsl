#version 300 es

precision highp float;

uniform vec3 lightColor;
uniform vec3 ambientColor;
uniform vec3 lightDirection;
uniform vec3 tangentDirection;
uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;

in vec3 vertPos;
in vec3 interpNormal;
in vec3 tangentDir;
in vec3 lightDir;

out vec4 out_FragColor;

void main() {

	// vec3 tan = normalize(vec3(viewMatrix * vec4(tangentDirection, 0.0)));
	//AMBIENT
	vec3 light_AMB = kAmbient * ambientColor;

	//DIFFUSE
	float diffuse = max(dot(normalize(lightDir), normalize(interpNormal)), 0.0);
	vec3 light_DFF = diffuse * kDiffuse * lightColor;

	//SPECULAR

	vec3 halfVec = normalize(normalize(lightDir) - normalize(vertPos));
	vec3 tangent = normalize(cross(normalize(tangentDirection), interpNormal));
	float specular = dot(tangent, halfVec);
	specular = pow(1.0 - specular*specular, shininess);
	vec3 light_SPC = specular * kSpecular * lightColor;

	//TOTAL
	vec3 TOTAL =  light_AMB + light_DFF + light_SPC;
	out_FragColor = vec4(TOTAL, 1.0);
}
