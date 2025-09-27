extends Node2D
class_name Scroll
"""
Scrollea el contenido hacia abajo (+Y) para simular que Hero avanza.
"""

const SCROLL_SPEED := 75.0


func _process(delta: float) -> void:
	position.y += SCROLL_SPEED * delta
