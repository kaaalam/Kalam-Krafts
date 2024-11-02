#version 120

varying vec2 outTexCoord;

uniform sampler2D colortex0;
/*
const int colortex0Format = RGBA32F;
*/

void main() {
   vec3 color = texture2D(colortex0, outTexCoord).rgb;
   //apply inverse gamma correction to get back to gamma space
   vec3 linear2Gamma = pow(color, vec3(1.0f/2.2f));
   gl_FragColor = vec4(linear2Gamma, 1.0f);
}