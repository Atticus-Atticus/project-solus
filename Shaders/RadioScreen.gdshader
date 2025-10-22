// CRT Shader by Harrison Allen
// V4 (Godot 4.3-safe version)

shader_type canvas_item;

// --------- Uniforms ---------
uniform sampler2D tex;                // assign a ViewportTexture (from your SubViewport)
uniform int   mask_type = 0;          // 0=Dots, 1=Aperture Grille, 2=Wide Grille, 3=Wide Soft Grille, 4=Slot Mask, 5=Null
uniform float curve = 0.5;
uniform float sharpness = 0.6666667;
uniform float color_offset = 0.0;
uniform float aspect = 0.75;          // height/width of input (e.g., 0.5625 for 16:9)
uniform float min_scanline_thickness = 0.5;
uniform float wobble_strength = 0.0;


// NEW: separate brightness controls (like V4)
uniform float mask_brightness = 1.0;      // 0..1 (lower to preserve mask detail in brights)
uniform float scanline_brightness = 1.0;  // 0.5..1 (lower to preserve scanline detail in brights)


varying float wobble;


void vertex() {
    // use explicit 2*PI to avoid TAU issues
    wobble = cos(TIME * 6.283185307179586 * 15.0) * wobble_strength / 4000.0;
}


vec2 warp(vec2 uv, float _aspect, float _curve) {
    uv -= 0.5;
    uv.x /= _aspect;


    float warping = dot(uv, uv) * _curve;
    warping -= _curve * 0.25;


    uv /= (1.0 - warping);
    uv.x *= _aspect;
    uv += 0.5;
    return uv;
}


vec3 linear_to_srgb(vec3 col) {
    bvec3 cut = lessThan(col, vec3(0.0031318));
    vec3 a = (pow(col, vec3(1.0 / 2.4)) * 1.055) - 0.055;
    vec3 b = col * 12.92;
    return mix(a, b, cut);
}


vec3 srgb_to_linear(vec3 col) {
    bvec3 cut = lessThan(col, vec3(0.04045));
    vec3 a = pow((col + 0.055) / 1.055, vec3(2.4));
    vec3 b = col / 12.92;
    return mix(a, b, cut);
}


// Get scanlines from coordinates (returns in linear color)
vec3 scanlines(vec2 uv) {
    uv *= vec2(textureSize(tex, 0));


    int y = int(floor(uv.y - 0.5));
    float x = floor(uv.x);


    float ax = x - 2.0;
    float bx = x - 1.0;
    float cx = x;
    float dx = x + 1.0;
    float ex = x + 2.0;


    vec3 upper_a = texelFetch(tex, ivec2(int(ax), y), 0).rgb;
    vec3 upper_b = texelFetch(tex, ivec2(int(bx), y), 0).rgb;
    vec3 upper_c = texelFetch(tex, ivec2(int(cx), y), 0).rgb;
    vec3 upper_d = texelFetch(tex, ivec2(int(dx), y), 0).rgb;
    vec3 upper_e = texelFetch(tex, ivec2(int(ex), y), 0).rgb;


    y += 1;


    vec3 lower_a = texelFetch(tex, ivec2(int(ax), y), 0).rgb;
    vec3 lower_b = texelFetch(tex, ivec2(int(bx), y), 0).rgb;
    vec3 lower_c = texelFetch(tex, ivec2(int(cx), y), 0).rgb;
    vec3 lower_d = texelFetch(tex, ivec2(int(dx), y), 0).rgb;
    vec3 lower_e = texelFetch(tex, ivec2(int(ex), y), 0).rgb;


    upper_a = srgb_to_linear(upper_a);
    upper_b = srgb_to_linear(upper_b);
    upper_c = srgb_to_linear(upper_c);
    upper_d = srgb_to_linear(upper_d);
    upper_e = srgb_to_linear(upper_e);


    lower_a = srgb_to_linear(lower_a);
    lower_b = srgb_to_linear(lower_b);
    lower_c = srgb_to_linear(lower_c);
    lower_d = srgb_to_linear(lower_d);
    lower_e = srgb_to_linear(lower_e);


    vec3 beam = vec3(uv.x - 0.5);
    beam.r -= color_offset;
    beam.b += color_offset;


    vec3 weight_a = smoothstep(1.0, 0.0, (beam - ax) * sharpness);
    vec3 weight_b = smoothstep(1.0, 0.0, (beam - bx) * sharpness);
    vec3 weight_c = smoothstep(1.0, 0.0, abs(beam - cx) * sharpness);
    vec3 weight_d = smoothstep(1.0, 0.0, (dx - beam) * sharpness);
    vec3 weight_e = smoothstep(1.0, 0.0, (ex - beam) * sharpness);


    vec3 upper_col = upper_a * weight_a +
                     upper_b * weight_b +
                     upper_c * weight_c +
                     upper_d * weight_d +
                     upper_e * weight_e;


    vec3 lower_col = lower_a * weight_a +
                     lower_b * weight_b +
                     lower_c * weight_c +
                     lower_d * weight_d +
                     lower_e * weight_e;


    vec3 weight_scaler = vec3(1.0) / (weight_a + weight_b + weight_c + weight_d + weight_e);
    upper_col *= weight_scaler;
    lower_col *= weight_scaler;


    // NEW: apply scanline brightness BEFORE computing thickness/shapes
    upper_col *= scanline_brightness;
    lower_col *= scanline_brightness;


    vec3 upper_thickness = mix(vec3(min_scanline_thickness), vec3(1.0), upper_col);
    vec3 lower_thickness = mix(vec3(min_scanline_thickness), vec3(1.0), lower_col);


    float sawtooth = fract(uv.y + 0.5);


    vec3 upper_line = vec3(sawtooth) / upper_thickness;
    upper_line = smoothstep(1.0, 0.0, upper_line);


    vec3 lower_line = vec3(1.0 - sawtooth) / lower_thickness;
    lower_line = smoothstep(1.0, 0.0, lower_line);


    upper_line *= upper_col / upper_thickness;
    lower_line *= lower_col / lower_thickness;


    vec3 combined = upper_line + lower_line;


    // Keep the darker fallback for very thin lines
    vec3 dark_upper = smoothstep(min_scanline_thickness, 0.0, vec3(sawtooth)) * upper_col;
    vec3 dark_lower = smoothstep(min_scanline_thickness, 0.0, vec3(1.0 - sawtooth)) * lower_col;
    vec3 dark_combined = dark_upper + dark_lower;


    // Use scanline_brightness already applied; return the shaped result
    // (No extra global "brightness" mix anymore)
    // Slight bias toward shaped lines:
    return mix(dark_combined, combined, 0.9);
}


