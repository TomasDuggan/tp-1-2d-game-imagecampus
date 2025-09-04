extends SkillsManager
class_name EnemySkillsManager

func is_skill_unlocked(_skill_config: SkillConfig) -> bool:
	return true

func create_skill_instance(skill_config: SkillConfig) -> SkillAbstractBehaviour:
	var instance: SkillAbstractBehaviour = skill_config.behaviour_config.behaviour.new()
	
	# TODO: level == 0 podria depender del level
	instance.initialize(skill_config.behaviour_config.config, 0, skill_config.behaviour_config.layer_to_affect)
	return instance
