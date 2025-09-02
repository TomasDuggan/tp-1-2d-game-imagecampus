extends Node2D
class_name SkillsController


var _skill_instances: Array[SkillAbstractBehaviour] = []

# TODO: componentizar esto en un SkillsManager
func add_skills(skill_configs: Array[SkillConfig]) -> void:
	for skill_config: SkillConfig in skill_configs:
		_add_skill(skill_config)

# TODO:
# Si quiero que esto funcione en enemigos, tendria que inyectarle el manager
func _add_skill(skill_config: SkillConfig):
	if SkillsManager.is_skill_unlocked(skill_config):
		var instance: SkillAbstractBehaviour = SkillsManager.create_skill_instance(skill_config)
		
		_skill_instances.append(instance)
		add_child(instance)

func update_caster_position(caster_cast_point: Vector2, caster_direction: Vector2):
	for skill_instance: SkillAbstractBehaviour in _skill_instances:
		skill_instance.update_caster_position(caster_cast_point, caster_direction)
