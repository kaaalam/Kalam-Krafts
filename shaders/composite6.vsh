#version 120
#include "blur_utility.glsl"

varying vec2 outTexCoord;

void main()
{
    gl_Position = ftransform();
    outTexCoord = gl_MultiTexCoord0.xy;
}