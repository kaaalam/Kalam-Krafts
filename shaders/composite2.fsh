#include "blur_utility.glsl"
#version 120

varying vec2 outTexCoord;

uniform sampler2D colortex0;
uniform float viewWidth;
uniform float viewHeight;

vec2 texelSize = vec2(1.0/viewWidth, 1.0/viewHeight);
/*
const int colortex0Format = RGBA32F;
*/


void main() 
{
    /*
    vec4 blurredResult = vec4(0.0f,0.0f,0.0f,0.0f);
    int i,j;
    int kernelSize = 3;
    float gaussianWeightSum = 0.0;  
    for(i = 0; i < kernelSize; i++) {
        for(j = 0; j < kernelSize; j++) {
            vec2 offset = vec2(i, j) * texelSize.xy;
            float gaussian = Gaussian2D(i, j, 4.0);
            gaussianWeightSum += gaussian;
            blurredResult += texture2D(colortex0, outTexCoord+offset.xy) * gaussian;
        }
    }
    blurredResult/= gaussianWeightSum;
    */

    //here, we are just performing a gaussian blur and write it out to DB 4
    /* DRAWBUFFERS:4*/
    //gl_FragData[0] = blurredResult;
}