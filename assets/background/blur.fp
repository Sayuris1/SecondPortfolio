#version 140
#define pi 3.1415926535897932384626433832795

in mediump vec2 var_texcoord0;

out vec4 out_fragColor;

uniform mediump sampler2D tex0;
uniform fs_uniforms
{
    uniform mediump vec4 u_res;
};

void main()
{
	float Directions = 16.0; // BLUR DIRECTIONS (Default 16.0 - More is better but slower)
	float Quality = 10.0; // BLUR QUALITY (Default 4.0 - More is better but slower)
	float Size = 20.0; // BLUR SIZE (Radius)

	vec2 Radius = Size/u_res.xy;

	// Normalized pixel coordinates (from 0 to 1)
	vec2 uv = var_texcoord0.xy;
	// Pixel colour
	vec4 Color = texture(tex0, uv);

	for( float d=0.0; d<pi; d+=pi/Directions)
	{
		for(float i=1.0/Quality; i<=1.0; i+=1.0/Quality)
		{
			Color += texture(tex0, uv+vec2(cos(d),sin(d))*Radius*i);		
		}
	}

	Color /= Quality * Directions - 15.0;
	gl_FragColor =  Color;
}