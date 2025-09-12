class_name Command


var nail: Nail
var before: Image
var after: Image


func _init(_nail: Nail, _before: Image, _after: Image) -> void:
	nail = _nail
	before = _before
	after = _after

func undo() -> void:
	nail.set_texture(before)

func redo() -> void:
	nail.set_texture(after)
