
#version 120

varying vec2 outTexCoord;
varying vec3 normal;
varying vec4 color;
varying vec2 lightMapCoordinates;
uniform sampler2D texture;
void main()
{
    vec4 color = texture2D(texture, outTexCoord) * color; //we need to multiply by the color because the terrain is stored as grayscale
    /* DRAWBUFFERS:012 */
    gl_FragData[0] = color;
    gl_FragData[1] = vec4(normalize(normal), 1.0f);
    gl_FragData[2] = vec4(lightMapCoordinates, 0.0f, 1.0f);
}
