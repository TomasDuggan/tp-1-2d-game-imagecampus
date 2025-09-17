extends Area2D
class_name Hurtbox
"""
Escena para recibir dmg de Hitbox
"""

@onready var _hp_bar: ProgressBar = $HPBar

signal hit()
signal healed()
signal destroyed(attacker_root: Node2D, defender_root: Node2D)

var _root: Node2D
var _max_hp: int
var _current_hp: int
var _faction: Enums.DamageFaction


func initialize(root: Node2D, hp: int, faction: Enums.DamageFaction, show_hp_bar: bool) -> void:
	_root = root
	_max_hp = hp
	_current_hp = hp
	_faction = faction
	
	_update_hp_bar()
	if !show_hp_bar:
		_hp_bar.hide()

func receive_damage(attacker_root: Node2D, damage_amount: int) -> void:
	_current_hp = max(_current_hp - damage_amount, 0)
	
	_update_hp_bar()
	
	if _current_hp == 0:
		destroyed.emit(attacker_root, _root)
	else:
		hit.emit()

func heal(heal_amount: int) -> void:
	_current_hp = min(_current_hp + heal_amount, _max_hp)
	_update_hp_bar()
	healed.emit()

func _update_hp_bar() -> void:
	_hp_bar.value = _current_hp / float(_max_hp)

func is_ally(other: Enums.DamageFaction) -> bool:
	return _faction == other






#
