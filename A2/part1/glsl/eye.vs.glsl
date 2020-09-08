#version 300 es

// Shared variable passed to the fragment shader
out vec3 color;

// HINT: YOU WILL NEED TWO UNIFORMS
uniform vec3 offset;
uniform vec3 magicPosition;

#define MAX_EYE_DEPTH 0.05

void main() {
  // Simple way to color the pupil where there is a concavity in the sphere
  float d = min(1.0 - length(position), MAX_EYE_DEPTH);
  color = mix(vec3(1.0), vec3(0.0), d * 1.0 / MAX_EYE_DEPTH);

  mat4 S = mat4(0.5);
  S[3][3] = 1.0;

  // YOUR CODE STARTS HERE: translate and rotate eyes corresponding to the movement of magic circle 

  // HINT: ROTATE THE EYES FIRST TO FACE FORWARD
  // HINT: LOOKAT MATRIX WILL BE HELPFUL
  // HINT: ORDER OF MULTIPLICATION WILL BE IMPORTANT
  mat4 T = mat4(
    1.0, 0.0, 0.0, 0.0,
    0.0, 1.0, 0.0, 0.0,
    0.0, 0.0, 1.0, 0.0,
    offset[0], offset[1], offset[2], 1.0
  );

  mat4 R = mat4(
    1.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 1.0, 0.0,
    0.0, -1.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 1.0
  );

  vec4 eye = vec4(offset, 1.0);
  vec4 to = vec4(magicPosition, 1.0);
  vec4 zAxis = to - eye;
  vec3 zAxis3 = normalize(vec3(zAxis[0], zAxis[1], zAxis[2]));
  vec3 xAxis3 = normalize(cross(vec3(0.0, 1.0, 0.0), zAxis3));
  vec3 yAxis3 = normalize(cross(zAxis3, xAxis3));
  mat4 lookAt = mat4(
    xAxis3, 0.0,
    yAxis3, 0.0,
    zAxis3, 0.0,
    0.0, 0.0, 0.0, 1.0
  );

  mat4 M = mat4(
    1.0, 0.0, 0.0, 0.0,
    0.0, 1.0, 0.0, 0.0,
    0.0, 0.0, 1.0, 0.0,
    0.0, 0.0, 0.0, 1.0
  );

  // Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
  gl_Position = projectionMatrix * viewMatrix * M * T * lookAt * R * S * vec4(position, 1.0);
}
