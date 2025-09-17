extends Node
"""
Global que maneja la moneda/score del jugador
"""

var _collected_by_type := {
	Enums.WorldType.MINER: 0,
	Enums.WorldType.WARRIOR: 0,
}

func add_collectables(type: Enums.WorldType, amount: int) -> void:
	_collected_by_type[type] += amount
	CollectableEventBus.raise_event_collectable_amount_changed(type, _collected_by_type[type])

func can_buy(type: Enums.WorldType, price: int) -> bool:
	return _collected_by_type[type] >= price

func buy(type: Enums.WorldType, price: int) -> void:
	_collected_by_type[type] -= price

func get_current_amount(type: Enums.WorldType) -> int:
	return _collected_by_type[type]







#
