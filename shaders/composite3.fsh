#version 120

varying vec2 outTexCoord;

uniform sampler2D colortex0;
uniform sampler2D colortex4;
uniform sampler2D depthtex0;
/*
const int colortex0Format = RGBA32F;
const int colortex4Format = RGBA32F;
*/

//SHARPNESS 
void main() {
    /*
    vec3 color = texture2D(colortex0, outTexCoord).rgb;
    float depth = texture2D(depthtex0, outTexCoord).r;
    vec3 blurredColor = vec3(0,0,0);
    if(depth < 0.9999f) {
        blurredColor = texture2D(colortex4, outTexCoord).rgb;
        color = color + (color - blurredColor) * 0.2f;        
    }
    */
    
    /* DRAWBUFFERS:0 */
    //gl_FragData[0] = vec4(color, 1.0f);
}