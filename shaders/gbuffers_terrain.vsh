
#version 120


varying vec2 outTexCoord;
varying vec3 normal;
varying vec4 color;
varying vec2 lightMapCoordinates;
void main()
{
    gl_Position = ftransform(); //transform from view space to clip space
    outTexCoord = gl_MultiTexCoord0.xy; //store x and y points
    normal = gl_NormalMatrix * gl_Normal; //converts the world space to view space.
    color = gl_Color; //we need to store this here, because our terrain is in grayscale. we multiply by the color to get the color 
    lightMapCoordinates = mat2(gl_TextureMatrix[1]) * gl_MultiTexCoord1.xy;
    lightMapCoordinates = (lightMapCoordinates * 33.05f / 32.0f) - (1.05f / 32.0f);
    

}
