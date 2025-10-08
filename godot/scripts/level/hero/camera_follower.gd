extends Camera2D
class_name CameraFollower
"""
Sigue al heroe en el eje X asi puede explorar horizontalmente el mapa.
Ignora Y para que se note cuando se traba y baja.
"""

@export var _hero: Hero


func _process(_delta):
	global_position.x = _hero.global_position.x
