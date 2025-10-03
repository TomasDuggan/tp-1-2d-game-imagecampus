extends CollectableBehaviourConfig
class_name GainSynergyBehaviourConfig

@export_range(0, 1, 0.01) var amount: float


func get_behaviour() -> CollectableBehaviour:
	return preload("uid://cek5cvckxm7xn").instantiate()
