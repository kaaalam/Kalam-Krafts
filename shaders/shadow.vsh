#version 120 
#include "shadow_utility_functions.glsl"
varying vec2 outTexCoord;
varying vec4 color;
void main()
{
    gl_Position = ftransform();
    gl_Position.xy = distortPosition(gl_Position.xy);
    color = gl_Color;
    outTexCoord = gl_MultiTexCoord0.xy;
}