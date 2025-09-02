extends SkillAbstractBehaviour
class_name FrontHeroBasicAttackSkillBehaviour


var config: FrontHeroBasicAttackSkillConfig

var _damage: int

func _ready():
	print("Config Damage: " + str(config.damage))
	print("Level: " + str(skill_level))
	print("Modifier: " + str(config.damage_modifier_percentage_by_level))
	
	print("Real Damage: " + str(_damage))

func downcast_config(generic_config: Resource) -> void:
	config = generic_config as FrontHeroBasicAttackSkillConfig

func modify_stats_by_level() -> void:
	_damage = config.damage + ceil(config.damage * config.damage_modifier_percentage_by_level * skill_level)
