#version 330

out vec4 fragColor;

in vec3 outPos;

uniform vec3 color1;
uniform vec3 color2;

void main() {
	// fragColor = vec4(distance(outPos, vec3(0, 1, 0)) / 2);
	// float c = (time + 1.0) / 2.0;
	// if (outPos.y > 0.1) {
		fragColor = vec4(color1, 1.0);
	// } else {
		// fragColor = vec4(color2, 1.0);
	// }
	color2;
}