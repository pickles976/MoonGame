shader_type spatial;
render_mode cull_front, unshaded;

uniform vec4 color : source_color;
uniform float size = 5.0;

void vertex() {
	vec4 clip_position = PROJECTION_MATRIX * (MODELVIEW_MATRIX * vec4(VERTEX, 1.0));
	vec3 clip_normal = mat3(PROJECTION_MATRIX) * (mat3(MODELVIEW_MATRIX) * NORMAL);

	vec2 offset = normalize(clip_normal.xy) / VIEWPORT_SIZE * clip_position.w * size * 2.0;

	clip_position.xy += offset;

	POSITION = clip_position;
}

void fragment() {
	ALBEDO = color.rgb;
	if (color.a < 1.0) {
		ALPHA = color.a;
	}
}