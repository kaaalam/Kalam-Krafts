#version 120
#include "fog_utility.glsl"

uniform sampler2D colortex0;
uniform sampler2D colortex2;
uniform sampler2D depthtex0;
uniform float near;
uniform float far; 
uniform float rainStrength;

/*
const int colortex0Format = RGBA32F;
const int colortex2Format = RGBA32F;
*/

varying vec2 outTexCoord;

void main() {
    vec3 color = texture2D(colortex0, outTexCoord).rgb;
    float mask = 1 - texture2D(colortex2, outTexCoord).r;
    float depth = texture2D(depthtex0, outTexCoord).r;
    depth = LinearDepth(depth, near, far);
    float viewDistance = (depth * far) - near;
    float fogFactor = 1 - clamp(FogFactorExponential(viewDistance), 0.0,1.0);
    fogFactor *= mask;
    vec3 fogColor = vec3(0.82f, 0.83f, 0.9f);
    vec3 fogged = mix(color, fogColor, fogFactor);
    /* DRAWBUFFERS:0*/
    gl_FragData[0] = vec4(fogged, 1.0);

}