extends AnimatedSprite2D
class_name HeroAnimation
"""
Animacion de un heroe y su Outline al estar seleccionado
"""

@export var _outline_material: ShaderMaterial

const ATTACK_PREFIX := "attack_"
const WALK_PREFIX := "walk_"
const UP_SUFFIX := "up"
const RIGHT_SUFFIX := "right"

var _current_raw_direction: int
var _default_material: Material


func initialize(hero_sprite_frames: SpriteFrames) -> void:
	sprite_frames = hero_sprite_frames

func _ready():
	_default_material = material
	
	animation_finished.connect(_on_animation_finished)
	_play_walk_animation()

func set_direction(new_dir: int) -> void:
	if new_dir != _current_raw_direction:
		_current_raw_direction = new_dir
		if not animation.begins_with(ATTACK_PREFIX):
			_play_walk_animation()

func _play_walk_animation() -> void:
	play(WALK_PREFIX + _resolve_suffix())

func play_attack_animation() -> void:
	play(ATTACK_PREFIX + _resolve_suffix())

func _resolve_suffix() -> String:
	flip_h = _current_raw_direction == -1
	
	if _current_raw_direction == 0:
		return UP_SUFFIX
	
	return RIGHT_SUFFIX

func _on_animation_finished():
	if animation.begins_with(ATTACK_PREFIX):
		_play_walk_animation()

func toggle_selected(is_selected: bool) -> void:
	material = _outline_material if is_selected else _default_material




#
