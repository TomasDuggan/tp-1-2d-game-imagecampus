extends Node
"""
Global que maneja los coleccionables/moneda/score (es todo lo mismo) del jugador
"""

var _collected_by_type: Dictionary[World.WorldType, int] = {
	World.WorldType.MINER: 7,
	World.WorldType.WARRIOR: 6,
}


func _ready():
	UpgradesEventBus.upgrade_bought.connect(_on_upgrade_bought)

func add_collectables(type: World.WorldType, amount: int) -> void:
	_collected_by_type[type] += amount
	_on_collectables_amount_changed(type)

func can_buy(type: World.WorldType, price: int) -> bool:
	return _collected_by_type[type] >= price

func _on_upgrade_bought(upgrade: UpgradeConfig) -> void:
	_collected_by_type[upgrade.world_type] -= upgrade.price
	_on_collectables_amount_changed(upgrade.world_type)

func _on_collectables_amount_changed(type: World.WorldType) -> void:
	CollectableEventBus.raise_event_collectable_amount_changed(type, _collected_by_type[type])

func get_current_amount(type: World.WorldType) -> int:
	return _collected_by_type[type]

func _exit_tree():
	UpgradesEventBus.upgrade_bought.disconnect(_on_upgrade_bought)





#
