extends CollectableBehaviourConfig
class_name CurrencyRewardBehaviourConfig


@export var type: Enums.CollectableType
@export var reward_amount: int

func get_behaviour() -> CollectableBehaviour:
	return preload("uid://bu5w21pdkf3b4").instantiate()
