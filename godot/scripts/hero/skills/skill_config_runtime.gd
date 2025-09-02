extends Object
class_name SkillConfigRuntime
"""
Representacion en play-mode de los Resources de tipo Skill
"""


var config: SkillConfig
var level: int

func _init(config_arg: SkillConfig, level_arg: int):
	config = config_arg
	level = level_arg

func is_unlocked() -> bool:
	return level > -1

func matches_config(config_arg: SkillConfig) -> bool: # TODO: rename
	return config == config_arg

func get_behaviour_config() -> Resource:
	return config.behaviour_config.config

func get_behaviour() -> SkillAbstractBehaviour:
	return config.behaviour_config.behaviour.new()
