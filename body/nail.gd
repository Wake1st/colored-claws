class_name Nail
extends Node2D


const NAIL_PATH = "res://assets/textures/nail.png"
const COLOR_ZERO: Color = Color(0,0,0,0)

@onready var sprite: Sprite2D = $Cuticle

var image: Image
var pixel_colors: Dictionary
var pixel_changes: Array[Vector2]
var pixel_count: float


func setup() -> void:
	pixel_changes.clear()
	pixel_count = 0
	
	var texture: CompressedTexture2D = load(NAIL_PATH)
	sprite.texture = texture
	image = texture.get_image()
	
	for j in image.get_height():
		for i in image.get_width():
			var coord = Vector2(i,j)
			var color = image.get_pixelv(coord)
			if color == COLOR_ZERO:
				continue
			
			pixel_colors[coord] = color
			pixel_count += 1


func brush(data: BrushData) -> float:
	var offset = data.position - global_position + sprite.texture.get_size()/2
	image = Paint.draw_line(image, offset, data.width, data.angle, data.color)
	sprite.texture = ImageTexture.create_from_image(image)
	
	# note changes
	for j in image.get_height():
		for i in image.get_width():
			var coord = Vector2(i,j)
			var color = image.get_pixelv(coord)
			if color == COLOR_ZERO:
				continue
			
			if pixel_colors[coord] != color:
				pixel_colors[coord] = color
				if !pixel_changes.has(coord):
					pixel_changes.push_back(coord)
	
	# update progress and check win
	return pixel_changes.size() / pixel_count
