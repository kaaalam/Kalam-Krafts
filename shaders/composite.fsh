#version 120
#include "lighting_utility_functions.glsl"
#include "shadow_utility_functions.glsl"

varying vec2 outTexCoord;

//TEXTURES
uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D colortex2;
uniform sampler2D depthtex0;
uniform sampler2D shadowtex0;
uniform sampler2D shadowtex1;
uniform sampler2D shadowcolor0;

//MATRICES 
uniform mat4 gbufferProjectionInverse;
uniform mat4 gbufferModelViewInverse;
uniform mat4 shadowModelView;
uniform mat4 shadowProjection;
/*
const int colortex0Format = RGBA32F;
const int colortex1Format = RGBA32F;
const int colortex2Format = RGBA32F;
*/

//sun's direction
uniform vec3 skyColor; 
uniform vec3 sunPosition;
const vec3 sunColor = vec3(0.98f, 0.73f, 0.15f);
const vec3 ambientLightingOffset = vec3(0.015f, 0.03f, 0.06f);



void main() 
{
   
    vec3 sampledColorInGamma = texture2D(colortex0, outTexCoord).rgb;
    float depthValue = texture2D(depthtex0, outTexCoord).r;
    //fix for broken sky
    if(depthValue == 1.0f) { //sky's depth is always 1.0f. we can just write out its color and return.
        gl_FragData[0] = vec4(sampledColorInGamma, 1.0f);
        return;
    }

    //apply gamma correction to convert to linear. all lighting operations need to be done in linear space.
    vec3 gamma2Linear = pow(sampledColorInGamma, vec3(1.85f));
    //read lightmap
   
    vec2 lightMap = texture2D(colortex2, outTexCoord).rg;
    lightMap = AdjustLightMapValues(lightMap); //adjust the strength of the lightmap
    vec3 adjustedLightMapColor = GetColorOfLightMap(lightMap, skyColor);

    //get the normal where we wrote it to in our gbuffers_terrain
    vec3 normal = texture2D(colortex1, outTexCoord).rgb;
    //calculate the dot product of the normal and the sun path rotation. gives us a value indicating how much sunlight is hitting an object
    vec3 NdotSun = sunColor * clamp(dot(normal, (sunPosition * 0.01f)), 0.0f, 1.0f); //normalized the sunPosition
    NdotSun *= 1.8f;
    float skyLuminance = CalculateLuminance(sunColor);
    NdotSun *= (skyLuminance + 0.01f);
    NdotSun *= lightMap.g;

    
    //do diffuse lighting calculations
    vec3 shadowValue = ComputeShadow(depthValue, outTexCoord, gbufferProjectionInverse, gbufferModelViewInverse, shadowModelView, shadowProjection, shadowtex0, shadowtex1, shadowcolor0);
    vec3 lighting = adjustedLightMapColor + NdotSun * shadowValue + ambientLightingOffset + 0.15;
    vec3 colorAfterDiffuse = gamma2Linear * lighting; 
    /* DRAWBUFFERS:0 */
    gl_FragData[0] = vec4(colorAfterDiffuse, 1.0f);

}