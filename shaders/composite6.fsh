#version 120
#include "fog_utility.glsl"

uniform sampler2D colortex0;
uniform sampler2D colortex2;
uniform sampler2D depthtex0;
uniform float near;
uniform float far; 
uniform float rainStrength;
uniform float sunAngle;
uniform mat4 gbufferProjectionInverse;

/*
const int colortex0Format = RGBA32F;
const int colortex2Format = RGBA32F;
*/

varying vec2 outTexCoord;

void main() {
    /*
    vec3 color = texture2D(colortex0, outTexCoord).rgb;
    float torchMask = 1 - texture2D(colortex2, outTexCoord).r;
    float depth = texture2D(depthtex0, outTexCoord).r;
    depth = LinearDepth(depth, near, far);
    float viewDistance = (depth * far) - near;
    float density = 0.01;
    float fogFactor = FogFactorExponential(viewDistance, density);
    fogFactor = 1 - clamp(fogFactor, 0.0,1.0);
    fogFactor *= torchMask;
    vec3 fogColor = vec3(0.82f, 0.83f, 0.9f);
    fogColor *= mix(1.0f, 0.2f, rainStrength);
    vec3 fogged = mix(color, fogColor, fogFactor);
    gl_FragData[0] = vec4(fogged, 1.0);
    */
    float depth = texture2D(depthtex0, outTexCoord).r;
    vec3 color = texture2D(colortex0, outTexCoord).rgb;
    if(depth == 1.0){
        gl_FragData[0] = vec4(color, 1.0);
        return;
    }
    float torchMask = 1 - texture2D(colortex2, outTexCoord).r;
    vec3 screenSpace = vec3(outTexCoord, depth); //xyz
    vec3 clipSpace = (screenSpace * 2.0f) - 1.0f; 
    vec4 worldSpace =  gbufferProjectionInverse * vec4(clipSpace,1.0f);
    vec3 viewSpace = worldSpace.xyz / worldSpace.w;
    float distance = length(viewSpace) / far;
    float fogFactor = 0.0;
    if(sunAngle > 0.0 && sunAngle < 0.5) {
        fogFactor = FogFactorExponential(distance, 5.0);
    }else {
        fogFactor = clamp(FogFactorExponential(distance, 15.0) - 0.05, 0.0, 0.1);
    }
    
    fogFactor *= torchMask;
    vec3 fogColor = vec3(0.82f, 0.83f, 0.9f);
    vec3 fogged = mix(color.rgb, fogColor, clamp(fogFactor, 0.0,1.0));
    /* DRAWBUFFERS:0 */
    gl_FragData[0] = vec4(fogged, 1.0);
    



}