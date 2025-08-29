#version 140

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

void main()
{
    // Pre-multiply alpha since all runtime textures already are
    vec4 tint_pm = vec4(tint.xyz * tint.w, tint.w);
    vec4 color = texture(tex0, var_texcoord0.xy) * tint_pm;

    // Diffuse light calculations
    vec3 ambient_light = vec3(0.2);
    vec3 diff_light = vec3(normalize(var_light.xyz - var_position.xyz));
    diff_light = max(dot(var_normal,diff_light), 0.0) + ambient_light;
    diff_light = clamp(diff_light, 0.0, 1.0);

    vec2 new_local = vec2(var_position_local.x, var_position_local.y);
    float d = 1 / (length(new_local)) * sin(u_time.x * 3) * 0.05;

    //out_fragColor = vec4(col);
    out_fragColor = vec4(d * diff_light, 1.0);
}

