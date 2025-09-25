extends Node2D
class_name Scroll
"""
Contenedor del contenido del nivel. Todo lo que esta dentro baja en Y, simulando que Hero avanza
"""

@export var scroll_speed: float = 75.0

func _process(delta: float) -> void:
	position.y += scroll_speed * delta
