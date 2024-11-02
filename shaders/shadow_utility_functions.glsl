


//SHADOW DISTORTION
vec2 distortPosition(in vec2 position) {
	float distanceFromCenter = length(position);
	float distortionFactor = mix(1.0f,distanceFromCenter, 0.9f);
	vec2 distortedPosition = position/distortionFactor;
	return distortedPosition;
}
float VisibilityOfShadow(in sampler2D shadowMap, in vec3 shadowScreenSpace) {
    return texture2D(shadowMap, shadowScreenSpace.xy).r < (shadowScreenSpace.z - 0.0025) ? 0.0f : 1.0f; //depth comparison. if the sampled shadow map texture >= the depth value, return light as usual (1.0). else, 0.0
    //we subtract a bias above (0.0025) to fix shadow acne. 
} 
vec3 TransparentShadow(in vec3 shadowScreenSpace, sampler2D shadowtex0, sampler2D shadowtex1, sampler2D shadowcolor0) {
    float shadowVisibility0 =  VisibilityOfShadow(shadowtex0, shadowScreenSpace);
    float shadowVisibility1 =  VisibilityOfShadow(shadowtex1, shadowScreenSpace);
    vec4 colorOfShadow0 = texture2D(shadowcolor0, shadowScreenSpace.xy);
    vec3 colorAfterHandlingTransparency = colorOfShadow0.rgb * (1.0f - colorOfShadow0.a);
    return mix(colorAfterHandlingTransparency * shadowVisibility1, vec3(1.0f), shadowVisibility0);

}

vec3 ComputeShadow(float depthValue, vec2 outTexCoord, mat4 gbufferProjectionInverse, mat4 gbufferModelViewInverse, mat4 shadowModelView, mat4 shadowProjection, 
                    sampler2D shadowtex0, sampler2D shadowtex1, sampler2D shadowcolor0 ) {
    const int SHADOW_SAMPLES = 2;
    const int ShadowSamplesPerSize = 2 * SHADOW_SAMPLES + 1;
    const int TotalSamples = ShadowSamplesPerSize * ShadowSamplesPerSize;
    const int shadowMapResolution = 2048;
    vec3 screenSpace = vec3(outTexCoord, depthValue); //screen space is in [0.0, 1.0];
    vec3 clipSpace = (screenSpace * 2.0f) - 1.0f; //convert SS to clipSpace. CS will be in [-1.0, 1.0]
    vec4 viewSpaceW = gbufferProjectionInverse * vec4(clipSpace, 1.0f); //convert from CS to VS 
    vec4 viewSpaceCartesian = viewSpaceW / viewSpaceW.w;
    vec4 worldSpace = gbufferModelViewInverse * viewSpaceCartesian; //finally convert from VS to WS. NOTE: this isn't really 'world space', it's actually player space, centered around the player's feet
    vec4 shadowClipSpace = shadowProjection * shadowModelView * worldSpace; 
    //distort shadow
    shadowClipSpace.xy = distortPosition(shadowClipSpace.xy);
    vec4 shadowScreenSpace = shadowClipSpace * (0.5f) + 0.5f; //convert from clip space to screen space
    vec3 ShadowAccum = vec3(0.0f);
    for(int x = -SHADOW_SAMPLES; x <= SHADOW_SAMPLES; x++){
        for(int y = -SHADOW_SAMPLES; y <= SHADOW_SAMPLES; y++){
            vec2 Offset = vec2(x, y) / shadowMapResolution;
            vec3 CurrentSampleCoordinate = vec3(shadowScreenSpace.xy + Offset, shadowScreenSpace.z);
            ShadowAccum += TransparentShadow(CurrentSampleCoordinate,shadowtex0, shadowtex1, shadowcolor0);
        }
    }
    ShadowAccum /= TotalSamples;
    return ShadowAccum;
   
}

