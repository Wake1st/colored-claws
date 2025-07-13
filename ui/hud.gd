class_name HUD
extends Control


signal color_changed(color: Color)

@onready var picker: ColorPickerButton = $ColorPickerButton


func get_color() -> Color:
	return picker.color


func _on_color_picker_button_color_changed(color):
	emit_signal("color_changed", color)

#func _on_color_picker_button_mouse_entered():
	#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#
#func _on_color_picker_button_mouse_exited():
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
