extends Node
"""
Global que maneja las monedas del jugador
"""

var _collected_by_type := {
	Enums.CollectableType.MINERAL: 0,
	Enums.CollectableType.ENEMY: 0,
}


func _ready():
	CollectableEventBus.collectable_destroyed.connect(_on_collectable_destroyed)

func _on_collectable_destroyed(type: Enums.CollectableType, reward_amount: int) -> void:
	_collected_by_type[type] += reward_amount

func can_buy(type: Enums.CollectableType, price: int) -> bool:
	return _collected_by_type[type] >= price

func buy(type: Enums.CollectableType, price: int) -> void:
	_collected_by_type[type] -= price

func _exit_tree():
	CollectableEventBus.collectable_destroyed.disconnect(_on_collectable_destroyed)
