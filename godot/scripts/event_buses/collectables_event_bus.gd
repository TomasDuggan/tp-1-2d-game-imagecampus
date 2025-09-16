extends Node

@warning_ignore("unused_signal")
signal collectable_destroyed(type: Enums.CollectableType, amount: int)

func raise_event_collectable_destroyed(type: Enums.CollectableType, amount: int) -> void:
	collectable_destroyed.emit(type, amount)
