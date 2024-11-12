#define FOG_DENSITY 0.01
#define E 2.71828182846

float LinearDepth(float depth, float near, float far) {
    //return (1/depth - 1/near) / (1/far - 1/near);
    return 1.0 / ((1 - far / near) * depth + (far / near));
}

float FogFactorExponential(float viewDistance) {
    float factor = viewDistance * (FOG_DENSITY / log(2.0f));
    return exp2(-factor);
}
