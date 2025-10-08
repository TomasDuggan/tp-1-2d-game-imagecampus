extends Node
class_name HeroMovementInputReader
"""
Resuelve la lectura del input de movimiento horizontal del heroe
"""


var _use_arrows_on_synergy_activation: bool
var _right_action := "move_right"
var _left_action := "move_left"

const SYNERGY_ACTION_SUFFIX := "_synergy_activated"


func initialize(use_arrows_on_synergy_activation: bool) -> void:
	_use_arrows_on_synergy_activation = use_arrows_on_synergy_activation

func _ready():
	SynergyEventBus.synergy_effect_activated.connect(_on_synergy_activated)
	SynergyEventBus.synergy_effect_ended.connect(_on_synergy_ended)

func _on_synergy_activated() -> void:
	if _use_arrows_on_synergy_activation:
		_right_action += SYNERGY_ACTION_SUFFIX
		_left_action += SYNERGY_ACTION_SUFFIX

func _on_synergy_ended() -> void:
	if _use_arrows_on_synergy_activation:
		_right_action = _remove_synergy_suffix(_right_action)
		_left_action = _remove_synergy_suffix(_left_action)

func _remove_synergy_suffix(action: String) -> String:
	return action.substr(0, action.length() - SYNERGY_ACTION_SUFFIX.length())

func get_raw_horizontal_input_direction() -> int:
	return int(Input.get_action_raw_strength(_right_action) - Input.get_action_raw_strength(_left_action))

func _exit_tree():
	SynergyEventBus.synergy_effect_activated.disconnect(_on_synergy_activated)
	SynergyEventBus.synergy_effect_ended.disconnect(_on_synergy_ended)




#
