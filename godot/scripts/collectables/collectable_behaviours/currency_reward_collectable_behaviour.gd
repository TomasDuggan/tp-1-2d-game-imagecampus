extends CollectableBehaviour
class_name CurrencyRewardCollectableBehaviour
"""
Comportamiento mas basico: el jugador gana recursos al destruir el collectable
"""


func on_destroyed_by_hero(_source: Hero) -> void:
	var currency_config := config as CurrencyRewardBehaviourConfig
	CollectableEventBus.raise_event_collectable_destroyed(currency_config.type, currency_config.reward_amount)
