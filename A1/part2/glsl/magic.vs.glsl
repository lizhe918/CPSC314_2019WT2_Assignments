#version 300 es

// The uniform variable is set up in the javascript code and the same for all vertices
uniform vec3 magicPosition;

// HINT: YOU WILL NEED AN ADDITIONAL UNIFORM VARIABLE TO MAKE THE MAGIC CIRCLE DISTORTION
uniform float timer;

// The shared variable is initialized in the vertex shader and attached to the current vertex being processed,
// such that each vertex is given a shared variable and when passed to the fragment shader,
// these values are interpolated between vertices and across fragments,
// below we can see the shared variable is initialized in the vertex shader using the 'out' classifier
out vec2 vcsTexcoord;


void main() {

  	// We now give the shared variable its value,
  	// this specific one handles texture (uv) coordinates which will be covered later in the course
    vcsTexcoord = uv;

    // HINT: GLSL PROVIDES TRIG FUNCTIONS SIN(), COS(), & TAN()

  	// HINT: BE MINDFUL OF WHICH COORDINATE SYSTEM THE MAGIC CIRCLE'S POSITION IS IN

    vec4 orgPos = modelMatrix * vec4(position, 1.0);
    vec4 newPos = orgPos + vec4(magicPosition, 0.0);

    if (timer != 0.0) {
        newPos[1] = newPos[1] + tan(sin(cos(timer + newPos[0])));
    }

    // Multiply each vertex by the model matrix to get the world position of each vertex, 
    // then the view matrix to get the position in the camera coordinate system, 
    // and finally the projection matrix to get final vertex position
    gl_Position = projectionMatrix * viewMatrix * newPos;
}