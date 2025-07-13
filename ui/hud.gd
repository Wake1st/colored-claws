class_name HUD
extends Control


signal color_changed(color: Color)
signal fin_selected()

@onready var picker: ColorPickerButton = $ColorPickerButton


func get_color() -> Color:
	return picker.color


func _on_color_picker_button_color_changed(color):
	emit_signal("color_changed", color)

func _on_texture_button_pressed():
	emit_signal("fin_selected")
