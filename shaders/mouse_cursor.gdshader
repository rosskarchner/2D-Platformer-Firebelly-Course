shader_type canvas_item;

void fragment() {
	vec4 texColor = texture(TEXTURE,UV);
	COLOR.rgba = vec4(0,0,0,texColor.a * .5);
	
}
