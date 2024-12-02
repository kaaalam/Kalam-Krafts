#version 120
#include "tone_mapper.glsl"

varying vec2 outTexCoord;

uniform sampler2D colortex0;
/*
const int colortex0Format = RGBA32F;
*/

vec3 ApplyTonemap(vec3 color)
{
   // multiply sRGB input by ACES Input Color Mat. sRGB=> XYZ => D65_2_D60 => AP1 => RRT_SAT 
   color = mul(ACESInputMatrix, color);
   //apply RRT and ODT Fit 
   color = RRTandODTFit(color);
   //multiply ODT_SAT by the ACES Output Color Mat. ODT_SAT => XYZ => D60_2_D65 => sRGB
   return mul(ACESOutputMatrix, color);
}

void main() {
   vec3 color = texture2D(colortex0, outTexCoord).rgb;
    //apply inverse gamma correction to get back to gamma space
   color = pow(color, vec3(1.0/1.85f));
   color = ApplyTonemap(color);
   gl_FragColor = vec4(color, 1.0f);
}