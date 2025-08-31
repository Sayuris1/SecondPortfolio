#version 140

in mediump vec2 var_texcoord0;

out vec4 out_fragColor;

uniform mediump sampler2D tex0;
uniform fs_uniforms
{
    uniform mediump vec4 u_time;
    uniform mediump vec4 u_res;
};

void main()
{
    float ResS = u_res.x;
	float ResT = u_res.y;

    vec2 distance = u_res.zw;

	vec2 stp0 = vec2(1.0/ResS, 0.0);
	vec2 st0p = vec2(0.0, 1.0/ResT);
	vec2 stpp = vec2(1.0/ResS, 1.0/ResT);
	vec2 stpm = vec2(1.0/ResS, -1.0/ResT);

	vec4 i00 = texture(tex0, var_texcoord0);
	vec4 im1m1 = texture(tex0, var_texcoord0-stpp*distance.x);
	vec4 ip1p1 = texture(tex0, var_texcoord0+stpp*distance.x);
	vec4 im1p1 = texture(tex0, var_texcoord0-stpm*distance.x);
	vec4 ip1m1 = texture(tex0, var_texcoord0+stpm*distance.x);
	vec4 im10 = texture(tex0, var_texcoord0-stp0*distance.x);
	vec4 ip10 = texture(tex0, var_texcoord0+stp0*distance.x);
	vec4 i0m1 = texture(tex0, var_texcoord0-st0p*distance.x);
	vec4 i0p1 = texture(tex0, var_texcoord0+st0p*distance.x);

	vec4 target = vec4 (0.0, 0.0, 0.0, 0.0);
	target += 1.0*(im1m1+ip1m1+ip1p1+im1p1); 
	target += 2.0*(im10+ip10+i0p1);
	target += 4.0*(i00);
	target /= 16.0;

	target.rgb *= 2;

    out_fragColor = target;
}