#version 140
#define SHADES 4.0

in highp vec4 var_position;
in mediump vec2 var_texcoord0;

out vec4 out_fragColor;

uniform mediump sampler2D tex0;

uniform vs_uniformss
{
    uniform mediump vec4 u_time;
};

vec3 camPos;
vec3 lightPos;

float smin( float a, float b, float k )
{
    k *= 1.0;
    float r = exp2(-a/k) + exp2(-b/k);
    return -k*log2(r);
}

float map(vec3 p){
    float t0 = sin(u_time.x * 0.2) * .46;
	float t1 = sin(u_time.x * 0.1) * .9;
	float t2 = cos(u_time.x * 1.4) * .87;
	float t3 = cos(u_time.x * 3.4);
	float tc = texture(tex0, var_texcoord0.xy + sin(u_time.x * 0.5)).x * 1.3;

    float sphere = length(p + vec3(0.0, -0.5, 0.0) + vec3(t0, t1, 1.0)) - 1.20;
    float sphere2 = length(p + vec3(t1, t2, 1.0)) - 0.66;
    float sphere3 = length(p + vec3(t2, t3, 1.0)) - 0.58;
    float sphere4 = length(p + vec3(tc, t3, 1.0)) - 0.90;
    float sphere5 = length(p + vec3(t2, tc, 1.0)) - 0.60;
    
    return smin(sphere, smin(sphere2, smin(sphere3, smin(sphere4, sphere5, 0.2), 0.2), 0.2), 0.2);
}

vec3 normal(vec3 p){
    return normalize(vec3(map(vec3(p.x + 0.0001, p.yz)) - map(vec3(p.x - 0.0001, p.yz)),
                          map(vec3(p.x, p.y + 0.0001, p.z)) - map(vec3(p.x, p.y - 0.0001, p.z)),
                	      map(vec3(p.xy, p.z + 0.0001)) - map(vec3(p.xy, p.z - 0.0001))));
}

vec3 diff(vec3 c, float k, vec3 p){
    vec3 n = normal(p);
    vec3 l = normalize(lightPos - p);
    return c * k * max(0.0, dot(n, l));
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

vec3 color(vec3 p){ 
    return palette(diff(vec3(1.0), 1.0, p));
} 

float trace(vec3 ro, vec3 rd){
    float t = 0.0;
    float d = 0.0;
    int inter = 0;
    for(int i = 0; i < 2000; i++){
        d = map(ro + rd * t);
        if(d < 0.0001){
            inter = 1;
            break;
        }
        t += d;
        if(t > 50.0){
            break;
        }
    }
    if(inter == 0){
        t = -1.0;
    }
    return t;
}

void main()
{
   	vec2 uv = var_texcoord0;
    uv = uv * 2.0 - 1.0;

	float text = texture(tex0, var_texcoord0.xy + u_time.yz).x * 2 - 1;
	float tex = sin(u_time.x * 0.3) * 2 - 1;
	float tex2 = cos(u_time.x + 0.6 * 0.2) * 2 - 1;
    camPos = vec3(0.0 , 0.0, -4.0);
    lightPos = vec3(tex + text, tex2 + text, -6.0);

    vec3 ro = camPos;
    vec3 rd = normalize(vec3(uv, 1.0));

    float d = trace(ro, rd);

    vec3 c = ro + rd * d;

    vec3 col = vec3(1.0);

    if(d > 0.0){
    	col = color(c);
    	col * d;
    }else{
        col = vec3(0.0);
    }

    out_fragColor = vec4(col, 1.0);;
}