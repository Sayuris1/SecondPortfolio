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
	float brightness = dot(col.rgb, vec3(0.2126, 0.7152, 0.0722));

    if(brightness > 1.0)
        out_fragColor = vec4(col.rgb, 1.0);
    else
        out_fragColor = vec4(0.0, 0.0, 0.0, 1.0);
}