#version 140

in mediump vec2 var_texcoord0;
in mediump vec3 var_texcoord1;

out vec4 out_fragColor;

uniform mediump sampler2D tex0;
uniform samplerCube cubemap;
uniform fs_uniforms
{
    uniform mediump vec4 u_time;
};

#define S(a,b,t) smoothstep(a,b,t)

mat2 Rot(float a)
{
    float s = sin(a);
    float c = cos(a);
    return mat2(c, -s, s, c);
}


vec2 hash( vec2 p )
{
    p = vec2( dot(p,vec2(2127.1,81.17)), dot(p,vec2(1269.5,283.37)) );
	return fract(sin(p)*43758.5453);
}

float noise( in vec2 p )
{
    vec2 i = floor( p );
    vec2 f = fract( p );
	
	vec2 u = f*f*(3.0-2.0*f);

    float n = mix( mix( dot( -1.0+2.0*hash( i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ), 
                        dot( -1.0+2.0*hash( i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),
                   mix( dot( -1.0+2.0*hash( i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ), 
                        dot( -1.0+2.0*hash( i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);
	return 0.5 + 0.5*n;
}


void main()
{
    vec2 uv = var_texcoord0.xy;
    float ratio = 1;

    vec2 tuv = uv;
    tuv -= .5;

    // rotate with Noise
	float degree = texture(tex0, vec2(u_time.x * 0.01, tuv.x*tuv.y)).x * 0.5;
    degree = texture(cubemap, var_texcoord1 + u_time.x).x * 0.5;

    tuv.y *= 1./ratio;
    tuv *= Rot(radians((degree-.5)*720.+180.));
	tuv.y *= ratio;

    
    // Wave warp with sin
    float frequency = 5.;
    float amplitude = 30.;
    float speed = u_time.x * 2;
    tuv.x += sin(tuv.y*frequency+speed)/amplitude;
   	tuv.y += sin(tuv.x*frequency*1.5+speed)/(amplitude*.5);
    
    
    // draw the image
    vec3 colorPurple = vec3(0.28235294117, 0.07450980392, 0.29019607843);
    vec3 colorPink = vec3(0.07843137254, 0.01960784313, 0.1294117647);
    vec3 layer1 = mix(colorPurple, colorPink, S(-.5, -.1, (tuv*Rot(radians(-5.))).x));
    
    vec3 colorRed = vec3(0.45882352941, 0.14117647058, 0.37647058823) * 0.3;
    vec3 colorDeepBlue = vec3(0.27058823529, 0.32549019607, 0.61176470588) * 0.6;
    vec3 layer2 = mix(colorRed, colorDeepBlue, S(-.5, .2, (tuv*Rot(radians(-5.))).x));
    
    vec3 finalComp = mix(layer1, layer2, S(-0.3, 0.9, tuv.y));
    
    vec3 col = finalComp;
    
    out_fragColor = vec4(col * u_time.y, 1.0);
}