#include "lighting_utility_functions.glsl"
#version 120 
varying vec2 outTexCoord;
varying vec3 normal;
varying vec4 color;
varying vec2 lightMapCoordinates;
uniform sampler2D texture;
uniform float rainStrength;
void main() 
{
    vec4 albedo = texture2D(texture, outTexCoord)*color;
     if (CalculateLuminance(albedo.rgb) <= 0.9)
        albedo.rgb = pow(albedo.rgb, vec3(2.2));
    albedo.a *= 1 - rainStrength;
    
    /* DRAWBUFFERS:02*/
    gl_FragData[0] = albedo;
    vec4 cloudColor = vec4(1.0, 0.725, 0.957, 1.0);
    vec4 white = vec4(1.0,1.0,1.0,1.0);
    vec4 newCloudColor = mix(white, cloudColor, 0.95);
    gl_FragData[0] = cloudColor;
    //gl_FragData[1] = vec4(1.0f - CalculateLuminance(albedo.rgb));
}