extends CollectableBehaviourConfig
class_name HeroDamagerBehaviourConfig


@export var damage: int
@export var attack_speed: float

func get_behaviour() -> CollectableBehaviour:
	return preload("res://scenes/collectables/behaviours/hero_damager_behaviour.tscn").instantiate()
