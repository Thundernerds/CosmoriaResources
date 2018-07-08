#version 330

in vec2 position2D;
in vec3 mvVertexPos;
in mat4 outModelViewMatrix;

out vec4 fragColor;

struct DirectionalLight {
    vec3 colour;
    vec3 direction;
    float intensity;
};

float random(vec3 st, float seed) {
    return fract(sin(dot(st.xyz, vec3(12.9898, 78.233, 56.7823))) * seed);
}

vec3 merge(vec3 color1, vec3 color2, float opacity) {
    vec3 end = vec3(color1);
    end.x += ((color2.x - end.x) * opacity);
    end.y += ((color2.y - end.y) * opacity);
    end.z += ((color2.z - end.z) * opacity);

    return end;
}

struct Fog {
    float density;
    float start;
};

vec4 ambientC;
const vec4 diffuseC = vec4(0.5, 0.5, 0.5, 1.0);
const vec4 speculrC = vec4(0.5, 0.5, 0.5, 1.0);

vec4 calcLightColour(vec3 light_colour, float light_intensity, vec3 position, vec3 to_light_dir, vec3 normal) {
    vec4 diffuseColour = vec4(0, 0, 0, 0);
    vec4 specColour = vec4(0, 0, 0, 0);

    // Diffuse Light
    float diffuseFactor = max(dot(normal, to_light_dir), 0.0);
    diffuseColour = diffuseC * vec4(light_colour, 1.0) * light_intensity * diffuseFactor;

    // Specular Light
    // vec3 camera_direction = normalize(-position);
    vec3 from_light_dir = -to_light_dir;
    vec3 reflected_light = normalize(reflect(from_light_dir , normal));
    float specularFactor = max( dot(vec3(1.0, 1.0, 1.0), reflected_light), 0.0);
    specularFactor = pow(specularFactor, 0.5);
    specColour = speculrC * light_intensity * vec4(light_colour, 1.0);

    return (diffuseColour + specColour);
}

uniform vec3 ambientLight;
uniform DirectionalLight directionalLight;
uniform Fog fog;

const vec3 baseColor = vec3(221, 90, 42);

const float addSeeds[] = float[] (18342.2738743, 37623.23224534, 734632.287321);
const float addRadius = 15.0;

void main() {
    vec3 faceNormal = normalize(cross(dFdx(mvVertexPos), dFdy(mvVertexPos)));
    faceNormal = normalize((vec4(faceNormal, 1.0) * outModelViewMatrix).xyz);
    
    vec3 pos = vec3(floor(position2D), mod(position2D.y, 1.0) > mod(-position2D.x - 1.0, 1.0)? 0.0:1.0);
    vec3 c = baseColor + (vec3(random(pos, addSeeds[0]), random(pos, addSeeds[1]), random(pos, addSeeds[1])) * addRadius) - (addRadius * 0.5);
    c *= 0.00444;
    ambientC = vec4(c, 1.0);

    c *= calcLightColour(directionalLight.colour, directionalLight.intensity, mvVertexPos, normalize(directionalLight.direction), faceNormal).xyz;
    c *= ambientLight;

    float dist = min(max(0.0, distance(vec3(0.0), mvVertexPos) - fog.start) * fog.density, 1.0);

    // fragColor = mix(vec4(c, 1.0), fog.color, dist);
    fragColor = vec4(c, 1 - dist);
}