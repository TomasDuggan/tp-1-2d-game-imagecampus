extends CollectableBehaviourConfig
class_name CurrencyRewardBehaviourConfig


@export var type: Enums.CollectableType
@export var reward_amount: int

func get_behaviour() -> CollectableBehaviour:
	return preload("res://scenes/collectables/behaviours/currency_reward_behaviour.tscn").instantiate()
