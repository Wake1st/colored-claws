class_name Brush
extends Node2D


const ROTATION_OFFSET: float = PI/2

@export var width: float = 22

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


func _process(_delta) -> void:
	var mouse = get_global_mouse_position()
	
	if pivoting:
		var vector = global_position.direction_to(mouse)
		rotation = vector.angle() + ROTATION_OFFSET
	else:
		last_position = position
		position = mouse - hold_offset


func _input(event) -> void:
	if event.is_action_pressed("activate_brush"):
		active = true
	elif event.is_action_released("activate_brush"):
		active = false
	
	if event.is_action_pressed("pivot_brush"):
		pivoting = true
	elif event.is_action_released("pivot_brush"):
		pivoting = false
		hold_offset = hold_offset.rotated(rotation - hold_offset.angle() - ROTATION_OFFSET)
