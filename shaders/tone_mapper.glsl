
mat3 ACESInputMatrix = mat3( 
    vec3(0.59719, 0.35458, 0.04823),
    vec3(0.07600, 0.90834, 0.01566),
    vec3(0.02840, 0.13383, 0.83777)
);


mat3 ACESOutputMatrix = mat3(
    vec3( 1.60475, -0.53108, -0.07367),
    vec3(-0.10208,  1.10813, -0.00605),
    vec3(-0.00327, -0.07276,  1.07602)
);


vec3 RRTandODTFit(vec3 color) {
    vec3 a = color * (color + 0.0245786) - 0.000090537;
    vec3 b = color * (0.983729 * color + 0.4329510) + 0.238081;
    return a/b;
}
vec3 mul(mat3 m, vec3 v) {
    float x = m[0][0] * v[0] + m[0][1] * v[1] + m[0][2] * v[2];
    float y = m[1][0] * v[1] + m[1][1] * v[1] + m[1][2] * v[2];
    float z = m[2][0] * v[1] + m[2][1] * v[1] + m[2][2] * v[2];
    return vec3(x, y, z);
}