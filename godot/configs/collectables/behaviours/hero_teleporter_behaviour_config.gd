extends CollectableBehaviourConfig
class_name HeroTeleporterBehaviourConfig

@export var teleport_radius: float


func get_behaviour() -> CollectableBehaviour:
	return preload("uid://cmcans4uc7y82").instantiate()
