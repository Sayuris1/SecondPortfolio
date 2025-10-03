#version 140
#define SHADES 1

in highp vec4 var_position;
in highp vec4 var_position_local;
in mediump vec3 var_normal;
in mediump vec2 var_texcoord0;
in mediump vec4 var_light;

out vec4 out_fragColor;

uniform fs_uniforms
{
    mediump vec4 tint;
};

void main() {

    gl_FragColor = vec4(tint.xyz * 5, 1);
}