class_name Main
extends Node


@onready var work_zone: WorkZone = $WorkZone
@onready var popup_manager: PopupManager = $PopupManager
@onready var hud: HUD = %HUD
@onready var timer: Timer = $Timer


func _ready() -> void:
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	work_zone.job_complete.connect(_handle_job_complete)
	hud.color_changed.connect(_handle_color_changed)
	hud.fin_selected.connect(_handle_fin_selected)
	
	work_zone.update_brush(hud.get_color())
	work_zone.setup()

func _handle_color_changed(color: Color) -> void:
	work_zone.update_brush(color)

func _handle_job_complete() -> void:
	popup_manager.display()

func _handle_fin_selected() -> void:
	work_zone.leave()
	timer.start()

func _on_timer_timeout():
	work_zone.setup()
