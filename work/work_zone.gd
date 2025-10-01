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

@onready var brush: Brush = %Brush
@onready var pad: Pad = %Pad

var nails: Array[Nail]
var completed: bool
var active_nail: Nail
var before_image: Image


func setup() -> void:
	# reset commands
	Commands.clear()
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
		# setup nail
		nail.setup()
		nails.push_back(nail)
	
	hand.position.y = AWAY


func _process(_delta) -> void:
	if brush.active: 
		var data: BrushData = brush.get_data()
		
		var progress: float = 0
		for nail in nails:
			# only update the nail we draw to
			if _check_brush_bounds(data, nail):
				if active_nail == null:
					# setup for commands
					active_nail = nail
					before_image = nail.image.duplicate(true)
				elif active_nail != nail:
					# the nail has changed, set a new command
					Commands.add(active_nail, before_image, active_nail.image.duplicate(true))
					active_nail = nail
					before_image = nail.image.duplicate(true)
				
				# draw on the nail
				progress += nail.brush(data) * 0.1
		
		if !completed && progress > COMPLETENESS:
			emit_signal("job_complete")
			completed = true
	elif pad.active:
		var data: PadData = pad.get_data()
		
		for nail in nails:
			# only update the nail we draw to
			if _check_pad_bounds(data, nail):
				if active_nail == null:
					# setup for commands
					active_nail = nail
					before_image = nail.image.duplicate(true)
				elif active_nail != nail:
					# the nail has changed, set a new command
					Commands.add(active_nail, before_image, active_nail.image.duplicate(true))
					active_nail = nail
					before_image = nail.image.duplicate(true)
				
				# draw on the nail
				nail.clean(data)
	elif active_nail:
		# store complete change
		Commands.add(active_nail, before_image, active_nail.image.duplicate(true))
		active_nail = null
		before_image = null


func _input(event) -> void:
	if event.is_action_pressed("ui_undo"):
		var cmd: Command = Commands.undo()
		if cmd:
			cmd.undo()
	elif event.is_action_pressed("ui_redo"):
		var cmd: Command = Commands.redo()
		if cmd:
			cmd.redo()


func _check_brush_bounds(data: BrushData, nail: Nail) -> bool:
	var rect: Rect2 = nail.get_rect()
	rect.position += nail.global_position
	
	var arm = Vector2(data.width/2, 0)
	arm.rotated(data.angle)
	
	var start_neg = data.start_position - arm
	var start_pos = data.start_position + arm
	var end_neg = data.end_position - arm
	var end_pos = data.end_position + arm
	
	return (
		rect.has_point(start_neg) || rect.has_point(start_pos)
	) || (
		rect.has_point(end_neg) || rect.has_point(end_pos)
	)


func _check_pad_bounds(data: PadData, nail: Nail) -> bool:
	var rect: Rect2 = nail.get_rect()
	rect.position += nail.global_position
	
	var arm = Vector2(data.radius/2, 0)
	
	var start_neg = data.start_position - arm
	var start_pos = data.start_position + arm
	var end_neg = data.end_position - arm
	var end_pos = data.end_position + arm
	
	return (
		rect.has_point(start_neg) || rect.has_point(start_pos)
	) || (
		rect.has_point(end_neg) || rect.has_point(end_pos)
	)
