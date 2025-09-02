extends Node
class_name SkillsManager
"""
'Interfaz' para cualquier manager que maneje Skills
"""

func is_skill_unlocked(_skill_config: SkillConfig) -> bool:
	assert(false, "This method needs to be implemented to check if a skill is unlocked")
	return false

func create_skill_instance(_skill_config: SkillConfig) -> SkillAbstractBehaviour:
	assert(false, "This method needs to be implemented to instantiate the skill behaviour script")
	return null
