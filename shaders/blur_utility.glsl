#define TWO_PI 6.283185307179586
#define E 2.71828182846

float Gaussian2D(int x, int y, float sigma) {
    float sigmaSquared = sigma*sigma;
    int xSquared = x*x;
    int ySquared = y*y;
    float gaussian = 1/(TWO_PI * sigmaSquared) * pow(E, -((xSquared+ySquared)/sigmaSquared));
    //float gaussian = 1/(TWO_PI * sigma) * pow(E, -((xSquared+ySquared)/sigma));
    return gaussian;
}