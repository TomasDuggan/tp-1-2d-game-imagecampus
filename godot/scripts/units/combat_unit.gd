extends Node2D
class_name CombatUnit

@onready var _skills_controller: SkillsController = $SkillsController
@onready var _health_controller: HealthController = $HealthController

signal death()
signal skill_animation_request(animation_name_prefix: String, halt_caster_movement: bool)


func initialize(unit_config: UnitConfig, skills_manager: SkillsManager, hurt_layer: int):
	_skills_controller.add_skills(unit_config.skill_configs, skills_manager)
	
	_skills_controller.skill_animation_request.connect(func(anim_name: String, halt_caster_movement: bool): 
			skill_animation_request.emit(anim_name, halt_caster_movement)
	) # Pasamanos
	
	_health_controller.initialize(hurt_layer, unit_config.hp, unit_config.armor)
	_health_controller.death.connect(func(): death.emit())

func rotate_unit_anchor(looking_direction: Vector2) -> void:
	_skills_controller.rotate_skills_anchor(looking_direction)
