extends Node

@warning_ignore("unused_signal")
signal collectable_destroyed(type: Enums.CollectableType, amount: int)
@warning_ignore("unused_signal")
signal collectable_amount_changed(type: Enums.CollectableType, amount: int)

func raise_event_collectable_destroyed(type: Enums.CollectableType, amount: int) -> void:
	collectable_destroyed.emit(type, amount)

func raise_event_collectable_amount_changed(type: Enums.CollectableType, current_amount: int) -> void:
	collectable_amount_changed.emit(type, current_amount)
