extends StaticBody2D
class_name Collectable
"""
Un obstaculo detectable por el ataque de Hero, gatilla efectos con sus comportamientos
"""

@onready var _sprite: Sprite2D = $Sprite

signal destroyed(config: CollectableConfig)

var _behaviours: Array[CollectableBehaviour] = []
var _config: CollectableConfig
var _current_hp: int

const REWARD_BEHAVIOUR_SCENE: PackedScene = preload("res://scenes/obstacle/behaviours/currency_reward_behaviour.tscn")


func initialize(config: CollectableConfig) -> void:
	_config = config
	_current_hp = config.hp
	
	if config.texture != null:
		_sprite.texture = config.texture
	
	for behaviour: PackedScene in config.behaviours:
		_add_behaviour(behaviour, config)
	
	_add_behaviour(REWARD_BEHAVIOUR_SCENE, config)
	
func _add_behaviour(behaviour_scene: PackedScene, config: CollectableConfig) -> void:
	var instance: CollectableBehaviour = behaviour_scene.instantiate()
	
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

	destroyed.emit(_config)
	queue_free()






#
