#version 330

in vec2 outTexCoord;
in vec3 mvPos;
out vec4 fragColor;

uniform sampler2D texture_sampler;
uniform vec4 color;
uniform int hasTexture;

void main() {
    if (hasTexture == 1) {
        fragColor = color * texture(texture_sampler, outTexCoord);
        // if (fragColor.a == 0) discard;
        // fragColor.a = 1.0;
        // fragColor = vec4(1.0);
    } else {
        fragColor = color;
    }
}