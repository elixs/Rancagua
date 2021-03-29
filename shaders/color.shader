shader_type canvas_item;

uniform vec4 color : hint_color;

void fragment() {
	vec4 image = texture(TEXTURE, UV);
	
	COLOR =  vec4(color.rgb, image.a);
}