#version 120

varying vec2 outTexCoord;

uniform sampler2D colortex0;
/*
const int colortex0Format = RGBA32F;
*/

void main() {
    vec3 color = texture2D(colortex0, outTexCoord).rgb;
    float brightness = dot(color, vec3(0.2126, 0.7152, 0.0722));
    /* DRAWBUFFERS:5*/
    if(brightness > 1.0) {//if our color is bright, write it to a texture
        gl_FragData[0] = vec4(color,1.0);
    } else { //else, write out black
        gl_FragData[0] = vec4(0.0,0.0,0.0,0.0);
    }
}