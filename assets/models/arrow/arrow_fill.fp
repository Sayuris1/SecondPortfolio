#version 140

in mediump vec2 var_texcoord0;

out vec4 out_fragColor;

uniform mediump sampler2D texture_sampler;
uniform mediump sampler2D tex0;

uniform fs_uniforms
{
    mediump vec4 tint;
    mediump vec4 u_fill;
};

void main()
{
    // Pre-multiply alpha since all runtime textures already are
    mediump vec4 tint_pm = vec4(tint.xyz * tint.w, tint.w);

    float y_pos = step(var_texcoord0.y, u_fill.x + 0.45 + texture(tex0, var_texcoord0.xy * 3 + u_fill.y).y * 0.1);

    out_fragColor = texture(texture_sampler, var_texcoord0.xy) * tint_pm * y_pos;
}
