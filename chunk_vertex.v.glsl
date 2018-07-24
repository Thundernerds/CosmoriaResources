#version 330

layout (location=0) in vec3 position;
layout (location=1) in vec2 displacement;

out vec3 mvVertexPos;
out vec2 position2D;
out vec3 noRotVertexPos;

uniform mat4 modelViewMatrix;
uniform mat4 modelViewMatrixNoRot;

uniform mat4 projectionMatrix;

const float width;

void main() {
	position2D = vec2((position.x + 0.5) * width, (position.z + 0.5) * width);

	vec4 nPos = vec4(position + vec3(displacement.x, displacement.y, 0), 1.0);

    vec4 mvPos = modelViewMatrix * nPos;
    noRotVertexPos = (modelViewMatrixNoRot * nPos).xyz;

    mvVertexPos = mvPos.xyz;
    gl_Position = projectionMatrix * mvPos;
}