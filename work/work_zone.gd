class_name WorkZone
extends Node2D


signal job_complete

const AWAY: float = 700
const REST: float = 43
const COMPLETENESS: float = 0.87

@onready var hand: Node2D = $Hand
@onready var nail_1: Nail = %Nail1
@onready var nail_2: Nail = %Nail2
@onready var nail_3: Nail = %Nail3
@onready var nail_4: Nail = %Nail4
@onready var nail_5: Nail = %Nail5
@onready var nail_6: Nail = %Nail6
@onready var nail_7: Nail = %Nail7
@onready var nail_8: Nail = %Nail8
@onready var nail_9: Nail = %Nail9
@onready var nail_10: Nail = %Nail10

@onready var brush: Brush = $Brush

var nails: Array[Nail]
var completed: bool


func setup() -> void:
	completed = false
	
	for nail: Nail in hand.get_children():
		nail.setup()
	
	var tween = create_tween()
	tween.tween_property(hand, "position:y", REST, 0.8).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)


func leave() -> void:
	var tween = create_tween()
	tween.tween_property(hand, "position:y", AWAY, 0.8).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)


func update_brush(color: Color) -> void:
	brush.color = color


func _ready() -> void:
	for nail: Nail in hand.get_children():
		nail.setup()
		nails.push_back(nail)
	
	hand.position.y = AWAY


func _process(_delta) -> void:
	if brush.active:
		var data: BrushData = brush.get_data()
		
		var progress: float = 0
		for nail in nails:
			progress += nail.brush(data) * 0.1
		
		if !completed && progress > COMPLETENESS:
			emit_signal("job_complete")
			completed = true
