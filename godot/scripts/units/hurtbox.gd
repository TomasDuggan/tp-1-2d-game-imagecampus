extends Area2D
class_name HealthController

signal death()

var _max_hp: int
var _current_hp: int
var _current_armor: int

func initialize(hurt_layer: int, hp: int, armor: int) -> void:
	collision_layer = hurt_layer
	
	_max_hp = hp
	_current_hp = hp
	_current_armor = armor

func receive_damage(damage: int) -> void:
	_current_hp = max(_current_hp - damage, 0)
	print("Current hp: " + str(_current_hp))
	if _current_hp == 0:
		death.emit()
