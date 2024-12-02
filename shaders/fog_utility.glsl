#define E 2.71828182846

float LinearDepth(float depth, float near, float far) {
    //return (1/depth - 1/near) / (1/far - 1/near);
    return 1.0 / ((1 - far / near) * depth + (far / near));
}

float FogFactorExponential(float viewDistance, float density) {
    return 0.05 + exp(-density * (1.0 - viewDistance));
}
