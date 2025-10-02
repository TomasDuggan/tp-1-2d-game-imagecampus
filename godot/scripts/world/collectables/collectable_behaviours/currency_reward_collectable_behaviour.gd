extends CollectableBehaviour
class_name CurrencyRewardCollectableBehaviour
"""
Comportamiento mas basico: el jugador gana recursos al destruir el collectable
"""


func on_destroyed_by_hero(_source: Hero) -> void:
	var currency_config := config as CurrencyRewardBehaviourConfig
	
	var amount_upgraded: int = currency_config.reward_amount + ceil(currency_config.reward_amount * UpgradesManager.get_modifier_value(currency_config.type, UpgradesManager.UpgradeId.CURRENCY_GATHER))
	CollectablesManager.add_collectables(currency_config.type, amount_upgraded)
