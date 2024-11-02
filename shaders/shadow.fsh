#version 120 

varying vec2 outTexCoord;
varying vec4 color;

uniform sampler2D texture;
void main()
{
    gl_FragData[0] = texture2D(texture, outTexCoord) * color;
}