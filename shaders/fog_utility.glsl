#define E 2.71828182846

float LinearDepth(float depth, float near, float far) {
    //return (1/depth - 1/near) / (1/far - 1/near);
    return 1.0 / ((1 - far / near) * depth + (far / near));
}

float FogFactorExponential(float viewDistance, float density) {
    float factor = viewDistance * (density / log(2.0f));
    return exp2(-factor);
}
