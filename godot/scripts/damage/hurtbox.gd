extends Area2D
class_name Hurtbox
"""
Escena para recibir dmg de Hitbox
"""

signal hit()
signal destroyed(attacker_root: Node2D, defender_root: Node2D)

var _root: Node2D
var _current_hp: int
var _faction: Enums.DamageFaction


func initialize(root: Node2D, hp: int, faction: Enums.DamageFaction) -> void:
	_root = root
	_current_hp = hp
	_faction = faction

func receive_damage(attacker_root: Node2D, damage: int) -> void:
	_current_hp = max(_current_hp - damage, 0)
	
	if _current_hp == 0:
		destroyed.emit(attacker_root, _root)
	else:
		hit.emit()

func is_ally(other: Enums.DamageFaction) -> bool:
	return _faction == other






#
