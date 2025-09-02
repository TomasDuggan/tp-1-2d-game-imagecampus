extends Node2D
class_name SkillsController
"""
Controlador de los skills de una unidad
"""

var _skill_instances: Array[SkillAbstractBehaviour] = []


func add_skills(skill_configs: Array[SkillConfig], skills_manager: SkillsManager) -> void:
	for skill_config: SkillConfig in skill_configs:
		_add_skill(skill_config, skills_manager)

func _add_skill(skill_config: SkillConfig, skills_manager: SkillsManager):
	if skills_manager.is_skill_unlocked(skill_config):
		var instance: SkillAbstractBehaviour = skills_manager.create_skill_instance(skill_config)
		
		_skill_instances.append(instance)
		add_child(instance)

func update_caster_position(caster_cast_point: Vector2, caster_direction: Vector2):
	for skill_instance: SkillAbstractBehaviour in _skill_instances:
		skill_instance.update_caster_position(caster_cast_point, caster_direction)
