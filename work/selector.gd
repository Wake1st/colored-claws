extends Node2D


@export var holders: Array[ToolHolder]

var tool_sets: Dictionary[Tool, ToolHolder]
var current_tool: Tool


func _ready() -> void:
	for holder in holders:
		holder.selected.connect(_handle_selection)
		tool_sets.set(holder.tool, holder)

func _process(_delta) -> void:
	if current_tool:
		current_tool.process(_delta, get_global_mouse_position())

func _input(event) -> void:
	if current_tool:
		current_tool.input(event)


func _handle_selection(tool: Tool) -> void:
	# return current tool to holder
	tool_sets[tool].holster()
	
	# set new tool
	current_tool = tool
