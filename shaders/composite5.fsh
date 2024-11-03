#version 120
#include "blur_utility.glsl"

varying vec2 outTexCoord;

uniform sampler2D colortex0;
uniform sampler2D colortex5;
uniform float viewWidth;
uniform float viewHeight;
/*
const int colortex0Format = RGBA32F;
const int colortex5Format = RGBA32F;
*/

vec2 texelSize = vec2(1.0/viewWidth, 1.0/viewHeight);

void main() {
    vec4 blurredHighlights = vec4(0.0f,0.0f,0.0f,0.0f);
    int i,j;
    int kernelSize = 7;
    float gaussianWeightSum = 0.0;  
    for(i = 0; i < kernelSize; i++) {
        for(j = 0; j < kernelSize; j++) {
            vec2 offset = vec2(i, j) * texelSize.xy;
            float gaussian = Gaussian2D(i, j, 7.0);
            gaussianWeightSum += gaussian;
            blurredHighlights += texture2D(colortex5, outTexCoord+offset.xy) * gaussian;
        }
    }
    blurredHighlights/= gaussianWeightSum;



    vec3 color = texture2D(colortex0, outTexCoord).rgb;
    color = mix(color, blurredHighlights.rgb, 0.2);

    /* DRAWBUFFERS:0*/
    gl_FragData[0] = vec4(color, 1.0);
}