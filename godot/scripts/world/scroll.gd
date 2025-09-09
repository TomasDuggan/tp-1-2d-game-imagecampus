extends Node2D
class_name Scroll

@export var scroll_speed: float = 100.0


func _process(delta: float) -> void:
	position.y += scroll_speed * delta
