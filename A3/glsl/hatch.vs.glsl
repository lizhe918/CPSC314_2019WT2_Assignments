#version 300 es

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

out vec3 vertPos;
out vec3 interpNormal;
out vec3 lightDir;

void main() {
   vertPos = vec3(modelViewMatrix * vec4(position, 1.0));
   interpNormal = normalize(normalMatrix * normal);
   lightDir = vec3(viewMatrix * vec4(lightDirection, 0.0));
   gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}