extends Node2D
class_name FloatingLabel
"""
Para mensajes informativos
"""

@onready var _label: Label = $Label


func show_message(text: String, color: Color, duration: float) -> void:
	modulate = color
	
	_label.text = text
	
	var tween: Tween = create_tween()
	tween.tween_property(_label, "position:y", -40, duration)
	tween.parallel().tween_property(_label, "modulate:a", 0.0, duration)
	tween.finished.connect(_on_tween_finished, CONNECT_ONE_SHOT)

func _on_tween_finished():
	queue_free() # se borra solo al terminar
