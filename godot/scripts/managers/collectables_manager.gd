extends Node
"""
Global que maneja los coleccionables/moneda/score (es todo lo mismo) del jugador
"""

var _collected_by_type := {
	Enums.WorldType.MINER: 5,
	Enums.WorldType.WARRIOR: 0,
}

func add_collectables(type: Enums.WorldType, amount: int) -> void:
	_collected_by_type[type] += amount
	_on_collectables_amount_changed(type)

func can_buy(type: Enums.WorldType, price: int) -> bool:
	return _collected_by_type[type] >= price

func buy_upgrade(upgrade: UpgradeConfig) -> void:
	_collected_by_type[upgrade.world_type] -= upgrade.price
	_on_collectables_amount_changed(upgrade.world_type)
	UpgradesManager.add_upgrade(upgrade)

func _on_collectables_amount_changed(type: Enums.WorldType) -> void:
	CollectableEventBus.raise_event_collectable_amount_changed(type, _collected_by_type[type])

func get_current_amount(type: Enums.WorldType) -> int:
	return _collected_by_type[type]







#
