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
	//TODO PART 1F: calculate light intensity
	float diffuse = max(dot(normalize(lightDir), normalize(interpNormal)), 0.0);

	float specular = 1.0;
	vec3 halfVec = normalize(normalize(lightDir) - normalize(vertPos));
	specular = max(dot(normalize(interpNormal), halfVec), 0.0);
	specular = pow(specular, shininess);


	float lightIntensity = kAmbient + diffuse * kDiffuse + specular * kSpecular;

	vec4 resultingColor = vec4(0.0,0.0,0.0,0.0);

	//TODO PART 1F: compute cool and warm colors
	vec3 kBlue = vec3(0.0,0.0,goochBlue);
	vec3 kYellow = vec3(goochYellow,goochYellow,0.0);
	vec3 kCool = kBlue + goodhAlpha * goochDiffuse;
	vec3 kWarm = kYellow + goochBeta * goochDiffuse;

   	//TODO PART 1F: change resultingColor based on lightIntensity 
	//              as an interpolation of cool and warm colors

	vec3 interpColor = vec3(1.0, 1.0, 1.0);
	vec3 firstPart = ((1.0 + dot(lightDir, interpNormal)) / 2.0) * kCool;
	vec3 secondPart = (1.0 - ((1.0 + dot(lightDir, interpNormal)) / 2.0)) * kWarm;
	interpColor = firstPart + secondPart;
	resultingColor = vec4(interpColor, 1.0);

//	if (lightIntensity > 0.90) {
//		resultingColor = vec4(interpColor,1.0);
//	} else if (lightIntensity > 0.80) {
//		resultingColor = vec4(0.8 * interpColor,1.0);
//	} else if (lightIntensity > 0.70) {
//		resultingColor = vec4(0.7 * interpColor,1.0);
//	} else if (lightIntensity > 0.60) {
//		resultingColor = vec4(0.6 * interpColor,1.0);
//	} else if (lightIntensity > 0.50) {
//		resultingColor = vec4(0.5 * interpColor,1.0);
//	} else if (lightIntensity > 0.40) {
//		resultingColor = vec4(0.4 * interpColor,1.0);
//	} else if (lightIntensity > 0.30) {
//		resultingColor = vec4(0.3 * interpColor,1.0);
//	} else if (lightIntensity > 0.20) {
//		resultingColor = vec4(0.2 * interpColor,1.0);
//	} else if (lightIntensity > 0.10) {
//		resultingColor = vec4(0.1 * interpColor,1.0);
//	} else {
//		resultingColor = vec4(ambientColor, 1.0);
//	}

   	//TODO PART 1F: change resultingColor to silhouette objects

	if (dot(interpNormal, normalize(-vertPos)) < 0.5) {
		resultingColor = vec4(0.0, 0.0, 0.0, 1.0);
	}

	out_FragColor = resultingColor;
}
