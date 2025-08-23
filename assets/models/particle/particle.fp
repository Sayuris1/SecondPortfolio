#version 140
#define SHADES 4.0

in highp vec4 var_position;
in mediump vec3 var_normal;
in mediump vec2 var_texcoord0;

out vec4 out_fragColor;

uniform mediump sampler2D tex0;

vec3 lightPos;

void main()
{
	vec4 tex = texture(tex0, var_texcoord0.xy);
    out_fragColor = vec4(tex);;
}