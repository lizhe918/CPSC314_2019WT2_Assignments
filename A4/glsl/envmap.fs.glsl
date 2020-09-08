#version 300 es

in vec3 vcsNormal;
in vec3 vcsPosition;

out vec4 out_FragColor;

uniform samplerCube skyboxCubemap;

void main( void ) {

  // Q4 : Calculate the vector that can be used to sample from the cubemap
  // Q4 Answer
  // Compute the bounce vector in camera frame using reflect()
  // then convert it to the world frame,
  // finally use texture() to perform texture mapping.
  vec3 N = normalize(vcsNormal);
  vec3 B = reflect(vcsPosition, N);
  vec3 R = vec3(inverse(viewMatrix) * vec4(B, 0.0));

  out_FragColor = texture(skyboxCubemap, R);
}
