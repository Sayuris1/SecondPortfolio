#version 140

in mediump vec2 var_texcoord0;

out vec4 out_fragColor;

uniform mediump sampler2D tex0;
uniform mediump sampler2D tex1;
uniform fs_uniforms
{
    uniform mediump vec4 u_time;
};

float softLight( float s, float d )
{
	return (s < 0.5) ? d - (1.0 - 2.0 * s) * d * (1.0 - d) 
		: (d < 0.25) ? d + (2.0 * s - 1.0) * d * ((16.0 * d - 12.0) * d + 3.0) 
					 : d + (2.0 * s - 1.0) * (sqrt(d) - d);
}

void main()
{
	vec4 col = texture(tex0, var_texcoord0);
	vec4 col1 = texture(tex1, var_texcoord0);

    const float gamma = 1.2;
    const float exposure = 1;
    vec3 hdrColor = col.rgb * col.a + col1.rgb * (1 - col1.a);
  
    vec3 mapped = vec3(1.0) - exp(-hdrColor * exposure);

    mapped = pow(mapped, vec3(1.0 / gamma));
  
    out_fragColor = vec4(mapped, 1.0);
}