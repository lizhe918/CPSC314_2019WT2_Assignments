#version 300 es

uniform vec3 lightDirection;

out vec3 vertPos;
out vec3 interpNormal;
out vec3 lightDir;

void main() {

    vertPos = vec3(modelViewMatrix * vec4(position, 1.0));

    interpNormal = normalize(normalMatrix * normal);

    lightDir = vec3(viewMatrix * vec4(lightDirection, 0.0));

    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}