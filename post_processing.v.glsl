#version 330

layout (location=0) in vec2 position;

out vec2 outPos;

void main() {
	gl_Position = vec4(position, 0.0, 1.0);
	outPos = (position + 1.0) / 2.0;
}