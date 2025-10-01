#version 140
#define SHADES 1

in highp vec4 var_position;
in highp vec4 var_position_local;
in mediump vec3 var_normal;
in mediump vec2 var_texcoord0;
in mediump vec4 var_light;

out vec4 out_fragColor;

uniform mediump sampler2D tex0;

uniform fs_uniforms
{
    mediump vec4 tint;
    mediump vec4 u_time;
};

vec3 colInterp(vec3 bcol, vec3 ecol, vec3 inCol){
    float st = 1.0 / SHADES;
    float avg = inCol.x * SHADES; 
    float band = ceil(avg) / SHADES;
    band = max(0.0, band - st);
    return mix(bcol, ecol, band);
}

vec3 palette(vec3 inCol){
/*         vec3 mcol = vec3(0.6);
        vec3 bcol = mcol/10; */
        vec3 mcol = vec3(0.28235294117, 0.07450980392, 0.29019607843) * 2;
        vec3 bcol = vec3(0.07843137254, 0.01960784313, 0.1294117647) * 2;
        return colInterp(bcol, mcol, inCol);
}

vec3 color(vec3 p){ 
    return palette(p);
} 

void main()
{
    float time = (sin(u_time.x) + 1.4) * 2;
    out_fragColor = vec4(vec3(time) * vec3(0.28235294117, 0.07450980392, 0.29019607843) * 2, 1.0);
}

