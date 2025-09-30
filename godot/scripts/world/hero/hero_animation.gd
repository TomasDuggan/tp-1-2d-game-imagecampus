extends AnimatedSprite2D
class_name HeroAnimation
"""
Animacion de un heroe y su Outline al estar seleccionado
"""

@export var _outline_material: ShaderMaterial
var _default_material: Material


func initialize(hero_sprite_frames: SpriteFrames) -> void:
	sprite_frames = hero_sprite_frames

func _ready():
	_default_material = material
	
	animation_finished.connect(_on_animation_finished)
	_play_vertical_movement_animation()

func play_movement_animation(facing_direction: Vector2) -> void:
	pass

func _play_vertical_movement_animation() -> void:
	play("walk_up")

func play_attack_animation() -> void:
	play("attack_up")

func _on_animation_finished():
	if animation == "attack_up":
		_play_vertical_movement_animation()

func toggle_selected(is_selected: bool) -> void:
	material = _outline_material if is_selected else _default_material




#
