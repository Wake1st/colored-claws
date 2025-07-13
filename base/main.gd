class_name Main
extends Node


@onready var work_zone: WorkZone = $WorkZone
@onready var popup_manager: PopupManager = $PopupManager
@onready var hud: HUD = %HUD


func _ready() -> void:
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	work_zone.job_complete.connect(_handle_job_complete)
	hud.color_changed.connect(_handle_color_changed)
	popup_manager.finished.connect(_handle_popup_finished)
	
	work_zone.update_brush(hud.get_color())
	work_zone.setup()

func _handle_job_complete() -> void:
	popup_manager.display()

func _handle_color_changed(color: Color) -> void:
	work_zone.update_brush(color)

func _handle_popup_finished() -> void:
	work_zone.setup()
