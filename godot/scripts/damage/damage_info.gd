extends Object
class_name DamageInfo
"""
Parametro de dmg
"""

enum DamageType { PHYSICAL, FIRE }

var attacker: Node2D
var damage_type: DamageType
var damage_amount: int

func _init(attacker_arg: Node2D, damage_amount_arg: int, damage_type_arg: DamageType):
	self.attacker = attacker_arg
	self.damage_type = damage_type_arg
	self.damage_amount = damage_amount_arg
