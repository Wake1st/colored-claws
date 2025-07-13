class_name NailShapes


static func draw_base(img: Image, offset: Vector2, size: Vector2, color: Color) -> Image:
	for i in size.y:
		for j in size.x:
			img.set_pixel(offset.x + j, offset.y + i, color)
	
	return img


static func draw_triangle(img: Image, offset: Vector2, size: Vector2, leftward: bool, color: Color) -> Image:
	var shift_counter = 0
	var ratio: int = round(size.y/size.x)
	var width_limit = size.x
	
	for i in size.y:
		# set the size.x limit per the current draw size.y
		shift_counter += 1
		if shift_counter % ratio == 0:
			width_limit -= 1
		
		# draw past the limit
		var start = (size.x - width_limit) if leftward else 0
		var end = size.x if leftward else width_limit
		for j in range(start, end):
			# set draw directions based on orientation
			img.set_pixel(offset.x + j, offset.y + i, color)
	
	return img


## Draws and fills a cicular segment within the specified size.x and size.y. 
## Note: the shape is drawn from the top left, so base origin accordingly.
static func draw_arc(img: Image, offset: Vector2, size: Vector2, origin: Vector2, radius: float, color: Color) -> Image:
	for i in size.y:
		for j in size.x:
			var dist = Vector2(offset.x + j, offset.y + i).distance_to(origin)
			if dist < radius:
				img.set_pixel(offset.x + j, offset.y + i, color)
	
	return img
