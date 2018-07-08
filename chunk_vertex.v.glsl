#version 330

layout (location=0) in vec3 position;

out vec3 mvVertexPos;
out vec2 position2D;
out mat4 outModelViewMatrix;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;

const float width = 64.0;

float random(vec2 st, float seed) {
    return fract(sin(dot(st, vec2(78.233, 56.7823))) * seed);
}

void main() {
	position2D = vec2((position.x + 0.5) * width, (position.z + 0.5) * width);

	vec3 displacement = vec3(0.0);
	if (abs(position.x) != 0.5 && abs(position.z) != 0.5) {
		displacement.x += random(position2D, 1823.623);
		displacement.y += random(position2D, 2732.8273);
		displacement *= 0.01;
	}

    vec4 mPos = modelViewMatrix * vec4(position + displacement, 1.0);
    gl_Position = projectionMatrix * mPos;
    mvVertexPos = mPos.xyz;
    outModelViewMatrix = modelViewMatrix;
}