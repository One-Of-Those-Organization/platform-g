// pixelate.glsl
extern number pixelSize;

vec4 effect(vec4 color, Image tex, vec2 texCoords, vec2 screenCoords)
{
    // snap the screen coordinates to pixelSize blocks
    vec2 snapped = floor(screenCoords / pixelSize) * pixelSize;
    vec2 uv = snapped / love_ScreenSize.xy;

    // since it's just solid geometry, sample normally
    return Texel(tex, uv) * color;
}

