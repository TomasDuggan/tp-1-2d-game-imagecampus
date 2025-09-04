extends AnimatedSprite2D
class_name UnitAnimation
"""
Manejador de animaciones de las unidades
"""

const WALK_PREFIX := "walk_"
const IDLE_PREFIX := "idle_"
const ATTACK_PREFIX := "attack_"

const UP := "up"
const DOWN := "down"
const LEFT := "left"
const RIGHT := "right"

signal skill_animation_finished()

var _is_playing_skill_animation: bool


func update_movement_animation(is_moving: bool, direction: Vector2) -> void:
	if _is_playing_skill_animation:
		return
	
	if !is_moving:
		_play_animation(IDLE_PREFIX, direction)
	else:
		flip_h = direction.x > 0
		_play_animation(WALK_PREFIX, direction)

func play_skill_animation(animation_name_prefix: String, direction: Vector2) -> void:
	_is_playing_skill_animation = true
	_play_animation(animation_name_prefix, direction)
	animation_finished.connect(_on_skill_animation_finished, CONNECT_ONE_SHOT)

func _on_skill_animation_finished() -> void:
	_is_playing_skill_animation = false
	skill_animation_finished.emit()

func _play_animation(prefix: String, direction: Vector2) -> void:
	var animation_name: String = prefix + _resolve_suffix(prefix, direction)
	
	if !sprite_frames.has_animation(animation_name):
		print_debug("Se intento dar play a una animacion que no existe: " + animation_name)
		return
	
	play(animation_name)

 # TODO: podria cachear una vez si es lefty o righty
func _resolve_suffix(prefix: String, direction: Vector2) -> String:
	if abs(direction.x) > abs(direction.y): # Horizontal
		return RIGHT if sprite_frames.has_animation(prefix + RIGHT) else LEFT
	else: # Vertical
		return UP if direction.y < 0 else DOWN
