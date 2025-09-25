extends StaticBody2D
class_name Collectable
"""
Un obstaculo detectable por el ataque de Hero, se compone de comportamientos que le dan efectos
"""

@export var _override_config: CollectableConfig

@onready var _animation: AnimatedSprite2D = $Animation
@onready var _hurtbox: Hurtbox = $Hurtbox
@onready var _animation_player: AnimationPlayer = $AnimationPlayer
@onready var _physics_collision_shape: CollisionShape2D = $PhysicsCollisionShape

var _config: CollectableConfig
var _behaviours: Array[CollectableBehaviour] = []


func initialize(config: CollectableConfig) -> void:
	_config = config

func _ready():
	if _override_config != null:
		_config = _override_config
	
	_hurtbox.initialize(self, _config.hp, Hurtbox.DamageFaction.ENEMY, false)
	_hurtbox.destroyed.connect(_on_hurtbox_destroyed)
	_hurtbox.hit.connect(_hit)
	
	_animation.scale = _config.scale_override
	_animation.sprite_frames = _config.sprite_frames
	_animation.play("default")
	
	for behaviour_config: CollectableBehaviourConfig in _config.behaviour_configs:
		_add_behaviour(behaviour_config)

func _add_behaviour(behaviour_config: CollectableBehaviourConfig) -> void:
	var behaviour_instance: CollectableBehaviour = behaviour_config.get_behaviour()
	
	_behaviours.append(behaviour_instance)
	behaviour_instance.initialize(behaviour_config)
	behaviour_instance.request_animation.connect(_on_animation_requested)
	add_child(behaviour_instance)

func _on_hurtbox_destroyed(damage_source: Hero, _defender: Node2D) -> void:
	for behaviour: CollectableBehaviour in _behaviours:
		behaviour.on_destroyed_by_hero(damage_source)
	
	_remove_collectable()

func _remove_collectable() -> void:
	_hurtbox.deactivate()
	_physics_collision_shape.call_deferred("set_disabled", true)
	
	# TODO: esto justifica hacer un script al animation
	if _animation.sprite_frames.has_animation("death"):
		_animation.play("death")
		await _animation.animation_finished
	else:
		_animation_player.play("fade_out")
		await _animation_player.animation_finished
	
	queue_free()

func _on_animation_requested(animation_name: String) -> void:
	_animation.play(animation_name)
	await _animation.animation_finished
	_animation.play("default")

func _hit() -> void:
	_animation_player.play("hit")

func get_destroyed_velocity_boost_duration() -> float:
	return _config.destroyed_velocity_boost_duration


#
