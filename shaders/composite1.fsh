#version 120
#include "color_correction.glsl"

varying vec2 outTexCoord;

uniform sampler2D colortex0;
uniform sampler2D depthtex0;
/*
const int colortex0Format = RGBA32F;
*/


void main() {
   vec3 color = texture2D(colortex0,outTexCoord).rgb;
   float depth = texture2D(depthtex0, outTexCoord).r;
   vec3 contrastedColor = AdjustSaturation(color, 2.2f);
   vec3 saturatedColor = AdjustContrastAndBrightness(color, 1.1f, 0.05f);
   color = mix(contrastedColor, saturatedColor, 0.6f);
    /* DRAWBUFFERS:0 */
   gl_FragData[0] = vec4(color, 1.0f);
}