#version 120
varying vec2 outTexCoord;
varying vec3 normal;
varying vec4 color;
varying vec2 lightMapCoordinates;

void main() {
    gl_Position = ftransform();
    outTexCoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    lightMapCoordinates = mat2(gl_TextureMatrix[1]) * gl_MultiTexCoord1.xy;
    lightMapCoordinates = (lightMapCoordinates * 33.05f / 32.0f) - (1.05f / 32.0f);
    normal = gl_NormalMatrix * gl_Normal;
    color = gl_Color;
}