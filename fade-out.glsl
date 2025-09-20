vec4 effect(vec4 color, Image tex, vec2 texCoord, vec2 screenCoord)
{
    vec4 pixel = Texel(tex, texCoord) * color;
    float fade = smoothstep(0.0, 0.25, texCoord.y);
    pixel.rgb *= fade;
    return pixel;
}
