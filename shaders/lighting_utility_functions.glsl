
float AdjustTorchLighting(in float torchLightMapValue) {
    float updatedTorchLightValue = 2.5f * pow(torchLightMapValue, 2.0f); //these are values that i chose based on how i felt a torch should behave 
    //float updatedTorchLightValue = 3.0f * pow(torchLightMapValue, 4.0f);
    return max(updatedTorchLightValue, 0.0f);
}

float AdjustSkyLighting(in float skyLightMapValue) {
    float updatedSkyLightValue = ((skyLightMapValue*skyLightMapValue) * (skyLightMapValue*skyLightMapValue)); //basically just skyLightMapValue^4 but pow is inefficient
    return max(updatedSkyLightValue, 0.0f);
}

//we should do any computations on the lightmap BEFORE calling this function
vec3 GetColorOfLightMap(in vec2 adjustedLightMap, vec3 skyColor) { 
    vec3 torchColor = vec3(0.95f, 0.58f, 0.55f);
    torchColor = adjustedLightMap.x * torchColor;
    vec3 newSkyColor = adjustedLightMap.y * skyColor;
    vec3 lightMapFinalColor = torchColor + newSkyColor;
    return lightMapFinalColor;

}
vec2 AdjustLightMapValues(in vec2 lightMap) {
    float newTorchLight = AdjustTorchLighting(lightMap.x);
    float newSkyLight = AdjustSkyLighting(lightMap.y);
    vec2 newLightMap = vec2(newTorchLight, newSkyLight);
    return newLightMap;
}

float CalculateLuminance(vec3 color) {
    return 0.2126*color.r + 0.7152*color.g + 0.0722*color.b;
}
