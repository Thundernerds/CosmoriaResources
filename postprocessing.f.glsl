#version 330

uniform sampler2D frameBufferTexture;

in vec2 outPos;
out vec4 fragColor;

uniform float time;

void main() {
	time;
	vec4 tex = texture(frameBufferTexture, outPos);
	fragColor = vec4(tex.xyz, 1.0);
}