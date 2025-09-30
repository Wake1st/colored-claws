class_name Paint


static func draw_line(
	img: Image, 
	start_position: Vector2, 
	end_position: Vector2, 
	width: float, 
	angle: float, 
	color: Color
) -> Image:
	# draw the new image
	var blend: Image = Image.create_empty(img.get_width(), img.get_height(), false, Image.FORMAT_RGBA8)
	var rect = img.get_used_rect()
	
	var total_x = width * cos(angle)
	var total_y = width * sin(angle)
	
	var current_position: Vector2 = start_position
	var paint_vector: Vector2 = end_position - start_position
	var height: int = ceili(paint_vector.length())
	for j in height:
		for i in width:
			current_position = paint_vector * j/height
			
			var x: int = start_position.x + current_position.x + total_x/2 - i * cos(angle) - 1
			var y: int = start_position.y + current_position.y +  total_y/2 - i * sin(angle) - 1
			
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
	
	# update image and return
	img.blend_rect_mask(blend, img, img.get_used_rect(), Vector2.ZERO)
	return img


static func clear_circle(
	img: Image,
	start_position: Vector2, 
	_end_position: Vector2, 
	radius: float
) -> Image:
	# draw the new image
	var blend: Image = Image.create_empty(img.get_width(), img.get_height(), false, Image.FORMAT_RGBA8)
	var rect = img.get_used_rect()
	var color = Color(0,0,0,0)
	
	for r in radius:
		for i in range(0,2*PI):
			var current_position = Vector2(
				radius * cos(i),
				radius * sin(i)
			)
			
			var x: int = start_position.x + current_position.x
			var y: int = start_position.y + current_position.y
			
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
	
	# update image and return
	img.blend_rect_mask(blend, img, img.get_used_rect(), Vector2.ZERO)
	return img
