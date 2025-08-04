#version 140
#define SHADES 4.0

in highp vec4 var_position;
in mediump vec3 var_normal;
in mediump vec2 var_texcoord0;

out vec4 out_fragColor;

uniform mediump sampler2D tex0;

uniform vs_uniformss
{
    uniform mediump vec4 u_time;
};

vec3 lightPos;

vec3 diff(){
    vec3 diff_light = vec3(normalize(lightPos.xyz - var_position.xyz));
    diff_light = max(dot(var_normal,diff_light), 0.0) + vec3(0.2);
    return clamp(diff_light, 0.0, 1.0);
}

vec3 colInterp(vec3 bcol, vec3 ecol, vec3 inCol){
    float st = 1.0 / SHADES;
    float avg = inCol.x * SHADES; 
    float band = ceil(avg) / SHADES;
    band = max(0.0, band - st);
    return mix(bcol, ecol, band);
}

vec3 palette(vec3 inCol){
        vec3 mcol = vec3(0.95);
        vec3 bcol = mcol/4;
        return colInterp(bcol, mcol, inCol);
}

vec3 color(){ 
    return palette(diff());
} 


void main()
{
	//float text = texture(tex0, var_texcoord0.xy + u_time.y).x * 2 - 1;
	//float tex = sin(u_time.x * 0.3) * 2 - 1;
	//float tex2 = cos(u_time.x + 0.6 * 0.2) * 2 - 1;
    //lightPos = vec3(tex + text, tex2 + text, -6.0);

    //vec3 col = color();

	vec4 tex = texture(tex0, var_texcoord0.xy);
    out_fragColor = vec4(tex);;
}