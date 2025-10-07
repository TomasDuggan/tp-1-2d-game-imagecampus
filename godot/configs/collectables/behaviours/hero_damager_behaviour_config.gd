extends CollectableBehaviourConfig
class_name HeroDamagerBehaviourConfig


@export var damage: int
@export_range(0, 1, 0.01) var crit_chance: float
@export var attack_speed: float

func get_behaviour() -> CollectableBehaviour:
	return preload("uid://d0udm77yblxq7").instantiate()
