extends CollectableBehaviour
class_name HeroDamageUpgraderCollectableBehaviour
"""
Comportamiento para aumentar el dmg del Hero que lo destruye
"""

func on_destroyed_by_hero(source: Hero) -> void:
	var damage_upgrade := config as HeroDamageUpgradeBehaviourConfig
	source.hit.upgrade_damage(damage_upgrade.damage_upgrade)
