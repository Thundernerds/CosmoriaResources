#version 330

out vec4 fragColor;

in vec3 outPos;

uniform vec3 color1;
uniform vec3 color2;

uniform sampler2D sun;
uniform vec3 sunDirection;

const float lowerStart = 0.025;
const float gradZone = 0.075;
const float mul = 1.0 / (gradZone * 2.0);

float range(float f, float mi, float ma) {
	return min(max(f, mi), ma);
}

void main() {
	float dist = ((lowerStart - outPos.y) + gradZone) * mul;
	dist = range(dist, 0.0, 1.0);	
	fragColor = vec4(mix(color1, color2, dist), 1.0);
	vec4 sunColor = texture(sun, outPos.xy);
	if (sunColor.a != 0.0) fragColor = sunColor.rgba;
	sunDirection;
}