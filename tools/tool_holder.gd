class_name ToolHolder
extends Area2D


signal selected(t: Tool)

@export var tool: Tool

var focused: bool


func holster() -> void:
	tool.global_position = global_position
	tool.rotation = 0


func _input(event) -> void:
	if focused && Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		selected.emit(tool)

func _on_mouse_entered():
	focused = true

func _on_mouse_exited():
	focused = false
