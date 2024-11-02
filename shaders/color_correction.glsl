#include "lighting_utility_functions.glsl"
vec3 AdjustContrastAndBrightness(vec3 color, float contrast, float brightness) {
       return contrast * (color - 0.5) + 0.5 + brightness;
}

vec3 AdjustSaturation(vec3 color, float saturation) {
     vec3 desaturatedColor = vec3(0.2126*color.r, 0.7152*color.g, 0.0722*color.b);
    return mix(desaturatedColor, color, saturation);
}
