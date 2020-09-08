#version 300 es

uniform vec3 lightDirection;
uniform vec3 tangentDirection;

out vec3 vertPos;
out vec3 interpNormal;
out vec3 tangentDir;
out vec3 lightDir;

void main() {

    // TODO: PART 1B
    vertPos = vec3(modelViewMatrix * vec4(position, 1.0));

    interpNormal = normalize(normalMatrix * normal);

    tangentDir = vec3(viewMatrix * vec4(tangentDirection, 0.0));
    lightDir = vec3(viewMatrix * vec4(lightDirection, 0.0));
   
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}