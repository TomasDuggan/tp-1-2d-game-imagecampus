extends CollectableBehaviour
class_name GainSynergyCollectableBehaviour
"""
Comportamiento para ganar sinergia
"""


func on_destroyed_by_hero(_source: Hero) -> void:
	var gain_synergy_config := config as GainSynergyBehaviourConfig
	SynergyEventBus.raise_event_gain_synergy(gain_synergy_config.amount)
