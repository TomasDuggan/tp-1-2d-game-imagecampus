extends Node
class_name CollectablesManager

var _collected_by_type := {
	Enums.CollectableType.MINERAL: 0,
	Enums.CollectableType.ENEMY: 0,
}

func _ready():
	CollectableEventBus.collectable_destroyed.connect(_on_collectable_destroyed)

func _on_collectable_destroyed(type: Enums.CollectableType, reward_amount: int) -> void:
	_collected_by_type[type] += reward_amount

func _exit_tree():
	CollectableEventBus.collectable_destroyed.disconnect(_on_collectable_destroyed)
