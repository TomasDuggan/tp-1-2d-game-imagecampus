extends StaticBody2D
class_name Collectable
"""
Un obstaculo detectable por el ataque de Hero, gatilla efectos con sus comportamientos
"""

@onready var _animation: AnimatedSprite2D = $Animation

signal destroyed(config: CollectableConfig)

var _config: CollectableConfig
var _behaviours: Array[CollectableBehaviour] = []
var _current_hp: int


func initialize(config: CollectableConfig) -> void:
	_config = config
	_current_hp = config.hp
	_animation.sprite_frames = config.sprite_frames
	
	for behaviour_config: CollectableBehaviourConfig in config.behaviour_configs:
		_add_behaviour(behaviour_config)

func _add_behaviour(behaviour_config: CollectableBehaviourConfig) -> void:
	var instance: CollectableBehaviour = behaviour_config.get_behaviour_scene().instantiate()
	
	_behaviours.append(instance)
	instance.initialize(behaviour_config)
	add_child(instance)

func receive_damage(damage_source: Hero, damage: int) -> void:
	_current_hp = max(_current_hp - damage, 0)
	
	if _current_hp == 0:
		_destroyed_by_hero(damage_source)

func _destroyed_by_hero(hero: Hero) -> void:
	for behaviour: CollectableBehaviour in _behaviours:
		behaviour.on_destroyed_by_hero(hero)

	destroyed.emit(_config)
	queue_free()






#
