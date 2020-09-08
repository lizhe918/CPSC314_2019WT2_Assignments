#version 300 es

precision highp float;

uniform vec3 lightColor;
uniform vec3 ambientColor;
uniform vec3 lightDirection;
uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;

uniform float goochDiffuse;
uniform float goochShininess;
uniform float goochBlue;
uniform float goochYellow;
uniform float goodhAlpha;
uniform float goochBeta;

in vec3 vertPos;
in vec3 interpNormal;
in vec3 lightDir;

out vec4 out_FragColor;

void main() {

	//TOTAL INTENSITY
	//TODO PART 1E: calculate light intensity (ambient+diffuse+speculars' intensity term)
	float diffuse = max(dot(normalize(lightDir), normalize(interpNormal)), 0.0);

	float specular = 1.0;
	vec3 halfVec = normalize(normalize(lightDir) - normalize(vertPos));
	specular = max(dot(normalize(interpNormal), halfVec), 0.0);
	specular = pow(specular, shininess);


	float lightIntensity = kAmbient + diffuse * kDiffuse + specular * kSpecular;

   	vec4 resultingColor = vec4(0.0,0.0,0.0,0.0);

	vec3 color = lightColor;

   	//TODO PART 1E: change resultingColor based on lightIntensity (toon shading)

	if (lightIntensity > 0.9) {
		resultingColor = vec4(color,1.0);
	} else if (lightIntensity > 0.6) {
		resultingColor = vec4(0.8 * color,1.0);
	} else if (lightIntensity > 0.6) {
		resultingColor = vec4(0.4 * color,1.0);
	} else if (lightIntensity > 0.4) {
		resultingColor = vec4(0.2 * color,1.0);
	} else {
		resultingColor = vec4(0.0, 0.0, 0.0, 1.0);
	}

   	// TODO PART 1E: change resultingColor to silhouette objects
	if (dot(interpNormal, normalize(-vertPos)) < 0.5) {
		resultingColor = vec4(0.0, 0.0, 0.0, 1.0);
	}

	out_FragColor = resultingColor;


}
