// Agrega Outline a un sprite
// IMPORTANTE: este codigo no es mio, lo encontre en "https://github.com/gdquest-demos/godot-shaders"
// 	y luego lo pase por una IA para fixear algunos detalles

shader_type canvas_item;

uniform vec4 line_color : source_color = vec4(1, 1, 1, 1);
uniform float line_thickness : hint_range(0, 10) = 1.0;

const vec2 OFFSETS[8] = vec2[](
    vec2(-1, -1), vec2(-1, 0), vec2(-1, 1),
    vec2(0, -1),               vec2(0, 1),
    vec2(1, -1), vec2(1, 0), vec2(1, 1)
);

void fragment() {
    vec4 sprite_color = COLOR; // modulate aplicado
    float is_border = 0.0;

    if (sprite_color.a < 0.001) {
        vec2 step = TEXTURE_PIXEL_SIZE * line_thickness / 2.0;
        for (int i = 0; i < OFFSETS.length(); i++) {
            if (texture(TEXTURE, UV + step * OFFSETS[i]).a > 0.0) {
                is_border = 1.0;
                break;
            }
        }
    }

    COLOR = (is_border > 0.0) ? vec4(line_color.rgb, 1.0) : sprite_color;
}
