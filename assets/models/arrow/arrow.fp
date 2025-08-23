#version 140

in highp vec4 var_position;
in mediump vec3 var_normal;
in mediump vec2 var_texcoord0;
in mediump vec4 var_light;

out vec4 out_fragColor;

uniform mediump sampler2D tex0;

uniform fs_uniforms
{
    mediump vec4 tint;
};

void main()
{
    vec3 lightPos = vec3(0, 0, 15);

    vec4 tint_pm = vec4(tint.xyz * tint.w, tint.w);
    //vec4 color = texture(tex0, var_texcoord0.xy) * tint_pm;
    vec4 color = vec4(1.0);

    vec3 ambient_light = vec3(0.2);
    vec3 diff_light = vec3(normalize(lightPos - var_position.xyz));
    diff_light = max(dot(var_normal,diff_light), 0.0) + ambient_light;
    diff_light = clamp(diff_light, 0.0, 1.0) * 0.2;

    vec3 viewDirection = normalize(vec3(0.0, 0.0, 15.0) - var_position.xyz);
    vec3 reflectDirection = normalize(reflect(-lightPos, var_normal));
    float spec = pow(max(dot(viewDirection, reflectDirection), 0.0), 128);
    vec3 specular = 0.5 * spec * vec3(1.0, 1.0, 1.0);  

    out_fragColor = vec4(color.rgb*(diff_light+specular),1.0);
}