#include <flutter/runtime_effect.glsl>

// ---------------------------------------------------------------------------
// Ocean water fragment shader for Flutter
// Renders: sky gradient, cloud wisps, sun/moon glow, animated waves,
//          caustic light patterns, and sun reflection column.
// ---------------------------------------------------------------------------

uniform vec2  uResolution;
uniform float uTime;
uniform float uHorizonY;
uniform vec4  uSkyTop;
uniform vec4  uSkyBottom;
uniform vec4  uWaterFar;
uniform vec4  uWaterNear;
uniform vec4  uSunGlow;
uniform vec4  uCausticColor;

out vec4 fragColor;

// ---------------------------------------------------------------------------
// Noise helpers
// ---------------------------------------------------------------------------

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

vec2 hash2(vec2 p) {
    return fract(sin(vec2(dot(p, vec2(127.1, 311.7)),
                          dot(p, vec2(269.5, 183.3)))) * 43758.5453);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    f = f * f * (3.0 - 2.0 * f);
    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));
    return mix(mix(a, b, f.x), mix(c, d, f.x), f.y);
}

// Simplified voronoi for caustic light patterns
float voronoi(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    float minDist = 1.0;
    for (int x = -1; x <= 1; x++) {
        for (int y = -1; y <= 1; y++) {
            vec2 neighbor = vec2(float(x), float(y));
            // Animate voronoi points slowly over time
            vec2 point = hash2(i + neighbor) * 0.5 + 0.25
                         + 0.15 * sin(uTime * 0.08 + hash2(i + neighbor) * 6.2831);
            float d = length(neighbor + point - f);
            minDist = min(minDist, d);
        }
    }
    return minDist;
}

// ---------------------------------------------------------------------------
// Sky helpers
// ---------------------------------------------------------------------------

// Faint cloud wisps — two octaves of noise, drifting horizontally
float cloudWisp(vec2 uv) {
    vec2 drift = vec2(uTime * 0.012, 0.0);
    float n1 = noise((uv + drift) * vec2(6.0, 3.0));
    float n2 = noise((uv + drift * 0.7) * vec2(12.0, 6.0) + vec2(3.7, 1.3));
    return clamp(n1 * 0.6 + n2 * 0.4 - 0.45, 0.0, 1.0);
}

// Sun / moon radial glow disc sitting on the horizon
float sunGlow(vec2 uv, float horizonY) {
    // Centre: horizontally centred, just above the horizon line
    vec2 centre = vec2(0.5, horizonY - 0.015);
    // Compensate for non-square aspect ratio so the disc looks round
    vec2 aspect = vec2(uResolution.x / uResolution.y, 1.0);
    float dist = length((uv - centre) * aspect);
    float radius = 0.15;
    return smoothstep(radius * 1.6, 0.0, dist);
}

// ---------------------------------------------------------------------------
// Wave helpers
// ---------------------------------------------------------------------------

// Returns a wave displacement in Y (normalised UV space).
// Each wave is a sine driven along X with slight noise perturbation.
float waveLayer(vec2 uv, float period, float amplitude, float drift, float phase) {
    float n = noise(vec2(uv.x * 3.5 + drift * uTime * 0.3, uTime * 0.15 + phase));
    float angle = uv.x * 6.2831 / period + uTime * (6.2831 / period) + n * 1.2 + phase;
    return sin(angle) * amplitude;
}

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------

void main() {
    vec2 fragCoord = FlutterFragCoord().xy;

    // Normalised UV — (0,0) top-left, (1,1) bottom-right
    vec2 uv = fragCoord / uResolution;

    float horizonY = uHorizonY;

    // ------------------------------------------------------------------
    // Accumulate total wave displacement at this UV column (used in both
    // water and sun-reflection calculations)
    // ------------------------------------------------------------------
    float waveDisp = 0.0;
    waveDisp += waveLayer(uv, 1.0 / 6.0,  0.018,  0.15, 0.00);
    waveDisp += waveLayer(uv, 1.0 / 4.5,  0.012, -0.10, 1.57);
    waveDisp += waveLayer(uv, 1.0 / 8.0,  0.022,  0.08, 3.14);
    waveDisp += waveLayer(uv, 1.0 / 3.0,  0.005,  0.25, 4.71);

    // ------------------------------------------------------------------
    // SKY
    // ------------------------------------------------------------------
    vec4 skyColor = vec4(0.0);
    if (uv.y < horizonY) {
        float t = uv.y / horizonY; // 0 = top, 1 = horizon
        skyColor = mix(uSkyTop, uSkyBottom, t);

        // Cloud wisps — very faint
        float wisp = cloudWisp(uv);
        float wispOpacity = mix(0.03, 0.06, wisp);
        skyColor.rgb = mix(skyColor.rgb, vec3(1.0), wispOpacity * wisp);

        // Sun / moon glow
        float glow = sunGlow(uv, horizonY);
        skyColor.rgb = mix(skyColor.rgb, uSunGlow.rgb, glow * uSunGlow.a);
    }

    // ------------------------------------------------------------------
    // WATER
    // ------------------------------------------------------------------
    vec4 waterColor = vec4(0.0);
    if (uv.y >= horizonY) {
        float waterDepth = (uv.y - horizonY) / max(1.0 - horizonY, 0.0001);

        // Base water colour — far (horizon) to near (bottom)
        waterColor = mix(uWaterFar, uWaterNear, waterDepth);

        // --- Wave crest brightening ---
        // Shift the effective Y by total wave displacement and modulate
        // brightness so crests appear lighter, troughs darker.
        float crestBrightness = waveDisp * 3.0; // [-~0.17 … +~0.17] mapped to brightness
        waterColor.rgb += crestBrightness * 0.18 * (1.0 - waterDepth * 0.6);

        // --- Caustic light patterns ---
        float causticScale = 4.0;
        vec2 causticUV = vec2(uv.x * (uResolution.x / uResolution.y), waterDepth) * causticScale;
        float vor = voronoi(causticUV);
        // Bright rings at cell edges
        float causticIntensity = smoothstep(0.25, 0.05, vor) * 0.65;
        // Fade caustics deeper into the water
        float depthFade = smoothstep(0.55, 0.0, waterDepth);
        causticIntensity *= depthFade * uCausticColor.a;
        waterColor.rgb += causticIntensity * uCausticColor.rgb;

        // --- Sun reflection column ---
        // A vertical shimmering band centred at x = 0.5 + wave wobble
        float reflCentreX = 0.5 + waveDisp * 0.4;
        float reflWidth    = 0.08;
        float reflDist     = abs(uv.x - reflCentreX);
        float reflMask     = smoothstep(reflWidth, 0.0, reflDist);
        // Strongest near horizon, fades toward bottom
        float reflFade = smoothstep(0.9, 0.0, waterDepth) * smoothstep(0.0, 0.04, waterDepth);
        // Add a gentle shimmer oscillation along y
        float shimmer = 0.75 + 0.25 * sin(uv.y * 80.0 + uTime * 2.5 + waveDisp * 30.0);
        float reflIntensity = reflMask * reflFade * shimmer * uSunGlow.a;
        waterColor.rgb = mix(waterColor.rgb, uSunGlow.rgb, reflIntensity * 0.65);
    }

    // ------------------------------------------------------------------
    // Horizon blend — smoothstep over ±0.02 band
    // ------------------------------------------------------------------
    float blend = smoothstep(horizonY - 0.02, horizonY + 0.02, uv.y);
    vec4 color  = mix(skyColor, waterColor, blend);

    fragColor = clamp(color, 0.0, 1.0);
}