// ----- Small helpers (no arrays/ternaries) -----
vec3 _pick4(int idx, vec3 a, vec3 b, vec3 c, vec3 d) {
    if (idx == 0) return a;
    if (idx == 1) return b;
    if (idx == 2) return c;
    return d;
}


vec3 _slot_color(int idx) {
    // 16-item pattern spelled out explicitly
    if (idx == 0)  return vec3(1,0,1);
    if (idx == 1)  return vec3(0,1,0);
    if (idx == 2)  return vec3(1,0,1);
    if (idx == 3)  return vec3(0,1,0);
    if (idx == 4)  return vec3(0,0,1);
    if (idx == 5)  return vec3(0,1,0);
    if (idx == 6)  return vec3(1,0,0);
    if (idx == 7)  return vec3(0,0,0);
    if (idx == 8)  return vec3(1,0,1);
    if (idx == 9)  return vec3(0,1,0);
    if (idx == 10) return vec3(1,0,1);
    if (idx == 11) return vec3(0,1,0);
    if (idx == 12) return vec3(1,0,0);
    if (idx == 13) return vec3(0,0,0);
    if (idx == 14) return vec3(0,0,1);
    return vec3(0,1,0);
}


vec4 generate_mask(vec2 fragcoord) {
    int mx = mask_type;


    if (mx == 0) {
        // Dots
        ivec2 icoords = ivec2(floor(fragcoord));
        int idx = (icoords.y * 2 + icoords.x) % 4;
        vec3 c = _pick4(idx, vec3(1,0,0), vec3(0,1,0), vec3(0,0,1), vec3(0,0,0));
        return vec4(c, 0.25);
    } else if (mx == 1) {
        // Aperture Grille
        int idx = int(floor(fragcoord.x)) % 2;
        vec3 c = vec3(0.0);
        if (idx == 0) c = vec3(0,1,0);
        else          c = vec3(1,0,1);
        return vec4(c, 0.5);
    } else if (mx == 2) {
        // Wide Grille
        int idx = int(floor(fragcoord.x)) % 4;
        vec3 c = _pick4(idx, vec3(1,0,0), vec3(0,1,0), vec3(0,0,1), vec3(0,0,0));
        return vec4(c, 0.25);
    } else if (mx == 3) {
        // Wide Soft Grille
        int idx = int(floor(fragcoord.x)) % 4;
        vec3 c = _pick4(idx,
            vec3(1.0, 0.125, 0.0),
            vec3(0.125, 1.0, 0.125),
            vec3(0.0, 0.125, 1.0),
            vec3(0.125, 0.0, 0.125)
        );
        return vec4(c, 0.3125);
    } else if (mx == 4) {
        // Slot Mask
        ivec2 ico = ivec2(floor(fragcoord));
        int ix = ico.x % 4;
        int iy = ico.y % 4;
        int idx = iy * 4 + ix;
        vec3 c = _slot_color(idx);
        return vec4(c, 0.375);
    } else {
        // Null
        return vec4(0.5);
    }
}


// Add phosphor mask/grille  (uses mask_brightness like V4)
vec3 mask(vec3 linear_color, vec2 fragcoord) {
    vec4 m = generate_mask(fragcoord);


    // Dim base to preserve mask detail in highlights (1.0 = no dimming)
    float dim = mix(m.w, 1.0, mask_brightness);
    linear_color *= dim;


    // Compute primary + highlights same as V4
    vec3 target_color = linear_color / m.w;
    vec3 primary_col = clamp(target_color, 0.0, 1.0);


    vec3 highlights = target_color - primary_col;
    highlights /= (1.0 / m.w - 1.0);


    primary_col *= m.rgb;
    primary_col += highlights * (1.0 - m.rgb);


    return primary_col;
}


void fragment() {
    vec2 warped_coords = warp(UV, aspect, curve * 0.5);
    warped_coords.x += wobble;


    vec3 col = scanlines(warped_coords);
    col = mask(col, FRAGCOORD.xy);
    col = linear_to_srgb(col);


    COLOR.rgb = col;
}
