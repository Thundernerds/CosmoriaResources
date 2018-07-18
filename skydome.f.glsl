#version 330

out vec4 fragColor;

in vec3 outPos;

uniform vec3 color1;
uniform vec3 color2;

uniform sampler2D sun;
uniform vec3 sunDirection;
uniform vec2 sunLine;

const float lowerStart = 0.025;
const float gradZone = 0.075;
const float mul = 1.0 / (gradZone * 2.0);

const float sunShrink = 1.2;

float range(float f, float mi, float ma) {
	return min(max(f, mi), ma);
}

vec2 intersection(vec2 line1, vec2 line2) {
	float x = (line1.y - line2.y) / (line1.x - line2.x);
    float y = (line1.x * x) + line1.y;

    return vec2(x, y);
}

void main() {
	sun; sunDirection;
	// float x = (((outPos.x - sunDirection.x) * 10) + 1) * 0.5;
	// float y = (((outPos.z - sunDirection.z) * 10) + 1) * 0.5;

	// vec2 pos = vec2(y, x);
	// pos *= sunShrink;
	// pos += (1.0 - sunShrink) / 2.0;
	
	// vec4 nColor = texture(sun, pos);
	// if (nColor.a != 0) {
	// 	fragColor = nColor;
	// 	return;
	// }

	// float dist = distance(sunDirection, outPos);
	// if (dist < 0.1) {
	// 	fragColor = vec4(1.0, 0, 0, 1.0);
	// 	return;
	// }
	// fragColor = vec4(0, 0, 0, 1.0);
	
	// color1; color2;

	vec3 angle = sunDirection - outPos;
	// fragColor = vec4(angle, 1.0);

	float dist = ((lowerStart - outPos.y) + gradZone) * mul;
	dist = range(dist, 0.0, 1.0);	
	// color1; color2;
	fragColor = vec4(mix(color1, color2, dist), 1.0);
	// fragColor = vec4(sunLine, 0.0, 1.0);
	sunLine;

}