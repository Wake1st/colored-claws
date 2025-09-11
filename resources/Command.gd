class_name Command


var nail: Nail
var image: Image


func _init(_nail: Nail, _img: Image) -> void:
	nail = _nail
	image = _img


func execute() -> void:
	nail.set_texture(image)
