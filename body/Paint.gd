class_name Paint


static func draw_line(img: Image, offset: Vector2, width: float, angle: float, color: Color) -> Image:
	var blend: Image = Image.create_empty(img.get_width(), img.get_height(), false, Image.FORMAT_RGBA8)
	var rect = img.get_used_rect()
	
	var total_x = width * cos(angle)
	var total_y = width * sin(angle)
	for i in width:
		var x: int = offset.x + total_x/2 - i * cos(angle) - 1
		var y: int = offset.y +  total_y/2 - i * sin(angle) - 1
		
		if rect.has_point(Vector2(x, y)):
			blend.set_pixel(x, y, color)
		if rect.has_point(Vector2(x, y - 1)):
			blend.set_pixel(x, y - 1, color)
		if rect.has_point(Vector2(x, y + 1)):
			blend.set_pixel(x, y + 1, color)
		if rect.has_point(Vector2(x - 1, y)):
			blend.set_pixel(x - 1, y, color)
		if rect.has_point(Vector2(x + 1, y)):
			blend.set_pixel(x + 1, y, color)
	
	img.blend_rect_mask(blend, img, img.get_used_rect(), Vector2.ZERO)
	return img
