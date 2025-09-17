extends CollectableBehaviourConfig
class_name HeroDamagerBehaviourConfig


@export var damage: int
@export var attack_speed: float

func get_behaviour() -> CollectableBehaviour:
	return preload("uid://d0udm77yblxq7").instantiate()
