extends Node
class_name HeroMovementInputReader
"""
Determina la direccion del jugador en base al input
"""

const MOVEMENT_KEY_TO_DIRECTION := {
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN,
	"move_left": Vector2.LEFT,
	"move_right": Vector2.RIGHT,
}


func get_movement_direction() -> Vector2:
	for input_key: String in MOVEMENT_KEY_TO_DIRECTION.keys():
		if Input.is_action_pressed(input_key):
			return MOVEMENT_KEY_TO_DIRECTION[input_key]
	
	return Vector2.ZERO
