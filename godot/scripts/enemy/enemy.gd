extends Node2D
class_name Enemy

@onready var _combat_unit: CombatUnit = $CombatUnit
@onready var _animation: UnitAnimation = $Animation


var _config: UnitConfig
var _skills_manager: EnemySkillsManager
var _direction: Vector2

func initialize(enemy_config: UnitConfig, skills_manager: EnemySkillsManager) -> void:
	_config = enemy_config
	_skills_manager = skills_manager

func _ready():
	_combat_unit.initialize(_config, _skills_manager, 16)
	_combat_unit.skill_animation_request.connect(_on_skill_requested_animation)
	_animation.sprite_frames = _config.sprite_frames

func get_movement_speed() -> float:
	return _config.movement_speed

func update(direction_arg: Vector2) -> void:
	_direction = direction_arg
	_animation.update_movement_animation(direction_arg != Vector2.ZERO, _direction)
	_combat_unit.rotate_unit_anchor(_direction)

func _on_skill_requested_animation(animation_name_prefix: String, halt_movement: bool) -> void:
	_animation.play_skill_animation(animation_name_prefix, _direction, halt_movement)
