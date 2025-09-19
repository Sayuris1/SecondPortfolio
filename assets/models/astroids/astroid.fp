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
        vec3 mcol = vec3(0.6);
        vec3 bcol = mcol/10;
        return colInterp(bcol, mcol, inCol);
}

vec3 color(vec3 p){ 
    return palette(p);
} 

void main()
{
    // Pre-multiply alpha since all runtime textures already are
    vec4 tint_pm = vec4(tint.xyz * tint.w, tint.w);
    vec4 sampled = texture(tex0, var_texcoord0.xy) * tint_pm;

    // Diffuse light calculations
    vec3 ambient_light = vec3(0.2);
    vec3 diff_light = vec3(normalize(var_light.xyz - var_position.xyz));
    diff_light = max(dot(var_normal,diff_light), 0.0) + ambient_light;
    diff_light = max(diff_light, 0.0);

    float time = (sin(u_time.x) + 1.4) * 2;
    out_fragColor = vec4(color(diff_light + time), 1.0);
}

