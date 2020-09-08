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
	//TODO PART 1G: calculate light intensity

	float diffuse = max(dot(normalize(lightDir), normalize(interpNormal)), 0.0);

	float specular = 1.0;
	vec3 halfVec = normalize(normalize(lightDir) - normalize(vertPos));
	specular = max(dot(normalize(interpNormal), halfVec), 0.0);
	specular = pow(specular, shininess);


	float lightIntensity = diffuse * kDiffuse + specular * kSpecular;

    vec4 resultingColor = vec4(1.0,1.0,1.0,1.0);

    //TODO PART 1G: Change resultingColor based on lightIntensity
    //              Use gl_FragCoord and mod() to find 
    //              which fragments should be shaded dark

//	if (lightIntensity < 0.2) {
//		float temp = mod(gl_FragCoord.x + gl_FragCoord.y, 2.0);
//		if (temp == 0.0) {
//			resultingColor = vec4(0.0, 0.0, 0.0, 1.0);
//		}
//	} else if (lightIntensity < 0.4) {
//		float temp = mod(gl_FragCoord.x + gl_FragCoord.y, 4.0);
//		if (temp == 0.0) {
//			resultingColor = vec4(0.0, 0.0, 0.0, 1.0);
//		}
//	} else if (lightIntensity < 0.6) {
//		float temp = mod(gl_FragCoord.x + gl_FragCoord.y, 6.0);
//		if (temp == 0.0) {
//			resultingColor = vec4(0.0, 0.0, 0.0, 1.0);
//		}
//	} else if (lightIntensity < 0.8) {
//		float temp = mod(gl_FragCoord.x + gl_FragCoord.y, 8.0);
//		if (temp == 0.0) {
//			resultingColor = vec4(0.0, 0.0, 0.0, 1.0);
//		}
//	}

	if (lightIntensity < 1.00) {
		if (mod(gl_FragCoord.x + gl_FragCoord.y, 10.0) == 0.0) {
			resultingColor = vec4(0.0, 0.0, 0.0, 1.0);
		}
	}

	if (lightIntensity < 0.75) {
		if (mod(gl_FragCoord.x - gl_FragCoord.y, 10.0) == 0.0) {
			resultingColor = vec4(0.0, 0.0, 0.0, 1.0);
		}
	}

	if (lightIntensity < 0.50) {
		if (mod(gl_FragCoord.x + gl_FragCoord.y - 5.0, 10.0) == 0.0) {
			resultingColor = vec4(0.0, 0.0, 0.0, 1.0);
		}
	}

	if (lightIntensity < 0.3) {
		if (mod(gl_FragCoord.x - gl_FragCoord.y - 5.0, 10.0) == 0.0) {
			resultingColor = vec4(0.0, 0.0, 0.0, 1.0);
		}
	}

   	//TODO PART 1G: change resultingColor to silhouette objects
	if (dot(interpNormal, normalize(-vertPos)) < 0.5) {
		resultingColor = vec4(0.0, 0.0, 0.0, 1.0);
	}

	out_FragColor = resultingColor;
}
