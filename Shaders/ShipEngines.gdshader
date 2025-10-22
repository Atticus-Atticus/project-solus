shader_type spatial;
render_mode blend_mix, unshaded, cull_back;

uniform float model_height = 3.0;
uniform float dissolve_start : hint_range(0.0, 1.0) = 0.001;
uniform float dissolve_length : hint_range(0.0, 1.0) = 1.0;
uniform float gradient_bias : hint_range(0.1, 5.0) = 1.0;

uniform float noise_speed = 1.0;
uniform float noise_strength = 0.1;
uniform float stretch_factor = 0.6;
uniform vec2 noise_direction = vec2(0.0, 1.0);
uniform sampler2D noise_texture : source_color;

uniform vec3 _color : source_color = vec3(0.2, 0.5, 1.0);
uniform float power_factor = 1.0;

uniform float fresnel_factor = 1.0;
uniform float fresnel_amplification = 1.0;
uniform float fresnel_power = 1.0;

varying float vert_height;
varying vec2 v_uv;

// Neon function for fiery glow
vec3 neon(float value, vec3 color) {
    float ramp = clamp(value, 0.0, 1.0);
    vec3 out_col = vec3(0.0);
    ramp = ramp * ramp; out_col += pow(color, vec3(4.0)) * ramp;
    ramp = ramp * ramp; out_col += color * ramp;
    ramp = ramp * ramp; out_col += vec3(1.0) * ramp;
    return out_col;
}

void vertex() {
    vert_height = (VERTEX.y + (model_height / 2.0)) / model_height;
    v_uv = UV;
}

void fragment() {
    // Base gradient fade
    float gradient_height = (vert_height - dissolve_start) * (1.0 / dissolve_length);
    gradient_height = clamp(pow(gradient_height, gradient_bias), 0.0, 1.0);

    // Animated noise
    float time = TIME * noise_speed;
    vec2 moving_uv = v_uv + noise_direction * time;
    vec2 stretched_uv = vec2(moving_uv.x, moving_uv.y * stretch_factor);
    float noise_value = texture(noise_texture, stretched_uv).r * noise_strength;

    gradient_height = clamp(gradient_height + noise_value, 0.0, 1.0);

    // Alpha fade
    ALPHA = mix(1.0, 0.0, gradient_height);

    // Neon color
    ALBEDO = neon(pow(ALPHA, power_factor), _color);

    // Fresnel edge fade
    float f = 1.0 - pow((1.0 - clamp(dot(normalize(NORMAL), normalize(VIEW)), 0.0, 1.0)), fresnel_factor);
    f = pow(f * fresnel_amplification, fresnel_power);
    ALPHA *= f;
}