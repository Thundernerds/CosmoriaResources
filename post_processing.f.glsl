#version 330

uniform sampler2D colorTexture;
uniform sampler2D depthTexture;

in vec2 outPos;
out vec4 fragColor;

struct Fog {
    float density;
    float start;
};

uniform float time;
uniform Fog fog;

float linearizeDepth(float zoverw){
	float n = 0.01; // camera z near
	float f = 4000.0; // camera z far
	return (2.0 * n) / ((f + n) - (zoverw * (f - n)));
}

vec4 blur(float dist) {
	return (texture(colorTexture, vec2(outPos.x, outPos.y)) +
			texture(colorTexture, vec2(outPos.x, outPos.y + dist)) +
			texture(colorTexture, vec2(outPos.x, outPos.y - dist)) +
			texture(colorTexture, vec2(outPos.x + dist, outPos.y)) +
			texture(colorTexture, vec2(outPos.x - dist, outPos.y)) +
			texture(colorTexture, vec2(outPos.x - dist, outPos.y - dist)) + 
			texture(colorTexture, vec2(outPos.x + dist, outPos.y + dist)) + 
			texture(colorTexture, vec2(outPos.x + dist, outPos.y - dist)) + 
			texture(colorTexture, vec2(outPos.x - dist, outPos.y + dist))) / 9.0;
}


void main() {
	time; fog.density; fog.start; depthTexture;

	fragColor = texture(colorTexture, outPos);
}