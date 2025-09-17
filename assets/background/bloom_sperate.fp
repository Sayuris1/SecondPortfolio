#version 140

in mediump vec2 var_texcoord0;

out vec4 out_fragColor;

uniform mediump sampler2D tex0;
uniform fs_uniforms
{
    uniform mediump vec4 u_time;
};

void main()
{
	vec4 col = texture(tex0, var_texcoord0);
    float Threshold = 1;

    float brightness = max(col.r, max(col.g, col.b));
    float contribution = max(0, brightness - Threshold);
    contribution /= max(brightness, 0.00001);

    out_fragColor = col * contribution;
}