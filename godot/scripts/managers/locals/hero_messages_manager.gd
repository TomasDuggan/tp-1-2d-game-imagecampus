extends Node
class_name HeroMessagesManager
"""
Muestra mensajes informativos sobre Hero
"""

const FLOATING_LABEL_SCENE: PackedScene = preload("uid://dtaor3dpc268a")
const HERO_HEAD_OFFSET := Vector2(0, -30)

const MIN_TIME_BETWEEN_MESSAGES := 0.5
const SHORT_MESSAGE_DURATION := 1.5
const LONG_MESSAGE_DURATION := 3.0
const SUCCESS_MESSAGE_COLOR := Color.LAWN_GREEN
const FAIL_MESSAGE_COLOR := Color.CRIMSON
const SWAP_BLOCKED_MESSAGE := "Swap Blocked!"
const SYNERGY_ACTIVATED_MESSAGE := "Synergy Activated!"

var _hero: Hero
var _timer_between_messages := Timer.new() # Evita spam

func initialize(hero: Hero) -> void:
	_hero = hero

func _ready():
	HeroEventBus.hero_swapped.connect(_on_hero_swapped)
	SynergyEventBus.synergy_effect_activated.connect(_on_synergy_activated)
	
	_timer_between_messages.autostart = true
	_timer_between_messages.one_shot = true
	_timer_between_messages.wait_time = MIN_TIME_BETWEEN_MESSAGES
	add_child(_timer_between_messages)

func _on_hero_swapped(_from, _to, success: bool) -> void:
	if !success && _timer_between_messages.is_stopped():
		_timer_between_messages.start()
		_create_floating_label(SWAP_BLOCKED_MESSAGE, FAIL_MESSAGE_COLOR, SHORT_MESSAGE_DURATION)

func _on_synergy_activated() -> void:
	_create_floating_label(SYNERGY_ACTIVATED_MESSAGE, SUCCESS_MESSAGE_COLOR, LONG_MESSAGE_DURATION)

func _create_floating_label(text: String, color: Color, duration: float) -> void:
	var floating_label_instance: FloatingLabel = FLOATING_LABEL_SCENE.instantiate()
	add_child(floating_label_instance)
	
	floating_label_instance.global_position = _hero.global_position + HERO_HEAD_OFFSET
	floating_label_instance.show_message(text, color, duration)

func _exit_tree():
	HeroEventBus.hero_swapped.disconnect(_on_hero_swapped)
	SynergyEventBus.synergy_effect_activated.disconnect(_on_synergy_activated)








#
