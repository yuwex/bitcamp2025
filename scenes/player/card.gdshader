shader_type canvas_item;

uniform bool enabled = true;

group_uniforms HydroDip;
uniform float speed_x: hint_range(-1.0, 1.0) = 0.01;
uniform float speed_y: hint_range(-1.0, 1.0) = 0.01;
uniform float whirl_speed: hint_range(0.0, 1.0) = 0.1;

uniform float compactness: hint_range(1, 50.0, 1) = 5.0;
uniform sampler2D noise: repeat_enable;
uniform float noise_offset: hint_range(0.0, 1.0) = 0;

group_uniforms Outline;
uniform float outline_width: hint_range(0.0, 1) = 0.5;
uniform vec4 outline_color: source_color;
uniform bool outline_enabled = true;

group_uniforms Dissolve;
uniform float dissolve_amount: hint_range(0.0, 1) = 0.0;
uniform float dissolve_min = 0.0;
uniform float dissolve_max = 0.0;
uniform float dissolve_mult = 0.5;

void fragment() {

	if (enabled) {
		vec4 modulate = COLOR;

		float size = outline_width * 1.0 / float(textureSize(TEXTURE, 0).x);

		vec2 uv = UV + noise_offset + TIME * vec2(speed_x, speed_y);
		float color_len = length(texture(noise, uv).rgb);
		vec4 effect_color = vec4(texture(noise, vec2(uv.x + TIME * whirl_speed + sin(color_len * compactness), uv.y + TIME * whirl_speed + sin(color_len * compactness))).rgb, 0.0);

		vec4 sprite_color = texture(TEXTURE, UV);
		float alpha = -4.0 * sprite_color.a;
		alpha += texture(TEXTURE, UV + vec2(size, 0.0)).a;
		alpha += texture(TEXTURE, UV + vec2(-size, 0.0)).a;
		alpha += texture(TEXTURE, UV + vec2(0, size)).a;
		alpha += texture(TEXTURE, UV + vec2(0, -size)).a;

		vec4 final_color = mix(effect_color, outline_color, clamp(alpha, 0.0, 1.0));

		// Set black to be black
		if (COLOR.rgb != vec3(0.0,0.0,0.0)) {
			COLOR.rgb = final_color.rgb;
		}

		if (outline_enabled) {
			COLOR = vec4(final_color.rgb, clamp((abs(alpha) + sprite_color.a), 0.0, 1.0));
		}

		float d = mix(dissolve_min, dissolve_max, dissolve_amount);
		float dissolve = smoothstep(d, d, length(effect_color.rgb) * dissolve_mult);
		if (dissolve_amount > 0.9999) {
			dissolve = 0.0;
		}

		COLOR = mix(modulate, COLOR, dissolve);
	}
}