extends CollectableBehaviourConfig
class_name HealHeroBehaviourConfig

@export var heal_destroyer_hero: bool
@export var heal_ally_hero: bool
@export var heal_amount: int

func get_behaviour() -> CollectableBehaviour:
	return preload("uid://c5tsvobsxc88k").instantiate()
