extends Area2D
class_name Collectable
"""
Un area detectable por el ataque de Hero, gatilla efectos al ser destruida
"""

signal destroyed()

var _behaviours: Array[CollectableBehaviour] = []
var _current_hp: int


func _ready():
	collision_layer = 8 # Collectable layer

func initialize(config: CollectableConfig) -> void:
	_current_hp = config.hp
	
	for behaviour: PackedScene in config.behaviours:
		var instance: CollectableBehaviour = behaviour.instantiate()
		
		instance.initialize(config)
		add_child(instance)
		_behaviours.append(instance)

func receive_damage(damage_source: Hero, damage: int) -> void:
	_current_hp = max(_current_hp - damage, 0)
	
	if _current_hp == 0:
		_destroyed_by_hero(damage_source)

func _destroyed_by_hero(hero: Hero) -> void:
	for behaviour: CollectableBehaviour in _behaviours:
		behaviour.on_destroyed_by_hero(hero)

	destroyed.emit()
	





#
