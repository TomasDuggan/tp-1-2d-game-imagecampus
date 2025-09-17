extends CollectableBehaviour
class_name HealHeroBehaviour
"""
Cura al ser destruido
"""

func on_destroyed_by_hero(source: Hero) -> void:
	var heal_config := config as HealHeroBehaviourConfig
	
	if heal_config.heal_destroyer_hero:
		source.hp.heal(heal_config.heal_amount)
	
	if heal_config.heal_ally_hero:
		source.ally.hp.heal(heal_config.heal_amount)
