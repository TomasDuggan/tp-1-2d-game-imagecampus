extends Node
class_name HeroMovementInputReader
"""
Determina la direccion del jugador en base al input
"""

var _movement_input_key: String

const MOVMENT_KEY_TO_STRING := {
	Enums.InputMovementKey.FRONT: "front",
	Enums.InputMovementKey.SUPPORT: "support",
}

const MOVEMENT_KEY_TO_DIRECTION := {
	"_move_up": Vector2.UP,
	"_move_down": Vector2.DOWN,
	"_move_left": Vector2.LEFT,
	"_move_right": Vector2.RIGHT,
}


func initialize(movement_input_key: Enums.InputMovementKey):
	_movement_input_key = MOVMENT_KEY_TO_STRING[movement_input_key]

func get_direction() -> Vector2:
	for input_key: String in MOVEMENT_KEY_TO_DIRECTION.keys():
		if Input.is_action_pressed(_movement_input_key + input_key):
			return MOVEMENT_KEY_TO_DIRECTION[input_key]
	
	return Vector2.ZERO
