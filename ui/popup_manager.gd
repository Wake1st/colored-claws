class_name PopupManager
extends Node2D


signal finished()

const CLOSED: float = 1400

@onready var timer: Timer = $Timer
@onready var popup: Sprite2D = $Popup

var animating: bool


func display() -> void:
	if !animating:
		animating = true
		_shift(true)


func _shift(open: bool) -> void:
	var target: float
	if open:
		target = 0
	else:
		target = -CLOSED
	
	var tween = create_tween()
	tween.tween_property(popup, "position:y", target, 1.2
	).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_callback(_handle_tween_finished.bind(open))

func _handle_tween_finished(opened: bool) -> void:
	if opened:
		timer.start()
	else:
		popup.position.y = CLOSED
		animating = false
		emit_signal("finished")

func _on_timer_timeout():
	_shift(false)
