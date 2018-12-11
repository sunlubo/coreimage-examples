#include <metal_math>
#include <metal_stdlib>

using namespace metal;

#include <CoreImage/CoreImage.h>

extern "C" {
namespace coreimage {

float4 minimumComponent(sample_t s) { return float4(float3(fmin(fmin(s.r, s.g), s.b)), s.a); }

float4 maximumComponent(sample_t s) { return float4(float3(fmax(fmax(s.r, s.g), s.b)), s.a); }

float4 red(sample_t s) { return float4(s.r, 0.0, 0.0, s.a); }

float4 green(sample_t s) { return float4(0.0, s.g, 0.0, s.a); }

float4 blue(sample_t s) { return float4(0.0, 0.0, s.b, s.a); }

float4 boxBlur(sampler src, float blurRadius, destination dst) {
    int radius = int(blurRadius);
    float2 p = dst.coord();
    float3 accumulator = float3(0.0);
    float n = 0.0;
    for (int x = -radius; x <= radius; x++) {
        for (int y = -radius; y <= radius; y++) {
            float2 p0 = p + float2(x, y);
            float2 p1 = src.transform(p0);
            float3 color = src.sample(p1).rgb;
            accumulator += color;
            n += 1.0;
        }
    }
    accumulator /= n;
    return float4(accumulator, 1.0);
}
}  // namespace coreimage
}
