#version 120
varying vec2 outTexCoord;
uniform float viewWidth;
uniform float viewHeight;
uniform vec3 sunPosition;
uniform vec3 playerLookVector;
uniform mat4 gbufferProjectionInverse;
uniform mat4 gbufferModelViewInverse;
uniform vec3 upPosition;


vec4 Convert_ScreenSpace_to_ViewSpace(vec4 screenSpace){
    vec4 clipSpace = (screenSpace * 2.0f) - 1.0f;
    vec4 viewSpaceW = gbufferProjectionInverse * clipSpace;
    vec4 viewSpaceCartesian = viewSpaceW/viewSpaceW.w;
    return viewSpaceCartesian;
}


void main() {
  
    vec2 resolution = vec2(viewWidth, viewHeight);
    vec4 screenSpace = vec4(gl_FragCoord.xy/resolution, gl_FragCoord.z, 1.0);
    vec4 viewSpaceCartesian = Convert_ScreenSpace_to_ViewSpace(screenSpace);
    viewSpaceCartesian = normalize(viewSpaceCartesian) / 4;
    float vdotu = clamp(dot(viewSpaceCartesian.xyz, upPosition) / 2, 0.0f, 1.0f);
    vec3 sunDirection = sunPosition * 0.01f;
    float sunVisibility  = clamp((dot( sunDirection, upPosition)), 0.0, 1.0);
    
    vec3 dayTopGradient = vec3(0.435, 0.639, 0.839);
    vec3 dayBottomGradient = vec3(0.867, 0.886, 0.941);
    vec3 nightTopGradient = vec3(0.02, 0.02, 0.05);
    vec3 nightBottomGradient = vec3(0.02, 0.02, 0.05);
    /* DRAWBUFFERS:0 */
    vec3 topGradient = mix(nightTopGradient, dayTopGradient, sunVisibility);
    vec3 bottomGradient = mix(nightBottomGradient, dayBottomGradient, sunVisibility);
    vec3 skyGradient = mix(bottomGradient, topGradient, vdotu);
    
    gl_FragData[0] = vec4(skyGradient, 1.0);
    //gl_FragData[0] = vec4(viewSpaceCartesian.x);
    //gl_FragData[0] = vec4(screenSpace.x);

}