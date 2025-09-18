extends CollectableBehaviourConfig
class_name BlockSwapBehaviourConfig

@export var block_duration: float


func get_behaviour() -> CollectableBehaviour:
	return preload("uid://chyafylphi2dr").instantiate()
