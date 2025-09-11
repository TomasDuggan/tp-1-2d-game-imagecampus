extends StaticBody2D
class_name Collectable
"""
Un obstaculo detectable por el ataque de Hero, gatilla efectos con sus comportamientos
"""

@onready var _animation: AnimatedSprite2D = $Animation
@onready var _hurtbox: Hurtbox = $Hurtbox

var _config: CollectableConfig
var _behaviours: Array[CollectableBehaviour] = []


func initialize(config: CollectableConfig) -> void:
	_config = config

func _ready():
	_hurtbox.initialize(self, _config.hp, Enums.DamageFaction.COLLECTABLE)
	_hurtbox.destroyed.connect(_destroyed)
	
	_animation.sprite_frames = _config.sprite_frames
	_animation.play("default")
	
	for behaviour_config: CollectableBehaviourConfig in _config.behaviour_configs:
		_add_behaviour(behaviour_config)

func _add_behaviour(behaviour_config: CollectableBehaviourConfig) -> void:
	var instance: CollectableBehaviour = behaviour_config.get_behaviour_scene().instantiate()
	
	_behaviours.append(instance)
	instance.initialize(behaviour_config)
	add_child(instance)

func _destroyed(damage_source: Hero, _defender: Node2D) -> void:
	for behaviour: CollectableBehaviour in _behaviours:
		behaviour.on_destroyed_by_hero(damage_source)
	
	queue_free()

func get_destroyed_velocity_boost_duration() -> float:
	return _config.destroyed_velocity_boost_duration




#
