#version 300 es

uniform vec3 offset;
uniform vec3 magicPosition;

void main() {

    float scale = length(offset - magicPosition);

    mat4 S = mat4(
        1.0, 0.0, 0.0, 0.0,
        0.0, scale, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        0.0, 0.0, 0.0, 1.0
    );

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


    // Multiply each vertex by the model matrix to get the world position of each vertex, 
    // then the view matrix to get the position in the camera coordinate system, 
    // and finally the projection matrix to get final vertex position
    gl_Position = projectionMatrix * viewMatrix * T * lookAt * R * S * vec4( position, 1.0 );

}