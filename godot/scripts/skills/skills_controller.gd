extends Node2D
class_name SkillsController
"""
Controlador de los skills de una unidad
"""

signal skill_animation_request(animation_name_prefix: String, halt_caster_movement: bool)

var _skill_instances: Array[SkillAbstractBehaviour] = []
var _skills_anchor := Node2D.new()

func _ready():
	add_child(_skills_anchor)

func add_skills(skill_configs: Array[SkillConfig], skills_manager: SkillsManager) -> void:
	for skill_config: SkillConfig in skill_configs:
		_add_skill(skill_config, skills_manager)

func _add_skill(skill_config: SkillConfig, skills_manager: SkillsManager):
	if skills_manager.is_skill_unlocked(skill_config):
		var instance: SkillAbstractBehaviour = skills_manager.create_skill_instance(skill_config)
		
		instance.request_animation.connect(func(anim_name: String, halt_caster_movement: bool): 
			skill_animation_request.emit(anim_name, halt_caster_movement)
		) # Pasamanos
		
		_skill_instances.append(instance)
		_skills_anchor.add_child(instance)

func rotate_skills_anchor(looking_direction: Vector2) -> void:
	_skills_anchor.rotation = looking_direction.angle()
