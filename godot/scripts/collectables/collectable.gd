extends StaticBody2D
class_name Collectable
"""
Un obstaculo detectable por el ataque de Hero, se compone de comportamientos que le dan efectos
"""

@onready var _animation: AnimatedSprite2D = $Animation
@onready var _hurtbox: Hurtbox = $Hurtbox
@onready var _animation_player: AnimationPlayer = $AnimationPlayer


var _config: CollectableConfig
var _behaviours: Array[CollectableBehaviour] = []


func initialize(config: CollectableConfig) -> void:
	_config = config

func _ready():
	_hurtbox.initialize(self, _config.hp, Enums.DamageFaction.ENEMY)
	_hurtbox.destroyed.connect(_destroyed)
	_hurtbox.hit.connect(_hit)
	
	_animation.sprite_frames = _config.sprite_frames
	_animation.play("default")
	
	for behaviour_config: CollectableBehaviourConfig in _config.behaviour_configs:
		_add_behaviour(behaviour_config)

func _add_behaviour(behaviour_config: CollectableBehaviourConfig) -> void:
	var instance: CollectableBehaviour = behaviour_config.get_behaviour()
	
	_behaviours.append(instance)
	instance.initialize(behaviour_config)
	add_child(instance)

func _destroyed(damage_source: Hero, _defender: Node2D) -> void:
	for behaviour: CollectableBehaviour in _behaviours:
		behaviour.on_destroyed_by_hero(damage_source)
	
	queue_free()

func _hit() -> void:
	_animation_player.play("hit")

func get_destroyed_velocity_boost_duration() -> float:
	return _config.destroyed_velocity_boost_duration


#
