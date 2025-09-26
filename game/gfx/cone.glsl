#ifdef VERTEX
vec4 position(mat4 transform_projection, vec4 vertex_position)
{
    return transform_projection * vertex_position;
}
#endif

#ifdef PIXEL
extern vec2 lightPosition; // Position of light in normalized coordinates (0-1)
extern number coneAngle;   // Angle of the cone (0-1, where 1 is 180 degrees)
extern number softness;    // Softness of the cone edges (0-1)
extern number dropoff;     // Light intensity dropoff (1.0 = linear, 2.0 = quadratic)
extern vec3 lightColor;    // Color of the light
extern vec2 direction;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    // Get the screen dimensions
    vec2 resolution = love_ScreenSize.xy;

    // Convert screen coordinates to normalized space (0-1)
    vec2 normalizedCoords = screen_coords / resolution;

    // Calculate direction from light to current pixel
    vec2 lightDir = normalize(normalizedCoords - lightPosition);

    // Reference direction (pointing down)
    vec2 coneDir = direction;

    // Calculate angle between current pixel and cone direction
    float angle = acos(dot(lightDir, coneDir)) / 3.14159;

    // Calculate distance from light
    float distance = length((normalizedCoords - lightPosition) * resolution);

    // Calculate cone mask with soft edges
    float coneMask = 1.0 - smoothstep(coneAngle - softness, coneAngle + softness, angle);

    // Calculate distance attenuation
    float attenuation = 1.0 / pow(1.0 + distance * 0.007, dropoff);

    // Combine everything
    vec4 texcolor = Texel(tex, texture_coords);
    vec3 finalColor = texcolor.rgb * lightColor * coneMask * attenuation;

    return vec4(finalColor, texcolor.a);
}
#endif
