class_name Brush
extends Tool


const ROTATION_OFFSET: float = PI/2
const BRUSH_STEP: int = 6
const BASE_WIDTH: int = 20

@export var width: int = BASE_WIDTH

@onready var sprite: Sprite2D = $Sprite2D

var hold_offset: Vector2 = Vector2(0, -220)
var color: Color

var active: bool
var pivoting: bool
var last_position: Vector2


func get_data() -> BrushData:
	var data: BrushData = BrushData.new()
	data.start_position = last_position
	data.end_position = global_position
	data.angle = rotation
	data.width = width
	data.color = color
	return data


func process(_delta: float, mouse: Vector2) -> void:
	if pivoting:
		var vector = global_position.direction_to(mouse)
		rotation = vector.angle() + ROTATION_OFFSET
	else:
		last_position = position
		position = mouse - hold_offset


func input(event: InputEvent) -> void:
	if event.is_action_pressed("activate_brush"):
		active = true
	elif event.is_action_released("activate_brush"):
		active = false
	
	if event.is_action_pressed("pivot_brush"):
		pivoting = true
	elif event.is_action_released("pivot_brush"):
		pivoting = false
		hold_offset = hold_offset.rotated(rotation - hold_offset.angle() - ROTATION_OFFSET)
	
	if event.is_action_pressed("widen_brush"):
		_animate_fan(true)
	elif event.is_action_pressed("narrow_brush"):
		_animate_fan(false)


func _animate_fan(opening: bool) -> void:
	# adjust and limit the frames
	var current_frame = sprite.frame
	if opening:
		current_frame += 1
		if current_frame >= sprite.hframes:
			current_frame = sprite.hframes - 1
	else:
		current_frame -= 1
		if current_frame < 0:
			current_frame = 0
	
	# update
	sprite.frame = current_frame
	width = sprite.frame * BRUSH_STEP + BASE_WIDTH
