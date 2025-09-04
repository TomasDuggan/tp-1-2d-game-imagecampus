extends Node2D
class_name CombatUnit

@onready var _skills_controller: SkillsController = $SkillsController
@onready var _health_controller: HealthController = $HealthController
@onready var _animation: UnitAnimation = $Animation

var _config: UnitConfig
var _looking_direction: Vector2
var _can_move := true

signal death(unit: CombatUnit)


func initialize(unit_config: UnitConfig, skills_manager: SkillsManager, hurt_layer: int):
	_config = unit_config
	_animation.sprite_frames = unit_config.sprite_frames
	_animation.scale = unit_config.animation_scale_offset
	
	# TODO: "_can_move = true", si can_move aplica para otras cosas (como stun), esto estaria mal
	_animation.skill_animation_finished.connect(func(): _can_move = true, CONNECT_ONE_SHOT)
	
	_skills_controller.add_skills(unit_config.skill_configs, skills_manager)
	_skills_controller.skill_animation_request.connect(_on_skill_requested_animation)
	
	_health_controller.initialize(hurt_layer, unit_config.hp, unit_config.armor)
	_health_controller.death.connect(_on_death)

func update(is_moving: bool, looking_direction: Vector2) -> void:
	_looking_direction = looking_direction
	_animation.update_movement_animation(is_moving, looking_direction)
	_skills_controller.rotate_skills_anchor(looking_direction)

func _on_skill_requested_animation(animation_name_prefix: String, halt_movement: bool) -> void:
	_animation.play_skill_animation(animation_name_prefix, _looking_direction)
	_can_move = !halt_movement

func _on_death() -> void:
	death.emit(self)

func can_move() -> bool:
	return _can_move

func get_config() -> UnitConfig:
	return _config
