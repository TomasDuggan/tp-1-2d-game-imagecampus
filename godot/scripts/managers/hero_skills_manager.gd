extends SkillsManager
"""
HeroSkillsManager singleton
"""

var _all_skill_configs: Array[SkillConfig] = [
	preload("res://configs/skills/front_hero/front_hero_basic_attack_skill_config.tres")
]

var _unlocked_on_start_skill_configs: Array[SkillConfig] = [
	preload("res://configs/skills/front_hero/front_hero_basic_attack_skill_config.tres")
]

var _skill_runtimes: Array[SkillConfigRuntime] = []


func _ready():
	_initialize_skill_runtimes()

func _initialize_skill_runtimes() -> void:
	for config: SkillConfig in _all_skill_configs:
		var unlock_on_start = _unlocked_on_start_skill_configs.has(config)
		var level = 0 if unlock_on_start else -1
		
		_skill_runtimes.append(SkillConfigRuntime.new(
			config,
			level,
		))

func is_skill_unlocked(skill_config: SkillConfig) -> bool:
	var runtime = _find_runtime_by_config(skill_config)
	
	return runtime.is_unlocked()
	
func _find_runtime_by_config(skill_config: SkillConfig) -> SkillConfigRuntime:
	for runtime: SkillConfigRuntime in _skill_runtimes:
		if runtime.matches_config(skill_config):
			return runtime
	
	print_debug("Skill no encontrada")
	return null

func create_skill_instance(skill_config: SkillConfig) -> SkillAbstractBehaviour:
	if !is_skill_unlocked(skill_config):
		return null
	
	var runtime: SkillConfigRuntime = _find_runtime_by_config(skill_config)
	var instance: SkillAbstractBehaviour = runtime.get_behaviour()
	
	instance.initialize(runtime.get_behaviour_config(), runtime.level, skill_config.behaviour_config.layer_to_affect)
	return instance

#
