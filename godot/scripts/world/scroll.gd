extends Node2D
class_name Scroll
"""
Scrollea el contenido (Rooms) hacia abajo (+Y) para simular que Hero avanza.
"""

const SCROLL_SPEED := 65.0


func _process(delta: float) -> void:
	position.y += SCROLL_SPEED * delta
