extends Node
class_name HeroMessagesManager
"""
Muestra mensajes informativos sobre Hero
"""

const FLOATING_LABEL_SCENE: PackedScene = preload("uid://dtaor3dpc268a")
const HERO_HEAD_OFFSET := Vector2(0, -30)

const MESSAGE_DURATION := 1.5
const SUCCESS_MESSAGE_COLOR := Color.LAWN_GREEN
const FAIL_MESSAGE_COLOR := Color.CRIMSON
const SWAP_BLOCKED_MESSAGE := "Swap Blocked!"

var _hero: Hero


func initialize(hero: Hero) -> void:
	_hero = hero

func _ready():
	HeroEventBus.hero_swapped.connect(_on_hero_swapped)

func _on_hero_swapped(_from, _to, success: bool) -> void:
	if !success:
		_spawn_swap_blocked_message()
		
func _spawn_swap_blocked_message() -> void:
	var floating_label_instance: FloatingLabel = FLOATING_LABEL_SCENE.instantiate()
	add_child(floating_label_instance)
	
	floating_label_instance.global_position = _hero.global_position + HERO_HEAD_OFFSET
	floating_label_instance.show_message(SWAP_BLOCKED_MESSAGE, FAIL_MESSAGE_COLOR, MESSAGE_DURATION)

func _exit_tree():
	HeroEventBus.hero_swapped.disconnect(_on_hero_swapped)








#
