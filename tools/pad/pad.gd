class_name Pad
extends Tool


var active: bool
var last_position: Vector2


func get_data() -> PadData:
	var data: PadData = PadData.new()
	data.start_position = last_position
	data.end_position = global_position
	data.radius = 16
	return data


func process(_delta: float, mouse: Vector2) -> void:
	last_position = global_position
	global_position = mouse


func input(event: InputEvent) -> void:
	if event.is_action_pressed("activate_brush"):
		active = true
	elif event.is_action_released("activate_brush"):
		active = false
