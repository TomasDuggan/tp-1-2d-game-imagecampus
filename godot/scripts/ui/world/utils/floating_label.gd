extends Node2D
class_name FloatingLabel
"""
Para mensajes informativos
"""

@onready var _label: Label = $Label

const END_Y_POSITION := -40.0


func show_message(text: String, color: Color, duration: float) -> void:
	modulate = color
	
	_label.text = text
	
	var tween: Tween = create_tween()
	tween.tween_property(_label, "position:y", END_Y_POSITION, duration)
	tween.parallel().tween_property(_label, "modulate:a", 0.0, duration)
	tween.finished.connect(func(): queue_free(), CONNECT_ONE_SHOT)
