#version 140

in mediump vec3 var_texcoord0;

uniform fs_uniforms
{
    uniform mediump vec4 u_time;
};

out vec4 out_fragColor;

// pseudo random generator (white noise)
float rand(vec2 n)
{ 
    return fract(sin(dot(n, vec2(12.9898, 78.233))) * 43758.5453);
}

// value noise
float noise(vec2 p)
{
    vec2 ip = floor(p);
    vec2 u = fract(p);
    u = u * u * (3.0 - 2.0 * u);

    float x = mix(rand(ip),                  rand(ip + vec2(1.0, 0.0)), u.x);
    float y = mix(rand(ip + vec2(0.0, 1.0)), rand(ip + vec2(1.0, 1.0)), u.x);
    float a = u.y;
    float res = mix(x, y, a);
    return res * res;
}

// used to rotate domain of noise function
const mat2 rot = mat2( 0.80,  0.60, -0.60,  0.80 );

// fast implementation
float fbm( vec2 p )
{
    float f = 0.0;
    f += 0.500000 * noise( p ); p = rot * p * 2.02;
    f += 0.031250 * noise( p ); p = rot * p * 2.01;
    f += 0.250000 * noise( p - 0.1 * sin(u_time.x) + 0.8 * u_time.x); p = rot * p * 2.03;
    f += 0.125000 * noise( p + 0.1 * sin(u_time.x) + 0.8 * u_time.x ); p = rot * p * 2.01;
    f += 0.062500 * noise( p + 0.3 * sin(u_time.x) ); p = rot * p * 2.04;
    f += 0.015625 * noise( p );
    return f / 0.96875;
}

void main()
{
    // draw the image
/*     vec3 colorBlack = vec3(0);
    vec3 colorPink = vec3(0.07843137254, 0.01960784313, 0.1294117647);
    vec3 layer1 = mix(colorBlack, colorPink, S(0.3, -.1, (tuv*Rot(radians(-5.))).x)); */
    
    vec3 col = vec3(u_time);
    
    out_fragColor = vec4(vec3(fbm(var_texcoord0.xy * 0.1)), 1.0) * vec4(0.07843137254, 0.01960784313, 0.1294117647, 1.0);
}