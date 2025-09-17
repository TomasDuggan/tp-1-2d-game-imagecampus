extends CollectableBehaviour
class_name CurrencyRewardCollectableBehaviour
"""
Comportamiento mas basico: el jugador gana recursos al destruir el collectable
"""


func on_destroyed_by_hero(_source: Hero) -> void:
	var currency_config := config as CurrencyRewardBehaviourConfig
	CollectablesManager.add_collectables(currency_config.type, currency_config.reward_amount)
