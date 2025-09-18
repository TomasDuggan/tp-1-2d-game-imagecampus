extends AnimatedSprite2D
class_name HeroAnimation
"""
Animacion de un heroe y su Outline al estar seleccionado
"""

@export var _outline_material: ShaderMaterial
var _default_material: Material


func _ready():
	_default_material = material
	
	animation_finished.connect(_on_animation_finished)
	play("walk_up")

func _play_vertical_movement_animation() -> void:
	play("walk_up")

func play_attack_animation() -> void:
	play("attack_up")

func _on_animation_finished():
	if animation == "attack_up":
		play("walk_up")

func toggle_selected(is_selected: bool) -> void:
	material = _outline_material if is_selected else _default_material




#
