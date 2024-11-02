#version 120


varying vec2 outTexCoord;

void main()
{
    gl_Position = ftransform();
    outTexCoord = gl_MultiTexCoord0.xy;
}