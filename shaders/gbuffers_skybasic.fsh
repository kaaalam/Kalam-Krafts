#version 120
varying vec2 outTexCoord;
uniform float viewWidth;
uniform float viewHeight;
uniform float sunPosition;
uniform vec3 playerLookVector;

void main() {
  
    vec2 resolution = vec2(viewWidth, viewHeight);
    vec2 st = gl_FragCoord.xy/resolution;
    vec3 pct = vec3(st.y);
    
    vec4 dayTopGradient = vec4(0.082, 0.396, 0.71, 1.0);
    vec4 dayBottomGradient = vec4(0.867, 0.886, 0.941, 1.0);
    /* DRAWBUFFERS:0 */
    float playerLookYDirection = playerLookVector.y;
    float playerLookZDirection = playerLookVector.z;
    //map 0-90 and 90-0 to range of 0-180.
    playerLookYDirection = playerLookZDirection > 0 ? playerLookYDirection : playerLookYDirection = 180 - playerLookYDirection;
    vec3 skyGradient = vec3(1.0,1.0,1.0);
    if (playerLookYDirection < 90) {
        skyGradient = mix(dayBottomGradient.xyz, dayTopGradient.xyz, pct);
    }else {
        skyGradient = mix(dayBottomGradient.xyz, dayTopGradient.xyz, pct);
    }
    
    gl_FragData[0] = vec4(skyGradient, 1.0);

}