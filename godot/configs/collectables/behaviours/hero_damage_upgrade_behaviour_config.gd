extends CollectableBehaviourConfig
class_name HeroDamageUpgradeBehaviourConfig

@export_range(0, 1, 0.01) var damage_upgrade: float


func get_behaviour() -> CollectableBehaviour:
	return preload("uid://5plwksvegdbe").instantiate()
