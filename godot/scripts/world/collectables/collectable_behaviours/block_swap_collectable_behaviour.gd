extends CollectableBehaviour
class_name BlockSwapCollectableBehaviour
"""
Comportamiento para bloquear el swap por X segundos
"""

func on_destroyed_by_hero(_source: Hero) -> void:
	var block_swap_config := config as BlockSwapBehaviourConfig
	HeroEventBus.raise_event_block_hero_swap(block_swap_config.block_duration)
