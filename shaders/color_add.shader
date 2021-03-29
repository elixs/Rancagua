shader_type canvas_item;

uniform vec4 color : hint_color;

void fragment() {
	vec4 image = texture(TEXTURE, UV);
	
	COLOR =  vec4(image.rgb * (1.0 - color.a) + color.rgb * color.a, image.a);
}