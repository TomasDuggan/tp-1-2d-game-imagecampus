extends AnimatedSprite2D
class_name UnitAnimation
"""
Manejador de animaciones basicas de las unidades
"""

const WALK_PREFIX := "walk_"
const IDLE_PREFIX := "idle_"
const ATTACK_PREFIX := "attack_"

const UP := "up"
const DOWN := "down"
const LEFT := "left"
const RIGHT := "right"


func update_movement_animation(is_moving: bool, direction: Vector2) -> void:
	if !is_moving:
		_play_animation(IDLE_PREFIX, direction)
	else:
		flip_h = direction.x > 0.0
		_play_animation(WALK_PREFIX, direction)

func _play_animation(prefix: String, direction: Vector2) -> void:
	var animation_name: String = prefix + _resolve_suffix(direction, prefix)
	
	if !sprite_frames.has_animation(animation_name):
		print_debug("Se intento dar play a una animacion que no existe: " + animation_name)
		return
	
	play(animation_name)

func _resolve_suffix(direction: Vector2, prefix: String) -> String:
	if abs(direction.x) > abs(direction.y): # Horizontal
		return RIGHT if sprite_frames.has_animation(prefix + RIGHT) else LEFT # TODO: podria cachear esto
	else: # Vertical
		return UP if direction.y < 0 else DOWN
